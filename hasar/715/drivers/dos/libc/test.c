#include <stdio.h>
#include <stdlib.h>
#include <dos.h>

#include "fislib.h"
#include "fiserr.h"


#define CMD_STATPRN			0xa1


void
SendCommandString (int Port, char *Command)
{
	static char Respuesta[500];
	unsigned short FiscalStatus, PrinterStatus;

	unsigned char ComandoEnviado = *Command;

	int Result = MandaPaqueteFiscal (Port, Command, 
							&FiscalStatus, &PrinterStatus, 
							Respuesta);

	if ( Result != OK ) {
		if ( Result == ERR_STATPRN ) {
			if ( ComandoEnviado != CMD_STATPRN ) {
				do {
					Result = ObtenerStatusImpresor (Port,  
						&FiscalStatus, &PrinterStatus, Respuesta);
					printf("Sending STATPRN: %s\n", Respuesta);
					sleep(1);
				} while ( Result == ERR_STATPRN );
			}
		}
		else {
			printf ("ERROR: Error sending packet\n");
			exit (1);
		}
	}

	printf ("Answer: %s\n", Respuesta);
}

int 
main(int argc, char *argv[])
{
	int PortNumber = atoi(argv[1]);
	int Port;

    if ((Port = OpenCommFiscal(PortNumber)) < 0)
	{
		printf ("ERROR: Can't open COM%d\n", PortNumber);
		exit (1);
	}

	printf ("Running on COM%d...\n", PortNumber);	
	
	SendCommandString (Port, "*");
	SendCommandString (Port, "9X");

	CloseCommFiscal(Port);
	return 0;
}

