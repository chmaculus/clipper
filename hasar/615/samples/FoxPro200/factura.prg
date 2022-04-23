*============================================================================
* Ejemplo:            Foxpro 2.0 
* Requiere:           Cargar fiscal.sys via archivo config.sys de la PC
*                     Disparar lptfis.exe en la sesion DOS donde correra su
*                     su aplicacion
* Consultar:          drivers.doc
* Valido para:        Impresoras fiscales HASAR
* Modelos:            SMH/P-320F / P-321F / P-322F /P-330F
* Manual de comandos: publfact.pdf
*............................................................................
* Emision de:         Documentos Fiscales ( Facturas, Recibos, Notas de Debi-
*                     to ) y Notas de Cr‚dito
* Clase:              "A", "B/C"
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
	
	* Se carga en la memoria de trabajo de la impresora fiscal un codigo de 
	* barras a imprimir ( opcional ).
	* Genera comando: BarCode
	* ---------------------------------------------------------------------
	s = "Z" + Se + "1" + Se + "779123456789" + Se + "N" + Se + "G" + Fin
	=Enviar (s)
	
	* Se cargan en la memoria de trabajo de la impresora fiscal, los datos 
	* del comprador ( opcional en Documentos Fiscales, obligatorio en Notas
	* de Credito ).  
	* Genera comando: SetCustomerData
	* ---------------------------------------------------------------------
	s = "b" + Se + "Razon Social..." + Se + "99999999995" + Se + "I" + Se + "C" + Se + "Domicilio..." + Fin
	=Enviar (s)

	* Se carga en la memoria de trabajo de la impresora fiscal al relacion
	* del documento a emitir con un Remito o una factura, segun corresponda
	* ( opcional en Documentos Fiscales, obligatorio en Notas de Credito )
	* Genera comando: SetEmbarkNumber
	* ---------------------------------------------------------------------
	s = CHR(147) + Se + "1" + Se + "9998-00000123" + Fin
	=Enviar (s)

	* Comando de apertura del Documento 
	* Factura "A"
	* Genera comando: OpenFiscalReceipt
	* ---------------------------------
	s = "@" + Se + "A" + Se + "S" + Fin

	* Nota de Credito "A"
	* Genera comando:  OpenDNFH
	* s = CHR(128) + Se + "R" + Se + "S" + Se + "1"	+ Fin

	=Enviar (s)

	* Impresion Texto Fiscal - solamente previo al item
	* Genera comando: PrintFiscalText
	* -------------------------------------------------
	s = "A" + Se + "Texto Fiscal..." + Se + "0" + Fin
	=Enviar(s)

	* Impresion de item
	* Genera comando: PrintLineitem
	* -----------------------------
	s = "B" + Se + "Articulo 1" + Se + "2.0" + Se + "10.0" + Se + "21.0" + Se + "M" + Se + "0.0" + Se + "0" + Se + "T" + Fin
	=Enviar (s)

	* Descuento sobre ultima venta
	* Genera comando: LastItemDiscount
	* --------------------------------
	s = "U" + Se + "Oferta Ult. Venta..." + Se + "1.0" + Se + "m" + Se + "0" + Se + "T" + Fin
	=Enviar(s)
	
	* Bonificacion a una alicuota de IVA
	* Genera comando: ReturnRecharge
	* ----------------------------------
	s = "m" + Se + "Bonif Iva21..." + Se + "1.0" + Se + "21.00" + Se + "m" + Se + "0.0" + Se + "0" + Se + "T" + Se + "B" + Fin
	=Enviar(s)
	
	* Recargo General
	* Genera comando: GeneralDiscount
	* -------------------------------
	s = "T" + Se + "Financiero..." + Se + "10.0" + Se + "M" + Se + "0" + Se + "T" + Fin
	=Enviar(s)
	
	* Percepciones a aplicar
	* Genera comando: Perception
	* --------------------------
	s = "`" + Se + "21.0" + Se + "Percep IVA 21..." + Se + "5.00" + Fin
	=Enviar (s)
	s = "`" + Se + "**.**" + Se + "Percep Gral..." + Se + "5.00" + Fin
	=Enviar (s)
	
	* Impresion del pago
	* Genera comando: TotalTender
	* ---------------------------
	s = "D" + Se + "Pago..." + Se + "10.0" + Se + "T" + Se + "0" + Fin
	=Enviar(s)

	* Cierre del Documento
	* --------------------
	* Documento Fiscal
	* Genera comando: CloseFiscalReceipt
	* ----------------------------------
	s = "E" + Fin
	
	* Nota de Credito
	* Genera comando: CloseDNFH
	* -------------------------
	* s = CHR(129) + Fin
	
	=Enviar (s)

* Se cierra el archivo - Hacerlo al bajar la aplicacion
* -----------------------------------------------------
=fclose(fp)

**
** Funcion que envia un comando al impresor.
** 

function Enviar

parameters string


if fp < 0 
	Wait Window "No se puede abrir el puerto"
	quit
endif

n = fwrite (fp, string)

if n <= 0
	? "Error enviando el comando"
	return -1
endif

respuesta = fread (fp, 500)



return 0

