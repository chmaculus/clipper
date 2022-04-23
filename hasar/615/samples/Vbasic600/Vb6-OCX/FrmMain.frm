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
      Begin VB.PictureBox HASAR1 
         Height          =   480
         Left            =   3120
         ScaleHeight     =   420
         ScaleWidth      =   1140
         TabIndex        =   2
         Top             =   2760
         Width           =   1200
      End
      Begin FiscalPrinterLibCtl.HASAR HASAR2 
         Left            =   1200
         OleObjectBlob   =   "FrmMain.frx":0442
         Top             =   2040
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
            Key             =   "Fecha"
            Object.Tag             =   ""
         EndProperty
         BeginProperty Panel2 {0713E89F-850A-101B-AFC0-4210102A8DA7} 
            Object.Width           =   1058
            MinWidth        =   1058
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
      Caption         =   "&Archivo"
      Begin VB.Menu SubMenuDos 
         Caption         =   "Ir a DO&S"
      End
      Begin VB.Menu MenuExit 
         Caption         =   "&Terminar"
      End
   End
   Begin VB.Menu document 
      Caption         =   "&Documentos"
      Begin VB.Menu MenuEjemplos 
         Caption         =   "&Ejemplos"
         Begin VB.Menu EjFactA 
            Caption         =   "Factura A"
         End
         Begin VB.Menu EjFactB 
            Caption         =   "Factura B"
         End
         Begin VB.Menu Separ1 
            Caption         =   "-"
         End
         Begin VB.Menu NCA 
            Caption         =   "Nota Crédito A"
         End
         Begin VB.Menu NCB 
            Caption         =   "Nota Crédito B"
         End
         Begin VB.Menu separ2 
            Caption         =   "-"
         End
         Begin VB.Menu ReciboA 
            Caption         =   "Recibo A"
         End
         Begin VB.Menu ReciboB 
            Caption         =   "Recibo B"
         End
         Begin VB.Menu ReciboX 
            Caption         =   "Recibo X"
         End
         Begin VB.Menu separ3 
            Caption         =   "-"
         End
         Begin VB.Menu RemitoEquis 
            Caption         =   "Remito"
         End
         Begin VB.Menu Cotizacion 
            Caption         =   "Cotización"
         End
         Begin VB.Menu OdenSal 
            Caption         =   "Orden de Salida"
         End
         Begin VB.Menu ResCuenta 
            Caption         =   "Resumen de Cuenta"
         End
         Begin VB.Menu CargoHabit 
            Caption         =   "Cargo Habitación"
         End
         Begin VB.Menu separador 
            Caption         =   "-"
         End
         Begin VB.Menu DocNoFis 
            Caption         =   "Doc. No Fiscal"
         End
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
            Caption         =   "Por Fechas"
         End
         Begin VB.Menu AudByNumber 
            Caption         =   "Por Número"
         End
         Begin VB.Menu lineados 
            Caption         =   "-"
         End
         Begin VB.Menu RepSerie 
            Caption         =   "Por Canal Serie"
            Begin VB.Menu IndNumero 
               Caption         =   "Individual Número"
            End
            Begin VB.Menu Indfecha 
               Caption         =   "Individual Fecha"
            End
         End
      End
   End
   Begin VB.Menu MenuAy 
      Caption         =   "A&yuda"
      Begin VB.Menu MenuAyuda 
         Caption         =   "Ay&uda"
      End
      Begin VB.Menu MenuAbout 
         Caption         =   "A&cerca de ..."
      End
   End
End
Attribute VB_Name = "FrmMain"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
'###########################################################################################
' Cía. HASAR saic                                                   Depto. Software de Base
' por Ricardo D. Cárdenes                 Impresoras Fiscales SMH / P-320F / PJ-20F / PL-8F
'###########################################################################################

Option Explicit

Public reporte As Boolean
Public fecha As String
Public hora As String

Private Sub AudByDate_Click()
Dim msg As String

On Error GoTo impresora_apag
    
Procesar:

    HASAR2.ReporteZPorFechas "01/01/00", "10/08/00", False
    'msg = "Reporte Z Por Fecha" + vbCrLf + vbCrLf + Hasar2.Respuesta(0)
    'MsgBox msg, vbOKOnly, "Respuesta Fiscal"
    Exit Sub

impresora_apag:

    If MsgBox("Error Impresora:" & Err.Description, vbRetryCancel, "Errores") = vbRetry Then
        Resume Procesar
    End If
    
End Sub

Private Sub AudByNumber_Click()
Dim msg As String

On Error GoTo impresora_apag
    
Procesar:

    HASAR2.ReporteZPorNumeros 1, 1, False
    Exit Sub

impresora_apag:

    If MsgBox("Error Impresora:" & Err.Description, vbRetryCancel, "Errores") = vbRetry Then
        Resume Procesar
    End If
    
End Sub

Private Sub CargoHabit_Click()
Dim msg As String
    
On Error GoTo impresora_apag

Procesar:
    
    HASAR2.DatosCliente "Alejo Alegre", "99999999995", TIPO_CUIT, RESPONSABLE_INSCRIPTO, "Domicilio: Desconocido"
    HASAR2.AbrirComprobanteNoFiscalHomologado CARGO_HABITACION, 1
    HASAR2.ImprimirItemEnCuenta "20/08/00", "9998-00000001", "Alojamiento x 2 noches", 100, 0
    HASAR2.ImprimirItemEnCuenta "21/08/00", "9998-00000028", "Servicio de Restaurante", 45, 300
    HASAR2.ImprimirItemEnCuenta "22/08/00", "9998-00000134", "Piscina y sauna", 300, 0
    HASAR2.CerrarComprobanteNoFiscalHomologado
        
    Exit Sub

impresora_apag:

    If MsgBox("Error Impresora:" & Err.Description, vbRetryCancel, "Errores") = vbRetry Then
        Resume Procesar
    End If
    
End Sub

Private Sub Cotizacion_Click()
Dim msg As String
    
On Error GoTo impresora_apag

Procesar:
    
    HASAR2.DatosCliente "Alejo Alegre", "99999999995", TIPO_CUIT, CONSUMIDOR_FINAL, "Domicilio: Desconocido"
    HASAR2.AbrirComprobanteNoFiscalHomologado 117, 1
    HASAR2.ImprimirItemEnCotizacion " "
    HASAR2.ImprimirItemEnCotizacion "La dirección de la Empresa Equis, con domicilio legal y comercial en la calle Principal número 9999, de esta Capital"
    HASAR2.ImprimirItemEnCotizacion " "
    HASAR2.ImprimirItemEnCotizacion "Abono por mantenimiento de equipo:........... $ 300 .- ........mensuales"
    HASAR2.ImprimirItemEnCotizacion "Servicio de Asesoría Técnica:................ $  50 .- ........la hora"
    HASAR2.ImprimirItemEnCotizacion " "
    HASAR2.ImprimirItemEnCotizacion "Más impuestos, traslados y estadía del personal"
    HASAR2.CerrarComprobanteNoFiscalHomologado
        
    Exit Sub

impresora_apag:

    If MsgBox("Error Impresora:" & Err.Description, vbRetryCancel, "Errores") = vbRetry Then
        Resume Procesar
    End If
    
End Sub

Private Sub DocNoFis_Click()
Dim msg As String
Dim j As Integer

On Error GoTo impresora_apag
       
Procesar:
    
    HASAR2.AbrirComprobanteNoFiscal
    
    For j = 1 To 22
        HASAR2.ImprimirTextoNoFiscal "Linea de Texto No Fiscal @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"
    Next j
    
    HASAR2.CerrarComprobanteNoFiscal
    Exit Sub

impresora_apag:

    If MsgBox("Error Impresora:" & Err.Description, vbRetryCancel, "Errores") = vbRetry Then
        Resume Procesar
    End If
    
End Sub

Private Sub EjFactA_Click()
Dim msg As String

On Error GoTo impresora_apag
       
Procesar:
    HASAR2.DatosCliente "Nombre del Cliente", "99999999995", TIPO_CUIT, RESPONSABLE_INSCRIPTO, "Domicilio: Donde Siempre"
    HASAR2.InformacionRemito(1) = "1234-56789012"
    HASAR2.AbrirComprobanteFiscal FACTURA_A
    HASAR2.ImprimirTextoFiscal "En oferta hasta 21-12-2000"
    HASAR2.ImprimirItem "Producto a la Venta: Uno", 30, 10.25, 21, 10
    HASAR2.DescuentoUltimoItem "Oferta del Dia", 5, True
    HASAR2.ImprimirItem "Producto a la Venta: Dos", 30, 10, 21, 10
    HASAR2.ImprimirItem "Producto a la Venta: Tres", 30, 10, 21, 20
    HASAR2.ImprimirItem "Producto a la Venta: Cuatro", 30, 10, 21, 30
    HASAR2.ImprimirItem "Producto a la Venta: Cinco", 30, 10, 10.5, 5
    HASAR2.ImprimirItem "Producto a la Venta: Seis", 30, 10, 10.5, 15
    HASAR2.ImprimirItem "Producto a la Venta: Siete", 30, 10, 21, 25
    HASAR2.ImprimirItem "Producto a la Venta: Ocho", 30, 10, 21, 35
    HASAR2.ImprimirItem "Producto a la Venta: Nueve", 30, 10, 21, 0
    HASAR2.ImprimirItem "Producto a la Venta: Diez", 30, 10, 10.5, 100
    HASAR2.DescuentoGeneral "Oferta Pago Efectivo", 25, True
    HASAR2.EspecificarPercepcionPorIVA "percep 21", 100, 21
    HASAR2.EspecificarPercepcionPorIVA "percep 10.5", 100, 10.5
    HASAR2.EspecificarPercepcionPorIVA "percep 0", 100, 0
    HASAR2.EspecificarPercepcionGlobal "Percep. RG 0000", 125#
    HASAR2.ImprimirPago "Efectivo", 3302.5
    HASAR2.CerrarComprobanteFiscal
    
    Exit Sub

impresora_apag:

    If MsgBox("Error Impresora:" & Err.Description, vbRetryCancel, "Errores") = vbRetry Then
        Resume Procesar
    End If

End Sub

Private Sub EjFactB_Click()
Dim msg As String

On Error GoTo impresora_apag
       
Procesar:
    
    HASAR2.InformacionRemito(1) = "1234-56789012"
    HASAR2.AbrirComprobanteFiscal FACTURA_B
    HASAR2.ImprimirTextoFiscal "En oferta hasta 21-12-2000"
    HASAR2.ImprimirItem "Producto a la Venta: Uno", 30, 10, 21, 10
    HASAR2.DescuentoUltimoItem "Oferta del Dia", 5, True
    HASAR2.ImprimirItem "Producto a la Venta: Dos", 30, 10, 21, 10
    HASAR2.ImprimirItem "Producto a la Venta: Tres", 30, 10, 21, 20
    HASAR2.DescuentoGeneral "Oferta Pago Efectivo", 25, True
    HASAR2.ImprimirPago "Efectivo", 395#
    HASAR2.CerrarComprobanteFiscal
    
    Exit Sub

impresora_apag:

    If MsgBox("Error Impresora:" & Err.Description, vbRetryCancel, "Errores") = vbRetry Then
        Resume Procesar
    End If

End Sub

Private Sub Equis_Click()

On Error GoTo impresora_apag

Procesar:

    HASAR2.ReporteX
    Exit Sub

impresora_apag:

    If MsgBox("Error Impresora:" & Err.Description, vbRetryCancel, "Errores") = vbRetry Then
        Resume Procesar
    End If
    
End Sub

Private Sub Form_Load()

    FrmMain.Caption = "SMH / P-320F / PL-8F"
    
    HASAR2.Puerto = 1
    HASAR2.Modelo = MODELO_P320
    HASAR2.Comenzar
    HASAR2.PrecioBase = False

On Error GoTo impresora_apag
    
Procesar:

    HASAR2.TratarDeCancelarTodo
    Exit Sub

impresora_apag:

    If MsgBox("Error Impresora:" & Err.Description, vbRetryCancel, "Errores") = vbRetry Then
        Resume Procesar
    End If
    
End Sub

Private Sub Indfecha_Click()
Dim msg As String

On Error GoTo impresora_apag
    
Procesar:

    HASAR2.ReporteZIndividualPorFecha "11/08/00"
    Exit Sub

impresora_apag:

    If MsgBox("Error Impresora:" & Err.Description, vbRetryCancel, "Errores") = vbRetry Then
        Resume Procesar
    End If
    
End Sub

Private Sub IndNumero_Click()
Dim msg As String

On Error GoTo impresora_apag
    
Procesar:

    HASAR2.ReporteZIndividualPorNumero 13
    Exit Sub

impresora_apag:

    If MsgBox("Error Impresora:" & Err.Description, vbRetryCancel, "Errores") = vbRetry Then
        Resume Procesar
    End If
    
End Sub

Private Sub MenuExit_Click()

    Unload Me
    
End Sub

Private Sub NCA_Click()
Dim msg As String

On Error GoTo impresora_apag

Procesar:
    
    HASAR2.DatosCliente "Alejo Alegre", "99999999995", TIPO_CUIT, RESPONSABLE_INSCRIPTO, "Domicilio: Desconocido"
    HASAR2.InformacionRemito(1) = "9998-56789012"
    HASAR2.AbrirComprobanteNoFiscalHomologado NOTA_CREDITO_A
    HASAR2.ImprimirItem "Item1", 30, 1, 0, 0
    HASAR2.DescuentoUltimoItem "Oferta del Dia", 5, True
    HASAR2.DescuentoGeneral "Oferta Pago Efectivo", 15, True
    HASAR2.EspecificarPercepcionGlobal "Percep. RG 3337", 125#
    HASAR2.EspecificarPercepcionGlobal "Percep. DN 3895", 40#
    HASAR2.CerrarComprobanteNoFiscalHomologado
    
    Exit Sub

impresora_apag:

    If MsgBox("Error Impresora:" & Err.Description, vbRetryCancel, "Errores") = vbRetry Then
        Resume Procesar
    End If
    
End Sub

Private Sub NCB_Click()
Dim msg As String

On Error GoTo impresora_apag

Procesar:
    
    HASAR2.DatosCliente "Alejo Alegre", "99999999995", TIPO_LE, CONSUMIDOR_FINAL, "Domicilio: Desconocido"
    HASAR2.InformacionRemito(1) = "9998-56789012"
    HASAR2.AbrirComprobanteNoFiscalHomologado NOTA_CREDITO_B
    HASAR2.ImprimirItem "Item1", 30, 1, 0, 0
    HASAR2.DescuentoUltimoItem "Oferta del Dia", 5, True
    HASAR2.DescuentoGeneral "Oferta Pago Efectivo", 15, True
    HASAR2.CerrarComprobanteNoFiscalHomologado
        
    Exit Sub

impresora_apag:

    If MsgBox("Error Impresora:" & Err.Description, vbRetryCancel, "Errores") = vbRetry Then
        Resume Procesar
    End If
    
End Sub

Private Sub OdenSal_Click()
Dim msg As String

On Error GoTo impresora_apag

Procesar:

    HASAR2.DatosCliente "Alejo Alegre", "99999999995", TIPO_CUIT, RESPONSABLE_INSCRIPTO, "Domicilio: Desconocido"
    HASAR2.AbrirComprobanteNoFiscalHomologado ORDEN_SALIDA, 1
    HASAR2.ImprimirItemEnRemito "Caja x 48  Jabones Tocador", 20
    HASAR2.ImprimirItemEnRemito "Caja x 60  Lápices Labiales", 30
    HASAR2.ImprimirItemEnRemito "Caja x 50  Desodorantes en Barra", 150
    HASAR2.ImprimirItemEnRemito "Caja x 100 Crema Enjuague", 5
    HASAR2.ImprimirItemEnRemito "Caja x 12  Desengrasante", 15
    HASAR2.CerrarComprobanteNoFiscalHomologado
    
    Exit Sub

impresora_apag:

    If MsgBox("Error Impresora:" & Err.Description, vbRetryCancel, "Errores") = vbRetry Then
        Resume Procesar
    End If
    
End Sub

Private Sub ReciboA_Click()
Dim msg As String
   
On Error GoTo impresora_apag

Procesar:
    
    HASAR2.DatosCliente "Alejo Alegre", "99999999995", TIPO_CUIT, RESPONSABLE_INSCRIPTO, "Domicilio: Desconocido"
    HASAR2.AbrirComprobanteFiscal RECIBO_A
    HASAR2.ImprimirItem "Item1", 30, 1, 21, 0
    HASAR2.ImprimirItem "Repuesto Dos", 1, 20, 10.5, 0.5
    HASAR2.ImprimirItem "Repuesto Tres", 1, 30, 21, 0
    HASAR2.ImprimirItem "Accesorio Uno", 1, 40, 10.5, 0
    HASAR2.ImprimirItem "Accesorio Dos", 1, 50, 21, 0
    HASAR2.DetalleRecibo "Los servicios que a continuación se detallan:"
    HASAR2.DetalleRecibo " "
    HASAR2.DetalleRecibo "Asesoramiento area ingenieria"
    HASAR2.DetalleRecibo "Abono mensual por mantenimiento de equipos"
    HASAR2.CerrarComprobanteFiscal
    
    Exit Sub

impresora_apag:

    If MsgBox("Error Impresora:" & Err.Description, vbRetryCancel, "Errores") = vbRetry Then
        Resume Procesar
    End If
    
End Sub

Private Sub ReciboB_Click()
Dim msg As String
    
On Error GoTo impresora_apag

Procesar:
    
    HASAR2.DatosCliente "Alejo Alegre", "", TIPO_NINGUNO, CONSUMIDOR_FINAL, "Domicilio: Desconocido"
    HASAR2.AbrirComprobanteFiscal RECIBO_B
    HASAR2.ImprimirItem "Item1", 30, 1, 21, 0
    HASAR2.ImprimirItem "Repuesto Dos", 1, 20, 10.5, 0.5
    HASAR2.ImprimirItem "Repuesto Tres", 1, 30, 21, 0
    HASAR2.ImprimirItem "Accesorio Uno", 1, 40, 10.5, 0
    HASAR2.ImprimirItem "Accesorio Dos", 1, 50, 21, 0
    HASAR2.DetalleRecibo "Los servicios que a continuación se detallan:"
    HASAR2.DetalleRecibo " "
    HASAR2.DetalleRecibo "Asesoramiento area ingenieria"
    HASAR2.DetalleRecibo "Abono mensual por mantenimiento de equipos"
    HASAR2.CerrarComprobanteFiscal
    
    Exit Sub

impresora_apag:

    If MsgBox("Error Impresora:" & Err.Description, vbRetryCancel, "Errores") = vbRetry Then
        Resume Procesar
    End If
    
End Sub

Private Sub ReciboX_Click()
Dim msg As String
    
On Error GoTo impresora_apag

Procesar:

    HASAR2.DatosCliente "Alejo Alegre", "99999999995", TIPO_LE, CONSUMIDOR_FINAL, "Domicilio: Desconocido"
    HASAR2.AbrirComprobanteNoFiscalHomologado RECIBO_X, 1
    HASAR2.ImprimirItem "Item1", 30, 1, 0, 0
    HASAR2.DetalleRecibo "Los servicios que a continuación se detallan:"
    HASAR2.DetalleRecibo " "
    HASAR2.DetalleRecibo "Asesoramiento area ingenieria"
    HASAR2.DetalleRecibo "Abono mensual por mantenimiento de equipos"
    HASAR2.CerrarComprobanteNoFiscalHomologado
    
    Exit Sub

impresora_apag:

    If MsgBox("Error Impresora:" & Err.Description, vbRetryCancel, "Errores") = vbRetry Then
        Resume Procesar
    End If
    
End Sub

Private Sub RemitoEquis_Click()
Dim msg As String
    
On Error GoTo impresora_apag

Procesar:
    
    HASAR2.DatosCliente "Alejo Alegre", "99999999995", TIPO_CUIT, RESPONSABLE_INSCRIPTO, "Domicilio: Desconocido"
    HASAR2.InformacionRemito(1) = "9998-56789012"
    HASAR2.AbrirComprobanteNoFiscalHomologado 114, 1
    HASAR2.ImprimirItemEnRemito "Caja x 48  Jabones Tocador", 20
    HASAR2.ImprimirItemEnRemito "Caja x 60  Lápices Labiales", 30
    HASAR2.ImprimirItemEnRemito "Caja x 50  Desodorantes en Barra", 150
    HASAR2.ImprimirItemEnRemito "Caja x 100 Crema Enjuague", 5
    HASAR2.ImprimirItemEnRemito "Caja x 12  Desengrasante", 15
    HASAR2.CerrarComprobanteNoFiscalHomologado
    
    Exit Sub

impresora_apag:

    If MsgBox("Error Impresora:" & Err.Description, vbRetryCancel, "Errores") = vbRetry Then
        Resume Procesar
    End If
    
End Sub

Private Sub ResCuenta_Click()
Dim msg As String
    
On Error GoTo impresora_apag

Procesar:
    
    HASAR2.DatosCliente "Alejo Alegre", "99999999995", TIPO_CUIT, RESPONSABLE_INSCRIPTO, "Domicilio: Desconocido"
    HASAR2.AbrirComprobanteNoFiscalHomologado RESUMEN_CUENTA, 1
    HASAR2.ImprimirItemEnCuenta "20/08/00", "9998-00000001", "Alojamiento x 2 noches", 100, 0
    HASAR2.ImprimirItemEnCuenta "21/08/00", "9998-00000028", "Servicio de Restaurante", 45, 300
    HASAR2.ImprimirItemEnCuenta "22/08/00", "9998-00000134", "Piscina y sauna", 300, 0
    HASAR2.CerrarComprobanteNoFiscalHomologado
    
    Exit Sub

impresora_apag:

    If MsgBox("Error Impresora:" & Err.Description, vbRetryCancel, "Errores") = vbRetry Then
        Resume Procesar
    End If
    
End Sub

Private Sub SubMenuDos_Click()
Dim retval As Long

    retval = Shell("C:\windows\command.com", vbNormalFocus)
    
End Sub

Private Sub Timer1_Timer()

    StatusBar1.Panels(2).Text = Format$(Now, "HH:MM")
    hora = Format$(Now, "HH:MM")
    StatusBar1.Panels(1).Text = Format$(Now, "DD/MM/YYYY")
    fecha = Format$(Now, "DD/MM/YYYY")
 
End Sub

Private Sub Form_QueryUnload(Cancel As Integer, UnloadMode As Integer)
Dim respbox As Integer

    respbox = MsgBox("ABANDONARA LA APLICACION ..." & vbCrLf & vbCrLf + _
    "ESTA SEGURO ?? ...", vbQuestion + vbYesNo, "  SALIDA !!!")
    
    If (respbox = vbNo) Then
        Cancel = True
    Else
        HASAR2.Finalizar
    End If
    
End Sub

Private Sub Hasar2_ErrorFiscal(ByVal Flags As Long)
    Debug.Print HASAR2.DescripcionStatusFiscal(Flags)
End Sub

Private Sub Hasar2_EventoFiscal(ByVal Flags As Long)
    Debug.Print CStr(Flags)
    On Error Resume Next
    Debug.Print HASAR2.DescripcionStatusFiscal(Flags)
End Sub

Private Sub Hasar2_EventoImpresora(ByVal Flags As Long)

    Debug.Print HASAR2.DescripcionStatusImpresor(Flags)
    
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

Private Sub Hasar2_ImpresoraOcupada()
    Debug.Print "DC2......."
End Sub

Private Sub Zeta_Click()

On Error GoTo impresora_apag

Procesar:

    HASAR2.ReporteZ
    Exit Sub

impresora_apag:

    If MsgBox("Error Impresora:" & Err.Description, vbRetryCancel, "Errores") = vbRetry Then
        Resume Procesar
    End If
    
End Sub
