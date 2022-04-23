//============================================================================================
//         Cía. HASAR SAIC - Dto. Software de Base - Impresoras fiscales HASAR
//         por Ricardo D. Cárdenes
//         Se adjunta el ejecutable p715f.exe generado a partir de este archivo fuente
//============================================================================================

#include <windows.h>
#include <stdio.h>
#include "winfis.h"              // Interfaz con las funciones de winfis32.dll

#define FS "\x1c"                // Separador de campos para el armado de strings de comandos

//============================================================================================
//    Ejemplo para impresora fiscal SMH/P-715F v1.00 - Utiliza funciones de winfis32.dll
//    Emite un ticket factura "A"
//    Para mayor información ver:  publtick.pdf
//============================================================================================ 

void
main (int argc, char *argv[])
{
	int h;
	int port;
	char Buffer[500];                            // Para las respuestas de la impresora fiscal
	char comando[500];                           // Para los comandos de la impresora fiscal

	if ( argc != 2 ) 
	{
		printf ("\nUso: %s nroport\n\n", argv[0]);
		exit (1);
	}

	port = atoi (argv[1]);

	// Se habre el puerto serie - Debe hacerse solamente una vez
	// Cuando la aplicación levanta
	//==========================================================
	h = OpenComFiscal (port,1);

	printf ("\nOpenComFiscal retorna %d\n\n", h);

	if ( h < 0 )
	{
		printf ("\nError OpenComFiscal...FIN !!\n\n");
		exit (1);
	}

	//###################### Bucle de emisión de comprobantes ##########################
	
	// Comando: StatusRequest
	//=======================
	strcpy( comando,"*");
	printf ("Comando   : %s\n", comando);
	MandaPaqueteFiscal (h, comando);
	UltimaRespuesta (h, Buffer);
	printf ("Respuesta : %s\n\n", Buffer);

	// Comando: SetCustomerData
	//=========================
	strcpy(comando,"b" FS "Empresa Equis" FS "99999999995" FS "I" FS "C" FS "Domicilio...");
	printf ("Comando  : %s\n", comando);
	MandaPaqueteFiscal (h, comando);
	UltimaRespuesta (h, Buffer);
	printf ("Respuesta: %s\n\n", Buffer);

	// Comando: OpenFiscalReceipt
	//===========================
	strcpy(comando,"@" FS "A" FS "T");
	printf ("Comando  : %s\n", comando);
	MandaPaqueteFiscal (h, comando);
	UltimaRespuesta (h, Buffer);
	printf ("Respuesta: %s\n\n", Buffer);

	// Comando: PrintLineItem
	//=======================
	strcpy(comando,"B" FS "Item Uno" FS "1.0" FS "100.0" FS "21.0" FS "M" FS "0.9090" FS "0" FS "b");
	printf ("Comando  : %s\n", comando);
	MandaPaqueteFiscal (h, comando);
	UltimaRespuesta (h, Buffer);
	printf ("Respuesta: %s\n\n", Buffer);

	// Comando: Subtotal
	//==================
	strcpy(comando,"C" FS "P" FS "Subtotal" FS "0");
	printf ("Comando  : %s\n", comando);
	MandaPaqueteFiscal (h, comando);
	UltimaRespuesta (h, Buffer);
	printf ("Respuesta: %s\n\n", Buffer);

	// Comando: TotalTender
	//=====================
	strcpy(comando,"D" FS "Efectivo Pesos" FS "131.50" FS "T" FS "0");
	printf ("Comando  : %s\n", comando);
	MandaPaqueteFiscal (h, comando);
	UltimaRespuesta (h, Buffer);
	printf ("Respuesta: %s\n\n", Buffer);

	// Comando: CloseFiscalReceipt
	//============================
	strcpy(comando,"E");
	printf ("Comando  : %s\n", comando);
	MandaPaqueteFiscal (h, comando);
	UltimaRespuesta (h, Buffer);
	printf ("Respuesta: %s\n\n", Buffer);

	//############################## Fin del bucle  ###############################

	// Cierre del puerto serie - Debe hacerse solamente una vez
	// Cuando la aplicación se cierra
	//=========================================================
	CloseComFiscal (h);
	printf ( "OK...\n");
}
