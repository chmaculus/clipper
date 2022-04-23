Attribute VB_Name = "WinFis32"
'// ########################################################################################
'//  CIA. HASAR SAIC - GRUPO HASAR                                Impresoras Fiscales Hasar
'//  VBasic 6.0 - SP3 - winfis32.dll 3.01                           Versión 1.00
'//  Ejemplo de uso
'// ########################################################################################
Option Explicit

'// Funciones disponibles en winfis32.dll
'// -----------------------------------
Declare Function OpenComFiscal Lib "winfis32" (ByVal Puerto As Long, ByVal Mode As Long) As Long
Declare Function ReOpenComFiscal Lib "winfis32" (ByVal Puerto As Long) As Long
Declare Sub CloseComFiscal Lib "winfis32" (ByVal Handler As Long)
Declare Function MandaPaqueteFiscal Lib "winfis32" (ByVal Handler As Long, ByVal Buffer As String) As Long
Declare Function UltimaRespuesta Lib "winfis32" (ByVal Handler As Long, ByVal Buffer As String) As Long
Declare Function UltimoStatus Lib "winfis32" (ByVal Handler As Long, ByRef FiscalStatus As Integer, ByRef PrinterStatus As Integer) As Long
Declare Function VersionDLLFiscal Lib "winfis32" () As Long
Declare Function InitFiscal Lib "winfis32" (ByVal Handler As Long) As Long
Declare Sub BusyWaitingMode Lib "winfis32" (ByVal Mode As Long)
Declare Function CambiarVelocidad Lib "winfis32" (ByVal Handler As Long, ByVal NewSpeed As Long) As Long
Declare Sub ProtocolMode Lib "winfis32" (ByVal Mode As Long)
Declare Function SetCommandRetries Lib "winfis32" (ByVal Handler As Long) As Long
Declare Function SearchPrn Lib "winfis32" (ByVal Handler As Long) As Long
'Declare Sub SetKeepAliveHandler Lib "winfis32" (ByVal filelog As String)
Declare Sub SetKeepAliveHandlerStdCall Lib "winfis32" (ByVal Ptr As Long)
Declare Sub Abort Lib "winfis32" (ByVal Handler As Long)
Declare Function ObtenerNumeroDePaquetes Lib "winfis32" (ByVal Handler As Long, ByRef Paqsend As Long, ByRef Paqrec As Long, ByRef Idcmd As String) As Long
Declare Sub SetFileLog Lib "winfis32" (ByVal filelog As String)

Public Const MODE_ANSI = 1              '// Usar caracteres ANSI.
Public Const MODE_ASCII = 0             '// Usar caracteres ASCII.

Public Const BUSYWAITING_OFF = 0        '// Control en la DLL.
Public Const BUSYWAITING_ON = 1         '// Control en el software fiscal.

Public Const OLD_PROTOCOL = 0           '// Pasar a protocolo viejo.
Public Const NEW_PROTOCOL = 1           '// Pasar a protocolo nuevo.

'// Errores devueltos por las funciones de la DLL
'// ---------------------------------------------
Public Const ERROR = -1                 '// Error general DLL.
Public Const ERR_HANDLER = -2           '// Handler inválido.
Public Const ERR_ATOMIC = -3            '// Intento de enviar un comando cuando se está
                                        '// procesando el anterior.
Public Const ERR_TIMEOUT = -4           '// Error de comunicaciones.
Public Const ERR_ALREADYOPEN = -5       '// Puerto ya abierto.
Public Const ERR_NOMEM = -6             '// Memoria host insuficiente.
Public Const ERR_NOTOPENYET = -7        '// Intento de usar un puerto no abierto.
Public Const ERR_INVALIDPTR = -8        '// La dirección del buffer de respuesta es inválida.
Public Const ERR_STATPRN = -9           '// El comando no finalizó, sino que volvió una res-
                                        '// puesta tipo STAT_PRN.
Public Const ERR_ABORT = -10            '// El proceso en curso fue abortado




'Sub ManejadorDeMantengaseVivo(ByVal Razon As Long, ByVal Puerto As Long)
    'Debug.Print "KeepAlive; Razon: " & Razon & " Puerto: " & Puerto
'End Sub

'Cuando carga el form main
'Sub PonerManejadorDeMantengaseVivo()
    'SetKeepAliveHandlerStdCall AddressOf ManejadorDeMantengaseVivo
'End Sub

