/*
	LibFunc: Funciones adicionales para tener en una librer¡a
			 las funciones que quedaron en el cuerpo de los drivers.

	Autor: Leandro Fanzone
*/

#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <dos.h>
#include <stdarg.h>
#include <ctype.h>
#include <io.h>
#include <conio.h>
#include <time.h>

#include "ascii.h"
#include "comm.h"

#include "fiscal.h"
#include "fisdebug.h"

long BaudTbl [] = 
{
	1200L,
	2400L,
	4800L,
	9600L,
	19200L,
	38400L,
	57600L,
	115200L	
};

#define MAX_BAUDS (sizeof (BaudTbl) / sizeof (long))

static clock_t TimerStart;
extern PUERTO_FISCAL Puertos[MAX_FISCAL_PORTS];

#ifdef C_LIB
PFV KeepAliveHandler = NULL;
#endif

void IncrementPacketNumber(int PortNumber);

static int CommandRetries = ANS_RETRY;
static int NroPaqueteRecibido;
static int NroPaqueteEnviado;
static int ComandoRecibido;

// Comando para pedir la version de controlador fiscal
// Valido solo para la serie nueva de controladores a 
// chorro de tinta y laser.

#define CMD_STATUS_REQUEST		0x2a
#define CMD_GET_CF_VERSION 		0x7f

// Esta variable indica si se esta usando el protocolo nuevo.

extern int New_Protocol;

int  SetNewProtocol (int Value);

int
MandaPaqueteFiscal (int PortNumber, char *Buffer, 
					unsigned short *FiscalStatus, 
					unsigned short *PrinterStatus,
					char *AnswerBuffer)
{
	static int i, j, c;
	static struct resp_fiscal 		*Respuesta;
	static struct resp_fiscal_new 	*RespuestaN;
	int Rc;
	int AckRetries = CommandRetries == 1 ? 1 : ACK_RETRY;
	int NroPaquete;
	char *FisStat;
	char *PrnStat;
	char *AnswerPtr;
	unsigned char Comando;

	FISdebug (2, "MandaPaqueteFiscal : CommandRetries %d, New_Protocol %d\n", 
		CommandRetries, New_Protocol);
	
    ArmaPaqueteFiscal (PortNumber, Buffer); 

    for ( j = 0; j < CommandRetries; j ++ ) 
	{
        FISdebug (3, "Testeando BufferEmpty()... ");

		if (!BufferEmpty(PortNumber))
		{
			FISdebug (2, "ACKeando respuestas perdidas...");

			while (GetAnswer(PortNumber, 
					Puertos[PortNumber].Buffer_Recepcion, 
					sizeof(Puertos[PortNumber].Buffer_Recepcion)) == OK)
				SendByte (PortNumber, ACK);
		}

        for ( i = 0; i < AckRetries; i ++ ) 
		{
            // Manda Comando

		    FISdebug (1, "Envio el comando: %s", Puertos[PortNumber].Buffer_Fiscal);

            if (SendCommand (PortNumber, 
		    		Puertos[PortNumber].Buffer_Fiscal) == ERROR)
		    {
				FISdebug (2, "Error enviando el comando");
				continue;
			}

            // Espero el ACK.
			FISdebug (2, "Espero el ACK");

        	if ( ( c = GetAck (PortNumber)) == ACK )
			{
				FISdebug (1, "ACK a comando");
            		break;
			}

			FISdebug (1, "%s esperando ACK", c == NAK ? "NAK" : "TIMEOUT");
       }

        if ( i == AckRetries ) 
		{
			FISdebug (1, 
				"Demasiados reintentos esperando el ACK. Retorna ERROR.");
			return ERR_TIMEOUT;
        }

        for ( i = 0; i < AckRetries; i ++ ) 
		{
            // Espero la respuesta.

			FISdebug (3, "A esperar la respuesta");

			Rc = GetAnswer (PortNumber, Puertos[PortNumber].Buffer_Recepcion, 
				sizeof(Puertos[PortNumber].Buffer_Recepcion));

            switch ( Rc )
			{
				case OK:

					FISdebug (1, "Vino la respuesta <%s>; Mando ACK",
							Puertos[PortNumber].Buffer_Recepcion);

					if (SendByte (PortNumber, ACK) == ERROR)
					{
						FISdebug (2, "Error enviando ACK a la respuesta");
						break;
					}

					if ( New_Protocol )
					{
						RespuestaN = (struct resp_fiscal_new *)
							Puertos[PortNumber].Buffer_Recepcion;

						NroPaquete = RespuestaN->Paquete;
						Comando    = RespuestaN->Comando;
						FisStat    = RespuestaN->fiscal_status;
						PrnStat    = RespuestaN->printer_status;
						AnswerPtr  = (char *)(&RespuestaN->printer_status);
					}
					
					else 
					{
						Respuesta =	(struct resp_fiscal *) 
							Puertos[PortNumber].Buffer_Recepcion;

						NroPaquete = Respuesta->Paquete;
						Comando    = Respuesta->Comando;
						FisStat    = Respuesta->fiscal_status;
						PrnStat    = Respuesta->printer_status;
						AnswerPtr  = (char *)(&Respuesta->printer_status);
					}
					
					NroPaqueteRecibido = NroPaquete;
					NroPaqueteEnviado  = Puertos[PortNumber].PacketNumber;
					
					if ( NroPaqueteEnviado != NroPaqueteRecibido )
					{
						FISdebug (2, "Error Nro Paq Espero %d, vino %d",
							NroPaqueteEnviado, NroPaqueteRecibido);
						break;
					}
					
					IncrementPacketNumber(PortNumber);

					if (PrinterStatus)
						*PrinterStatus = xtoi (PrnStat);

					if (FiscalStatus)
						*FiscalStatus  = xtoi (FisStat);

					if (AnswerBuffer)
					{
						strcpy (AnswerBuffer, AnswerPtr);
						AnswerBuffer [strlen(AnswerBuffer) - 1] = 0;
					}

					FISdebug (2, "Comando = %X", Comando);

					ComandoRecibido = Comando;
					
					return Comando == CMD_STATPRN ? ERR_STATPRN : OK;

				case ERR_TIMEOUT:
					// A reenviar el comando 
					FISdebug (2, "TIMEOUT recibiendo la respuesta");
					goto ReSend;

				case ERROR:
					FISdebug (2, "Mando NAK a la respuesta");
					SendByte (PortNumber, NAK);
					break;
			}
        }
ReSend:
		FISdebug (2, "ReEnvio comando ...");
   } 

	FISdebug (2, "MandaPaqueteFiscal retorna ERROR");
	return ERR_TIMEOUT;
}

int 
OpenCommFiscal (int PortNumber)
{
	int Handler;
	char Command[100], *p;
	char FiscalAnswer[200];
	unsigned short FiscalStatus;
	unsigned short PrinterStatus;
	
	FISdebug (2, "OpenComFiscal COM%d.", PortNumber);
	
	Handler = start_comm(PortNumber);

#if 0
	// Envio el comando de version. Si el impresor reconoce 
	// el comando, se trata de la serie nueva de impresores 
	// que usan el protocolo nuevo.

	Command[0] = CMD_GET_CF_VERSION;
	Command[1] = NUL;

	if ( !MandaPaqueteFiscal (Handler, 
		Command, &FiscalStatus, &PrinterStatus, FiscalAnswer) )
	{
		// Veo si es un comando valido
		if ( !(FiscalStatus & 0x0008) )		
			SetNewProtocol (1);
	}
#endif 

	return Handler;
}

int 
CloseCommFiscal (int PortNumber)
{
	FISdebug (3, "CloseComFiscal: Cierro %d", PortNumber);
	end_comm (PortNumber);
	return 0;
}

int 
SetBaudios (int PortNumber, long Baud)
{
	return SetBaudRate (PortNumber, Baud);
}

int
SetCommandRetries (int Retries)
{
	int OldRetries = CommandRetries;
	CommandRetries = Retries;
	return OldRetries;
}

int 
SetNewProtocol (int Value)
{
	New_Protocol = Value;
}

int 
ObtenerStatusImpresor (int PortNumber, unsigned short *FiscalStatus, 
	unsigned short *PrinterStatus,	char *AnswerBuffer)
{
	char Comando[10], *p;
	int Result;

	Comando[0] = CMD_STATPRN;
	Comando[1] = NUL;

	return MandaPaqueteFiscal (PortNumber, Comando, 
		FiscalStatus, PrinterStatus, AnswerBuffer);
}

void
ObtenerNumeroDePaquetes (int *Enviado, int *Recibido, int *CmdRecibido)
{
	*Enviado     = NroPaqueteEnviado;
	*Recibido 	 = NroPaqueteRecibido;
	*CmdRecibido = ComandoRecibido;
}

#ifdef C_LIB
int
SetKeepAliveHandler(PFV Handler)
{
	KeepAliveHandler = Handler;
}
#endif

#if defined __CLIPPER || defined __MFCOBOL
extern long myclock (void);
#define clock myclock
#endif

void
StartTimer (void)
{
	TimerStart = clock ();
}

int 
GetTimer (void)
{
	return clock() - TimerStart;
}

void
IncrementPacketNumber(int PortNumber)
{
	Puertos[PortNumber].PacketNumber += 2;
	if (Puertos[PortNumber].PacketNumber > END_PACKET)
		Puertos[PortNumber].PacketNumber = START_PACKET;
}

int 
SearchPrn (int PortNumber, long *Baud)
{
	int i;
	int OldRet;
	char Buffer[10];
	unsigned short PrnStatus;
	unsigned short FisStatus;
	static char FisAnswer[500];

	FISdebug (2, "Buscando Controlador Fiscal ");

	OldRet = SetCommandRetries (1);
		
	// Manda un comando de status a las distintas velocidades 
	// hasta que el printer responde.
		
	for (i = 0; i < MAX_BAUDS; i ++ )
	{
		SetBaudRate (PortNumber, BaudTbl[i]);
			
		Buffer[0] = CMD_STATUS_REQUEST;
		Buffer[1] = NUL;

		if ( !MandaPaqueteFiscal (
			PortNumber, Buffer, &FisStatus, &PrnStatus, FisAnswer) )
			break;
	}
	
	SetCommandRetries (OldRet);

	if ( i == MAX_BAUDS )
	{
		FISdebug (2, "El controlador fiscal NO fue encontrado !");
		return -1;
	}

	*Baud = BaudTbl[i];
	
	FISdebug (2, "Controlador fiscal detectado a %ld baudios", *Baud);

	return 0;
}


