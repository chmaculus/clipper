*============================================================================
* Cia. HASAR SAIC     Grupo HASAR - Dto. Software de Base
*                     por Ricardo D. Cardenes
  
* Ejemplo:            Foxpro 2.0 
* Requiere:           Cargar fiscal.sys via archivo config.sys de la PC
*                     Disparar lptfis.exe en la sesion DOS donde correra su
*                     su aplicacion
* Consultar:          publtick.pdf - drivers.pdf
* Valido para:        Impresoras fiscales HASAR
* Modelos:            SMH/P-PR5F v1.00
*
* Emision de:         Factura "A" ( Documento Fiscal )
*============================================================================
set talk on
store space(500) to respuesta
Se = CHR(28)	
Fin = CHR(10)

* Se abre ( modo binario ) el archivo para lectura / escritura
* Hacerlo al levantar la aplicacion
* ------------------------------------------------------------
fp = fopen("c:\fisprn",2)

	* Si hay un documento abierto se lo cancela. Si no se pudo cancelar,
	* se intenta cerrarlo.
	* Genera comandos: Cancel y CloseFiscalReceipt
	* ------------------------------------------------------------------	
	s = CHR(152) + Fin
	=Enviar (s)
	
	s = "E" + Fin
	=Enviar (s)
	
	* Genera comando: SetCustomerData
	* ---------------------------------------------------------------------
	s = "b" + Se + "Razon Social..." + Se + "99999999995" + Se + "I" + Se + "C" + Se + "Domicilio..." + Fin
	=Enviar (s)

	* Genera comando: OpenFiscalReceipt
	* ---------------------------------
	s = "@" + Se + "A" + Se + "T" + Fin
	=Enviar (s)

	* Genera comando: PrintFiscalText
	* -------------------------------------------------
	s = "A" + Se + "Texto Fiscal..." + Se + "0" + Fin
	=Enviar(s)

	* Genera comando: PrintLineitem
	* -----------------------------
	s = "B" + Se + "Articulo 1" + Se + "2.0" + Se + "10.0" + Se + "21.0" + Se + "M" + Se + "0.0" + Se + "0" + Se + "T" + Fin
	=Enviar (s)

	* Genera comando: LastItemDiscount
	* --------------------------------
	s = "U" + Se + "Oferta Ult. Venta..." + Se + "1.0" + Se + "m" + Se + "0" + Se + "T" + Fin
	=Enviar(s)
	
	* Genera comando: ReturnRecharge
	* ----------------------------------
	s = "m" + Se + "Bonif Iva21..." + Se + "1.0" + Se + "21.00" + Se + "m" + Se + "0.0" + Se + "0" + Se + "T" + Se + "B" + Fin
	=Enviar(s)
	
	* Genera comando: GeneralDiscount
	* -------------------------------
	s = "T" + Se + "Financiero..." + Se + "10.0" + Se + "M" + Se + "0" + Se + "T" + Fin
	=Enviar(s)
	
	* Genera comando: TotalTender
	* ---------------------------
	s = "D" + Se + "Pago..." + Se + "10.0" + Se + "T" + Se + "0" + Fin
	=Enviar(s)

	* Genera comando: CloseFiscalReceipt
	* ----------------------------------
	s = "E" + Fin
	=Enviar (s)

* Se cierra el archivo - Hacerlo al bajar la aplicacion
* -----------------------------------------------------
=fclose(fp)

**==========================================================================
** Funcion que envia un comando a la impresora fiscal.
**========================================================================== 

function Enviar

parameters string


if fp < 0 
	Wait Window "No se puede abrir el puerto"
	quit
endif

* Se escribe el comando en el archivo "fisprn"
*---------------------------------------------
n = fwrite (fp, string)

if n <= 0
	? "Error enviando el comando"
	return -1
endif

* Se lle la respuesta desde el archivo "fisprn"
*----------------------------------------------
respuesta = fread (fp, 500)

return 0

