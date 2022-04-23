#include <windows.h>
#include <stdio.h>

#include "winfis.h"

void
main (int argc, char *argv[])
{
	int h;
	int port;
	char Buffer[500];
	char comando[100];

	if ( argc != 2 ) 
	{
		printf ("Uso: %s nroport", argv[0]);
		exit (1);
	}

	port = atoi (argv[1]);

	h = OpenComFiscal (port,1);

	printf ("OpenComFiscal retorna %d\n", h);

	if ( h < 0 )
		exit (1);
	
	comando = "*";
	MandaPaqueteFiscal (h, comando);
	UltimaRespuesta (h, Buffer);
	printf ("Status : %s\n", Buffer);

	comando = "d93";
	MandaPaqueteFiscal (h, comando);
	UltimaRespuesta (h, Buffer);
	printf ("Respuesta: %s\n", Buffer);

	comando = "bEmpresa Equis30702383923NCDomicilio Desconocido";
	MandaPaqueteFiscal (h, comando);
	UltimaRespuesta (h, Buffer);
	printf ("Respuesta: %s\n", Buffer);

	comando = "@AS";
	MandaPaqueteFiscal (h, comando);
	UltimaRespuesta (h, Buffer);
	printf ("Respuesta: %s\n", Buffer);

	comando = "BItem Uno110021M%100b";
	MandaPaqueteFiscal (h, comando);
	UltimaRespuesta (h, Buffer);
	printf ("Respuesta: %s\n", Buffer);

	comando = "CPSubtotal0";
	MandaPaqueteFiscal (h, comando);
	UltimaRespuesta (h, Buffer);
	printf ("Respuesta: %s\n", Buffer);

	comando = "DEfectivo Pesos141.50T0";
	MandaPaqueteFiscal (h, comando);
	UltimaRespuesta (h, Buffer);
	printf ("Respuesta: %s\n", Buffer);

	comando = "E";
	MandaPaqueteFiscal (h, comando);
	UltimaRespuesta (h, Buffer);
	printf ("Respuesta: %s\n", Buffer);

	comando = "™";
	MandaPaqueteFiscal (h, comando);
	UltimaRespuesta (h, Buffer);
	printf ("Respuesta: %s\n", Buffer);

	CloseComFiscal (h);
}
