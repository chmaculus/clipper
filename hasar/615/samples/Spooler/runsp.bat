@echo off
rem ########################################################################
rem ##         Cia. HASAR saic - Depto. Software de Base                  ##
rem ##         por Ricardo D. Cardenes                                    ##
rem ##                                                                    ##
rem ##   Ejemplo de uso del programa SPOOLER.EXE en dos de sus formas:    ##
rem ##                                                                    ##
rem ##   a) Leyendo comandos desde archivo ( solamente en comercios au-   ##
rem ##      torizados por AFIP para impresion diferida )                  ##
rem ##                                                                    ##
rem ##   b) Invocacion comando a comando ( forma valida por Resolucion    ##
rem ##      AFIP )  -- IMPRESION CONCOMITANTE --                          ##
rem ########################################################################

cls
if "%1"=="" goto noparam
if exist spooler.log del spooler.log

echo .
echo .
echo .+++++++++++++++++++ MODELO DE IMPRESORA FISCAL ++++++++++++++++++++++++
echo .                    ==========================
echo .
echo .           1      SMH / P-320F / P-321F / P-322F / P-330F
echo .           2      -- SALIR -- ( no hacer nada )
echo .
echo .+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
echo .
echo .

choice /c:12 ......Su opci¢n es...
if errorlevel 2 goto final
if errorlevel 1 goto genfact
goto final

rem ########################################################################
rem      EJEMPLOS DE EMISION DE DOCUMENTOS CON IMPRESORAS FISCALES
rem      MODELOS:       SMH / P-320F / PJ-20F / PL-8F
rem ########################################################################

:genfact
cls
echo .
echo .
echo .++++++++++++++++++++++ DOCUMENTO A EMITIR ++++++++++++++++++++++++++++
echo .                       ==================
echo .
echo .           1      Emitir Factura "A"
echo .           2      Emitir Nota de CrÇdito "A"
echo .           3      Emitir Recibo "X"
echo .           4      Emitir Cotizaci¢n o Presupuesto
echo .           5      Emitir Remito / Orden de Salida
echo .           6      Emitir Resumen de Cuenta / Cargo Habitaci¢n
echo .           7      Emitir Documento No Fiscal
echo .           8      -- ABORTAR -- Ejecuci¢n del Programa
echo .
echo .++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
echo .
echo .

choice /c:12345678 ......Su opcion es...
if errorlevel 8 goto final
if errorlevel 7 goto gendnf
if errorlevel 6 goto gencta
if errorlevel 5 goto genrto
if errorlevel 4 goto gencot
if errorlevel 3 goto genrx
if errorlevel 2 goto gennc
if errorlevel 1 goto genfa

rem ###----------------------------------------------------------------###
rem ### Emision de una Factura "A"                                     ###
rem ### Es obligacion de la aplicacion realizar el analisis de la res- ###
rem ### puesta generada por el programa spooler.exe                    ###
rem ###                                                                ###
rem ### Modo de empleo solo en comercios autorizados por AFIP para     ###
rem ### emplear impresion diferida.                                    ###
rem ###----------------------------------------------------------------###

:genfa
cls
echo .
echo . ********************************************************
echo . ***   El Spooler leyendo comandos desde un archivo   ***
echo . *** IMPRESION DIFERIDA -- Solo con autorizaci¢n AFIP ***
echo . ********************************************************
echo .
pause
cls

rem ... Aqui se deja que el spooler muestre ...
rem ... sus mensajes por pantalla           ...
rem ...........................................
echo .
echo . Enviando comandos desde archivo a la impresora fiscal
echo .
echo . Por Favor.....Espere !!
echo .
spooler -p%1  -f fa.320
if errorlevel 1 goto problem1

cls
echo .
echo ......Archivo fa.320 con los comandos a ejecutar
echo .
type fa.320
echo .
pause

cls
echo .
echo ......Archivo fa.ans respuestas a los comandos ejecutados
echo .
type fa.ans
echo .
pause

cls
echo .
echo ......Archivo spooler.log mensajes de esta prueba
echo .
type spooler.log
echo .
pause
goto facte

rem ###----------------------------------------------------------------###
rem ### Emision de una Factura "A"                                     ###
rem ### Es obligacion de la aplicacion realizar el analisis de la res- ###
rem ### puesta generada por el programa spooler.exe                    ###
rem ###                                                                ###
rem ### Modo exigido por AFIP - Concomitante                           ###
rem ### El comando "pause" indica que alli va la captura de datos      ###
rem ###----------------------------------------------------------------###

:facte
cls
echo .
echo . ********************************************************
echo . ***   El Spooler enviando comandos de a uno por vez  ***
echo . ***    IMPRESION CONCOMITANTE -- Exigida por AFIP    ***
echo . ********************************************************
echo .
pause

rem ... Se le indica al spooler, con el parametro -m ...
rem ... que no muestre mensajes por pantalla         ...
rem ....................................................
cls
echo .
echo . *** Se envian los datos del cliente ***
if exist respuest.ans del respuest.ans
echo .
echo ......Comando Fiscal......
echo . bEmpresa Equis30702383923ICDomicilio Desconocido
echo .
spooler -m -p%1  -e -c "bEmpresa Equis30702383923ICDomicilio Desconocido"
if errorlevel 6 goto problem6
if errorlevel 5 goto problem5
if errorlevel 4 goto problem4
if errorlevel 3 goto problem3
if errorlevel 2 goto problem2
if errorlevel 1 goto problem1
goto sigo

:problem6
echo .
echo . *********************************
echo . * Impresora Fiscal              *
echo . * ERROR Fatal en Comando Fiscal *
echo . *********************************
echo .
goto final

:problem5
echo .
echo . ****************************************
echo . * SPOOLER                              *
echo . * ERROR tratando de abrir puerto serie *
echo . ****************************************
echo .
goto final

:problem4
echo .
echo . ***********************************************
echo . * SPOOLER                                     *
echo . * ERROR tratando de abrir archivo de comandos *
echo . ***********************************************
echo .
goto final

:problem3
echo .
echo . *************************************************
echo . * SPOOLER                                       *
echo . * ERROR tratando de abrir archivo de respuestas *
echo . *************************************************
echo .
goto final

:problem2
echo .
echo . ******************************************** 
echo . * SPOOLER                                  *
echo . * ERROR de comunicaciones con la impresora *
echo . ********************************************
echo .
goto final

:sigo
echo .
echo ......Respuesta recibida......
type respuest.ans
echo .
echo ..........................................................
echo . La respuesta recibida debe ser analizada por el programa
echo . Si todo anduvo bien, entonces ...
echo . Enviar siguiente comando fiscal
echo ..........................................................
echo .
pause

cls
echo .
echo . *** Se pide abrir una Factura "A" ***
del respuest.ans
echo .
echo ......Comando Fiscal......
echo . @AT
echo .
spooler -p%1  -e -c "@AT"
if errorlevel 1 goto problem1

echo .
echo ......Respuesta recibida......
rem  Aqui el programa debe revisar la respuesta y actuar en consecuencia
type respuest.ans
echo .
echo ..........................................................
echo . La respuesta recibida debe ser analizada por el programa
echo . Si todo anduvo bien, entonces ...
echo . Enviar siguiente comando fiscal
echo ..........................................................
echo .
pause

cls
echo .
echo . *** Se realiza la venta de un item ***
del respuest.ans
echo .
echo ......Comando Fiscal......
echo . BItem Uno30.01.021.0M0.00b
echo .
spooler -p%1  -e -c "BItem Uno30.01.021.0M0.00b"
if errorlevel 1 goto problem1

echo .
echo ......Respuesta recibida......
type respuest.ans
echo .
echo ..........................................................
echo . La respuesta recibida debe ser analizada por el programa
echo . Si todo anduvo bien, entonces ...
echo . Enviar siguiente comando fiscal
echo ..........................................................
echo .
pause

cls
echo .
echo . *** Se realiza la venta de un item ***
del respuest.ans
echo .
echo ......Comando Fiscal......
echo . BItem Dos1.020.8110.0M0.8950b
echo .
spooler -p%1  -e -c "BItem Dos1.020.8110.0M0.8950b"
if errorlevel 1 goto problem1

echo .
echo ......Respuesta recibida......
type respuest.ans
echo .
echo ..........................................................
echo . La respuesta recibida debe ser analizada por el programa
echo . Si todo anduvo bien, entonces ...
echo . Enviar siguiente comando fiscal
echo ..........................................................
echo .
pause

cls
echo .
echo . *** Se pide el subtotal de lo facturado ***
del respuest.ans
echo .
echo ......Comando Fiscal......
echo . CPSubtotal0
echo .
spooler -p%1  -e -c "CPSubtotal0"
if errorlevel 1 goto problem1

echo .
echo ......Respuesta recibida......
type respuest.ans
echo .
echo ..........................................................
echo . La respuesta recibida debe ser analizada por el programa
echo . Si todo anduvo bien, entonces ...
echo . Enviar siguiente comando fiscal
echo ..........................................................
echo .
pause

cls
echo .
echo . *** Se registra un pago ***
del respuest.ans
echo .
echo ......Comando Fiscal......
echo . DEfectivo100.00T0
echo .
spooler -p%1  -e -c "DEfectivo100.00T0"
if errorlevel 1 goto problem1

echo .
echo ......Respuesta recibida......
type respuest.ans
echo .
echo ..........................................................
echo . La respuesta recibida debe ser analizada por el programa
echo . Si todo anduvo bien, entonces ...
echo . Enviar siguiente comando fiscal
echo ..........................................................
echo .
pause

cls
echo .
echo . *** Se pide el cierre de la factura ***
del respuest.ans
echo .
echo ......Comando Fiscal......
echo . E
echo .
spooler -p%1  -e -c "E"
if errorlevel 1 goto problem1

echo .
echo ......Respuesta recibida......
type respuest.ans
echo .
echo ..........................................................
echo . La respuesta recibida debe ser analizada por el programa
echo . Si todo anduvo bien, entonces ...
echo . Enviar siguiente comando fiscal
echo ..........................................................
echo .
pause

goto final

rem ######################################################################

rem ###----------------------------------------------------------------###
rem ### Emision de una Nota de Credito "A"                             ###
rem ### Es obligacion de la aplicacion realizar el analisis de la res- ###
rem ### puesta generada por el programa spooler.exe                    ###
rem ###                                                                ###
rem ### Modo de empleo solo en comercios autorizados por AFIP para     ###
rem ### emplear impresion diferida.                                    ###
rem ###----------------------------------------------------------------###

:gennc
cls
echo .
echo . ********************************************************
echo . ***   El Spooler leyendo comandos desde un archivo   ***
echo . *** IMPRESION DIFERIDA -- Solo con autorizaci¢n AFIP ***
echo . ********************************************************
echo .
pause
cls

rem ... Aqui se deja que el spooler muestre ...
rem ... sus mensajes por pantalla           ...
rem ...........................................
echo .
echo . Enviando comandos de archivo a la impresora fiscal
echo .
echo . Por Favor...Espere !!
echo .
spooler -p%1  -f nca.320
if errorlevel 1 goto problem1

cls
echo .
echo ......Archivo nca.320 con los comandos a ejecutar
echo .
type nca.320
echo .
pause

cls
echo .
echo ......Archivo nca.ans respuestas a los comandos ejecutados
echo .
type nca.ans
echo .
pause

rem ###----------------------------------------------------------------###
rem ### Emision de una Nota de Credito "A"                             ###
rem ### Es obligacion de la aplicacion realizar el analisis de la res- ###
rem ### puesta generada por el programa spooler.exe                    ###
rem ###                                                                ###
rem ### Modo exigido por AFIP - Concomitante                           ###
rem ### El comando "pause" indica que alli va la captura de datos      ###
rem ###----------------------------------------------------------------###

cls
echo .
echo . ********************************************************
echo . ***   El Spooler enviando comandos de a uno por vez  ***
echo . ***    IMPRESION CONCOMITANTE -- Exigida por AFIP    ***
echo . ********************************************************
echo .
pause

cls
echo .
echo . *** Se envian los datos del cliente ***
if exist respuest.ans del respuest.ans
echo .
echo ......Comando Fiscal......
echo . bEl Cliente de Siempre99999999995ICDomicilio: El mismo de toda la vida
echo .
spooler -p%1  -e -c "bEl Cliente de Siempre99999999995ICDomicilio: El mismo de toda la vida"
if errorlevel 1 goto problem1

echo .
echo ......Respuesta recibida......
type respuest.ans
echo .
pause

cls
echo .
echo . *** Se envia el numero de Comprobante Original ( Factura ) ***
if exist respuest.ans del respuest.ans
echo .
echo ......Comando Fiscal......
echo . ì19998-00000123
echo .
spooler -p%1  -e -c "ì19998-00000123"
if errorlevel 1 goto problem1

echo .
echo ......Respuesta recibida......
type respuest.ans
echo .
pause

cls
echo .
echo . *** Se pide abrir la Nota de Credito A ***
if exist respuest.ans del respuest.ans
echo .
echo ......Comando Fiscal......
echo . ÄRT1
echo .
spooler -p%1  -e -c "ÄRT1"
if errorlevel 1 goto problem1

echo .
echo ......Respuesta recibida......
type respuest.ans
echo .
pause

cls
echo .
echo . *** Impresion de un item ***
if exist respuest.ans del respuest.ans
echo .
echo ......Comando Fiscal......
echo . BProducto Uno101021M00T
echo .
spooler -p%1  -e -c "BProducto Uno101021M00T"
if errorlevel 1 goto problem1

echo .
echo ......Respuesta recibida......
type respuest.ans
echo .
pause

cls
echo .
echo . *** Impresion de un item ***
if exist respuest.ans del respuest.ans
echo .
echo ......Comando Fiscal......
echo . BProducto Dos22021M%100T
echo .
spooler -p%1  -e -c "BProducto Dos22021M%%100T"
if errorlevel 1 goto problem1

echo .
echo ......Respuesta recibida......
type respuest.ans
echo .
pause

cls
echo .
echo . *** Impresion de un item ***
if exist respuest.ans del respuest.ans
echo .
echo ......Comando Fiscal......
echo . BProducto Tres33010.5M00T
echo .
spooler -p%1  -e -c "BProducto Tres33010.5M00T"
if errorlevel 1 goto problem1

echo .
echo ......Respuesta recibida......
type respuest.ans
echo .
pause

cls
echo .
echo . *** Cierre de la Nota de Credito ***
if exist respuest.ans del respuest.ans
echo .
echo ......Comando Fiscal......
echo . Å
echo .
spooler -p%1  -e -c "Å"
if errorlevel 1 goto problem1

echo .
echo ......Respuesta recibida......
type respuest.ans
echo .
pause

goto final

rem ######################################################################

rem ###----------------------------------------------------------------###
rem ### Emision de un Recibo "X"                                       ###
rem ### Es obligacion de la aplicacion realizar el analisis de la res- ###
rem ### puesta generada por el programa spooler.exe                    ###
rem ###                                                                ###
rem ### Modo de empleo solo en comercios autorizados por AFIP para     ###
rem ### emplear impresion diferida.                                    ###
rem ###----------------------------------------------------------------###

:genrx
cls
echo .
echo . ********************************************************
echo . ***   El Spooler leyendo comandos desde un archivo   ***
echo . *** IMPRESION DIFERIDA -- Solo con autorizaci¢n AFIP ***
echo . ********************************************************
echo .
pause
cls

echo .
echo . Enviando comandos desde archivo a la impresora fiscal
echo .
echo . Por Favor.....Espere !!
echo .
spooler -p%1  -f rx.320
if errorlevel 1 goto problem1

cls
echo .
echo ......Archivo rx.320 con los comandos a ejecutar
echo .
type rx.320
echo .
pause

cls
echo .
echo ......Archivo rx.ans respuestas a los comandos ejecutados
echo .
type rx.ans
echo .
pause

rem ###----------------------------------------------------------------###
rem ### Emision de un Recibo "X"                                       ###
rem ### Es obligacion de la aplicacion realizar el analisis de la res- ###
rem ### puesta generada por el programa spooler.exe                    ###
rem ###                                                                ###
rem ### Modo exigido por AFIP - Concomitante                           ###
rem ### El comando "pause" indica que alli va la captura de datos      ###
rem ###----------------------------------------------------------------###

cls
echo .
echo . ********************************************************
echo . ***   El Spooler enviando comandos de a uno por vez  ***
echo . ***    IMPRESION CONCOMITANTE -- Exigida por AFIP    ***
echo . ********************************************************
echo .
pause

cls
echo .
echo . *** Se envian los datos del cliente ***
if exist respuest.ans del respuest.ans
echo .
echo ......Comando Fiscal......
echo . bEmpresa Equis99999999995ICDomicilio: De la Empresa Equis
echo .
spooler -p%1  -e -c "bEmpresa Equis99999999995ICDomicilio: De la Empresa Equis"
if errorlevel 1 goto problem1

echo .
echo ......Respuesta recibida......
type respuest.ans
echo .
pause

cls
echo .
echo . *** Se envia el numero de Comprobante Original ( Factura ) ***
if exist respuest.ans del respuest.ans
echo .
echo ......Comando Fiscal......
echo . ì19998-00000452
echo .
spooler -p%1  -e -c "ì19998-00000452"
if errorlevel 1 goto problem1

echo .
echo ......Respuesta recibida......
type respuest.ans
echo .
pause

cls
echo .
echo . *** Se pide abrir Recibo X ***
if exist respuest.ans del respuest.ans
echo .
echo ......Comando Fiscal......
echo . ÄxT9998-00000001
echo .
spooler -p%1  -e -c "ÄxT9998-00000001"
if errorlevel 1 goto problem1

echo .
echo ......Respuesta recibida......
type respuest.ans
echo .
pause

cls
echo .
echo . *** Impresion de un item ***
if exist respuest.ans del respuest.ans
echo .
echo ......Comando Fiscal......
echo . BNo se imprime110000M00T
echo .
spooler -p%1  -e -c "BNo se imprime110000M00T"
if errorlevel 1 goto problem1

echo .
echo ......Respuesta recibida......
type respuest.ans
echo .
pause

cls
echo .
echo . *** Linea de texto en el Recibo ***
if exist respuest.ans del respuest.ans
echo .
echo ......Comando Fiscal......
echo . óLas facturas a Cuenta Corriente del mes de Noviembre del 2000 y seg£n el siguiente detalle:
echo .
spooler -p%1  -e -c "óLas facturas a Cuenta Corriente del mes de Noviembre del 2000 y seg£n el siguiente detalle:"
if errorlevel 1 goto problem1

echo .
echo ......Respuesta recibida......
type respuest.ans
echo .
pause

cls
echo .
echo . *** Linea de texto en el Recibo ***
if exist respuest.ans del respuest.ans
echo .
echo ......Comando Fiscal......
echo . óDesde la 9998-00000100 hasta la 9998-00000323 ( ambas inclusive )
echo .
spooler -p%1  -e -c "óDesde la 9998-00000100 hasta la 9998-00000323 ( ambas inclusive )"
if errorlevel 1 goto problem1

echo .
echo ......Respuesta recibida......
type respuest.ans
echo .
pause

cls
echo .
echo . *** Cierre del Recibo ***
if exist respuest.ans del respuest.ans
echo .
echo ......Comando Fiscal......
echo . Å
echo .
spooler -p%1  -e -c "Å"
if errorlevel 1 goto problem1

echo .
echo ......Respuesta recibida......
type respuest.ans
echo .
pause

goto final

rem ######################################################################

rem ###----------------------------------------------------------------###
rem ### Emision de una Cotizacion o Presupuesto                        ###
rem ### Es obligacion de la aplicacion realizar el analisis de la res- ###
rem ### puesta generada por el programa spooler.exe                    ###
rem ###                                                                ###
rem ### Modo de empleo solo en comercios autorizados por AFIP para     ###
rem ### emplear impresion diferida.                                    ###
rem ###----------------------------------------------------------------###

:gencot
cls
echo .
echo . ********************************************************
echo . ***   El Spooler leyendo comandos desde un archivo   ***
echo . *** IMPRESION DIFERIDA -- Solo con autorizaci¢n AFIP ***
echo . ********************************************************
echo .
pause
cls

rem ... Aqui se deja que el spooler muestre ...
rem ... sus mensajes por pantalla           ...
rem ...........................................
echo .
echo . Enviando comandos desde archivo a la impresora fiscal
echo .
echo . Por Favor.....Espere !!
echo .
spooler -p%1  -f cot.320
if errorlevel 1 goto problem1

cls
echo .
echo ......Archivo cot.320 con los comandos a ejecutar
echo .
type cot.320
echo .
pause

cls
echo .
echo ......Archivo cot.ans respuestas a los comandos ejecutados
echo .
type cot.ans
echo .
pause

rem ###----------------------------------------------------------------###
rem ### Emision de una Cotizacion o Presupuesto                        ###
rem ### Es obligacion de la aplicacion realizar el analisis de la res- ###
rem ### puesta generada por el programa spooler.exe                    ###
rem ###                                                                ###
rem ### Modo exigido por AFIP - Concomitante                           ###
rem ### El comando "pause" indica que alli va la captura de datos      ###
rem ###----------------------------------------------------------------###

cls
echo .
echo . ********************************************************
echo . ***   El Spooler enviando comandos de a uno por vez  ***
echo . ***    IMPRESION CONCOMITANTE -- Exigida por AFIP    ***
echo . ********************************************************
echo .
pause

cls
echo .
echo . *** Se envian los datos del cliente ***
if exist respuest.ans del respuest.ans
echo .
echo ......Comando Fiscal......
echo . bEl Cliente Potencial99999999995MCDomicilio: Del Cliente Potencial
echo .
spooler -p%1  -e -c "bEl Cliente Potencial99999999995MCDomicilio: Del Cliente Potencial"
if errorlevel 1 goto problem1

echo .
echo ......Respuesta recibida......
type respuest.ans
echo .
pause

cls
echo .
echo . *** Se pide abrir la Cotizacion ***
if exist respuest.ans del respuest.ans
echo .
echo ......Comando Fiscal......
echo . ÄuT9998-00000145
echo .
spooler -p%1  -e -c "ÄuT9998-00000145"
if errorlevel 1 goto problem1

echo .
echo ......Respuesta recibida......
type respuest.ans
echo .
pause

cls
echo .
echo . *** Impresion de un item de cotizacion ***
if exist respuest.ans del respuest.ans
echo .
echo ......Comando Fiscal......
echo . Ñ.0
echo .
spooler -p%1  -e -c "Ñ.0"
if errorlevel 1 goto problem1

echo .
echo ......Respuesta recibida......
type respuest.ans
echo .
pause

cls
echo .
echo . *** Impresion de un item de cotizacion ***
if exist respuest.ans del respuest.ans
echo .
echo ......Comando Fiscal......
echo . Ñ.0
echo .
spooler -p%1  -e -c "Ñ.0"
if errorlevel 1 goto problem1

echo .
echo ......Respuesta recibida......
type respuest.ans
echo .
pause

cls
echo .
echo . *** Impresion de un item de cotizacion ***
if exist respuest.ans del respuest.ans
echo .
echo ......Comando Fiscal......
echo . ÑLas autoridades de la Escuela Normal Nro 270
echo .
spooler -p%1  -e -c "ÑLas autoridades de la Escuela Normal Nro 270"
if errorlevel 1 goto problem1

echo .
echo ......Respuesta recibida......
type respuest.ans
echo .
pause

cls
echo .
echo . *** Impresion de un item de cotizacion ***
if exist respuest.ans del respuest.ans
echo .
echo ......Comando Fiscal......
echo . Ñ.0
echo .
spooler -p%1  -e -c "Ñ.0"
if errorlevel 1 goto problem1

echo .
echo ......Respuesta recibida......
type respuest.ans
echo .
pause

cls
echo .
echo . *** Impresion de un item de cotizacion ***
if exist respuest.ans del respuest.ans
echo .
echo ......Comando Fiscal......
echo . Ñ.0
echo .
spooler -p%1  -e -c "Ñ.0"
if errorlevel 1 goto problem1

echo .
echo ......Respuesta recibida......
type respuest.ans
echo .
pause

cls
echo .
echo . *** Impresion de un item de cotizacion ***
if exist respuest.ans del respuest.ans
echo .
echo ......Comando Fiscal......
echo . ÑServicios de mantenimiento mensual .....................................$ 50.00 .-0
echo .
spooler -p%1  -e -c "ÑServicios de mantenimiento mensual .....................................$ 50.00 .-0"
if errorlevel 1 goto problem1

echo .
echo ......Respuesta recibida......
type respuest.ans
echo .
pause

cls
echo .
echo . *** Impresion de un item de cotizacion ***
if exist respuest.ans del respuest.ans
echo .
echo ......Comando Fiscal......
echo . Ñ.0
echo .
spooler -p%1  -e -c "Ñ.0"
if errorlevel 1 goto problem1

echo .
echo ......Respuesta recibida......
type respuest.ans
echo .
pause

cls
echo .
echo . *** Impresion de un item de cotizacion ***
if exist respuest.ans del respuest.ans
echo .
echo ......Comando Fiscal......
echo . ÑPara detalle de los servicios presupuestados, ver....................... ANEXO I.0
echo .
spooler -p%1  -e -c "ÑPara detalle de los servicios presupuestados, ver....................... ANEXO I.0"
if errorlevel 1 goto problem1

echo .
echo ......Respuesta recibida......
type respuest.ans
echo .
pause

cls
echo .
echo . *** Cierre de la Cotizacion ***
if exist respuest.ans del respuest.ans
echo .
echo ......Comando Fiscal......
echo . Å
echo .
spooler -p%1  -e -c "Å"
if errorlevel 1 goto problem1

echo .
echo ......Respuesta recibida......
type respuest.ans
echo .
pause

goto final

rem ######################################################################

rem ###----------------------------------------------------------------###
rem ### Emision de un Remito / Orden de Salida                         ###
rem ### Es obligacion de la aplicacion realizar el analisis de la res- ###
rem ### puesta generada por el programa spooler.exe                    ###
rem ###                                                                ###
rem ### Modo de empleo solo en comercios autorizados por AFIP para     ###
rem ### emplear impresion diferida.                                    ###
rem ###----------------------------------------------------------------###

:genrto
cls
echo .
echo . ********************************************************
echo . ***   El Spooler leyendo comandos desde un archivo   ***
echo . *** IMPRESION DIFERIDA -- Solo con autorizaci¢n AFIP ***
echo . ********************************************************
echo .
pause
cls

rem ... Aqui se deja que el spooler muestre ...
rem ... sus mensajes por pantalla           ...
rem ...........................................
echo .
echo . Enviando comandos desde archivo a la impresora fiscal
echo .
echo . Por Favor.....Espere !!
echo .
spooler -p%1  -f rto.320
if errorlevel 1 goto problem1

cls
echo .
echo ......Archivo rto.320 con los comandos a ejecutar
echo .
type rto.320
echo .
pause

cls
echo .
echo ......Archivo rto.ans respuestas a los comandos ejecutados
echo .
type rto.ans
echo .
pause

rem ###----------------------------------------------------------------###
rem ### Emision de un Remito / Orden de Salida                         ###
rem ### Es obligacion de la aplicacion realizar el analisis de la res- ###
rem ### puesta generada por el programa spooler.exe                    ###
rem ###                                                                ###
rem ### Modo exigido por AFIP - Concomitante                           ###
rem ### El comando "pause" indica que alli va la captura de datos      ###
rem ###----------------------------------------------------------------###

cls
echo .
echo . ********************************************************
echo . ***   El Spooler enviando comandos de a uno por vez  ***
echo . ***    IMPRESION CONCOMITANTE -- Exigida por AFIP    ***
echo . ********************************************************
echo .
pause

cls
echo .
echo . *** Se envian los datos del cliente ***
if exist respuest.ans del respuest.ans
echo .
echo ......Comando Fiscal......
echo . bEl Cliente Nuestro99999999995NCDomicilio: Ver Base de Datos
echo .
spooler -p%1  -e -c "bEl Cliente Nuestro99999999995NCDomicilio: Ver Base de Datos"
if errorlevel 1 goto problem1

echo .
echo ......Respuesta recibida......
type respuest.ans
echo .
pause

cls
echo .
echo . *** Referencia a una factura ***
if exist respuest.ans del respuest.ans
echo .
echo ......Comando Fiscal......
echo . ì19998-00000897
echo .
spooler -p%1  -e -c "ì19998-00000897"
if errorlevel 1 goto problem1

echo .
echo ......Respuesta recibida......
type respuest.ans
echo .
pause

cls
echo .
echo . *** Apertura del Remito ***
if exist respuest.ans del respuest.ans
echo .
echo ......Comando Fiscal......
echo . ÄrT9998-00000432
echo .
spooler -p%1  -e -c "ÄrT9998-00000432"
if errorlevel 1 goto problem1

echo .
echo ......Respuesta recibida......
type respuest.ans
echo .
pause

cls
echo .
echo . *** Impresion de un item en el remito ***
if exist respuest.ans del respuest.ans
echo .
echo ......Comando Fiscal......
echo . ÇBultos x 12 unidades - Jab¢n en povlo x 400 gr120
echo .
spooler -p%1  -e -c "ÇBultos x 12 unidades - Jab¢n en povlo x 400 gr120"
if errorlevel 1 goto problem1

echo .
echo ......Respuesta recibida......
type respuest.ans
echo .
pause

cls
echo .
echo . *** Impresion de un item en el remito ***
if exist respuest.ans del respuest.ans
echo .
echo ......Comando Fiscal......
echo . ÇBultos x 48 unidades - Cuadernos Tapa Dura x 96 Hojas60
echo .
spooler -p%1  -e -c "ÇBultos x 48 unidades - Cuadernos Tapa Dura x 96 Hojas60"
if errorlevel 1 goto problem1

echo .
echo ......Respuesta recibida......
type respuest.ans
echo .
pause

cls
echo .
echo . *** Impresion de un item en el remito ***
if exist respuest.ans del respuest.ans
echo .
echo ......Comando Fiscal......
echo . ÇBultos x 60 unidades - Bol°grafos tipo roller100
echo .
spooler -p%1  -e -c "ÇBultos x 60 unidades - Bol°grafos tipo roller100"
if errorlevel 1 goto problem1

echo .
echo ......Respuesta recibida......
type respuest.ans
echo .
pause

cls
echo .
echo . *** Impresion de un item en el remito ***
if exist respuest.ans del respuest.ans
echo .
echo ......Comando Fiscal......
echo . ÇBultos x 1000 unidades - Etiquetas autoadhesivas10
echo .
spooler -p%1  -e -c "ÇBultos x 1000 unidades - Etiquetas autoadhesivas10"
if errorlevel 1 goto problem1

echo .
echo ......Respuesta recibida......
type respuest.ans
echo .
pause

cls
echo .
echo . *** Impresion de un item en el remito ***
if exist respuest.ans del respuest.ans
echo .
echo ......Comando Fiscal......
echo . ÇBultos x 6 unidades - Canoplas pl†sticas nuevo modelo550
echo .
spooler -p%1  -e -c "ÇBultos x 6 unidades - Canoplas pl†sticas nuevo modelo550"
if errorlevel 1 goto problem1

echo .
echo ......Respuesta recibida......
type respuest.ans
echo .
pause

cls
echo .
echo . *** Impresion de un item en el remito ***
if exist respuest.ans del respuest.ans
echo .
echo ......Comando Fiscal......
echo . ÇBultos x 30 unidades - Gomas l†piz/Tinta10
echo .
spooler -p%1  -e -c "ÇBultos x 30 unidades - Gomas l†piz/Tinta10"
if errorlevel 1 goto problem1

echo .
echo ......Respuesta recibida......
type respuest.ans
echo .
pause

cls
echo .
echo . *** Impresion de un item en el remito ***
if exist respuest.ans del respuest.ans
echo .
echo ......Comando Fiscal......
echo . ÇBultos x 12 unidades - Detergente por 1 Lts40
echo .
spooler -p%1  -e -c "ÇBultos x 12 unidades - Detergente por 1 Lts40"
if errorlevel 1 goto problem1

echo .
echo ......Respuesta recibida......
type respuest.ans
echo .
pause

cls
echo .
echo . *** Cierre del Remito ***
if exist respuest.ans del respuest.ans
echo .
echo ......Comando Fiscal......
echo . Å
echo .
spooler -p%1  -e -c "Å"
if errorlevel 1 goto problem1

echo .
echo ......Respuesta recibida......
type respuest.ans
echo .
pause

goto final

rem ######################################################################

rem ###----------------------------------------------------------------###
rem ### Emision de un Resumen de Cuenta / Cargo a la Habitacion        ###
rem ### Es obligacion de la aplicacion realizar el analisis de la res- ###
rem ### puesta generada por el programa spooler.exe                    ###
rem ###                                                                ###
rem ### Modo de empleo solo en comercios autorizados por AFIP para     ###
rem ### emplear impresion diferida.                                    ###
rem ###----------------------------------------------------------------###

:gencta
cls
echo .
echo . ********************************************************
echo . ***   El Spooler leyendo comandos desde un archivo   ***
echo . *** IMPRESION DIFERIDA -- Solo con autorizaci¢n AFIP ***
echo . ********************************************************
echo .
pause
cls

rem ... Aqui se deja que el spooler muestre ...
rem ... sus mensajes por pantalla           ...
rem ...........................................
echo .
echo . Enviando comandos desde archivo a la impresora fiscal
echo .
echo . Por Favor.....Espere !!
echo .
spooler -p%1  -f rcta.320
if errorlevel 1 goto problem1

cls
echo .
echo ......Archivo rcta.320 con los comandos a ejecutar
echo .
type rcta.320
echo .
pause

cls
echo .
echo ......Archivo rcta.ans respuestas a los comandos ejecutados
echo .
type rcta.ans
echo .
pause

rem ###----------------------------------------------------------------###
rem ### Emision de un Resumen de Cuenta / Cargo a la Habitacion        ###
rem ### Es obligacion de la aplicacion realizar el analisis de la res- ###
rem ### puesta generada por el programa spooler.exe                    ###
rem ###                                                                ###
rem ### Modo exigido por AFIP - Concomitante                           ###
rem ### El comando "pause" indica que alli va la captura de datos      ###
rem ###----------------------------------------------------------------###

cls
echo .
echo . ********************************************************
echo . ***   El Spooler enviando comandos de a uno por vez  ***
echo . ***    IMPRESION CONCOMITANTE -- Exigida por AFIP    ***
echo . ********************************************************
echo .
pause

cls
echo .
echo . *** Se envian los datos del cliente ***
if exist respuest.ans del respuest.ans
echo .
echo ......Comando Fiscal......
echo . bEl Cliente Golondrina99999999995MCDomicilio: No Especificado
echo .
spooler -p%1  -e -c "bEl Cliente Golondrina99999999995MCDomicilio: No Especificado"
if errorlevel 1 goto problem1

echo .
echo ......Respuesta recibida......
type respuest.ans
echo .
pause

cls
echo .
echo . *** Se abre el resumen de Cuenta ***
if exist respuest.ans del respuest.ans
echo .
echo ......Comando Fiscal......
echo . ÄtT9998-00000895
echo .
spooler -p%1  -e -c "ÄtT9998-00000895"
if errorlevel 1 goto problem1

echo .
echo ......Respuesta recibida......
type respuest.ans
echo .
pause

cls
echo .
echo . *** Impresion de un item en el resumen ***
if exist respuest.ans del respuest.ans
echo .
echo ......Comando Fiscal......
echo . É0011039998-00000123Servicio de Abono Mantenimiento50.0000
echo .
spooler -p%1  -e -c "É0011039998-00000123Servicio de Abono Mantenimiento50.0000"
if errorlevel 1 goto problem1

echo .
echo ......Respuesta recibida......
type respuest.ans
echo .
pause

cls
echo .
echo . *** Impresion de un item en el resumen ***
if exist respuest.ans del respuest.ans
echo .
echo ......Comando Fiscal......
echo . É0011039998-00000135Reparaciones Sucursal 1150.0000
echo .
spooler -p%1  -e -c "É0011039998-00000135Reparaciones Sucursal 1150.0000"
if errorlevel 1 goto problem1

echo .
echo ......Respuesta recibida......
type respuest.ans
echo .
pause

cls
echo .
echo . *** Impresion de un item en el resumen ***
if exist respuest.ans del respuest.ans
echo .
echo ......Comando Fiscal......
echo . É0011039998-00000165Repuestos para Sucursal 23330.0000
echo .
spooler -p%1  -e -c "É0011039998-00000165Repuestos para Sucursal 23330.0000"
if errorlevel 1 goto problem1

echo .
echo ......Respuesta recibida......
type respuest.ans
echo .
pause

cls
echo .
echo . *** Impresion de un item en el resumen ***
if exist respuest.ans del respuest.ans
echo .
echo ......Comando Fiscal......
echo . É0011039998-00000198Vi†ticos y estad°a TÇcnicos1000.0000
echo .
spooler -p%1  -e -c "É0011039998-00000198Vi†ticos y estad°a TÇcnicos1000.0000"
if errorlevel 1 goto problem1

echo .
echo ......Respuesta recibida......
type respuest.ans
echo .
pause

cls
echo .
echo . *** Impresion de un item en el resumen ***
if exist respuest.ans del respuest.ans
echo .
echo ......Comando Fiscal......
echo . É0011039998-00000213Cobertura fuera de abono100.0000
echo .
spooler -p%1  -e -c "É0011039998-00000213Cobertura fuera de abono100.0000"
if errorlevel 1 goto problem1

echo .
echo ......Respuesta recibida......
type respuest.ans
echo .
pause

cls
echo .
echo . *** Cierre del Resumen ***
if exist respuest.ans del respuest.ans
echo .
echo ......Comando Fiscal......
echo . Å
echo .
spooler -p%1  -e -c "Å"
if errorlevel 1 goto problem1

echo .
echo ......Respuesta recibida......
type respuest.ans
echo .
pause

goto final

rem ######################################################################

rem ###----------------------------------------------------------------###
rem ### Emision de un Documento No Fiscal                              ###
rem ### Es obligacion de la aplicacion realizar el analisis de la res- ###
rem ### puesta generada por el programa spooler.exe                    ###
rem ###                                                                ###
rem ### Modo de empleo solo en comercios autorizados por AFIP para     ###
rem ### emplear impresion diferida.                                    ###
rem ###----------------------------------------------------------------###

:gendnf
cls
echo .
echo . ********************************************************
echo . ***   El Spooler leyendo comandos desde un archivo   ***
echo . *** IMPRESION DIFERIDA -- Solo con autorizaci¢n AFIP ***
echo . ********************************************************
echo .
pause
cls

rem ... Aqui se deja que el spooler muestre ...
rem ... sus mensajes por pantalla           ...
rem ...........................................
echo .
echo . Enviando comandos desde archivo a la impresora fiscal
echo .
echo . Por Favor.....Espere !!
echo .
spooler -p%1  -f dnf.320
if errorlevel 1 goto problem1

cls
echo .
echo ......Archivo dnf.320 con los comandos a ejecutar
echo .
type dnf.320
echo .
pause

cls
echo .
echo ......Archivo dnf.ans respuestas a los comandos ejecutados
echo .
type dnf.ans
echo .
pause

rem ###----------------------------------------------------------------###
rem ### Emision de un Documento No Fiscal                              ###
rem ### Es obligacion de la aplicacion realizar el analisis de la res- ###
rem ### puesta generada por el programa spooler.exe                    ###
rem ###                                                                ###
rem ### Modo exigido por AFIP - Concomitante                           ###
rem ### El comando "pause" indica que alli va la captura de datos      ###
rem ###----------------------------------------------------------------###

cls
echo .
echo . ********************************************************
echo . ***   El Spooler enviando comandos de a uno por vez  ***
echo . ***    IMPRESION CONCOMITANTE -- Exigida por AFIP    ***
echo . ********************************************************
echo .
pause

cls
echo .
echo . *** Se abre el Documento No Fiscal ***
if exist respuest.ans del respuest.ans
echo .
echo ......Comando Fiscal......
echo . H
echo .
spooler -p%1  -e -c "H"
if errorlevel 1 goto problem1

echo .
echo ......Respuesta recibida......
type respuest.ans
echo .
pause

cls
echo .
echo . *** Impresion de una linea ***
if exist respuest.ans del respuest.ans
echo .
echo ......Comando Fiscal......
echo . IÙEsta es una linea de texto no fiscal0
echo .
spooler -p%1  -e -c "IÙEsta es una linea de texto no fiscal0"
if errorlevel 1 goto problem1

echo .
echo ......Respuesta recibida......
type respuest.ans
echo .
pause

cls
echo .
echo . *** Impresion de una linea ***
if exist respuest.ans del respuest.ans
echo .
echo ......Comando Fiscal......
echo . IEsta es otra linea de texto no fiscal0
echo .
spooler -p%1  -e -c "IEsta es otra linea de texto no fiscal0"
if errorlevel 1 goto problem1

echo .
echo ......Respuesta recibida......
type respuest.ans
echo .
pause

cls
echo .
echo . *** Impresion de una linea ***
if exist respuest.ans del respuest.ans
echo .
echo ......Comando Fiscal......
echo . IEsta es otra linea de texto no fiscal0
echo .
spooler -p%1  -e -c "IEsta es otra linea de texto no fiscal0"
if errorlevel 1 goto problem1

echo .
echo ......Respuesta recibida......
type respuest.ans
echo .
pause

cls
echo .
echo . *** Impresion de una linea ***
if exist respuest.ans del respuest.ans
echo .
echo ......Comando Fiscal......
echo . IEsta es otra linea de texto no fiscal0
echo .
spooler -p%1  -e -c "IEsta es otra linea de texto no fiscal0"
if errorlevel 1 goto problem1

echo .
echo ......Respuesta recibida......
type respuest.ans
echo .
pause

cls
echo .
echo . *** Impresion de una linea ***
if exist respuest.ans del respuest.ans
echo .
echo ......Comando Fiscal......
echo . IEsta es otra linea de texto no fiscal0
echo .
spooler -p%1  -e -c "IEsta es otra linea de texto no fiscal0"
if errorlevel 1 goto problem1

echo .
echo ......Respuesta recibida......
type respuest.ans
echo .
pause

cls
echo .
echo . *** Impresion de una linea ***
if exist respuest.ans del respuest.ans
echo .
echo ......Comando Fiscal......
echo . IÙEsta es otra linea de texto no fiscal0
echo .
spooler -p%1  -e -c "IÙEsta es otra linea de texto no fiscal0"
if errorlevel 1 goto problem1

echo .
echo ......Respuesta recibida......
type respuest.ans
echo .
pause

cls
echo .
echo . *** Impresion de una linea ***
if exist respuest.ans del respuest.ans
echo .
echo ......Comando Fiscal......
echo . IEsta es otra linea de texto no fiscal0
echo .
spooler -p%1  -e -c "IEsta es otra linea de texto no fiscal0"
if errorlevel 1 goto problem1

echo .
echo ......Respuesta recibida......
type respuest.ans
echo .
pause

cls
echo .
echo . *** Impresion de una linea ***
if exist respuest.ans del respuest.ans
echo .
echo ......Comando Fiscal......
echo . IEsta es otra linea de texto no fiscal0
echo .
spooler -p%1  -e -c "IEsta es otra linea de texto no fiscal0"
if errorlevel 1 goto problem1

echo .
echo ......Respuesta recibida......
type respuest.ans
echo .
pause

cls
echo .
echo . *** Impresion de una linea ***
if exist respuest.ans del respuest.ans
echo .
echo ......Comando Fiscal......
echo . IEsta es otra linea de texto no fiscal0
echo .
spooler -p%1  -e -c "IEsta es otra linea de texto no fiscal0"
if errorlevel 1 goto problem1

echo .
echo ......Respuesta recibida......
type respuest.ans
echo .
pause

cls
echo .
echo . *** Impresion de una linea ***
if exist respuest.ans del respuest.ans
echo .
echo ......Comando Fiscal......
echo . IEsta es otra linea de texto no fiscal0
echo .
spooler -p%1  -e -c "IEsta es otra linea de texto no fiscal0"
if errorlevel 1 goto problem1

echo .
echo ......Respuesta recibida......
type respuest.ans
echo .
pause

cls
echo .
echo . *** Cierre del Documento No Fiscal ***
if exist respuest.ans del respuest.ans
echo .
echo ......Comando Fiscal......
echo . J
echo .
spooler -p%1  -e -c "J"
if errorlevel 1 goto problem1

echo .
echo ......Respuesta recibida......
type respuest.ans
echo .
pause

goto final

rem #########################################################################
rem                     MANEJO DE ALGUNOS ERRORES
rem #########################################################################

:problem1
echo .
echo . ****************************
echo . * SPOOLER                  *
echo . * Se ha producido un ERROR *
echo . ****************************
echo .
goto final

:noparam
echo .
echo .
echo . ***************************************
echo . *** RUNSP                           ***
echo . *** ERROR: Falta indicar puerto COM ***
echo . ***************************************
echo .
echo .

:final
echo .
echo .
echo . ***************************************
echo . ***       Fin de ejecuci¢n          ***
echo . ***************************************
echo .
echo .

