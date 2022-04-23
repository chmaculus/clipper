declare PF_DatoaEnviar[25]       // Contiene los datos enviados con el comando
declare PF_DatoRecibido[25]      // Contiene la respuesta recibida del impresor
declare PF_StringRecibido        // Contiene el string recibido del impresor
declare PF_StringEnviado         // Contiene el string enviado al impresor
declare PF_PuertoNum             // Contiene el Nro de puerto del impresor
#define PF_TIEMPOMAXIMO  5     // Tiempo para indicar TimeOut de comunicaci¢n
* Caracteres de control de flujo
#define PF_TAB        chr(28)  // 0H1C
#define PF_STX        chr(02)  // 0H02
#define PF_ETX        chr(03)  // 0H03
#define PF_ACK        chr(06)  // 0H06
#define PF_NAK        chr(21)  // 0H15
#define PF_XON        chr(17)  // 0H11
#define PF_XOFF       chr(19)  // 0H13
#define PF_TIEMPO     chr(18)  // 0H12
#define PF_DEL        chr(127) // Se usa para mandar un par metro en vac¡o
#define PF_ModuloImpresor   1  // Es la ubicaci¢n del estado del m¢dulo Impresor
#define PF_ModuloFiscal     2  // Es la ubicaci¢n del estado del m¢dulo Fiscal
* Comandos del impresor EPSON
* Comandos de Tique
#define PF_TQAbre          64  // &H40
#define PF_TQDescExtra     65  // &H41
#define PF_TQItemDeLinea   66  // &H42
#define PF_TQSubTotal      67  // &H43
#define PF_TQPago          68  // &H44
#define PF_TQCerrar        69  // &H45
* Comandos de Factura
#define PF_FCAbre          96  // &H60
#define PF_FCItemDeLinea   98  // &H62
#define PF_FCSubTotal      99  // &H63
#define PF_FCPago         100  // &H64
#define PF_FCCerrar       101  // &H65
#define PF_FCPercep       102  // &H66
* Comandos de Documento No Fiscal
#define PF_NFAbre          72  // &H48
#define PF_NFItem          73  // &H49
#define PF_NFCerrar        74  // &H4A
#define PF_CortaPapel      75  // &H4B
#define PF_AvanTique       80  // &H50
#define PF_AvanAudit       81  // &H51
#define PF_AvanAmbos       82  // &H52
#define PF_AvanHoja        83  // &H53
* Comandos Generales
#define PF_Estado          42  // &H2A  Solicita Estado al Impresor Fiscal
#define PF_CierreX         57  // &H39  Solicita Cierre X (de cajero)
#define PF_CierreZ         57  // &H39  Solicita Cierre Z (diario)
#define PF_AuditF          58  // &H3A  Solicita Informe auditoria por fecha
#define PF_AuditZ          59  // &H3B  Solicita Informe auditoria por Cierre Z
#define PF_Diagnos         34  // &H22  Solicita Informe Diagn¢stico
#define PF_PideHora        89  // &H59  Solicita Hora del Impresor Fiscal
#define PF_PoneHora        88  // &H58  Envia nueva Hora al Impresor Fiscal
#define PF_PideEncabe      94  // &H5E  Solicita texto de Encabezado
#define PF_PoneEncabe      93  // &H5D  Envia texto para encabezado
#define PF_AbreCajon1     123  // &H7B  Abre cajon de dinero 1
#define PF_AbreCajon2     124  // &H7C  Abre cajon de dinero 2
#define PF_SysCommand      92  // &H5C  Comando de sistema
#define PF_SetPrefer       90  // &H5A  Configura preferencia
#define PF_GetPrefer       91  // &H5B  Lee preferencia
