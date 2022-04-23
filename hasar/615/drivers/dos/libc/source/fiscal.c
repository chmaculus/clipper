/*
    Fiscal.c:

	M¢dulo de manejo de paquetes fiscales.
	Com£n para LptFis (programa residente DOS), WinFis.DLL 
	(DLL para Windows 3.x) y WinFis32 (DLL para Win95).

	Autor: Leandro Fanzone
	Fecha: 1/97

*/

#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <ctype.h>

#ifdef ERROR
	#undef ERROR
#endif

#ifdef DOS
	#include "rtcom.h"
#else
	#include "commlib.h"
	#include "asciidef.h"
#endif

#include "comm.h"
#include "fisdebug.h"

#include "fiscal.h"
#ifdef DOS
	#include "timer.h"
#endif
#ifdef WIN32
#include "winfis.h"
#endif

#define IS_TOKEN_FISCAL(c) (c == STX || c == ACK || c == NAK || \
									 c == DC2 || c == DC4)

int Verif_CheckSum(int PortNumber, int CheckSum);
int WaitAnswer (int PortNumber, char *Buffer, int Max);

static char Buffer_Respuesta[MX_FISCAL];
extern PUERTO_FISCAL Puertos[MAX_FISCAL_PORTS];

#ifdef WIN32
extern PFV KeepAliveHandler;
extern PFVSTDCALL KeepAliveHandlerStdCall;
#endif

#ifdef C_LIB
extern PFV KeepAliveHandler;
#endif

int New_Protocol;

/* 
 * ArmaPaqueteFiscal ()
 * 
 * Arma un comando fiscal agregando el STX,ETX y CheckSum
 * Recibe el comando fiscal (command) y arma el paquete 
 * completo sobre Buffer_Fiscal .
 *
 */

void 
ArmaPaqueteFiscal(int PortNumber, char far *command)
{
	unsigned short CheckSum=STX;
	char *p = Puertos[PortNumber].Buffer_Fiscal;
	char sCheckSum[5];
	int i, len;

	FISdebug (2, "Arma paquete <%s>", command);
	*(p++)=STX;
	*(p++)=Puertos[PortNumber].PacketNumber;
	CheckSum += Puertos[PortNumber].PacketNumber;

	if ( New_Protocol )
	{
		*p++ = ESC;
		CheckSum += ESC;
	}

	while( *command )
	{
		CheckSum += * ((unsigned char *) command);
		*(p++) = *(command++);
	}
	*(p++) = ETX;
	CheckSum += ETX;

	/* Le coloco el CheckSum */
	// sprintf(p,"%04x",CheckSum);
	itoa (CheckSum, sCheckSum, 16);
	len = strlen(sCheckSum);
	for (i = 0; i < 4; i++)
		if (i < len)
			*(p+(4-len)+i) = sCheckSum[i];
		else
			*(p+4-i-1) = '0';
	p[4] = 0;

	FISdebug (1, "Buffer a transmitir: <%s>", Puertos[PortNumber].Buffer_Fiscal);
}

/*
 * Funcion: GetAck ()
 *
 * Espera ACK, NACK o KEEP_ALIVE del printer
 *
 */

int 
GetAck (int PortNumber)
{
    int caracter;
	int Count = 0;

    while ( (caracter = GetByteTimed(PortNumber)) != ERROR )
	{

#ifdef WIN32
		if (Puertos[PortNumber].AbortInProgress)
		{
			FISdebug(2, "Aborción para GetAck");
			return ERR_ABORT;
		}
#endif
        if ( IS_TOKEN_FISCAL (caracter) )
		{
			if (caracter == STX)
			{
				FISdebug (2, "Esperando ACK recibo STX. A esperar respuesta:");
				if (WaitAnswer (PortNumber, Buffer_Respuesta, MX_FISCAL-1) == OK)
				{
					FISdebug (2, "ACK a respuesta");
					SendByte (PortNumber, ACK);
				}
				else
				{
					FISdebug (2, "NAK a respuesta");
					SendByte (PortNumber, NAK);
				}
				continue;
			}
			if (caracter == ACK || caracter == NAK)
			{
				FISdebug (1, "Recibo %s", caracter == NAK ? "NAK" : "ACK");
				return caracter;
			}
		}
		if (caracter == DC2 || caracter == DC4)
		{
#ifdef WIN32
			__try
			{
				if (KeepAliveHandler)
					KeepAliveHandler(caracter, PortNumber);
				if (KeepAliveHandlerStdCall)
					KeepAliveHandlerStdCall(caracter, PortNumber);
			}
			__except (1, EXCEPTION_EXECUTE_HANDLER) 
			{
				FISdebug (1, "Puntero KeepAlive Inv lido [%x %x]", KeepAliveHandler, KeepAliveHandlerStdCall);
			}

#endif
#ifdef C_LIB
			if (KeepAliveHandler)
				KeepAliveHandler(caracter, PortNumber);
#endif
			FISdebug (1, "%s", caracter == DC2 ? "DC2" : "DC4");
		}
		else
		{
			if (Count++ > MAX_TRASH)
			{
				FISdebug (2, "Demasiada basura esperando ACK");
				return ERROR;
			}
		}
	}

	FISdebug (1, "Getting ACK: TIMEOUT");        
    return ERROR;
}

/*
 * Funcion: GetAnswer ()
 *
 * Espera la respuesta del printer al comando anterior.
 *
 */

int 
GetAnswer (int PortNumber, char *Buffer, int Max)
{
    int c;
	int Count = 0;

    // Espero el STX. Continuo con cualquier otro caracter.

    while ( (c = GetByteTimed (PortNumber)) != ERROR && c != STX)
		if (c == DC2 || c == DC4)
		{
#ifdef WIN32
			if (Puertos[PortNumber].AbortInProgress)
			{
				FISdebug(2, "Aborción para KeepAlive/GetAnswer");
				return ERR_ABORT;
			}
			__try
			{
				if (KeepAliveHandler)
					KeepAliveHandler(c, PortNumber);
				if (KeepAliveHandlerStdCall)
					KeepAliveHandlerStdCall(c, PortNumber);
			} 
			__except (1, EXCEPTION_EXECUTE_HANDLER) 
			{
				FISdebug (1, "Puntero KeepAlive Inv lido [%x %x]", KeepAliveHandler, KeepAliveHandlerStdCall);
			}
#endif
#ifdef C_LIB
			if (KeepAliveHandler)
				KeepAliveHandler(c, PortNumber);
#endif
			FISdebug (1, "%s", c == DC2 ? "DC2" : "DC4");
		}
		else
		{
#ifdef WIN32
			if (Puertos[PortNumber].AbortInProgress)
			{
				FISdebug(2, "Aborción para GetAnswer");
				return ERR_ABORT;
			}
#endif

			if (Count++ > MAX_TRASH)
			{
				FISdebug (2, "Demasiada basura esperando STX");
				return ERROR;
			}
		}

    // Retorna ERROR por TIMEOUT.
    if ( c < 0 )
	{
		FISdebug (1, "TIMEOUT esperando STX");
        return ERR_TIMEOUT;
	}
	return WaitAnswer (PortNumber, Buffer, Max);
}

/*
	Espera el resto de un paquete, cuando
	ya se recibi¢ el STX.
*/

int
WaitAnswer (int PortNumber, char *Buffer, int Max)
{
    unsigned short CheckSum = 0;
    int c;

	c = STX;

    // Espero el bloque completo hasta el ETX
    while ( (*Buffer++ = c ) != ETX ) 
	{
		if (--Max <= 1)
		{
			FISdebug (2, "Out of buffer esperando ETX");
			return ERROR;
		}

        CheckSum += c;

		c = GetByteTimed (PortNumber);
        
#ifdef WIN32
		if (Puertos[PortNumber].AbortInProgress)
		{
			FISdebug(2, "Aborción para WaitAnswer");
			return ERR_ABORT;
		}
#endif
		// Si es TIMEOUT retorno ERROR.
        if ( c < 0 )
		{
			FISdebug (1, "Armando paquete: TIMEOUT");
            return ERR_TIMEOUT;
		}
    }

	*Buffer = 0;

    CheckSum += c;

    return Verif_CheckSum (PortNumber, CheckSum);
}

/*
 * Funcion: Verif_CheckSum ()
 *
 * Lee los 4 bytes que corresponde al CheckSum y lo  
 * compara con el recibido.  Retorna OK si el        
 * CheckSum esta OK y ERROR en caso contrario.       
 *
 */
int
Verif_CheckSum(int PortNumber, int CheckSum)
{
	char buff[5];
	int i;
	int c=0;
	int error = FALSE;
	int chk;
		
	for(i=0 ; i < 4 ; i++ )
	{
		c = GetByteTimed (PortNumber);

#ifdef WIN32
		if (Puertos[PortNumber].AbortInProgress)
		{
			FISdebug(2, "Aborción para Verify_Checksum");
			return ERR_ABORT;
		}
#endif
		if ( c < 0 )
		{
			FISdebug (1, "TIMEOUT esperando CheckSum");
            error = TRUE;
			break;
		}
		c = toupper(c);
		if( !isdigit(c) && c < 'A' && c > 'F' )
		{
			FISdebug (2, "Basura esperando CheckSum");
			error = TRUE;  
			break;
		}
		buff[i] = c;
	}
	chk = xtoi(buff);
	FISdebug (1, "Checksum: %s", (chk != CheckSum || error) ? "FAIL" : "OK");
	return ( ( error || chk != CheckSum ) ? ERROR : OK );
} 


