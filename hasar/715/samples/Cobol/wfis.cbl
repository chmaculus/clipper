       IDENTIFICATION DIVISION.
       PROGRAM-ID.                      wfis.
       AUTHOR.                          Daniel Alés. 
      * Programa demostración de comunicación desde AcuCobol con el
      * Controlador Fiscal Hasar de las impresoras de ticket factura
      * modelos PR4F y P-615F
      *
      * Desarrollado por:
      *                          Carlos Daniel Alés
      *                          Juan Carlos Alés
      *                            Alberdi 430
      *                            (B 7000 ACJ) TANDIL
      *                            Pcia. de Buenos Aires
      *                            TE (02293) 425748
      *                            mailto <jcales@infovia.com.ar>
      * Con la colaboración de:
      *    Acucorp Inc. (USA - Empresa desarrolladora del lenguaje AcuCobol)
      *                          Eduardo Mendiola
      *                            Ingeniero de Software
      *                            mailto <eduardo@acucorp.com>
      *
      *    Infocom S. A. (Representante Acucorp en Argentina)
      *                          Carlos Achiary
      *                            Santa Fe 3694 1º piso
      *                            (1425) Buenos Aires
      *                            TE (011) 4831-0940
      *                            mailto <achiary@arnet.com.ar>
      *
      *    Hasar S. A. (Fabricante del Controlador Fiscal)
      *                          Ricardo D. Cárdenes
      *                            mailto <rcardenes@hasar.com>
      *                          Juan Pedro Sosa
      *                            mailto <psosa@hasar.com>
      *
      * Este programa es de dominio público.
      *
       INSTALLATION.                    Contolador Fiscal para Windows.
       DATE-WRITTEN.                    2000/02/21 - 10:05:00.

      ******************************************************************
       ENVIRONMENT DIVISION.
       CONFIGURATION SECTION.
       SOURCE-COMPUTER.                 IBM-PC.
       OBJECT-COMPUTER.                 IBM-PC.
       INPUT-OUTPUT SECTION.
       FILE-CONTROL.
       DATA DIVISION.
       FILE SECTION.
       WORKING-STORAGE SECTION. 
       01  Tota-fis.
      * Imprime totales (Facturas A, B o ticket)
           03 filler  PIC X VALUE "D".
           03 filler  PIC X VALUE h"1C".
           03 Text-t  PIC X(5) VALUE spaces.
           03 filler  PIC X VALUE h"1C".
           03 pago-t  PIC x(4).
           03 filler  PIC X VALUE h"1C".
           03 canc-t  PIC X VALUE "C".
           03 filler  PIC X VALUE h"1C".
           03 dspl-t  PIC X VALUE zeros.
       01  INICIA.
      * Control de estado del impresor
           03 ANUEVE   PIC X VALUE "*".
       01  Abre-fac.
      * Abre comprobante Fiscal (Facturas A, B o ticket)
           03 filler  PIC X VALUE "@".
           03 filler  PIC X VALUE h"1C".
           03 tipo-f  PIC X VALUE spaces.
           03 filler  PIC X VALUE h"1C".
           03 filler  PIC X VALUE "T".
       01  Clie-fac.
      * Carga datos de Comprador (Facturas A o B)
           03 cabe-f  PIC X VALUE "b".
           03 filler  PIC X VALUE h"1C".
           03 nomb-f  PIC X(10) VALUE spaces.
           03 filler  PIC X VALUE h"1C".
           03 cuit-f  PIC X(11) VALUE zeros.
           03 filler  PIC X VALUE h"1C".
           03 civa-f  PIC x VALUE zeros.
           03 filler  PIC X VALUE h"1C".
           03 tdoc-f  PIC x VALUE zeros.
       01  Line-fac.
      * L¡nea de art¡culos del ticket  (Facturas A, B o ticket)
           03 cabe-c  PIC X VALUE "B".
           03 filler  PIC X VALUE h"1C".
           03 arti-c  PIC X(18) VALUE spaces.
           03 filler  PIC X VALUE h"1C".
           03 cant-c  PIC X(5) VALUE zeros.
           03 filler  PIC X VALUE h"1C".
           03 mont-c  PIC X(5) VALUE zeros.
           03 filler  PIC X VALUE h"1C".
           03 piva-c  PIC 99.99 VALUE zeros.
           03 filler  PIC X VALUE h"1C".
           03 impu-c  PIC x VALUE "M".
           03 filler  PIC X VALUE h"1C".
           03 impi-c  PIC X(10) VALUE "0.00000000".
           03 filler  PIC X VALUE h"1C".
           03 dspl-c  PIC x VALUE zeros.
           03 filler  PIC X VALUE h"1C".
           03 cali-c  PIC x VALUE "T".
       01  Cier-fis.
      * Pide valores calculados (Facturas A, B o ticket)
           03 filler  PIC X VALUE "E".
       copy "errores.cpy". 
       77  KEY-STATUS  IS SPECIAL-NAMES CRT STATUS PIC 9(5) VALUE 0.
           88 Screen-No-Input-Field               VALUE 97. 
           88  exit-button-pushed                 value 13.
       01 cont    pic 9(3). 
       01  mand-chr    pic x(512).
       01  long-chr    unsigned-Short.
       01 ventana-flo handle of window.
       01 fis-s  usage is unsigned-short. 
       01 com    usage is signed-int value 1.
       01 modo   usage is signed-int value 1.
       01 hand   usage is signed-int.
       01 hand1  usage is signed-int.
       01 hand2  usage is signed-int.
       01 hand3  usage is signed-int.  
       SCREEN SECTION.
       01 tik-tab.
          03  label "Tiket - A - B" line 1, col 2, size 15.
          03 tike-f, entry-field, using tipo-f, upper.
          03  push-button, "&OK", termination-value 100,
               size 8, line 3, col 13.
       01 cancela.
          03  label "Texto" line 1, col 2, size 15.
          03 Text-2   entry-field, using text-t.
          03  label "Pago" line 3, col 2, size 15.
          03 pago-2   entry-field, using pago-t.
          03  label "Cancela/Total" line 5, col 2, size 15.
          03 canc-2   entry-field, using canc-t.
          03  label "Display" line 7, col 2, size 15.
          03 dspl-2   entry-field, using dspl-t.
          03  push-button, "&OK", termination-value 100,
               size 8, line 9, col 13. 
       01 linea-fis.
          03  label "Atriculo" line 1, col 2, size 15.
          03 arti-1   entry-field, using arti-c.
          03  label "Cantidad" line 3, col 2, size 15.
          03 cant-1   entry-field, using cant-c.
          03  label "Monto" line 5, col 2, size 15.
          03 mont-1  entry-field, using mont-c.
          03  label "% IVA" line 7, col 2, size 15.
          03 piva-1   entry-field, using piva-c.
          03  label "M o m (+ o -)" line 9, col 2, size 15.
          03 impu-1   entry-field, using impu-c.
          03  label "Imp. Int." line 11, col 2, size 15.
          03 impi-1   entry-field, using impi-c.
          03  label "Display" line 13, col 2, size 15.
          03 dspl-1   entry-field, using dspl-c.
          03  label "B base o T Total" line 15, col 2, size 15.
          03 cali-1   entry-field, using cali-c.
          03  push-button, "&OK", termination-value 100,
               size 8, line 17, col 13.
       01 Com-scr.
          03 com-s, entry-field, using com, enabled 1
                   col 5, line 1.
          03  push-button, "&OK", termination-value 100,
               size 8, line 3, col 3.
          03  push-button, "&Salir", termination-value 101,
               size 8, line 3, col 13.
       01 acc-cli.
          03  label "Nombre" line 1, col 2, size 15.
          03 nomb-c  entry-field, using nomb-f.
          03  label "CUIT" line 3, col 2, size 15.
          03 cuit-c  entry-field, using cuit-f.
          03  label "Resp. IVA." line 5, col 2, size 15.
          03 civa-c  entry-field, using civa-f.
          03  label "Tipo Docum." line 7, col 2, size 15.
          03 tdoc-c  entry-field, using tdoc-f.
          03  push-button, "&OK", termination-value 100,
               size 8, line 9, col 18.
       01 opciones.
          03  push-button, "&Status fiscal", termination-value 100,
               size 18, line 1, col 2.
          03  push-button, "&Datos del Cliente", termination-value 101,
               size 18, line 3, col 2.
          03  push-button, "&Tiket Fac A - Fac B", 
              termination-value 102, size 18, line 5, col 2.
          03  push-button, "&Linea de item",
              termination-value 103, size 18, line 7, col 2.
          03  push-button, "&Cancela/Pago",
              termination-value 104, size 18, line 9, col 2.
          03  push-button, "&Cierra Comprobante",
              termination-value 105, size 18, line 11, col 2.
          03  push-button, "&Salir", termination-value 96,
               size 18, line 24, col 30.

      ******************************************************************
       PROCEDURE DIVISION.
       inicio.
           set environment "DLL_CONVENTION" to "WINAPI".         
           call "winfis32.dll".
           DISPLAY initial GRAPHICAL WINDOW
              SCREEN LINE 1, SCREEN COLUMN 1,
              LINES 25, SIZE 80,
              TITLE-BAR, MODELESS, ERASE, LINK TO THREAD,
              NO SCROLL, NO WRAP, COLOR IS 65793,
              TITLE "Prueba de Controlador Fiscal Bajo Windows 1.00",
              LABEL-OFFSET 0.
       accept-pant1.
           display com-scr.
           accept com-scr. 
           if key-status = 101
              go to fin.
           if com = zeros 
               go to accept-pant1.
           destroy com-scr. 
           call "VersionDLLFiscal" returning hand. 
           move zeros to hand long-chr.
       accept-pant2.
           display opciones
           perform, with test after, until exit-button-pushed
              accept opciones
                evaluate key-status
                   when 96
                     go to fin
                   when 100
                     move inicia to mand-chr
                     go to mand-pak
                   when 101
                     go to Datos
                   when 102
                     go to abre-fact
                   when 103
                     go to linea
                   when 104
                     go to canc
                   when 105
                     move cier-fis to mand-chr                       
                     go to mand-pak
                 end-evaluate
           end-perform.
           go to accept-pant2.
       canc.
           display floating  window,
               at line 1, at col 1,
               size 46, lines 11,
               handle in ventana-flo, 
               top centered title "Cancelacion/Pago".
           display cancela.
       a-canc.
           perform, with test after, until exit-button-pushed
              accept cancela
                evaluate key-status
                   when 100
                     destroy ventana-flo
                     move Tota-fis to mand-chr                       
                     go to mand-pak
                 end-evaluate
           end-perform.
           go to a-canc.       
       linea.
           display floating  window,
               at line 1, at col 1,
               size 46, lines 19,
               handle in ventana-flo, 
               top centered title "Linea de Irtem".
           display linea-fis.
       a-linea.
           perform, with test after, until exit-button-pushed
              accept linea-fis
                evaluate key-status
                   when 100
                     destroy ventana-flo
                     move line-fac to mand-chr                       
                     go to mand-pak
                 end-evaluate
           end-perform.
           go to a-linea. 
       abre-fact.
           display floating  window,
               at line 1, at col 1,
               size 46, lines 5,
               handle in ventana-flo, 
               top centered title "Abre tiket o Factura".
           display Tik-tab.
       a-tiket.
           perform, with test after, until exit-button-pushed
              accept Tik-tab
                evaluate key-status
                   when 100
                     destroy ventana-flo
                     move Abre-fac to mand-chr                       
                     go to mand-pak
                 end-evaluate
           end-perform.
           go to a-tiket.
       datos.
           display floating  window,
               at line 1, at col 1,
               size 46, lines 10,
               handle in ventana-flo, 
               top centered title "Datos del comprador".
           display acc-cli.
       a-datos.
           perform, with test after, until exit-button-pushed
              accept acc-cli
                evaluate key-status
                   when 100
                     destroy ventana-flo
                     move clie-fac to mand-chr                       
                     go to mand-pak
                 end-evaluate
           end-perform.
           go to a-datos.
        mand-pak.
           move zeros to cont hand1. 
      * a-inicio.
           call "OpenComFiscal" using by value com, by value modo,
                                returning hand. 
       ciclo-ini.
           add 1 to cont.
           call "InitFiscal" using by value hand giving hand1. 
           if cont > 100
              move "cont > 100"  to men-1
              perform info thru f-info
              go to fin.
           if hand1 >= 0 go to b-inicio.
           go to ciclo-ini.
       b-inicio.
           INSPECT mand-chr REPLACING TRAILING SPACES
                       BY LOW-VALUES.
           call "MandaPaqueteFiscal" using by value hand, 
                                     by reference mand-chr,
                                     returning hand1.  
           call "UltimoStatus" using by value hand1,
                                   by reference long-chr,
                                   by Reference fis-s,
                                   returning hand2.
            call "UltimaRespuesta" using by value Hand 
                                   by reference mand-chr.
           call "CloseComFiscal" using by value hand2,
                                 returning hand3. 
           move long-chr to men-1.
           move fis-s   to men-2.
           move mand-chr to men-3.
           perform info thru f-info. 
           go to accept-pant2.
       fin.
           stop run.
       info.
            move 3 to Mensage-tip.
            move 1 to Defecto-bot.
            move 1 to Boton-tipos.
            call "errores" using MENSAGE-TIP, RESPUESTA-TIP,
                                 MEN-1, MEN-2, MEN-3.
       f-info.
            exit.

