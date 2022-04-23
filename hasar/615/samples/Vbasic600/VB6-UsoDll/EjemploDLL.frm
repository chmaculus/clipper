VERSION 5.00
Begin VB.Form Ejdll 
   Caption         =   "Form1"
   ClientHeight    =   3195
   ClientLeft      =   60
   ClientTop       =   345
   ClientWidth     =   4680
   LinkTopic       =   "Form1"
   ScaleHeight     =   3195
   ScaleWidth      =   4680
   StartUpPosition =   3  'Windows Default
   Begin VB.Timer Timer1 
      Left            =   960
      Top             =   2280
   End
End
Attribute VB_Name = "Ejdll"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit

Private Sub Form_Load()
Dim k As Integer
Dim cod As Long
Dim handler As Long

    k = 1
    handler = OpenComFiscal(k, MODE_ASCII)

  If (handler < 0) Then
      '// Hacer tratamiento del error
  End If

    cod = InitFiscal(handler)

   If (cod < 0) Then
      '// Hacer tratamiento del error
  End If
    
  ConsultarEstado handler
  ImprimirEquis handler

    CloseComFiscal handler
  Unload Me

End Sub

Public Sub EnviarComando(nrohand As Long, strcmd As String)
Dim PrinterStatus As Integer, FiscalStatus As Integer
Static Atomic As Boolean
Dim cod As Long
Dim respfiscal As String * 500

If (Atomic) Then
    MsgBox "No puede ejecutar más de un comando por vez..."
    Exit Sub
End If

Atomic = True
Timer1.Enabled = True

Do
    cod = MandaPaqueteFiscal(nrohand, strcmd)
    
    If ((cod < 0) And (cod <> ERR_ATOMIC)) Then
    MsgBox "ERROR al enviar comando... "
            Timer1.Enabled = False
            Atomic = False
            Exit Sub
    End If
    
    DoEvents
Loop Until (cod = 0)

Timer1.Enabled = False
cod = UltimaRespuesta(nrohand, respfiscal)

If (cod = 0) Then
       '// Analizar los campos de status de la respuesta
Else
    MsgBox "ERROR esperando respuesta..."
End If
 
Atomic = False

End Sub

Public Sub ConsultarEstado(handler As Long)
Dim id As String

    id = Chr$(42)
    EnviarComando handler, id
    
End Sub

Public Sub ImprimirEquis(handler As Long)
Dim id As String
Dim comando As String

    id = "9"
    comando = id & Chr$(28) & "X"
    EnviarComando handler, comando
    
End Sub




