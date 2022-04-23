* ==========================================================================
* CIA. HASAR SAIC     Dto. Software de Base
*
* Ejemplo:            Foxpro 2.0 
* Requiere:           Cargar fiscal.sys via archivo config.sys de la PC
*                     Disparar lptfis.exe en la sesion DOS donde correra su
*                     su aplicacion
* Consultar:          drivers.doc
*
* Valido para:        Impresoras fiscales HASAR
* Modelos:            SMH/P-320F / P-321F / P-322F /P-330F
* Manual de comandos: publfact.pdf
* 
* Emision de:         Recibo ( Documento No Fiscal Homologado )
* Clase:              "X"
* ==========================================================================
set talk on
store space(500) to respuesta
Se = CHR(28)	                        
Fin = CHR(10)                           

* Se abre archivo para lectura / escritura
* ----------------------------------------
fp = fopen("c:\fisprn",2)

	* Si hay un documento abierto se cancela. Si no se pudo cancelar,
	* se intenta su cierre
	* Genera comandos: Cancel y CloseFiscalReceipt
	* ------------------------------------------------------------------	
	s = CHR(152) + Fin                                  
	=Enviar (s)
	
	s = "E" + Fin                                       
	=Enviar (s)
	
	* Se cargan en la memoria de trabajo de la impresora fiscal, los datos 
	* del comprador -- Responsable Inscripto -- ( opcional )  
	* Genera comando: SetCustomerData
	* ---------------------------------------------------------------------
	s = "b" + Se + "Razon Social..." + Se + "99999999995" + Se + "I" + Se + "C" + Se + "Domicilio..." + Fin
	=Enviar (s)

	* Se carga en la memoria de trabajo de la impresora fiscal la relacion
	* del Recibo con un Remito o una Factura, segun corresponda
	* ( opcional )
	* Genera comando: SetEmbarkNumber
	* ---------------------------------------------------------------------
	s = CHR(147) + Se + "1" + Se + "9998-00000123" + Fin
	=Enviar (s)

	* Apertura Recibo "X" 
	* Genera comando: OpenDNFH
	* ------------------------
	s = CHR(128) + Se + "R" + Se + "S" + Se + "1"	+ Fin
	=Enviar (s)

	* Se genera el monto del Recibo "X"
	* Genera comando: PrintLineitem
	* ---------------------------------
	s = "B" + Se + "No se imprime..." + Se + "1.0" + Se + "1500.0" + Se + "0.0" + Se + "M" + Se + "0.0" + Se + "0" + Se + "T" + Fin
	=Enviar (s)

	* Impresion de los conceptos
	* Genera comando: ReceiptText
	* ---------------------------
	s = CHR(151) + Se + "Texto 1 detalle en Recibo..." + Fin
	=Enviar(s)

	s = CHR(151) + Se + "Texto 2 detalle en Recibo..." + Fin
	=Enviar(s)

	* Cierre del Recibo "X"
	* Genera comando: CloseDNFH
	* -------------------------
	s = CHR(129) + Fin
	=Enviar (s)

* Se cierra el archivo 
* --------------------
=fclose(fp)

* ==========================================================================
*  Funcion que envia un comando a la impresora fiscal
* ==========================================================================
function Enviar
parameters string

if fp < 0 
	Wait Window "No se puede abrir el puerto"
	quit
endif

* Se envia el comando
* -------------------
n = fwrite (fp, string)

if n <= 0
	? "Error enviando el comando"
	return -1
endif

* Respuesta de la impresora fiscal
* --------------------------------
respuesta = fread (fp, 500)




return 0

