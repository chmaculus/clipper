VERSION 5.00
Object = "{248DD890-BB45-11CF-9ABC-0080C7E7B78D}#1.0#0"; "MSWINSCK.OCX"
Begin VB.Form Form1 
   Caption         =   "Form1"
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
Option Explicit
Dim arrcmd(1 To 5) As String
Dim ind As Integer

Private Sub Command1_Click()

    If (ind > 5) Then
        MsgBox "SE COMPLETO DOC"
        Exit Sub
    End If
    
    Winsock1.SendData arrcmd(ind)
    DoEvents
    
End Sub

Private Sub Form_Load()

    Winsock1.RemoteHost = "192.0.2.176"
    Winsock1.RemotePort = 1600
    Winsock1.Connect
    
    arrcmd(1) = "b" & Chr$(28) & "Cliente..." & Chr$(28) & "99999999995" & Chr$(28) _
                      & "M" & Chr$(28) & "C" & Chr$(28) & "Domicilio..."
    
    arrcmd(2) = "@" & Chr$(28) & "B" & Chr$(28) & "T"
    
    arrcmd(3) = "A" & Chr$(28) & "Linea texto fiscal" & Chr$(28) & "0"
    
    arrcmd(4) = "B" & Chr$(28) & "Descrp. Item..." & Chr$(28) & "1.00" & Chr$(28) _
                      & "100.00" & Chr$(28) & "21.0" & Chr$(28) & "M" & Chr$(28) & _
                      "0.0" & Chr$(28) & "0" & Chr$(28) & "T"
    
    arrcmd(5) = "E"
    
    ind = 1

End Sub

Private Sub Form_Unload(Cancel As Integer)

    Winsock1.Close
    
End Sub

Private Sub Winsock1_DataArrival(ByVal bytesTotal As Long)
Dim s As String
Dim aux As String
    
    Winsock1.GetData s, vbString
    
    '// antes de mostrar la respuestas habría que eliminar los "DC2" del comienzo
    MsgBox "Respuesta: " & s
    ind = ind + 1

End Sub

