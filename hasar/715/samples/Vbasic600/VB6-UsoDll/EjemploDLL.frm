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
'//=========================================================================================
'// Cía. HASAR SAIC - Grupo HASAR                                      Dto. Software de Base
'// Por Ricardo D. Cárdenes                                        Impresoras fiscales HASAR
'// Requiere: winfis32.dll                                                  SMH/P-715F v1.00
'// Consultar: publtick.pdf - drivers.pdf
'//=========================================================================================
Option Explicit

'//=========================================================================================
'// Se carga el form
'//=========================================================================================
Private Sub Form_Load()
Dim k As Integer                              '// Número de COM a utilizar
Dim cod As Long                               '// Valor de retorno funciones de winfis32.dll
Dim Handler As Long                           '// Manejador del puerto serie

  '// Se abre el puerto serie - Debe hacerse solamente una vez
  '// Cuando levanta la aplicación
  '//---------------------------------------------------------
  k = 1
  Handler = OpenComFiscal(k, MODE_ASCII)

  If (Handler < 0) Then
      '// Hacer tratamiento del error
  End If

  '// Sincronismo con la impresora fiscal
  '//------------------------------------
  cod = InitFiscal(Handler)

  If (cod < 0) Then
      '// Hacer tratamiento del error
  End If

  '//########################### Bucle de emisión de comprobante ##########################
  
  ConsultarEstado Handler                                          '// Pedido de status
  ImprimirEquis Handler                                            '// Imprimir reporte "X"
  
  '//###########################      Fin bucle de emisión       ##########################

  '// Se cierra el puerto serie - Debe hacersse solamente una vez
  '// Cuando se cierra la aplicación
  '//------------------------------------------------------------
  CloseComFiscal Handler
  Unload Me

End Sub

'//=========================================================================================
'// Rutina que envía a la impresora fiscal el string del coamndo que se ha generado
'//=========================================================================================
Public Sub EnviarComando(nrohand As Long, strcmd As String)
Dim PrinterStatus As Integer, FiscalStatus As Integer
Static Atomic As Boolean
Dim cod As Long
Dim respfiscal As String * 500

Debug.Print "Comando: " & strcmd

'// No enviar otro comando hasta haber recibido la respuesta del anterior
'//----------------------------------------------------------------------
If (Atomic) Then
    MsgBox "No puede ejecutar más de un comando por vez..."
    Exit Sub
End If

Atomic = True                                                '// Procesando comando generado
Timer1.Enabled = True

Do
    cod = MandaPaqueteFiscal(nrohand, strcmd)                '// Enviando comando generado
    
    If ((cod < 0) And (cod <> ERR_ATOMIC)) Then
    MsgBox "ERROR al enviar comando... "
            Timer1.Enabled = False
            Atomic = False
            Exit Sub
    End If
    
    DoEvents
Loop Until (cod = 0)

Timer1.Enabled = False
cod = UltimaRespuesta(nrohand, respfiscal)      '// Tomando respuesta de la impresora fiscal
Debug.Print "Respuesta: " & respfiscal

If (cod = 0) Then
       '// Analizar los campos de status de la respuesta
Else
    MsgBox "ERROR esperando respuesta..."
End If
 
Atomic = False                                  '// Procesar otro comando

End Sub

'//=========================================================================================
'// Rutina que genera el string del comando:  StatusRequest  -ver publtick.pdf-
'//=========================================================================================
Public Sub ConsultarEstado(Handler As Long)

    EnviarComando Handler, Chr$(42)
    
End Sub

'//=========================================================================================
'// Rutina que genera el string del comando:  DailyClose  -ver publtick.pdf-
'// Para emitir un reporte "X"
'//=========================================================================================
Public Sub ImprimirEquis(Handler As Long)
Dim id As String
Dim comando As String

    id = "9"
    comando = id & Chr$(28) & "X"
    EnviarComando Handler, comando
    
End Sub




