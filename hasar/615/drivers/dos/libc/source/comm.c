/*

    Comm.c:

	M¢dulo de comunicaciones para DOS, Windows 3.x/95.
	Usa la librer¡a Greenleaf y RTCom.

	Autor: Leandro Fanzone
	Fecha: 1/97

*/

#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include <conio.h>

#ifndef WIN32
#include <bios.h>
#endif

#include <fcntl.h>
#include <dos.h>
#include <time.h>

static int CheckPort (int PortNumber);

#define STRICT

#ifndef DOS
	#include "compiler.h"
	#include <windows.h>
	#ifdef ERROR 
		#undef ERROR
	#endif
	#include "commlib.h"
	#include "asciidef.h"
#else
	#include "rtcom.h"
#endif

#include "comm.h"

#ifdef DOS
	#include "timer.h"
#endif
#include "fiscal.h"
#include "fisdebug.h"

static long Baud = 9600L;
#ifdef DOS
	static int Parity = PARITY_NONE;
#else
	static char Parity = 'N';
#endif
static int DataBits = 8;
static int Stop = 1;

#define BUFFER_SIZE 1000

/*
	NO COMPARTIR EN 32BITS (ver winfis.c)
*/

PUERTO_FISCAL Puertos[MAX_FISCAL_PORTS];

int
start_comm(int n)
{
	int PortNumber;
#ifdef DOS
	int rc;
#endif

	FISdebug (1, "Open port COM%d...", n);

	PortNumber = n - 1;

	if (PortNumber < 0 || PortNumber >= MAX_FISCAL_PORTS)
	{
		FISdebug (2, "Port err¢neo %d", PortNumber);
		return ERROR;
	}

	if ( Puertos[PortNumber].Port ) // Si ya est  abierto.
	{
		FISdebug (2, "Intento de abrir port inicializado. Retorno ERROR");
        return ERR_ALREADYOPEN;
	}

#ifdef WIN32
	Puertos[PortNumber].Port = PortOpenMSWin32 (PortNumber, Baud, Parity, DataBits, Stop);
#elif defined(DOS)
	rc = InitPort (PortNumber, Baud, Parity, Stop, DataBits);
	if (rc < 0)
	{
		FISdebug (1, "InitPort fall¢ (rc %d)", rc);
		return ERROR;
	}
	if ((rc = EnableCOMInterrupt (PortNumber, BUFFER_SIZE)) < 0)
	{
		FISdebug (1, "EnableCOMInterrupt fall¢ (rc %d)", rc);
		if (rc == 2)
			return ERR_NOMEM;
		return ERROR;
	}
	Puertos[PortNumber].Port = 1; // Como que est  inicializado
#else
	Puertos[PortNumber].Port = PortOpenMSWindows (PortNumber, Baud, Parity, DataBits, Stop);
#endif

#ifndef DOS
	if (!Puertos[PortNumber].Port)
	{
		FISdebug(1, "Librer¡a de comunicaciones no pudo crear el objeto");
		return ERR_NOMEM;
	}
	if ( Puertos[PortNumber].Port->status < ASSUCCESS )
	{
		FISdebug (1, "Error %d abriendo puerto", Puertos[PortNumber].Port->status);
		if (Puertos[PortNumber].Port->status == ASINUSE)
		{
			FISdebug (2, "Windows dice que ya est  abierto");
			return ERR_ALREADYOPEN;
		}
		return ERROR;
	}
#endif

#ifndef WIN32
#ifndef DOS
	Puertos[PortNumber].Atomic = 0;
#endif
#endif

	Puertos[PortNumber].PacketNumber = START_PACKET;
	memset (Puertos[PortNumber].Buffer_Fiscal, 0, MX_FISCAL);
	FISdebug (3, "OpenPort OK, PortNumber %d", PortNumber);
	return PortNumber;
}


#ifdef WIN32	
int
GetComHandle(int n)
{
	int	  PortNumber;
	PORT *Handle;

	FISdebug (1, "Get Com Handle port COM%d...", n);

	PortNumber = n - 1;
	Handle = Puertos[PortNumber].Port;

	if (PortNumber < 0 || PortNumber >= MAX_FISCAL_PORTS)
	{
		FISdebug (2, "Port erroneo %d", PortNumber);
		return ERROR;
	}

	if ( Handle )			// Verifica si ya esta abierto.
	{
		FISdebug (2, "El port estaba abierto. Retorna el Handle");
        return PortNumber;
	}
	else {
		FISdebug (2, "El port no estaba abierto. Retorno ERROR");
        return ERR_NOTOPENYET;
	}
}
#endif

#ifdef DOS	
void
SetPortIOBase (int PortNumber, unsigned int IOBase)
{
	PortNumber--;
	SetIOBase(PortNumber, IOBase);
}

void
SetIRQNumber (int PortNumber, int IRQNumber)
{
	PortNumber--;
	SetIRQ(PortNumber, IRQNumber);
}
#endif

void
end_comm (int PortNumber)
{
	if ( PortNumber < 0 || PortNumber >= MAX_FISCAL_PORTS || 
			!Puertos[PortNumber].Port )
	{
		FISdebug (3, "Intento de cerrar puerto no abierto (Handler %d)", PortNumber);
		return;
	}
	
	FISdebug (2, "Cierro el puerto %d", PortNumber+1);
#ifdef DOS
	CloseCom (PortNumber);
	Puertos[PortNumber].Port = 0;
#else
	PortClose (Puertos[PortNumber].Port);
	Puertos[PortNumber].Port = NULL;
#endif
}

int
SendByte (int PortNumber, int Byte)
{
	if ( !CheckPort (PortNumber) )
	{
		FISdebug (3, "Handler (%d) invalido", PortNumber);
		return ERROR;
	}

#ifndef DOS
	if (WriteCharTimed (Puertos[PortNumber].Port, Byte, TIMEOUT_FISCAL_MS) < ASSUCCESS) 
		return ERROR;
	return OK;
#else
	if (WriteChar (PortNumber, Byte) < 0)
		return ERROR;
	return OK;
#endif
}

int
GetByte (int PortNumber, int *Byte)
{
#ifndef DOS
	int c;
#endif

	if ( !CheckPort (PortNumber) )
	{
		FISdebug (3, "Handler (%d) invalido", PortNumber);
		return ERROR;
	}

#ifdef DOS
	if (ReadChar(PortNumber, Byte) < 0)
		return ERROR;
	return *Byte;
#else
    if ( (c = ReadChar(Puertos[PortNumber].Port)) < ASSUCCESS )
	    return ERROR;
	return (*Byte = c);
#endif
}

int
GetByteTimed (int PortNumber)
{
    int c;

#ifdef DOS

    StartTimer (); // Disparo el TIMEOUT

    while ( 1 ) {

        if ( GetTimer () >= TIMEOUT_FISCAL )
            return ERROR;

        if ( GetByte (PortNumber, &c) >= 0 )
            return c;
    }
#else

	c = ReadCharTimed (Puertos[PortNumber].Port, TIMEOUT_FISCAL_MS);
	if (c == ASBUFREMPTY)
		return ERROR;

	return c;

#endif
}

int
send_packet(int PortNumber, char *data)
{
#ifdef DOS
	for ( ; *data ; data++)
		if (SendByte (PortNumber, *data) < 0)
			return ERROR;
	return OK;
#else
	if (WriteStringTimed (Puertos[PortNumber].Port, data, -1, TIMEOUT_FISCAL_MS) < ASSUCCESS) 
		return ERROR;

    return OK;
#endif
}


/* Sends a command */

int
SendCommand(int PortNumber, char *Com)
{
	if ( !Puertos[PortNumber].Port )
	{
		FISdebug (2, "Error: Handler %d no inicializado", PortNumber);
		return ERROR;
	}

	if (send_packet (PortNumber, Com) == ERROR)
	{
		FISdebug (1, "Error mandando paquete");
		return ERROR;
	}

    return OK;
}


int
BufferEmpty (int PortNumber)
{
#ifdef DOS
	return SpaceUsedInRXBuffer(PortNumber) == 0;
#else
	return SpaceUsedInRXBuffer(Puertos[PortNumber].Port) == 0;
#endif
}

// Chequea el Port al cual se quiere acceder.
// Retorna 0 si es erroneo, 1 si esta OK.

static int 
CheckPort (int PortNumber )
{
	return !(PortNumber < 0 || PortNumber >= MAX_FISCAL_PORTS || !Puertos[PortNumber].Port);
}

#ifdef __CLIPPER 

int 
SpaceUsedInBuffer (int PortNumber)
{
	if ( !CheckPort (PortNumber) )
	{
		FISdebug (3, "Handler (%d) invalido", PortNumber);
		return ERROR;
	}

	return SpaceUsedInRXBuffer(PortNumber);
}

#endif 

int 
SetBaudRate (int PortNumber, long Baudios)
{
	int rc;
	int NumPacket;
	
	if ( !Puertos[PortNumber].Port )
	{
		FISdebug (2, "Error: Handler %d no inicializado", PortNumber);
		return ERROR;
	}

	FISdebug(1, "Cambio velocidad a %ld", Baudios);
#ifdef DOS
	rc = InitPort (PortNumber, Baudios, Parity, Stop, DataBits);
#else
	Baud = Baudios;
	NumPacket = Puertos[PortNumber].PacketNumber;
	end_comm(PortNumber);

	rc = start_comm(PortNumber+1);
#endif

	if (rc < 0)
	{
		FISdebug (1, "Cambio de baudios fall¢ (rc %d)", rc);
		return ERROR;
	}

#ifndef DOS
	Puertos[PortNumber].PacketNumber = NumPacket;
#endif

	return OK;
}
