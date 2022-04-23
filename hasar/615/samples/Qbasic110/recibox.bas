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
'// Emision de:         Recibo ( Documento No Fiscal Homologado ) 
'// Clase:              "X"
'// ============================================================================
DIM Comando AS STRING, Se AS STRING, Fin AS STRING
DIM Respuesta AS STRING * 500
cls

Se = CHR$(28)                '// Separador de campos en el comando
Fin = CHR$(10)               '// Terminador comando - requerido por el driver

'// Abrir archivo lectura / escritura
'// ---------------------------------
ON ERROR GOTO ErrorOpen
OPEN "fisprn" FOR BINARY AS #1

	'// Si hay un documento abierto se cancela. Si no se pudo cancelar,
	'// se intenta su cierre.
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
    Comando = "E"+Fin                              '// CloseFiscalReceipt
	PRINT "Comando: "; Comando
	PUT #1, , Comando

	'// Ver respuesta de la impresora fiscal
	'// ------------------------------------
	ON ERROR GOTO ErrorGet
	GET #1, , Respuesta
	PRINT "Respuesta: "; Respuesta

	'// Se cargan en la memoria de trabajo de la impresora fiscal, los datos 
	'// del comprador -- Responsable Inscripto -- ( opcional )  
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
	'// del Recibo "X" con un Remito o una factura, segun corresponda
	'// ( opcional )
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

	'// Apertura del Recibo "X" 
	'// Genera comando:  OpenDNFH
	'// ---------------------------------
	ON ERROR GOTO ErrorPut
	Comando = CHR$(128)+Se+"x"+Se+"S"+Se+"1"+Fin	
	PRINT "Comando: "; Comando
	PUT #1, , Comando

	'// Ver respuesta de la impresora fiscal
	'// ------------------------------------
	ON ERROR GOTO ErrorGet
	GET #1, , Respuesta
	PRINT "Respuesta: "; Respuesta

	'// Generar monto del Recibo "X"
	'// Genera comando: PrintLineitem
	'// -------------------------------------------------
	ON ERROR GOTO ErrorPut
    Comando = "B"+Se+"No se imprime"+Se+"1.0"+Se+"1500.0"+Se+"0.0"+Se+"M"+Se+"0.0"+Se+"0"+Se+"T"+Fin
	PRINT "Comando: "; Comando
	PUT #1, , Comando

	'// Ver respuesta de la impresora fiscal
	'// ------------------------------------
	ON ERROR GOTO ErrorGet
	GET #1, , Respuesta
	PRINT "Respuesta: "; Respuesta

	'// Impresion texto del concepto
	'// Genera comando: ReceiptText
	'// ----------------------------
	ON ERROR GOTO ErrorPut
    Comando = CHR$(151)+Se+"Texto 1 detalle Recibo"+Fin
	PRINT "Comando: "; Comando
	PUT #1, , Comando

	'// Ver respuesta de la impresora fiscal
	'// ------------------------------------
	ON ERROR GOTO ErrorGet
	GET #1, , Respuesta
	PRINT "Respuesta: "; Respuesta

	ON ERROR GOTO ErrorPut
    Comando = CHR$(151)+Se+"Texto 2 detalle Recibo"+Fin
	PRINT "Comando: "; Comando
	PUT #1, , Comando

	'// Ver respuesta de la impresora fiscal
	'// ------------------------------------
	ON ERROR GOTO ErrorGet
	GET #1, , Respuesta
	PRINT "Respuesta: "; Respuesta

	'// Cierre del Recibo "X"
	'// Genera comando: CloseDNFH
	'// -------------------------
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
'// Agregar todo el analisis de los campos de status
'// ------------------------------------------------
ErrorOpen:
	PRINT "Error abriendo driver"
	END

ErrorPut:
	PRINT "Error escribiendo comando"
	END

ErrorGet:
	PRINT "Error obteniendo respuesta"
	END

