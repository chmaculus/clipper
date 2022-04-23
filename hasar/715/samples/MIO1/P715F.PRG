*============================================================================
* Cia. HASAR SAIC     Grupo HASAR - Dto. Software de Base
*                     por Ricardo D. Cardenes
*
* Ejemplo:            Clipper 5.02 - linkeditar con fiscal.lib
* Valido para:        Impresoras fiscales HASAR
* Modelos:            SMH/P-715F v1.00 
* Consultar:          publtick.pdf - drivers.pdf
*
* Emision de:         Ticket Factura "A", y Reporte Z 
*============================================================================
PARAMETERS Com
PUBLIC Handler, Port, n, Se

	* Separador de campos en los comandos a generar
	* ---------------------------------------------
	Se = CHR(28)	

	* Apertura del puerto serie
	* -------------------------
	n = VAL(Com)
	
	if ( n < 0 .OR. n > 4 )
		return
	endif

	Handler = OpenPort (Com)

	* Sincronizar velocidad de la comunicacion serial. No es necesario llamar
	* a esta funcion toda vez que se arranque el programa. 
	* Una vez establecida la velocidad de trabajo, utilizar la funcion
	* SetBaud para fijar la velocidad en la PC.
	* NOTA: otros modelos trabajan unicamente a 9600 baudios
	* -----------------------------------------------------------------------
	BaudRate = SearchPr (Handler)
	? "Controlador Fiscal detectado a " + alltrim(str(BaudRate))

	* Sincronizarse con la impresora fiscal
	* -------------------------------------
	InitFiscal (Handler)

	* Si hay un documento abierto se lo cancela. Si no se pudo cancelar,
	* se intenta cerrarlo.
	* ------------------------------------------------------------------
	CancelDoc ()
	CloseFiscal ()

	* Se carga en la memoria de trabajo de la impresora fiscal el texto de 
	* las lineas de fantasia, encabezamiento y pie del documento.
	* --------------------------------------------------------------------
	CargarTexto ()

    * Emision del Documento
	* ---------------------
    ImprimirDocumento ()
	
	* Reporte de acumulados
	* ---------------------
	ReporteXZ ()

	* Cierre del Puerto serie
	* -----------------------
	ClosePort (Handler)

*############################################################################

*----------------------------------------------------------------------------
* Rutina que intenta cancelar un Documento abierto.
* Genera comando: Cancel
*----------------------------------------------------------------------------
FUNCTION CancelDoc 

	s = CHR(152)
	Enviar (s)

RETURN 0

*----------------------------------------------------------------------------
* Rutina que intenta cerrar un Documento Fiscal abierto.
* Genera comando: CloseFiscalReceipt
*----------------------------------------------------------------------------
FUNCTION CloseFiscal 

	s = "E"
	Enviar (s)

RETURN 0

*----------------------------------------------------------------------------
* Rutina que carga en la memoria de trabajo de la impresora fiscal las lineas
* de fantasia, encabezado y pie del documento.
* Los textos fijos cargarlos en el arranque del programa. Los textos varia-
* cargarlos al emitir el nuevo documento.
*----------------------------------------------------------------------------
FUNCTION CargarTexto 

	* Carga lineas de fantasia
	* Genera comando: SetfantayName
	* -----------------------------
	for i=1 to 2
		linea = alltrim(str(i))
		s = "]" + Se + linea + Se + "Linea " + linea + " Fantasia..."
		Enviar (s)
	next

	* Carga lineas de encabezado
	* Genera comando: SetHeaderTrailer
	* --------------------------------
	for i=1 to 10
		linea = alltrim(str(i))
		s = "]" + Se + linea + Se + "Linea " + linea + " Header..."
		Enviar (s)
	next

	* Carga lineas de pie
	* Genera comando: SetHeaderTrailer
	* --------------------------------
	for i=11 to 20
		linea = alltrim(str(i))
		s = "]" + Se + linea + Se + "Linea " + linea + " Trailer..."
		Enviar (s)
	next

RETURN 0

*----------------------------------------------------------------------------
* Rutina de impresion del Documento.
* El Documento a emitir dependera del comando de apertura. El comando de 
* cierre debera ser coherente al de apertura.
* El cuerpo es valido cualquiera sea el Documento a emitir ( Fiscal o Ticket 
* Nota de Credito ).
*----------------------------------------------------------------------------
FUNCTION ImprimirDocumento

	* Se carga en la memoria de trabajo de la impresora fiscal un codigo de 
	* barras a imprimir ( opcional ).
	* Genera comando: BarCode
	* ---------------------------------------------------------------------
	s = "Z" + Se + "1" + Se + "779123456789" + Se + "N" + Se + "G"
	Enviar (s)

	* Se cargan en la memoria de trabajo de la impresora fiscal, los datos 
	* del comprador ( opcional en Documentos Fiscales, obligatorio en Notas
	* de Credito ).  
	* Genera comando: SetCustomerData
	* ---------------------------------------------------------------------
	s = "b" + Se + "Razon Social..." + Se + "99999999995" + Se + "I" + Se + "C" + Se + "Domicilio..."
	Enviar (s)

	* Se carga en la memoria de trabajo de la impresora fiscal al relacion
	* del documento a emitir con un Remito o una factura, segun corresponda
	* ( opcional en Documentos Fiscales, obligatorio en Notas de Credito )
	* Genera comando: SetEmbarkNumber
	* ---------------------------------------------------------------------
	s = CHR(147) + Se + "1" + Se + "9998-00000123"
	Enviar (s)
	
	* Comando de apertura del Documento 
	* ---------------------------------
	* Ticket Factura "A"
	* Genera comando: OpenFiscalReceipt
	s = "@" + Se + "A" + Se + "T"
	
	* Ticket Nota de Credito "A"
	* Genera comando:  OpenDNFH
	* s = CHR(128) + Se + "R" + Se + "T" + Se + "1"	
	Enviar (s)

	* Impresion Texto Fiscal - solamente previo al item
	* Genera comando: PrintFiscalText
	* -------------------------------------------------
	s = "A" + Se + "Texto Fiscal..." + Se + "0"
	Enviar(s)

	* Impresion de item
	* Genera comando: PrintLineitem
	* -----------------------------
	s = "B" + Se + "Articulo 1" + Se + "2.0" + Se + "10.0" + Se + "21.0" + Se + "M" + Se + "0.0" + Se + "0" + Se + "T"
	Enviar (s)

	* Descuento sobre ultima venta
	* Genera comando: LastItemDiscount
	* --------------------------------
	s = "U" + Se + "Oferta Ult. Venta..." + Se + "1.0" + Se + "m" + Se + "0" + Se + "T"
	Enviar(s)
	
	* Bonificacion a una alicuota de IVA
	* Genera comando: ReturnRecharge
	* ----------------------------------
	s = "m" + Se + "Bonif Iva21..." + Se + "1.0" + Se + "21.00" + Se + "m" + Se + "0.0" + Se + "0" + Se + "T" + Se + "B"
	Enviar(s)
	
	* Recargo General
	* Genera comando: GeneralDiscount
	* -------------------------------
	s = "T" + Se + "Financiero..." + Se + "10.0" + Se + "M" + Se + "0" + Se + "T"
	Enviar(s)
	
	* Percepciones a aplicar
	* Genera comando: Perception
	* --------------------------
	s = "`" + Se + "21.0" + Se + "Percep IVA 21..." + Se + "5.00"
	Enviar (s)
	s = "`" + Se + "**.**" + Se + "Percep Gral..." + Se + "5.00"
	Enviar (s)
	
	* Impresion del pago
	* Genera comando: TotalTender
	* ---------------------------
	s = "D" + Se + "Pago..." + Se + "10.0" + Se + "T" + Se + "0"
	Enviar(s)

	* Cierre del Documento
	* --------------------
	
	* Documento Fiscal
	* Genera comando: CloseFiscalReceipt
	* ----------------------------------
	s = "E" 
	
	* Nota de Credito
	* Genera comando: CloseDNFH
	* -------------------------
	* s = CHR(129)
	
	Enviar (s)
  
RETURN 0

*----------------------------------------------------------------------------
* Rutina que emite el Cierre Diario "X" o "Z".
* Genera el comando: DailyClose
*----------------------------------------------------------------------------
FUNCTION ReporteXZ 

	* Cierre X - Reporte por cambio de turno
	* --------------------------------------
	Enviar ("9" + Se + "X")

	* Cierre Z - Acumulados de la jornada
	* -----------------------------------
	* Enviar ("9" + Se + "Z")
	
return 0

*----------------------------------------------------------------------------
* Rutina para enviar un comando a la impresora fiscal y atrapar la respuesta.
* La inteligencia para el tratamiento de errores es responsabilidad del de-
* sarrollador de software.
*----------------------------------------------------------------------------
FUNCTION Enviar
PARAMETERS String
PRIVATE Result, StatPrn

? "Enviando: " + String

* Si la funcion MandaPaq() retorna un valor menor a cero, se retorna indi-
* cando Error.
* Consultar: drivers.pdf para el tratamiento de estos errores
* ------------------------------------------------------------------------
StatPrn = MandaPaq (Handler, String)
* ? " StatPrn = " + alltrim (str(StatPrn))

IF ( StatPrn < 0 )
	? "Error enviando el comando"
	RETURN -1
ENDIF

* Se obtiene la respuesta de la impresora fiscal
* ----------------------------------------------
Result = Respuesta (Handler)
? "Recibido: " + Result

* Tratamiento de la respuesta recibida
* ------------------------------------
GetErrors (Result)
? " "

RETURN 0

*----------------------------------------------------------------------------
* Rutina que a partir de la respuesta de la impresora fiscal muestra mensajes
* asociados al status de impresora y al status fiscal, de corresponder.
*----------------------------------------------------------------------------
FUNCTION GetErrors
PARAMETERS Resp
PRIVATE Origen, OffsetSep, i, c

DECLARE FiscalErrors [16]
DECLARE PrinterErrors[16]

FiscalErrors[1] = 	"Error en chequeo de memoria fiscal"
FiscalErrors[2] = 	"Error en chequeo de la memoria de trabajo"
FiscalErrors[3] = 	"Carga de bateria baja"
FiscalErrors[4] = 	"Comando desconocido"
FiscalErrors[5] = 	"Datos no validos en un campo"
FiscalErrors[6] = 	"Comando no valido para el estado fiscal actual"
FiscalErrors[7] = 	"Desborde del total"
FiscalErrors[8] = 	"Memoria fiscal llena"
FiscalErrors[9] = 	"Memoria fiscal a punto de llenarse"
FiscalErrors[10] = 	""
FiscalErrors[11] = 	""
FiscalErrors[12] = 	"Error en ingreso de fecha"
FiscalErrors[13] = 	"Documento fiscal abierto"
FiscalErrors[14] = 	"Documento abierto"
FiscalErrors[15] = 	"Factura abierta"
FiscalErrors[16] = 	""

PrinterErrors[1]  = ""
PrinterErrors[2]  = ""
PrinterErrors[3]  = "Error de Impresora"
PrinterErrors[4]  = "Impresora Offline"
PrinterErrors[5]  = "Falta papel del diario"
PrinterErrors[6]  = "Falta papel de tickets"
PrinterErrors[7]  = "Buffer de Impresora lleno"
PrinterErrors[8]  = ""
PrinterErrors[9]  = ""
PrinterErrors[10] = ""
PrinterErrors[11] = ""
PrinterErrors[12] = ""
PrinterErrors[13] = ""
PrinterErrors[14] = ""
PrinterErrors[15] = ""
PrinterErrors[16] = ""

Origen = 0
OffsetSep = AT ( CHR(28), Resp )

* Convierte en hexa el campo de status de impresora
* -------------------------------------------------
PrinterStatus = HexaToInt (SUBSTR ( Resp, Origen, OffsetSep - 1))

IF PrinterStatus < 0 
	RETURN -1
ENDIF

Origen = OffsetSep

* Analiza los bits comenzando del menos significativo
* ---------------------------------------------------
FOR i = 1 TO 16
	IF ( INT (PrinterStatus % 2) == 1 )
		IF ( LEN (PrinterErrors[i]) > 0 )
			? "Status Impresora: " + PrinterErrors[i]
			* Agregar la inteligencia de su tratamiento
		ENDIF
	ENDIF
	PrinterStatus = PrinterStatus / 2	
NEXT

OffsetSep = AT ( CHR(28), SUBSTR (Resp, Origen + 1) )

IF OffsetSep == 0 
	OffsetSep = LEN(Resp)
ENDIF

* Convierte en hexa el status fiscal
* ----------------------------------
FiscalStatus = HexaToInt (SUBSTR (Resp, Origen + 1, OffsetSep - 1))

IF FiscalStatus < 0 
	RETURN -1
ENDIF

* Analiza los bits comenzando del menos significativo
* ---------------------------------------------------
FOR i = 1 TO 16
	IF ( INT (FiscalStatus % 2) == 1 )
		IF ( LEN (FiscalErrors[i]) > 0 )
			? "Status Fiscal: " + FiscalErrors[i]
			* Agregar la inteligencia de su tratamiento
		ENDIF
	ENDIF
	FiscalStatus = FiscalStatus / 2	
NEXT

RETURN 0

*----------------------------------------------------------------------------
* Rutina que convierte un string de digitos hexadecimales en su equivalente
* en binario.
*----------------------------------------------------------------------------
FUNCTION HexaToInt 
PARAMETERS HexValue
PRIVATE i, Value, Status

Status = 0

FOR i = 4 TO 1 STEP -1
	S = SUBSTR(HexValue, i, 1)
	Value = ASC (S)

	IF ( Value >= ASC("A") .AND. Value <= ASC("F") )
		Value = Value - ASC("A") + 10
	ELSEIF ( Value >= ASC("a") .AND. Value <= ASC("f") )
		Value = Value - ASC("a") + 10
	ELSEIF ( Value >= ASC("0") .AND. Value <= ASC("9") )
		Value = Value - ASC("0")
	ELSE
		? "HexaToInt: Digito hexadecimal incorrecto: " + HexValue
		RETURN -1
	ENDIF

	Status = Status + Value * (16 ** ( 4 - i ))

NEXT

RETURN Status

