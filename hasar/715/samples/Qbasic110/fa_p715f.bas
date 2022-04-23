'//==========================================================================
'// CIA. HASAR SAIC     Grupo HASAR - Dto. Software de Base
'//                     Por Ricardo D. Cardenes
'//
'// Ejemplo:            Qbasic 1.10
'// Requiere:           Cargar fiscal.sys via archivo config.sys de la PC
'//                     Disparar lptfis.exe en la sesion DOS donde correra
'//                     la aplicacion
'//
'// Consultar:          publtick.pdf - drivers.pdf
'//
'// Valido para:        Impresoras fiscales HASAR
'// Modelos:            SMH/P-715F v1.00
'// 
'// Emision de:         Factura "A" ( Documento Fiscal )
'// =========================================================================
DIM Comando AS STRING, Se AS STRING, Fin AS STRING
DIM Respuesta AS STRING * 500
cls

Se = CHR$(28)                          '// Separador de campos en el comando
Fin = CHR$(10)                         '// Terminador requerido por el driver

'// Abrir archivo lectura / escritura
'// ---------------------------------
ON ERROR GOTO ErrorOpen
OPEN "c:\fisprn" FOR BINARY AS #1

	'// Si hay un documento abierto se cancela. Si no se pudo cancelar,
	'// se intenta su cierre
	'// Genera comandos: Cancel y CloseFiscalRceipt
	'// ------------------------------------------------------------------
	ON ERROR GOTO ErrorPut
    Comando = CHR$(152)+Fin                         '// Cancel
	PRINT "Comando: "; Comando
	PUT #1, , Comando

	'// Ver respuesta de la impresora fiscal
	'// ------------------------------------
	ON ERROR GOTO ErrorGet
	GET #1, , Respuesta
	PRINT "Respuesta: "; Respuesta

	ON ERROR GOTO ErrorPut
    Comando = "E"+Fin                                '// CloseFiscalReceipt
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

	'// Apertura Factura "A" 
	'// Genera comando: OpenFiscalReceipt
	'// ---------------------------------
	ON ERROR GOTO ErrorPut
    Comando = "@"+Se+"A"+Se+"T"+Fin
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

	'// Impresion del pago
	'// Genera comando: TotalTender
	'// ---------------------------
	ON ERROR GOTO ErrorPut
    Comando = "D"+Se+"Pago..."+Se+"10.0"+Se+"T"+Se+"0"+Fin
	PRINT "Comando: "; Comando
	PUT #1, , Comando

	'// Ver respuesta de la impresora fiscal
	'// ------------------------------------
	ON ERROR GOTO ErrorGet
	GET #1, , Respuesta
	PRINT "Respuesta: "; Respuesta

	'// Cierre de la Factura
	'// Genera comando: CloseFiscalReceipt
	'//  ----------------------------------
	ON ERROR GOTO ErrorPut
    Comando = "E"+Fin
	PRINT "Comando: "; Comando
	PUT #1, , Comando

	'// Ver respuesta de la impresora fiscal
	'// ------------------------------------
	ON ERROR GOTO ErrorGet
	GET #1, , Respuesta
	PRINT "Respuesta: "; Respuesta
	END

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

