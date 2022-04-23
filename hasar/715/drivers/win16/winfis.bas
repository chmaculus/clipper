Attribute VB_Name = "WinFis16"
Option Explicit

Declare Function MandaPaqueteFiscal Lib "WinFis16" (ByVal Handler As Integer, ByVal Name As String) As Integer
Declare Function UltimaRespuesta Lib "WinFis16" (ByVal Handler As Integer, ByVal Buffer As String) As Integer
Declare Function UltimoStatus Lib "WinFis16" (ByVal Handler As Integer, ByRef FiscalStatus As Integer, ByRef PrinterStatus As Integer) As Integer
Declare Function OpenComFiscal Lib "WinFis16" (ByVal Puerto As Integer, ByVal Mode As Integer) As Integer
Declare Sub CloseComFiscal Lib "WinFis16" (ByVal Handler As Integer)
Declare Function InitFiscal Lib "WinFis16" (ByVal Handler As Integer) As Integer
Declare Function VersionDLLFiscal Lib "WinFis16" () As Integer
Declare Sub BusyWaitingMode Lib "WinFis16" (ByVal Mode as Integer)

Public Const MODE_ASCII = 0
Public Const MODE_ANSI = 1

Public Const BUSYWAITING_OFF = 0
Public Const BUSYWAITING_ON = 1

Public Const ERROR = -1
Public Const ERR_HANDLER = -2
Public Const ERR_ATOMIC = -3
Public Const ERR_TIMEOUT = -4
Public Const ERR_ALREADYOPEN = -5
Public Const ERR_NOMEM = -6
Public Const ERR_NOTOPENYET = -7
Public Const ERR_INVALIDPTR = -8

