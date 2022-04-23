/*
	libclipp.c

	Implementa las funciones de entrada al protocolo fiscal para
	linkear con CLIPPER.

	Autor: Eduardo Sabaj
	Fecha: 22/10/97
*/

#ifdef __CLIPPER

#include <stdio.h>
#include <string.h>

#include "extend.h"
#include "fiscal.h"
#include "fisdebug.h"
#include "comm.h"

static	char AnswerBuffer[MAX_FISCAL_PORTS][200];

static	unsigned short  FiscalStatus;
static	unsigned short  PrinterStatus;

extern int OpenCommFiscal  		(int PortNumber);
extern int CloseCommFiscal 		(int PortNumber);
extern int MandaPaqueteFiscal 	(int PortNumber, char *Buffer,
	unsigned short *FiscalStatus, unsigned short *PrinterStatus,
	char *AnswerBuffer);
extern void IncrementPacketNumber(int PortNumber);


// Funciones Nuevas.
extern int  SetBaudios 			(int PortNumber, long Baudios);
extern int  SetCommandRetries	(int Retries);
extern int  SetNewProtocol		(int Value);
extern void ObtenerNumeroDePaquetes (int *Enviado, int *Recibido);

extern int  ObtenerStatusImpresor(int PortNumber, unsigned short *FiscalStatus, 
	unsigned short *PrinterStatus, 	char *AnswerBuffer);
	
extern int SearchPrn 			(int PortNumber, long *Baud);
	
CLIPPER
OpenPort (void)
{
	int Handler;
	int NroCom = 0;

	if ( _parinfo (1) & CHARACTER )
		NroCom = atoi (_parc(1));

	else if ( _parinfo (1) & NUMERIC )
		NroCom = _parni (1);

	if ( !NroCom )
	{
		Handler = -1;
		_retni (Handler);
	}
	else
	{
		Handler = OpenCommFiscal (NroCom);
		_retni (Handler);
	}
}

CLIPPER
ClosePort (void)
{
	CloseCommFiscal (_parni (1));
	_ret();
}

CLIPPER
MandaPaq (void)
{
	int PortNumber = _parni (1);
	char *Buffer   = _parc  (2);
	int Result;

	Result = MandaPaqueteFiscal (PortNumber,
		Buffer, &FiscalStatus, &PrinterStatus, AnswerBuffer[PortNumber]);

	_retni (Result);
}


CLIPPER
Respuesta (void)
{
	_retc (AnswerBuffer[_parni(1)]);
}

CLIPPER
InitFiscal (void)
{
	char *StatusString = "*";
	int Handler = _parni (1);
	int Result;

	FISdebug (3, "Entro en InitPrinter");

	/******************************************************************/
	/* Mando dos request de status para sincronizar un posible packet */
	/* mismatch.													  */
	/******************************************************************/

	FISdebug (2, "Init Status Request #1:");

	MandaPaqueteFiscal (Handler,
		StatusString, &FiscalStatus, &PrinterStatus, AnswerBuffer[Handler]);

	FISdebug (2, "Init Status Request #2:");
	IncrementPacketNumber(Handler);

	Result = MandaPaqueteFiscal (Handler,
		StatusString, &FiscalStatus, &PrinterStatus, AnswerBuffer[Handler]);

	_retni (Result);
}

CLIPPER 
EnviarByte (void)
{
	int PortNumber;
	int Result;
	int Byte;

	// El primer parametro debe ser numerico y el segundo, caracter.

	if ( (_parinfo (1) & NUMERIC) && (_parinfo (2) & CHARACTER) )
	{
		PortNumber = _parni (1);
		Byte = *(_parc(2));
	}

	else 
	{
		Result = -1;
		_retni (Result);
	}

	Result = SendByte (PortNumber, Byte);

	_retni (Result);
}

CLIPPER 
LeerByte (void)
{
	char Byte[2] = {0};
	int c, Timeout;
	int PortNumber;
	int Result;

	// El primer parametro debe ser numerico 

	if ( (_parinfo (1) & NUMERIC) && (_parinfo(2) & NUMERIC))
	{
		PortNumber = _parni (1);
		Timeout    = _parni (2);
	}

	else 
	{
		Result = -1;
		_retni (Result);
	}

	if ( Timeout )
		c = Result = GetByteTimed (PortNumber);
	else 
		Result = GetByte (PortNumber, &c);

	Byte[0] = Result == ERROR ? 0 : c;
	_retc(Byte);
}

CLIPPER 
CantBytes (void)
{
	int PortNumber;
	int Result;

	// El primer parametro debe ser numerico 

	if ( _parinfo (1) & NUMERIC )
		PortNumber = _parni (1);

	else 
	{
		Result = -1;
		_retni (Result);
	}
	
	Result = SpaceUsedInBuffer (PortNumber);

	_retni (Result);
}

/******************************************************************************
 ** 	Funciones Nuevas
 **/

CLIPPER 
SetBaud( void ) 
{ 
	int 	PortNumber;
	long	Baudios;
	int		Result		= -1;

	if( _parinfo( 1 ) & NUMERIC )
		PortNumber = _parni( 1 );
	else 
		_retni( Result );

	if( _parinfo( 2 ) & NUMERIC )
		Baudios = _parnl( 2 );
	else 
		_retni( Result );

	Result = SetBaudios( PortNumber, Baudios );

	_retni( Result );
}

CLIPPER 
SetRetries( void )
{
	int		Retries;
	int		Result 	= -1;

	if( _parinfo( 1 ) & NUMERIC )
		Retries = _parni( 1 );
	else 
		_retni( Result );

	Result = SetCommandRetries( Retries );

	_retni( Result ); 
} 

CLIPPER 
NProtocol( void )
{ 
	int		Value; 
	int		Result	= -1;	

	if( _parinfo( 1 ) & NUMERIC )
		Value = _parni( 1 );
	else 
		_retni( Result );

	Result = SetNewProtocol( Value );

	_retni( Result );
}

CLIPPER 
GetNumPaq( void )
{
	int		Enviado;
	int		Recibido;
	int     CmdRecibido;

	char *	PEnviado 	= _parc (1);
	char *	PRecibido 	= _parc (2);

	ObtenerNumeroDePaquetes( &Enviado, &Recibido, &CmdRecibido );

	*PEnviado 	= (char) Enviado;
	*PRecibido	= (char) Recibido;
}

CLIPPER 
GetStatus( void )
{
	int		PortNumber;
	char *	AnswerBuffer;
	int		Result	= -1;

	if( _parinfo( 1 ) & NUMERIC )
		PortNumber = _parni( 1 );
	else 
		_retni( Result );

	AnswerBuffer = _parc( 2 );

	Result = ObtenerStatusImpresor( PortNumber, &FiscalStatus, 
				&PrinterStatus, AnswerBuffer );

	_retni( Result );
}

CLIPPER 
SearchPr( void )
{
	int		PortNumber;
	long 	Baud = -1L;

	if( _parinfo( 1 ) & NUMERIC )
		PortNumber = _parni( 1 );
	else 
		_retnl( Baud );

	SearchPrn( PortNumber, &Baud );

	_retnl( Baud );
}
	
#endif
