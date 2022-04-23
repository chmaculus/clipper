@echo off
rem ########################################################################
rem ##      Cia. HASAR SAIC - Grupo HASAR - Depto. Software de Base       ##
rem ##      por Ricardo D. Cardenes                                       ##
rem ##                                                                    ##
rem ##           Impresoras fiscales HASAR - SMH/P-715F v1.00             ##
rem ##                                                                    ##
rem ##   Ejemplo de uso del programa SPOOLER.EXE en dos de sus formas:    ##
rem ##                                                                    ##
rem ##   a) Leyendo comandos desde archivo ( solamente en comercios au-   ##
rem ##      torizados por AFIP para impresion diferida )                  ##
rem ##                                                                    ##
rem ##   b) Invocacion comando a comando ( forma valida por Resolucion    ##
rem ##      AFIP )  -- IMPRESION CONCOMITANTE --                          ##
rem ##                                                                    ##
rem ##   Consultar:  publtick.pdf - spooler.pdf                           ##
rem ########################################################################

cls
if "%1"=="" goto noparam
if exist spooler.log del spooler.log

echo .
echo .
echo .+++++++++++++++++++ MODELO DE IMPRESORA FISCAL ++++++++++++++++++++++++
echo .                    ==========================
echo .
echo .                    1      SMH/P-715F v1.00 
echo .                    2      -- SALIR -- 
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
rem ########################################################################

:genfact
cls
echo .
echo .
echo .++++++++++++++++++++++ DOCUMENTO A EMITIR ++++++++++++++++++++++++++++
echo .                       ==================
echo .
echo .           1      Emitir Ticket Factura "A"
echo .           2      Emitir Ticket Nota de CrÇdito "A"
echo .           3      Emitir Documento No Fiscal
echo .           4      -- ABORTAR -- Ejecuci¢n del Programa
echo .
echo .++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
echo .
echo .

choice /c:1234 ......Su opcion es...
if errorlevel 4 goto final
if errorlevel 3 goto gendnf
if errorlevel 2 goto gennc
if errorlevel 1 goto genfa

rem ###----------------------------------------------------------------###
rem ### Emision de un Ticket Factura "A"                               ###
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
spooler -p%1  -f fa.715
if errorlevel 1 goto problem1

cls
echo .
echo ......Archivo fa.715 con los comandos ejecutados
echo .
type fa.715
echo .
pause

cls
echo .
echo ......Archivo fa.ans respuestas a los comandos ejecutados
echo .
type fa.ans
echo .
pause
goto facte

rem ###----------------------------------------------------------------###
rem ### Emision de un Ticket Factura "A"                               ###
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
spooler -m -p%1  -e -c "bEmpresa Equis30702383923ICDomicilio..."
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
echo . *** Se pide abrir un Ticket Factura "A" ***
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
echo . BItem Dos1.020.8110.0M0.00b
echo .
spooler -p%1  -e -c "BItem Dos1.020.8110.0M0.00b"
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
rem ### Emision de un Ticket Nota de Credito "A"                       ###
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
spooler -p%1  -f nca.715
if errorlevel 1 goto problem1

cls
echo .
echo ......Archivo nca.715 con los comandos ejecutados
echo .
type nca.715
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
rem ### Emision de un Ticket Nota de Credito "A"                       ###
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
echo . bCliente...99999999995ICDomicilio...
echo .
spooler -p%1  -e -c "bCliente...99999999995ICDomicilio..."
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
echo . *** Se pide abrir el Ticket Nota de Credito A ***
if exist respuest.ans del respuest.ans
echo .
echo ......Comando Fiscal......
echo . ÄRT
echo .
spooler -p%1  -e -c "ÄRT"
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
echo . BProducto Uno10.010.021.0M0.00T
echo .
spooler -p%1  -e -c "BProducto Uno10.010.021.0M0.00T"
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
echo . BProducto Dos2.020.021.0M0.90900T
echo .
spooler -p%1  -e -c "BProducto Dos2.020.021.0M0.90900T"
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
echo . BProducto Tres3.030.010.5M0.00T
echo .
spooler -p%1  -e -c "BProducto Tres3.030.010.5M0.00T"
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
spooler -p%1  -f dnf.715
if errorlevel 1 goto problem1

cls
echo .
echo ......Archivo dnf.715 con los comandos ejecutados
echo .
type dnf.715
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
echo . IÙtexto no fiscal0
echo .
spooler -p%1  -e -c "IÙtexto no fiscal0"
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
echo . Itexto no fiscal0
echo .
spooler -p%1  -e -c "Itexto no fiscal0"
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
echo . Itexto no fiscal0
echo .
spooler -p%1  -e -c "Itexto no fiscal0"
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
echo . Itexto no fiscal0
echo .
spooler -p%1  -e -c "Itexto no fiscal0"
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
echo . Itexto no fiscal0
echo .
spooler -p%1  -e -c "Itexto no fiscal0"
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
echo . IÙtexto no fiscal0
echo .
spooler -p%1  -e -c "IÙtexto no fiscal0"
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
echo . Itexto no fiscal0
echo .
spooler -p%1  -e -c "Itexto no fiscal0"
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
echo . Itexto no fiscal0
echo .
spooler -p%1  -e -c "Itexto no fiscal0"
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
echo . Itexto no fiscal0
echo .
spooler -p%1  -e -c "Itexto no fiscal0"
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
echo . Itexto no fiscal0
echo .
spooler -p%1  -e -c "Itexto no fiscal0"
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

