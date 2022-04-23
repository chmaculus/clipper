#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#ifndef __CLIPPER
#include <signal.h>
#endif
#include "RTCom.h"

static CIRCULAR_BUFFER *ReceiveBuffer[MAX_PORTS];

/* port offsets */
#define RXB  0x00
#define TXB  0x00
#define IER  0x01
#define IIR  0x02
#define FCR  0x02
#define LCR  0x03
#define MCR  0x04
#define LSR  0x05
#define MSR  0x06
#define DLL  0x00
#define DLM  0x01

/* Interrupt Ids in decending priorities */
#define RCVLSTIntr      0x06
#define RCVIntr         0x04
#define TimeoutIntr     0x0C  /* 16550 only */
#define THREmptyIntr    0x02
#define ModemStatIntr   0x00
#define NoInterrupt     0x01

#define MASTER		0x20
#define SLAVE		0xa0
#define EOI			0x20
#define MASK(pic)	((pic) + 1)
#define	BIT(n)		(1 << ((n) & 7))

#define EnableInterrupts()	ASM sti
#define DisableInterrupts() ASM cli
#define EndOfInterrupt() OUT(MASTER, EOI)
#define Slave_EndOfInterrupt() OUT(SLAVE, EOI)

#define XOn             0x11
#define XOff            0x13

#define MaxBuffFillup   70   /* Percent of receive buffer size    */
#define MinBuffFillup   30   /* dito                              */

/* default IRQs for COM1..COM4 */
static Byte       near IRQ[4] = { 4, 3, 4, 3};
static Byte       near IRQSharePartner[4] = { COM3, COM4, COM1, COM2 };

typedef enum { DoNothing, SendXOff, SendXOn } ProtStatus;

struct PortRec {
  CIRCULAR_BUFFER *InBuffer,
                  *OutBuffer;
  unsigned      Base;
  unsigned      MinBufferLevel,
                MaxBufferLevel,
                SendBufferSize;
  int           BufferNotFull,
                IntsOn,
                ActiveProt,
                SendAllowed,
                ReceiveAllowed,
                TransmitterFree;
  int           FiFoInstalled,
                TriggerLevel;
  Protocol      Prot;
  ProtStatus    XOnXOffStatus;
  int           Used;
} ;

static unsigned   far * near BIOSUARTBase;
static ISRPtr     near OrgIntVector[4];
static struct PortRec near PortData[MAX_PORTS];

static int        near COMXType;
static ISRPtr     near COMXOrgVect;
static Byte       near COMXIRQ;
static unsigned   near COMXStatusReg;
static int        near COMXFirstPort;
static Byte       near PortTable[256];

static int Initialised = False;

void SetIRQHandler (int irq, IRQHandler Handler);
IRQHandler GetIRQHandler (int irq);
void DisableIRQ(unsigned irq);
void EnableIRQ(unsigned irq);

/*----------------------------------*/
static void near HandlePort(struct PortRec near * P)
{
   Byte     Status;
   unsigned B = P->Base;
   static COMData Data;         
   unsigned i;

   while (True)
   {
      switch (IN(B + IIR) & 0x0F)
      {
         case RCVIntr:
         case TimeoutIntr:
         case RCVLSTIntr:
			do 
			{
				Data = IN(B + RXB);
				Data += (((Status = IN(B + LSR)) & HARD_ERROR) << 8);
				if (!P->BufferNotFull)
					Data |= (BUFFER_FULL << 8);
				if (P->Prot == XOnXOff)
				{
					switch (Data & 0xFF)
					{
						case XOn:
							P->SendAllowed = True;
							if (P->TransmitterFree)
								goto Transmit;
							break;
						case XOff:
							P->SendAllowed = False;
							break;
						default:
							P->BufferNotFull = PutInBuffer(P->InBuffer, &Data, sizeof(COMData));
					}
				}
				else
					P->BufferNotFull = PutInBuffer(P->InBuffer, &Data, sizeof(COMData));
			} while (Status & DATA_READY);
			if ((P->ActiveProt) &&
				(P->Prot != NoProtocol) &&
				(P->ReceiveAllowed) &&
				(P->InBuffer->Count >= P->MaxBufferLevel))
			{
				P->ReceiveAllowed = False;
				switch (P->Prot)
				{
					case XOnXOff:
						if (P->TransmitterFree)
						{
							P->TransmitterFree = False;
							OUT(B + TXB, XOff);
						}
						else
							P->XOnXOffStatus = SendXOff;
						break;
					case RTSCTS:
					case DTRDSR:
						OUT(B + MCR, IN(B + MCR) & ~(RTS + DTR));
						break;
					default:
						return;
				}
			}
			break;
		case NoInterrupt:
			return;
		case THREmptyIntr:
Transmit:   switch (P->XOnXOffStatus)
			{
				case DoNothing:
					if (P->SendAllowed)
					{
						for (i = 1; i <= P->SendBufferSize; i++)
						{
							if (GetOfBuffer(P->OutBuffer, &Data, sizeof(Byte)))
								OUT(B + TXB, Data);
							else
							{
								if (i == 1)
									P->TransmitterFree = True;
								break;
							}
						}
					}
					else
						P->TransmitterFree = True;
					break;
				case SendXOff:
					OUT(B + TXB, XOff);
					P->XOnXOffStatus = DoNothing;
					break;
				case SendXOn:
					OUT(B + TXB, XOn);
					P->XOnXOffStatus = DoNothing;
					break;
				default:
					return;
			}
			break;
		case ModemStatIntr:
			switch (P->Prot)
			{
				case NoProtocol:
				case XOnXOff:
					IN(B + MSR);
					break;
				case RTSCTS:
					if (IN(B + MSR) & CTS)
					{
						P->SendAllowed = True;
						if (P->TransmitterFree)
							goto Transmit;
					}
					else
						P->SendAllowed = False;
					break;
				case DTRDSR:
					if (IN(B + MSR) & DSR)
					{
						P->SendAllowed = True;
						if (P->TransmitterFree)
							goto Transmit;
					}
					else
						P->SendAllowed = False;
					break;
				default:
					return;
			}
			break;
		default:
			return;
		}
	}
}

/*----------------------------------*/
static void interrupt far IntCOM1(void)
{
   EnableInterrupts();
   HandlePort(&PortData[COM1]);
   DisableInterrupts();
   EndOfInterrupt();
   if (IRQ[COM1] > 7)
      Slave_EndOfInterrupt();
}

/*----------------------------------*/
static void interrupt far IntCOM2(void)
{
   EnableInterrupts();
   HandlePort(&PortData[COM2]);
   DisableInterrupts();
   EndOfInterrupt();
   if (IRQ[COM2] > 7)
      Slave_EndOfInterrupt();
}

/*----------------------------------*/
static void interrupt far IntCOM3(void)
{
   EnableInterrupts();
   HandlePort(&PortData[COM3]);
   DisableInterrupts();
   EndOfInterrupt();
   if (IRQ[COM3] > 7)
      Slave_EndOfInterrupt();
}

/*----------------------------------*/
static void interrupt far IntCOM4(void)
{
   EnableInterrupts();
   HandlePort(&PortData[COM4]);
   DisableInterrupts();
   EndOfInterrupt();
   if (IRQ[COM4] > 7)
      Slave_EndOfInterrupt();
}

/*----------------------------------*/
static void interrupt far IntCOM1_3(void)
{
   EnableInterrupts();
   do {
      HandlePort(&PortData[COM1]);
      HandlePort(&PortData[COM3]);
   } while ((IN(PortData[COM1].Base + IIR) & NoInterrupt) != NoInterrupt);
   DisableInterrupts();
   EndOfInterrupt();
   if (IRQ[COM1] > 7)
      Slave_EndOfInterrupt();
}

/*----------------------------------*/
static void interrupt far IntCOM2_4(void)
{
   EnableInterrupts();
   do {
      HandlePort(&PortData[COM2]);
      HandlePort(&PortData[COM4]);
   } while ((IN(PortData[COM2].Base + IIR) & NoInterrupt) != NoInterrupt);
   DisableInterrupts();
   EndOfInterrupt();
   if (IRQ[COM2] > 7)
      Slave_EndOfInterrupt();
}

/*----------------------------------*/
static void interrupt far IntHandlerDigiBoard(void)
{
   Byte Status;

   EnableInterrupts();
   while ((Status = IN(COMXStatusReg)) != 0xFF)
      HandlePort(&PortData[COMXFirstPort + Status]);
   DisableInterrupts();
   EndOfInterrupt();
   if (COMXIRQ > 7)
      Slave_EndOfInterrupt();
}

/*----------------------------------*/
static void interrupt far IntHandlerHostess(void)
{
   Byte P;

   EnableInterrupts();
   while ((P = PortTable[IN(COMXStatusReg)]) != 0xFF)
      HandlePort(&PortData[P]);
   DisableInterrupts();
   EndOfInterrupt();
   if (COMXIRQ > 7)
      Slave_EndOfInterrupt();
}

/*----------------------------------*/
static void interrupt far IntHandlerHostess16(void)
{
   Byte P;
   int SomeThingToDo = True;

   EnableInterrupts();
   do {
      if ((P = PortTable[IN(COMXStatusReg)]) != 0xFF)
         HandlePort(&PortData[P]);
      else
         if ((P = PortTable[IN(COMXStatusReg + 0x40)]) != 0xFF)
            HandlePort(&PortData[P+8]);
         else
            SomeThingToDo = (PortTable[IN(COMXStatusReg)] != 0xFF);
   } while (SomeThingToDo);
   DisableInterrupts();
   EndOfInterrupt();
   if (COMXIRQ > 7)
      Slave_EndOfInterrupt();
}

/*----------------------------------*/
int HasFIFO(int P)
{
   unsigned Base = PortData[P].Base;

   if (PortData[P].FiFoInstalled == -1)
   {
      if ((IN(Base + IIR) & 0x30) != 0)
         PortData[P].FiFoInstalled = 0;
      else
      {
          OUT(Base + FCR, 0x01);
          PortData[P].FiFoInstalled = (IN(Base + IIR) & 0xC0) == 0xC0;
      }
      if (PortData[P].FiFoInstalled)
         if (PortData[P].TriggerLevel == -1)
            EnableFIFO(P, DEFAULT_TRIGGER_LEVEL);
         else
            EnableFIFO(P, PortData[P].TriggerLevel);
      else
         EnableFIFO(P, 0);
  }
  return (int) PortData[P].FiFoInstalled;
}

/*----------------------------------*/
int
EnableFIFO(int P, int Trigger)
{
	unsigned Base = PortData[P].Base;

	switch (Trigger)
	{
		case  0: OUT(Base + FCR, 0x00); break;
		case  1: OUT(Base + FCR, 0x01); break;
		case  4: OUT(Base + FCR, 0x41); break;
		case  8: OUT(Base + FCR, 0x81); break;
		case 14: OUT(Base + FCR, 0xC1); break;
		default:
         	/* RTCom: illegal FIFO trigger level */
			return -1;
	}
	if (Trigger == 0)
		PortData[P].SendBufferSize = 1;
	else
	{
		if (!HasFIFO(P))
			/* RTCom: cannot enable FIFO on specified port */
			return -1;
		PortData[P].SendBufferSize = 16;
	}
	PortData[P].TriggerLevel = Trigger;
	return 0;
}

/*----------------------------------*/
static void near SetHandler(int          P,
                            int          SharedPort,
                            IRQHandler   NoHandler,
                            IRQHandler   Handler,
                            IRQHandler   OtherHandler,
                            IRQHandler   SharedHandler)
{
   IRQHandler H;

   if (PortData[P].IntsOn)
      if (PortData[SharedPort].IntsOn)
         H = SharedHandler;
      else
         H = Handler;
   else
      if (PortData[SharedPort].IntsOn)
         H = OtherHandler;
      else
         H = NoHandler;
   SetIRQHandler(IRQ[P], H);
   if (H == NoHandler)
      DisableIRQ(IRQ[P]);
   else
      EnableIRQ(IRQ[P]);
}

/*----------------------------------*/
static void near InstallHandler(int P)
{
	static unsigned PrimPort[4] = { COM1, COM2, COM1, COM2 };
	static ISRPtr   Handler[4]; // = { IntCOM1, IntCOM2, IntCOM3, IntCOM4 };
	static ISRPtr  SHandler[4]; //= { IntCOM1_3, IntCOM2_4, IntCOM1_3, IntCOM2_4 };
	static int Initialized;

	if (!Initialized)
	{
		Handler[0] = IntCOM1;
		Handler[1] = IntCOM2;
		Handler[2] = IntCOM3;
		Handler[3] = IntCOM4;
		SHandler[0] = IntCOM1_3;
		SHandler[1] = IntCOM2_4;
		SHandler[2] = IntCOM1_3;
		SHandler[3] = IntCOM2_4;
		Initialized = 1;
	}

   if (IRQ[IRQSharePartner[P]] == IRQ[P])
      SetHandler(P, IRQSharePartner[P], OrgIntVector[PrimPort[P]], Handler[P], Handler[IRQSharePartner[P]], SHandler[P]);
   else
      SetHandler(P, P, OrgIntVector[P], Handler[P], Handler[P], Handler[P]);
}

/*----------------------------------*/
int
AllocateCOMBuffers(int P, unsigned ReceiveBufferSize, unsigned SendBufferSize)
{
	if (ReceiveBuffer[P] == NULL) /* mailboxes not yet created */
	{
		PortData[P].InBuffer = ReceiveBuffer[P] = CreateBuffer(ReceiveBufferSize);
		PortData[P].OutBuffer = CreateBuffer(SendBufferSize);
		if (!PortData[P].OutBuffer || !PortData[P].InBuffer)
			return -1;
		PortData[P].MaxBufferLevel = (long) ReceiveBufferSize * MaxBuffFillup / 100;
		PortData[P].MinBufferLevel = (long) ReceiveBufferSize * MinBuffFillup / 100;
	}
	return 0;
}

/*----------------------------------*/
int
EnableCOMInterrupt (int P, unsigned BufferSize)
{
	unsigned Base = PortData[P].Base;

	if (!Initialised)
		return -1;

	if (Base == 0)
      /* COM not installed. Use SetIOBase do define I/O-address */
    	return -1;

	if (AllocateCOMBuffers(P, BufferSize, BufferSize) < 0)
		return -2;
	PortData[P].IntsOn = True;
	if (P < COMXFirstPort)
	{
		if ((OrgIntVector[P] == NULL) && ((P <= COM2) || (IRQ[P] != IRQ[P-2])))
			OrgIntVector[P] = GetIRQHandler(IRQ[P]);
		InstallHandler(P);
	}
	else
	{
		switch (COMXType) 
		{
			case DigiBoard: 
				SetIRQHandler(COMXIRQ, IntHandlerDigiBoard); 
				break;
			case Hostess:
				SetIRQHandler(COMXIRQ, IntHandlerHostess);
				break;
			case Hostess16: 
				SetIRQHandler(COMXIRQ, IntHandlerHostess16);
				break;
		}
		EnableIRQ(COMXIRQ);
	}
	IN(Base + LSR);
	IN(Base + RXB);
	OUT(Base + MCR, DTR + RTS + Out1 + Out2);
	PortData[P].TransmitterFree = True;
	OUT(Base + IER, 0x0F);
	return 0;
}

/*----------------------------------*/
void DisableCOMInterrupt(int P)
{
   if (!PortData[P].IntsOn)
      return;
   OUT(PortData[P].Base + IER, 0);
   PortData[P].IntsOn = False;
   if (P < COMXFirstPort)
      InstallHandler(P);
}

/*-----------------------------------*/
static void COMProtTask(int PortNumber)
{
   struct PortRec near *P;

   P = &PortData[PortNumber];
   if (P->IntsOn && P->ActiveProt)
   {
		if ( P->OutBuffer->Count > 0 )
        {
        	OUT(P->Base + IER, 0x0F - 0x02);
            P->TransmitterFree = False;
            OUT(P->Base + IER, 0x0F);
        }
        if (!P->ReceiveAllowed && (P->InBuffer->Count <= P->MinBufferLevel))
        {
        	P->ReceiveAllowed = True;
            switch (P->Prot)
            {
            	case XOnXOff:
                    if (P->TransmitterFree)
                    {
                    	P->TransmitterFree = False;
                        OUT(P->Base + TXB, XOn);
                    }
                    else
                    	P->XOnXOffStatus = SendXOn;
                    break;
                case RTSCTS:
                case DTRDSR:
                    OUT(P->Base + MCR, IN(P->Base + MCR) | (RTS + DTR));
                    break;
                default:
					return;
              }
         }
	}
}

/*----------------------------------*/
int PortInstalled(int P)
{
   return PortData[P].Base != 0;
}

/*----------------------------------*/
Byte LineStatus(int  P)
{
   return IN(PortData[P].Base + LSR);
}

/*-----------------------------------*/
Byte ModemStatus(int P)
{
   return IN(PortData[P].Base + MSR);
}

/*-----------------------------------*/
int
ModemControl(int P, int SetToOneZero, int NewValue)
{
	ASM cli
	switch (SetToOneZero)
	{
		case 1: OUT(PortData[P].Base + MCR, IN(PortData[P].Base + MCR) | NewValue); break;
		case 0: OUT(PortData[P].Base + MCR, IN(PortData[P].Base + MCR) & ~NewValue); break;
		default: ASM sti
               /* SetToOneZero: illegal value */
				return -1;
	}
	ASM sti
	return 0;
}

/*----------------------------------*/
COMData ReceiveCharPolled(int P)
{
   Byte Status;

   while (!(Status = (IN(PortData[P].Base + LSR) & (HARD_ERROR | DATA_READY))))
      ;
   return IN(PortData[P].Base + RXB) + (Status << 8);
}

/*----------------------------------*/
void SendCharPolled(int P, Byte Data)
{
   while (!(IN(PortData[P].Base + LSR) & TXB_EMPTY))
      ;
   OUT(PortData[P].Base + TXB, Data);
}

/*----------------------------------*/
int InitPort(int  P,
              long BaudRate,
              int  Parity,
              int  StopBits,
              int  WordLength)
{
   unsigned Base;
   unsigned Divider = (unsigned) ((MAXBAUD + MAXBAUD % BaudRate) / BaudRate);
   Byte     Temp;

   if (!Initialised)
	  RTComInit();

   Base = PortData[P].Base;

   if (Base == 0)
      /* RTCom: COM%i not installed. Use SetIOBase do define I/O-address */
      return -1;

   OUT(Base + IER, 0);
   OUT(Base + LCR, 0x80);
   OUT(Base + DLL, Divider % 256);
   OUT(Base + DLM, Divider / 256);
   switch (Parity)
   {
      case PARITY_ODD:  Temp = 0x08; break;
      case PARITY_EVEN: Temp = 0x18; break;
      default:          Temp = 0x00;
   }
   OUT(Base + LCR, (WordLength-5) + ((StopBits-1) << 2) + Temp);
   OUT(Base + MCR, DTR+ RTS + Out1 + Out2);
   IN(Base + IIR);
   IN(Base + LSR);
   IN(Base + RXB);
   if (HasFIFO(P))
      EnableFIFO(P, DEFAULT_TRIGGER_LEVEL);

	// Indico que el port esta siendo usado.
	PortData[P].Used = 1;
	
   return 0;
}

/*----------------------------------*/

int SetCOMBoardTyp(AddOnPortType Typ,
                    unsigned      Address,
                    int           IRQ,
                    int           FirstPort)
{
	int i;

	COMXType = Typ;
	COMXIRQ = IRQ;
	COMXFirstPort = FirstPort;
	switch (Typ)
	{
		case DigiBoard:
			COMXStatusReg = Address;
			break;
		case Hostess:
		case Hostess16:
			COMXStatusReg = Address + 7;
			for (i = 0; i <= 255; i++)
				PortTable[i] = 0xFF;
			break;
		default:
			return -1;
	}
	COMXOrgVect = GetIRQHandler(COMXIRQ);
	return 0;
}

/*-----------------------------------*/
void SetIOBase(int P, unsigned IOBase)
{
   int i;

   PortData[P].Base = IOBase;
   if ((COMXOrgVect != NULL) &&
       ((COMXType == Hostess) || (COMXType == Hostess16)) &&
       (P >= COMXFirstPort))
          for (i = 1; i <= 255; i++)
             if ((i & (1 << (P - COMXFirstPort))) != 0)
                PortTable[i] = P;
}

/*-----------------------------------*/
int
SetIRQ(int P, int I)
{
	if ((P < COM1) || (P > COM4) || (I < 0) || (I > 15))
		return -1;
	IRQ[P] = I;
	return 0;
}

/*-----------------------------------*/
void SetProtocol(int      P,
                 Protocol Prot, 
				 int ActiveProtocol)
{
   PortData[P].Prot = Prot;
   PortData[P].ActiveProt = ActiveProtocol;
   PortData[P].ReceiveAllowed = True;
   switch (Prot)
   {
      case NoProtocol:
         PortData[P].SendAllowed = True;
         break;
      case XOnXOff:
         PortData[P].SendAllowed = True;
         if (PortData[P].ActiveProt)
            SendCharPolled(P, XOn);
         break;
      case RTSCTS:
         OUT(PortData[P].Base + MCR, IN(PortData[P].Base + MCR) | (RTS + DTR));
         PortData[P].SendAllowed = ((IN(PortData[P].Base + MSR) & CTS) == CTS);
         break;
      case DTRDSR:
         OUT(PortData[P].Base + MCR, IN(PortData[P].Base + MCR) | (RTS + DTR));
         PortData[P].SendAllowed = ((IN(PortData[P].Base + MSR) & DSR) == DSR);
   }
}

/*----------------------------------*/
char *COMError(COMData Data)
{
   Data >>= 8;
   if ((Data & FRAME) != 0)
      return "frame error";
   if ((Data & PARITY) != 0)
      return "parity error";
   if ((Data & OVERRUN) != 0)
      return "overrun error";
   if ((Data & BUFFER_FULL) != 0)
      return "buffer overflow";
   if ((Data & BREAK) != 0)
      return "break";
   return "no error";
}

void
CloseCom (int P)
{
	if ( !PortData[P].Base || !PortData[P].Used )
		return;
		
	if (PortData[P].IntsOn)
		DisableCOMInterrupt(P);

	if (HasFIFO(P))
		EnableFIFO(P, 0);      /* all FIFOs off */

	DestroyBuffer (&PortData[P].InBuffer);
	DestroyBuffer (&PortData[P].OutBuffer);
	ReceiveBuffer[P] = NULL;

	if (P <= COM4)
		BIOSUARTBase[P] = PortData[P].Base;

	// Bajo el flag que indica si el port esta usado o no.
	PortData[P].Used = 0;
}

/*-----------------------------------*/
static void CleanUp(void)
{
	int i;

	for (i = COM1; i < MAX_PORTS; i++)
		CloseCom (i);

	if (COMXOrgVect != NULL)
		SetIRQHandler(COMXIRQ, COMXOrgVect);
}

/*----------------------------------*/
void RTComInit(void)
{
   int i;

   if (Initialised)
      return;
   Initialised = True;

   BIOSUARTBase = MK_FP(0x0040, 0);
   #ifdef DPMI
      ASM mov ax, 0002h
      ASM mov bx, word ptr [BIOSUARTBase+2]
      ASM int 31h
      ASM mov word ptr [BIOSUARTBase+2], ax
   #endif

   memset(PortData, 0, sizeof(PortData));
   for (i = COM1; i < MAX_PORTS; i++)
   {
      if (i <= COM4)
         PortData[i].Base = BIOSUARTBase[i];
      PortData[i].BufferNotFull = True;
      PortData[i].SendAllowed = True;
      PortData[i].SendBufferSize = 1;
      PortData[i].ReceiveAllowed = True;
      PortData[i].TriggerLevel = -1;      /* unknown */
      PortData[i].FiFoInstalled = -1;     /* unknown */
   }
   COMXOrgVect = NULL;
   COMXFirstPort = 4;
#ifndef DRIVER 
#ifndef __CLIPPER
	signal(SIGINT, exit);
	signal(SIGTERM, exit);
	signal(SIGABRT, exit);
#endif
	atexit(CleanUp);
#endif
}

void
DisableIRQ(unsigned irq)
{
	DisableInterrupts();
	if ( irq <= 7 )
		outp(MASK(MASTER), inp(MASK(MASTER)) | BIT(irq));
	else
		outp(MASK(SLAVE), inp(MASK(SLAVE)) | BIT(irq));
	EnableInterrupts();
}

void
EnableIRQ(unsigned irq)
{
	DisableInterrupts();
	if ( irq <= 7 )
		outp(MASK(MASTER), inp(MASK(MASTER)) & ~BIT(irq));
	else
		outp(MASK(SLAVE), inp(MASK(SLAVE)) & ~BIT(irq));
	EnableInterrupts();
}

void
SetIRQHandler (int irq, IRQHandler Handler)
{
	int c;

	DisableIRQ(irq);
	c = irq + 8;
	SETVECT(c, Handler);
	EnableIRQ(irq);
}

IRQHandler
GetIRQHandler (int irq)
{
	return GETVECT(irq+8);
}

/*****************/
/* INTERFACE:    */
/*****************/

int
ReadChar (int P, int *c)
{
	int WordRead;
	int rc;

	COMProtTask(P);

	rc = GetOfBuffer (PortData[P].InBuffer, &WordRead, sizeof(int)) ;
	if (rc != sizeof(int))
		return -1;

	if (WordRead & 0xFF00)
		return WordRead & 0xFF00;

	*c = WordRead & 0x00FF;

	return 0;
}

int
SpaceUsedInRXBuffer(int P)
{
	return PortData[P].InBuffer->Count;
}

int
WriteChar (int P, int Data)
{
   struct PortRec near * p = &PortData[P];
   int rc;

   rc = PutInBuffer(p->OutBuffer, &Data, sizeof(Byte));
   if (p->TransmitterFree && p->SendAllowed)
   {
      OUT(p->Base + IER, 0x0F - 0x02);  /* send ints off */
      p->TransmitterFree = False;
      OUT(p->Base + IER, 0x0F);         /* and back on   */
   }
   return rc == 0 ? -1 : 0;
}


