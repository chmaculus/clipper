Attribute VB_Name = "WinFis32"
Option Explicit

Declare Function MandaPaqueteFiscal Lib "WinFis32" (ByVal Handler As Long, ByVal Buffer As String) As Long
Declare Function UltimoStatus Lib "WinFis32" (ByVal Handler As Long, ByRef FiscalStatus As Integer, ByRef PrinterStatus As Integer) As Long
Declare Function UltimaRespuesta Lib "WinFis32" (ByVal Handler As Long, ByVal Buffer As String) As Long
Declare Function OpenComFiscal Lib "WinFis32" (ByVal Puerto As Long, ByVal Mode As Long) As Long
Declare Sub CloseComFiscal Lib "WinFis32" (ByVal Handler As Long)
Declare Function InitFiscal Lib "WinFis32" (ByVal Handler As Long) As Long
Declare Function VersionDLLFiscal Lib "WinFis32" () As Long
Declare Sub BusyWaitingMode Lib "WinFis32" (ByVal Mode As Long)
Declare Function CambiarVelocidad Lib "WinFis32" (ByVal Handler As Long, ByVal NewSpeed As Long) As Long
Declare Sub ProtocolMode Lib "WinFis32" (ByVal Mode As Long)
Declare Function SearchPrn Lib "WinFis32" (ByVal Handler As Long) As Long

Public Const MODE_ANSI = 1
Public Const MODE_ASCII = 0

Public Const BUSYWAITING_OFF = 0
Public Const BUSYWAITING_ON = 1

Public Const OLD_PROTOCOL = 0
Public Const NEW_PROTOCOL = 1

Public Const ERROR = -1
Public Const ERR_HANDLER = -2
Public Const ERR_ATOMIC = -3
Public Const ERR_TIMEOUT = -4
Public Const ERR_ALREADYOPEN = -5
Public Const ERR_NOMEM = -6
Public Const ERR_NOTOPENYET = -7
Public Const ERR_INVALIDPTR = -8
Public Const ERR_STATPRN = -9

