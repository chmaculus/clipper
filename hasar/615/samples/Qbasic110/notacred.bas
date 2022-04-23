'//==========================================================================
'// CIA. HASAR SAIC     Dto. Software de Base
'//
'// Ejemplo:            Qbasic 1.10
'// Requiere:           Cargar fiscal.sys via archivo config.sys de la PC
'//                     Disparar lptfis.exe en la sesion DOS donde correra
'//                     la aplicacion
'// Consultar:          drivers.doc
'//
'// Valido para:        Impresoras fiscales HASAR
'// Modelos:            SMH/P-320F / P-321F / P-322F /P-330F
'// Manual de comandos: publfact.pdf
'// 
'// Emision de:         Notas de Credito ( Documento No Fiscal Homologado )
'// Clase:              "A", "B/C"
'// =========================================================================
DIM Comando AS STRING, Se AS STRING, Fin AS STRING
DIM Respuesta AS STRING * 500
cls

Se = CHR$(28)                          '// Separador de campos en el comando
Fin = CHR$(10)                         '// Terminador requerido por el driver

'// Abrir archivo lectura / escritura
'// ---------------------------------
ON ERROR GOTO ErrorOpen
OPEN "fisprn" FOR BINARY AS #1

	'// Si hay un documento abierto se cancela. Si no se pudo cancelar,
	'// se intenta su cierre
	'// Genera comandos: Cancel y CloseFiscalRceipt
	'// ------------------------------------------------------------------
	ON ERROR GOTO ErrorPut
    Comando = CHR$(152)+Fin                          '// Cancel     
	PRINT "Comando: "; Comando
	PUT #1, , Comando

	'// Ver respuesta de la impresora fiscal
	'// ------------------------------------
	ON ERROR GOTO ErrorGet
	GET #1, , Respuesta
	PRINT "Respuesta: "; Respuesta

	ON ERROR GOTO ErrorPut
    Comando = "E"+Fin                                 '// CloseFiscalReceipt
	PRINT "Comando: "; Comando
	PUT #1, , Comando

	'// Ver respuesta de la impresora fiscal
	'// ------------------------------------
	ON ERROR GOTO ErrorGet
	GET #1, , Respuesta
	PRINT "Respuesta: "; Respuesta

	'// Se carga en la memoria de trabajo de la impresora fiscal un codigo de 
	'// barras -- EAN13 -- a imprimir ( opcional ).
	'// Genera comando: BarCode
	'// ---------------------------------------------------------------------
	ON ERROR GOTO ErrorPut
    Comando = "Z"+Se+"1"+Se+"779123456789"+Se+"N"+Se+"G"+Fin
	PRINT "Comando: "; Comando
	PUT #1, , Comando

	'// Ver respuesta de la impresora fiscal
	'// ------------------------------------
	ON ERROR GOTO ErrorGet
	GET #1, , Respuesta
	PRINT "Respuesta: "; Respuesta

	'// Se cargan en la memoria de trabajo de la impresora fiscal, los datos 
	'// del comprador -- Responsable Inscripto -- ( obligatorio )  
	'// Genera comando: SetCustomerData
	'// ---------------------------------------------------------------------
	ON ERROR GOTO ErrorPut
    Comando = "b"+Se+"Razon Social..."+Se+"99999999995"+Se+"I"+Se+"C"+Se+"Domicilio..."+Fin
	PRINT "Comando: "; Comando
	PUT #1, , Comando

	'// Ver respuesta de la impresora fiscal
	'// ------------------------------------
	ON ERROR GOTO ErrorGet
	GET #1, , Respuesta
	PRINT "Respuesta: "; Respuesta

	'// Se carga en la memoria de trabajo de la impresora fiscal la relacion
	'// de la Nota de Credito con un Remito o una Factura, segun corresponda
	'// ( obligatorio )
	'// Genera comando: SetEmbarkNumber
	'// ---------------------------------------------------------------------
	ON ERROR GOTO ErrorPut
    Comando = CHR$(147)+Se+"1"+Se+"9998-00000123"+Fin
	PRINT "Comando: "; Comando
	PUT #1, , Comando

	'// Ver respuesta de la impresora fiscal
	'// ------------------------------------
	ON ERROR GOTO ErrorGet
	GET #1, , Respuesta
	PRINT "Respuesta: "; Respuesta

	'// Apertura Nota de Credito "A" 
	'// Genera comando: OpenDNFH
	'// ----------------------------
	ON ERROR GOTO ErrorPut
	Comando = CHR$(128)+Se+"R"+Se+"S"+Se+"1"+Fin	
	PRINT "Comando: "; Comando
	PUT #1, , Comando

	'// Ver respuesta de la impresora fiscal
	'// ------------------------------------
	ON ERROR GOTO ErrorGet
	GET #1, , Respuesta
	PRINT "Respuesta: "; Respuesta

	'// Impresion Texto Fiscal - solamente previo al item
	'// Genera comando: PrintFiscalText
	'// -------------------------------------------------
	ON ERROR GOTO ErrorPut
    Comando = "A"+Se+"Texto Fiscal..."+Se+"0"+Fin
	PRINT "Comando: "; Comando
	PUT #1, , Comando

	'// Ver respuesta de la impresora fiscal
	'// ------------------------------------
	ON ERROR GOTO ErrorGet
	GET #1, , Respuesta
	PRINT "Respuesta: "; Respuesta

	'// Impresion de item
	'// Genera comando: PrintLineitem
	'// -----------------------------
	ON ERROR GOTO ErrorPut
    Comando = "B"+Se+"Articulo 1"+Se+"2.0"+Se+"10.0"+Se+"21.0"+Se+"M"+Se+"0.0"+Se+"0"+Se+"T"+Fin
	PRINT "Comando: "; Comando
	PUT #1, , Comando

	'// Ver respuesta de la impresora fiscal
	'// ------------------------------------
	ON ERROR GOTO ErrorGet
	GET #1, , Respuesta
	PRINT "Respuesta: "; Respuesta

	'// Descuento sobre ultima venta
	'// Genera comando: LastItemDiscount
	'// --------------------------------
	ON ERROR GOTO ErrorPut
    Comando = "U"+Se+"Oferta Ult. Venta..."+Se+"1.0"+Se+"m"+Se+"0"+Se+"T"+Fin
	PRINT "Comando: "; Comando
	PUT #1, , Comando

	'// Ver respuesta de la impresora fiscal
	'// ------------------------------------
	ON ERROR GOTO ErrorGet
	GET #1, , Respuesta
	PRINT "Respuesta: "; Respuesta

	'// Bonificacion a una alicuota de IVA
	'// Genera comando: ReturnRecharge
	'// ----------------------------------
	ON ERROR GOTO ErrorPut
    Comando = "m"+Se+"Bonif Iva21..."+Se+"1.0"+Se+"21.00"+Se+"m"+Se+"0.0"+Se+"0"+Se+"T"+Se+"B"+Fin
	PRINT "Comando: "; Comando
	PUT #1, , Comando

	'// Ver respuesta de la impresora fiscal
	'// ------------------------------------
	ON ERROR GOTO ErrorGet
	GET #1, , Respuesta
	PRINT "Respuesta: "; Respuesta

	'// Recargo General
	'// Genera comando: GeneralDiscount
	'// -------------------------------
	ON ERROR GOTO ErrorPut
    Comando = "T"+Se+"Financiero..."+Se+"10.0"+Se+"M"+Se+"0"+Se+"T"+Fin
	PRINT "Comando: "; Comando
	PUT #1, , Comando

	'// Ver respuesta de la impresora fiscal
	'// ------------------------------------
	ON ERROR GOTO ErrorGet
	GET #1, , Respuesta
	PRINT "Respuesta: "; Respuesta

	'// Percepciones a aplicar
	'// Genera comando: Perception
	'// --------------------------
	
	'// Precepcion a una alicuota de IVA
	'// --------------------------------
	ON ERROR GOTO ErrorPut
    Comando = "`"+Se+"21.0"+Se+"Percep IVA 21..."+Se+"5.00"+Fin
	PRINT "Comando: "; Comando
	PUT #1, , Comando

	'// Ver respuesta de la impresora fiscal
	'// ------------------------------------
	ON ERROR GOTO ErrorGet
	GET #1, , Respuesta
	PRINT "Respuesta: "; Respuesta

	'// Percepcion General
	'// ------------------
	ON ERROR GOTO ErrorPut
    Comando = "`"+Se+"**.**"+Se+"Percep Gral..."+Se+"5.00"+Fin
	PRINT "Comando: "; Comando
	PUT #1, , Comando

	'// Ver respuesta de la impresora fiscal
	'// ------------------------------------
	ON ERROR GOTO ErrorGet
	GET #1, , Respuesta
	PRINT "Respuesta: "; Respuesta

	'// Cierre de la Nota de Credito
	'// Genera comando: CloseDNFH
	'// ----------------------------
	ON ERROR GOTO ErrorPut
	Comando = CHR$(129)+Fin
	PRINT "Comando: "; Comando
	PUT #1, , Comando

	'// Ver respuesta de la impresora fiscal
	'// ------------------------------------
	ON ERROR GOTO ErrorGet
	GET #1, , Respuesta
	PRINT "Respuesta: "; Respuesta

'// Tratamiento de errores muy elemental
'// Falta analisis campos de status
'// ------------------------------------
ErrorOpen:
	PRINT "Error abriendo driver"
	END

ErrorPut:
	PRINT "Error escribiendo comando"
	END

ErrorGet:
	PRINT "Error obteniendo respuesta"
	END

