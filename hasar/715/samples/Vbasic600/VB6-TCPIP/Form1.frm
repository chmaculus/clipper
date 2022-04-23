VERSION 5.00
Object = "{248DD890-BB45-11CF-9ABC-0080C7E7B78D}#1.0#0"; "MSWINSCK.OCX"
Begin VB.Form Form1 
   ClientHeight    =   2025
   ClientLeft      =   60
   ClientTop       =   345
   ClientWidth     =   3495
   LinkTopic       =   "Form1"
   ScaleHeight     =   2025
   ScaleWidth      =   3495
   StartUpPosition =   3  'Windows Default
   Begin MSWinsockLib.Winsock Winsock1 
      Left            =   1560
      Top             =   1440
      _ExtentX        =   741
      _ExtentY        =   741
      _Version        =   393216
   End
   Begin VB.CommandButton Command1 
      Caption         =   "SEND CMD"
      Height          =   855
      Left            =   360
      TabIndex        =   0
      Top             =   480
      Width           =   2655
   End
End
Attribute VB_Name = "Form1"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
'###########################################################################################
' Cía. HASAR SAIC - Grupo HASAR                                       Dto. Software de Base
' Por Ricardo D. Cárdenes                                         Impresoras Fiscales HASAR
' Requiere en la PC remota:                                                SMH/P-715F v1.00
'      Copiada winfis32.dll                                         Consultar: publtick.pdf
'      Corriendo wspooler.exe                                                  spooler.pdf
'      Conectada la impresora fiscal
'###########################################################################################
Option Explicit
Dim arrcmd(1 To 10) As String
Dim ind As Integer

'//=========================================================================================
'// Se envía un comando a la impresora fiscal conectada a la PC remota
'//=========================================================================================
Private Sub Command1_Click()

    If (arrcmd(ind) = Chr$(254)) Then
        MsgBox "SE COMPLETO DOC"
        Exit Sub
    End If
    
    Winsock1.SendData arrcmd(ind)                         '// Se envía el comando por el LAN
    ind = ind + 1
    DoEvents
    
End Sub

'//=========================================================================================
'// Se inicializa el IP remoto y el socket a utilizar. Se carga el array de comandos a
'// enviar
'//=========================================================================================
Private Sub Form_Load()

    Winsock1.RemoteHost = "192.0.2.176"
    Winsock1.RemotePort = 1600
    Winsock1.Connect
    Form1.Caption = "SMH/P-715F"
    
    '// Se generan los comandos de una factura "B" a Consumidor Final
    '// Comando SetCustomerData - Datos del comprador
    '//--------------------------------------------------------------
    arrcmd(1) = "b" & Chr$(28) & "Cliente..." & Chr$(28) & "99999999995" & Chr$(28) _
                      & "M" & Chr$(28) & "C" & Chr$(28) & "Domicilio..."
    '// Comando: OpenFiscalReceipt - Abrir Documento fiscal
    '//----------------------------------------------------
    arrcmd(2) = "@" & Chr$(28) & "B" & Chr$(28) & "T"
    '// Comando: PrintFiscalText - Impresión de texto fiscal
    '//-----------------------------------------------------
    arrcmd(3) = "A" & Chr$(28) & "Linea texto fiscal" & Chr$(28) & "0"
    '// Comando: PrintLineItem - Impresión de ítem
    '//-------------------------------------------
    arrcmd(4) = "B" & Chr$(28) & "Descrp. Item..." & Chr$(28) & "1.00" & Chr$(28) _
                      & "100.00" & Chr$(28) & "21.0" & Chr$(28) & "M" & Chr$(28) & _
                      "0.0" & Chr$(28) & "0" & Chr$(28) & "T"
    '// Comando: CloseFiscalReceipt - Cerrar documento fiscal
    '//------------------------------------------------------
    arrcmd(5) = "E"
    
    arrcmd(6) = Chr$(254)                                           '// No hay más comandos
    
    ind = 1

End Sub

'//=========================================================================================
'// Se cierran las comunicaciones remotas
'//=========================================================================================
Private Sub Form_Unload(Cancel As Integer)

    Winsock1.Close
    
End Sub

'//=========================================================================================
'// Se atrapa el evento que se genera con la llegada de un string ( respuesta de la
'// impresora fiscal )
'//=========================================================================================
Private Sub Winsock1_DataArrival(ByVal bytesTotal As Long)
Dim s As String
Dim aux As String
    
    Winsock1.GetData s, vbString
    
    '// Antes de mostrar la respuestas se eliminan posibles "DC2"
    '//----------------------------------------------------------
    While ((Len(s) >= 3) And (Left$(s, 3) = "DC2"))
        aux = Mid$(s, 4, Len(s))
        s = aux
    Wend
    
    If (Len(s) > 3) Then
        MsgBox "Respuesta: " & s
    End If

End Sub

