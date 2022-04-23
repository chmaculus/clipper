VERSION 5.00
Object = "{6B7E6392-850A-101B-AFC0-4210102A8DA7}#1.3#0"; "COMCTL32.OCX"
Object = "{F9043C88-F6F2-101A-A3C9-08002B2F49FB}#1.2#0"; "COMDLG32.OCX"
Object = "{D9AF33E0-7C55-11D5-9151-0000E856BC17}#1.0#0"; "FISCAL010724.OCX"
Begin VB.Form FrmMain 
   BorderStyle     =   1  'Fixed Single
   ClientHeight    =   4275
   ClientLeft      =   150
   ClientTop       =   435
   ClientWidth     =   4245
   ForeColor       =   &H00400040&
   Icon            =   "FrmMain.frx":0000
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   ScaleHeight     =   4275
   ScaleWidth      =   4245
   StartUpPosition =   2  'CenterScreen
   Begin VB.Frame Frame1 
      Height          =   3855
      Left            =   0
      TabIndex        =   1
      Top             =   0
      Width           =   4215
      Begin FiscalPrinterLibCtl.HASAR HASAR1 
         Left            =   2880
         OleObjectBlob   =   "FrmMain.frx":0442
         Top             =   2640
      End
      Begin VB.Image ImgLogo 
         BorderStyle     =   1  'Fixed Single
         Height          =   3495
         Left            =   120
         Picture         =   "FrmMain.frx":0466
         Stretch         =   -1  'True
         ToolTipText     =   "Cía. Hasar SAIC"
         Top             =   240
         Width           =   3945
      End
   End
   Begin VB.Timer Timer1 
      Interval        =   1000
      Left            =   1200
      Top             =   2160
   End
   Begin ComctlLib.StatusBar StatusBar1 
      Align           =   2  'Align Bottom
      Height          =   375
      Left            =   0
      TabIndex        =   0
      Top             =   3900
      Width           =   4245
      _ExtentX        =   7488
      _ExtentY        =   661
      SimpleText      =   ""
      _Version        =   327682
      BeginProperty Panels {0713E89E-850A-101B-AFC0-4210102A8DA7} 
         NumPanels       =   6
         BeginProperty Panel1 {0713E89F-850A-101B-AFC0-4210102A8DA7} 
            Object.Width           =   1835
            MinWidth        =   1835
            TextSave        =   ""
            Key             =   "Fecha"
            Object.Tag             =   ""
         EndProperty
         BeginProperty Panel2 {0713E89F-850A-101B-AFC0-4210102A8DA7} 
            Object.Width           =   1058
            MinWidth        =   1058
            TextSave        =   ""
            Key             =   "Hora"
            Object.Tag             =   ""
         EndProperty
         BeginProperty Panel3 {0713E89F-850A-101B-AFC0-4210102A8DA7} 
            Style           =   4
            AutoSize        =   2
            Enabled         =   0   'False
            Object.Width           =   1058
            MinWidth        =   1058
            TextSave        =   "SCRL"
            Key             =   "Scroll"
            Object.Tag             =   ""
         EndProperty
         BeginProperty Panel4 {0713E89F-850A-101B-AFC0-4210102A8DA7} 
            Style           =   3
            Enabled         =   0   'False
            Object.Width           =   1058
            MinWidth        =   1058
            TextSave        =   "INS"
            Key             =   "Insert"
            Object.Tag             =   ""
         EndProperty
         BeginProperty Panel5 {0713E89F-850A-101B-AFC0-4210102A8DA7} 
            Style           =   2
            Object.Width           =   1058
            MinWidth        =   1058
            TextSave        =   "NUM"
            Key             =   "Num"
            Object.Tag             =   ""
         EndProperty
         BeginProperty Panel6 {0713E89F-850A-101B-AFC0-4210102A8DA7} 
            Style           =   1
            Enabled         =   0   'False
            Object.Width           =   1058
            MinWidth        =   1058
            TextSave        =   "CAPS"
            Key             =   "Caps"
            Object.Tag             =   ""
         EndProperty
      EndProperty
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
   End
   Begin MSComDlg.CommonDialog CommonDialog 
      Left            =   3120
      Top             =   2040
      _ExtentX        =   847
      _ExtentY        =   847
      _Version        =   393216
   End
   Begin ComctlLib.ImageList ImageList1 
      Left            =   2160
      Top             =   2040
      _ExtentX        =   1005
      _ExtentY        =   1005
      BackColor       =   -2147483643
      ImageWidth      =   32
      ImageHeight     =   32
      MaskColor       =   12632256
      _Version        =   327682
      BeginProperty Images {0713E8C2-850A-101B-AFC0-4210102A8DA7} 
         NumListImages   =   12
         BeginProperty ListImage1 {0713E8C3-850A-101B-AFC0-4210102A8DA7} 
            Picture         =   "FrmMain.frx":71EE
            Key             =   ""
         EndProperty
         BeginProperty ListImage2 {0713E8C3-850A-101B-AFC0-4210102A8DA7} 
            Picture         =   "FrmMain.frx":7508
            Key             =   ""
         EndProperty
         BeginProperty ListImage3 {0713E8C3-850A-101B-AFC0-4210102A8DA7} 
            Picture         =   "FrmMain.frx":7822
            Key             =   ""
         EndProperty
         BeginProperty ListImage4 {0713E8C3-850A-101B-AFC0-4210102A8DA7} 
            Picture         =   "FrmMain.frx":7B3C
            Key             =   ""
         EndProperty
         BeginProperty ListImage5 {0713E8C3-850A-101B-AFC0-4210102A8DA7} 
            Picture         =   "FrmMain.frx":7E56
            Key             =   ""
         EndProperty
         BeginProperty ListImage6 {0713E8C3-850A-101B-AFC0-4210102A8DA7} 
            Picture         =   "FrmMain.frx":8170
            Key             =   ""
         EndProperty
         BeginProperty ListImage7 {0713E8C3-850A-101B-AFC0-4210102A8DA7} 
            Picture         =   "FrmMain.frx":848A
            Key             =   ""
         EndProperty
         BeginProperty ListImage8 {0713E8C3-850A-101B-AFC0-4210102A8DA7} 
            Picture         =   "FrmMain.frx":87A4
            Key             =   ""
         EndProperty
         BeginProperty ListImage9 {0713E8C3-850A-101B-AFC0-4210102A8DA7} 
            Picture         =   "FrmMain.frx":8ABE
            Key             =   ""
         EndProperty
         BeginProperty ListImage10 {0713E8C3-850A-101B-AFC0-4210102A8DA7} 
            Picture         =   "FrmMain.frx":8DD8
            Key             =   ""
         EndProperty
         BeginProperty ListImage11 {0713E8C3-850A-101B-AFC0-4210102A8DA7} 
            Picture         =   "FrmMain.frx":90F2
            Key             =   ""
         EndProperty
         BeginProperty ListImage12 {0713E8C3-850A-101B-AFC0-4210102A8DA7} 
            Picture         =   "FrmMain.frx":940C
            Key             =   ""
         EndProperty
      EndProperty
   End
   Begin VB.Menu MenuArchivo 
      Caption         =   "Archivo"
      Begin VB.Menu MenuExit 
         Caption         =   "Terminar"
      End
   End
   Begin VB.Menu document 
      Caption         =   "Documentos"
      Begin VB.Menu TicketCF 
         Caption         =   "Ticket Cons. Final"
      End
      Begin VB.Menu l1 
         Caption         =   "-"
      End
      Begin VB.Menu EjFactA 
         Caption         =   "Ticket Factura A"
      End
      Begin VB.Menu TckFactB 
         Caption         =   "Ticket Factura B"
      End
      Begin VB.Menu l2 
         Caption         =   "-"
      End
      Begin VB.Menu tnca 
         Caption         =   "Ticket NC A"
      End
      Begin VB.Menu tncb 
         Caption         =   "Ticket NC B"
      End
      Begin VB.Menu Separ1 
         Caption         =   "-"
      End
      Begin VB.Menu DocNoFis 
         Caption         =   "Doc. No Fiscal"
      End
      Begin VB.Menu DNFHVoucher 
         Caption         =   "Voucher"
      End
   End
   Begin VB.Menu MenuRep 
      Caption         =   "Reportes"
      Begin VB.Menu Equis 
         Caption         =   "Lectura X"
      End
      Begin VB.Menu Zeta 
         Caption         =   "Cierre Z"
      End
      Begin VB.Menu linea 
         Caption         =   "-"
      End
      Begin VB.Menu MenuAudit 
         Caption         =   "Auditoria"
         Begin VB.Menu AudByDate 
            Caption         =   "Por Fechas (impreso)"
         End
         Begin VB.Menu AudByNumber 
            Caption         =   "Por Número (impreso)"
         End
         Begin VB.Menu IndNumero 
            Caption         =   "Por Puerto Serie (no impreso)"
         End
      End
   End
End
Attribute VB_Name = "FrmMain"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
'###########################################################################################
' Cía. HASAR saic - Grupo HASAR                                     Depto. Software de Base
' por Ricardo D. Cárdenes                                       Impresora Fiscal SMH/P-715F
' fiscal010724.ocx - winfis32.dll                               Consultar: publtick.pdf
'                                                                          activex.pdf
'###########################################################################################
Option Explicit

'//=========================================================================================
'// Reporte de auditoría por rango de fechas
'//=========================================================================================
Private Sub AudByDate_Click()
Dim msg As String

On Error GoTo impresora_apag
    
Procesar:

    HASAR1.ReporteZPorFechas "05/05/05", "05/05/05", False
    msg = "Reporte auditoría por fecha" + vbCrLf + vbCrLf + HASAR1.Respuesta(0)
    MsgBox msg, vbOKOnly, "Respuesta Fiscal"
    Exit Sub

impresora_apag:

    If MsgBox("Error Impresora:" & Err.Description, vbRetryCancel, "Errores") = vbRetry Then
        Resume Procesar
    End If
    
End Sub

'//=========================================================================================
'// Reporte de auditoría por rango de números de "Z"
'//=========================================================================================
Private Sub AudByNumber_Click()
Dim msg As String

On Error GoTo impresora_apag
    
Procesar:

    HASAR1.ReporteZPorNumeros 1, 1, False
    msg = "Reporte Z Por Número" + vbCrLf + vbCrLf + HASAR1.Respuesta(0)
    MsgBox msg, vbOKOnly, "Respuesta Fiscal"
    Exit Sub

impresora_apag:

    If MsgBox("Error Impresora:" & Err.Description, vbRetryCancel, "Errores") = vbRetry Then
        Resume Procesar
    End If
    
End Sub

'//=========================================================================================
'// Imprimir voucher de tarjeta de crédito
'//=========================================================================================
Private Sub DNFHVoucher_Click()
Dim msg As String
Dim comando As String
Dim FS As String

FS = Chr$(28)

On Error GoTo impresora_apag
       
Procesar:
    
    '// Se reemplaza ImprimirVoucher() por Enviar()
    '// -------------------------------------------
    
    '// Se arma comando SETVOUCHERDATA1
    '//--------------------------------
    comando = Chr$(106) & FS & "Cliente..." & FS & "PlastiCard" & FS & "C" & FS & _
              "1234567890123456" & FS & "0512" & FS & "C" & FS & "1"
    HASAR1.Enviar comando
    '// Se arma comando SETVOUCHERDATA2
    '// Se agregó en este comando el campo de vendedor
    '//-----------------------------------------------
    comando = Chr$(107) & FS & "123456789012345" & FS & "12345678" & FS & "123" & FS & _
              "1234" & FS & " " & FS & "N" & FS & "123456" & FS & "100.00" & FS & _
              "12345678" & FS & "Vendedor..."
    HASAR1.Enviar comando
    '// Se arma comando PRINTVOUCHER
    '//-----------------------------
    comando = Chr$(108) & FS & "1"
    HASAR1.Enviar comando
    
    Exit Sub

impresora_apag:

    If MsgBox("Error Impresora:" & Err.Description, vbRetryCancel, "Errores") = vbRetry Then
        Resume Procesar
    End If

End Sub

'//=========================================================================================
'// Documento No Fiscal
'//=========================================================================================
Private Sub DocNoFis_Click()
Dim msg As String
Dim j As Integer

On Error GoTo impresora_apag
       
Procesar:
    
    HASAR1.AbrirComprobanteNoFiscal
    
    For j = 1 To 10
        HASAR1.ImprimirTextoNoFiscal "Linea Texto No Fiscal..."
    Next j
    
    HASAR1.CerrarComprobanteNoFiscal
    Exit Sub

impresora_apag:

    If MsgBox("Error Impresora:" & Err.Description, vbRetryCancel, "Errores") = vbRetry Then
        Resume Procesar
    End If
    
End Sub

'//=========================================================================================
'// Ticket Factura "B"
'//=========================================================================================
Private Sub TckFactB_Click()
Dim msg As String
Dim comando As String
Dim FS As String

FS = Chr$(28)                                            '// Separador de campos del comando

On Error GoTo impresora_apag
       
Procesar:
    
    '// Se reemplaza DatosCliente() por Enviar()
    '// Se agregó en este comando el campo de domicilio
    '// -----------------------------------------------
    comando = Chr$(98) & FS & "Cliente..." & FS & "9999" & FS & "C" & FS & "0" & _
              FS & "Domicilio..."
    HASAR1.Enviar comando
    
    HASAR1.AbrirComprobanteFiscal TICKET_FACTURA_B
    HASAR1.ImprimirTextoFiscal "Texto Fiscal..."
    HASAR1.ImprimirItem "Producto Uno", 1, 100, 21, 0
    HASAR1.DescuentoUltimoItem "Oferta del Dia", 5, True
    HASAR1.DescuentoGeneral "Oferta Pago Efectivo", 25, True
    HASAR1.EspecificarPercepcionPorIVA "Percep IVA21", 100, 21
    HASAR1.EspecificarPercepcionGlobal "Percep. RG 0000", 125#
    HASAR1.ImprimirPago "Efectivo", 295#
    HASAR1.CerrarComprobanteFiscal
    Exit Sub

impresora_apag:

    If MsgBox("Error Impresora:" & Err.Description, vbRetryCancel, "Errores") = vbRetry Then
        Resume Procesar
    End If

End Sub

'//=========================================================================================
'// Ticket a Consumidor Final
'//=========================================================================================
Private Sub TicketCF_Click()
Dim msg As String

On Error GoTo impresora_apag
       
Procesar:
    HASAR1.AbrirComprobanteFiscal TICKET_C
    HASAR1.ImprimirTextoFiscal "Texto Fiscal..."
    HASAR1.ImprimirItem "Producto Uno", 1, 100, 21, 0
    HASAR1.DescuentoUltimoItem "Oferta del Dia", 5, True
    HASAR1.DescuentoGeneral "Oferta Pago Efectivo", 25, True
    HASAR1.ImprimirPago "Efectivo", 70#
    HASAR1.CerrarComprobanteFiscal
    Exit Sub

impresora_apag:

    If MsgBox("Error Impresora:" & Err.Description, vbRetryCancel, "Errores") = vbRetry Then
        Resume Procesar
    End If

End Sub

'//=========================================================================================
'// Ticket Factura "A"
'//=========================================================================================
Private Sub EjFactA_Click()
Dim msg As String
Dim comando As String
Dim FS As String

FS = Chr$(28)                                            '// Separador de campos del comando

On Error GoTo impresora_apag
       
Procesar:
    
    '// Se reemplaza DatosCliente() por Enviar()
    '// Se agregó el campode domicilio en este comando
    '// ----------------------------------------------
    comando = Chr$(98) & FS & "Cliente..." & FS & "99999999995" & FS & "I" & FS & "C" & _
              FS & "Domicilio..."
    HASAR1.Enviar comando
    
    HASAR1.AbrirComprobanteFiscal TICKET_FACTURA_A
    HASAR1.ImprimirTextoFiscal "Texto Fiscal..."
    HASAR1.ImprimirItem "Producto Uno", 1, 100, 21, 0
    HASAR1.DescuentoUltimoItem "Oferta del Dia", 5, True
    HASAR1.DescuentoGeneral "Oferta Pago Efectivo", 25, True
    HASAR1.EspecificarPercepcionPorIVA "Percep IVA21", 100, 21
    HASAR1.EspecificarPercepcionGlobal "Percep. RG 0000", 125#
    HASAR1.ImprimirPago "Efectivo", 295#
    HASAR1.CerrarComprobanteFiscal
    
    Exit Sub

impresora_apag:

    If MsgBox("Error Impresora:" & Err.Description, vbRetryCancel, "Errores") = vbRetry Then
        Resume Procesar
    End If

End Sub

'//=========================================================================================
'// Cierre "X" entre lecturas
'//=========================================================================================
Private Sub Equis_Click()

On Error GoTo impresora_apag

Procesar:

    HASAR1.ReporteX
    Exit Sub

impresora_apag:

    If MsgBox("Error Impresora:" & Err.Description, vbRetryCancel, "Errores") = vbRetry Then
        Resume Procesar
    End If
    
End Sub

'//=========================================================================================
'// Levanta la aplicación
'//=========================================================================================
Private Sub Form_Load()

    FrmMain.Caption = "SMH/P-715F - Impres. Fiscal"

On Error GoTo impresora_apag
Procesar:

    HASAR1.Puerto = 1
    HASAR1.Modelo = MODELO_615                              '//Este OCX no es 100% para 715F
    HASAR1.Comenzar
    HASAR1.PrecioBase = False
    HASAR1.TratarDeCancelarTodo
    Exit Sub

impresora_apag:

    If MsgBox("Error Impresora:" & Err.Description, vbRetryCancel, "Errores") = vbRetry Then
        Resume Procesar
    End If
    
End Sub

'//=========================================================================================
'// Reporte Z Individual por número de Z
'//=========================================================================================
Private Sub IndNumero_Click()
Dim msg As String

On Error GoTo impresora_apag
    
Procesar:

    HASAR1.ReporteZIndividualPorNumero 1
    msg = "Reporte auditoría individual por número de Z" + vbCrLf + vbCrLf + HASAR1.Respuesta(0)
    MsgBox msg, vbOKOnly, "Respuesta Fiscal"
    Exit Sub

impresora_apag:

    If MsgBox("Error Impresora:" & Err.Description, vbRetryCancel, "Errores") = vbRetry Then
        Resume Procesar
    End If
    
End Sub

'//=========================================================================================
'// Terminar la ejecución del ejemplo
'//=========================================================================================
Private Sub MenuExit_Click()

    Unload Me
    
End Sub

'//=========================================================================================
'// Colocar fecha y hora en la barra de status inferior
'//=========================================================================================
Private Sub Timer1_Timer()

    StatusBar1.Panels(2).Text = Format$(Now, "HH:MM")
    StatusBar1.Panels(1).Text = Format$(Now, "DD/MM/YYYY")
 
End Sub

'//=========================================================================================
'// Consultar antes de bajar la aplicación
'//=========================================================================================
Private Sub Form_QueryUnload(Cancel As Integer, UnloadMode As Integer)
Dim respbox As Integer

    respbox = MsgBox("ABANDONARA LA APLICACION ..." & vbCrLf & vbCrLf + _
    "ESTA SEGURO ?? ...", vbQuestion + vbYesNo, "  SALIDA !!!")
    
    If (respbox = vbNo) Then
        Cancel = True
    Else
        HASAR1.Finalizar
    End If
    
End Sub

'//=========================================================================================
'// Atrapando el evento de error fiscal que se genera a partir del campo de status fiscal de
'// las respuestas a comandos enviados
'//=========================================================================================
Private Sub HASAR1_ErrorFiscal(ByVal Flags As Long)

    '// Falta la inteligencia del tratamiento del evento
    '//-------------------------------------------------
    Debug.Print HASAR1.DescripcionStatusFiscal(Flags)
    
End Sub

'//=========================================================================================
'// Atrapando el evento fiscal que se genera a partir del campo de status fiscal de las
'// respuestas a comandos enviados
'//=========================================================================================
Private Sub HASAR1_EventoFiscal(ByVal Flags As Long)

    '// Falta la inteligencia del tratamiento del evento
    '//-------------------------------------------------
    Debug.Print HASAR1.DescripcionStatusFiscal(Flags)
    
End Sub

'//=========================================================================================
'// Atrapando el evento impresora que se genera a partir del campo de status de impresora de
'// las respuestas a comandos enviados
'//=========================================================================================
Private Sub HASAR1_EventoImpresora(ByVal Flags As Long)

    Debug.Print HASAR1.DescripcionStatusImpresor(Flags)

    '// Falta la inteligencia del tratamiento del evento
    '//-------------------------------------------------
    Select Case Flags
        Case P_JOURNAL_PAPER_LOW, P_RECEIPT_PAPER_LOW:
            Debug.Print "Falta papel"
        Case P_OFFLINE:
            Debug.Print "Impresor fuera de línea"
        Case P_PRINTER_ERROR:
            Debug.Print "Error mecánico de impresor"
        Case Else:
            Debug.Print "Otro bit de impresora"
    End Select

End Sub

'//=========================================================================================
'// Atrapando el evento de impresora ocupada que se genera a partir de que la impresora
'// fiscal envía caracteres DC2 demorando la entrega de la respuesta ( porque no terminó de
'// procesar el comando enviado )
'//=========================================================================================
Private Sub HASAR1_ImpresoraOcupada()

    '// Falta la inteligencia del tratamiento del evento
    '//-------------------------------------------------
    Debug.Print "DC2......."
    
End Sub

'//=========================================================================================
'// Ticket Nota de Crédito "A"
'//=========================================================================================
Private Sub tnca_Click()
Dim msg As String
Dim comando As String
Dim FS As String

FS = Chr$(28)                                        '// Separador de campos para el comando

On Error GoTo impresora_apag
Procesar:

    '// Se reemplaza InformacionRemito() por Enviar()
    '// Comnado no existente en P-615F
    '// ---------------------------------------------
    comando = Chr$(147) & FS & "1" & FS & "0000-0000000"
    HASAR1.Enviar comando

    '// Se reemplaza DatosCliente() por Enviar()
    '// Se agregó el campo de domicilio en este comando
    '// -----------------------------------------------
    comando = Chr$(98) & FS & "Cliente..." & FS & "99999999995" & FS & "I" & FS & "C" & _
              FS & "Domicilio..."
    HASAR1.Enviar comando
    
    '// Se reemplaza AbrirComprobanteNoFiscalHomologado() por Enviar()
    '// Comando no existente en P-615F
    '//---------------------------------------------------------------
    comando = Chr$(128) & FS & "R" & FS & "T"
    HASAR1.Enviar comando
    
    HASAR1.ImprimirTextoFiscal "Texto Fiscal..."
    HASAR1.ImprimirItem "Producto Uno", 1, 100, 21, 0
    HASAR1.DescuentoUltimoItem "Oferta del Dia", 5, True
    HASAR1.DescuentoGeneral "Oferta Pago Efectivo", 25, True
    HASAR1.EspecificarPercepcionPorIVA "Percep IVA21", 100, 21
    HASAR1.EspecificarPercepcionGlobal "Percep. RG 0000", 125#
    HASAR1.ImprimirPago "Efectivo", 295#
    
    '// Se reemplaza CerrarComprobanteNoFiscalHomologado() por Enviar()
    '// Comando no existente en P-615F
    '//---------------------------------------------------------------
    HASAR1.Enviar Chr$(129)

    Exit Sub
    
impresora_apag:

    If MsgBox("Error Impresora:" & Err.Description, vbRetryCancel, "Errores") = vbRetry Then
        Resume Procesar
    End If

End Sub

'//=========================================================================================
'// Ticket Nota de Crédito "B"
'//=========================================================================================
Private Sub tncb_Click()
Dim msg As String
Dim comando As String
Dim FS As String

FS = Chr$(28)                                        '// Separador de campos para el comando

On Error GoTo impresora_apag
Procesar:

    '// Se reemplaza InformacionRemito() por Enviar()
    '// Comando no existente en P-615F
    '// ---------------------------------------------
    comando = Chr$(147) & FS & "1" & FS & "0000-0000000"
    HASAR1.Enviar comando

    '// Se reemplaza DatosCliente() por Enviar()
    '// Se agregó el campo de domicilio al comando
    '// ------------------------------------------
    comando = Chr$(98) & FS & "Cliente..." & FS & "9999" & FS & "C" & FS & "2" & _
              FS & "Domicilio..."
    HASAR1.Enviar comando
    
    '// Se reemplaza AbrirComprobanteNoFiscalHomologado() por Enviar()
    '// Comando no existente en el P-615F
    '//---------------------------------------------------------------
    comando = Chr$(128) & FS & "S" & FS & "T"
    HASAR1.Enviar comando
    
    HASAR1.ImprimirTextoFiscal "Texto Fiscal..."
    HASAR1.ImprimirItem "Producto Uno", 1, 100, 21, 0
    HASAR1.DescuentoUltimoItem "Oferta del Dia", 5, True
    HASAR1.DescuentoGeneral "Oferta Pago Efectivo", 25, True
    HASAR1.EspecificarPercepcionPorIVA "Percep IVA21", 100, 21
    HASAR1.EspecificarPercepcionGlobal "Percep. RG 0000", 125#
    HASAR1.ImprimirPago "Efectivo", 295#
    
    '// Se reemplaza CerrarComprobanteNoFiscalHomologado() por Enviar()
    '// Comando no existente en P-615F
    '//---------------------------------------------------------------
    HASAR1.Enviar Chr$(129)

    Exit Sub
    
impresora_apag:

    If MsgBox("Error Impresora:" & Err.Description, vbRetryCancel, "Errores") = vbRetry Then
        Resume Procesar
    End If

End Sub

'//=========================================================================================
'// Rutina para emisión de reportes de cierre diario "Z"
'//=========================================================================================
Private Sub Zeta_Click()

On Error GoTo impresora_apag

Procesar:

    HASAR1.ReporteZ
    Exit Sub

impresora_apag:

    If MsgBox("Error Impresora:" & Err.Description, vbRetryCancel, "Errores") = vbRetry Then
        Resume Procesar
    End If
    
End Sub
