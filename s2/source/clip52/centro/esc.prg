#include "colores.ch"
CORRECTO=0
DO WHILE .T.
   SET CURSOR OFF
   STORE 'N' TO SINO
   SET COLOR TO FONDO0
   @0,0,24,79 BOX INTER2
   SET COLOR TO COLOR1
   @10,11,23,71 BOX INTER4
   SET COLOR TO COLOR14
   @9,9,22,69 BOX INTER4
   SET COLOR TO COLOR10
   @10,10 TO 21,68 DOUBLE
   SET COLOR TO COLOR4
   @12,14 SAY '€€€€€€'
   @13,14 SAY '€€     '
   @14,14 SAY '€€€€€€'
   @15,14 SAY '€€ '
   @16,14 SAY '€€€€€€'
   @12,23 SAY '€€€€€€'
   @13,23 SAY '€€'
   @14,23 SAY '€€€€€€'
   @15,27 SAY     '€€'
   @16,23 SAY '€€€€€€'
   @12,32 SAY '€€€€€€'
   @13,32 SAY '€€     '
   @14,32 SAY '€€ '
   @15,32 SAY '€€ '
   @16,32 SAY '€€€€€€'
   @11,41 TO 17,41
   @12,45 SAY 'staci¢n de'
   @14,54 SAY 'ervicios'
   @16,61 SAY 'entro'
   @22,58 SAY 'Calculadora'
   SET COLOR TO COLOR3
   @18,11 TO 18,67
   @12,44 SAY 'E'
   @14,53 SAY 'S'
   @16,60 SAY 'C'
   @22,52 SAY '<F10>'
   set color to LETRASC1
   @19,16 SAY 'Programado por Chango - Christian A. M†culus'
   @20,14 SAY 'Tel. 02625-425706 / Mail: chmaculus@softhome.net'
   SET COLOR TO COLOR0
   SAVE SCREEN TO LAUTI


   DECLARE MENUP[6]
   MENUP[1]='Mercader°a'
   MENUP[2]='Stock'
   MENUP[3]='Venta'
   MENUP[4]='Utiles'
   MENUP[5]='Operadores'
   MENUP[6]='Salir'

   DECLARE FILAS[6]
   FILAS [1] = 1
   FILAS [2] = 1
   FILAS [3] = 1
   FILAS [4] = 1
   FILAS [5] = 1
   FILAS [6] = 1

   DECLARE COLS [6]
   COLS [1] = 3
   COLS [2] = 20
   COLS [3] = 32
   COLS [4] = 44
   COLS [5] = 56
   COLS [6] = 70

   DECLARE coldes[6]
   coldes[1]=2
   coldes[2]=19
   coldes[3]=31
   coldes[4]=43
   coldes[5]=56
   coldes[6]=77

   DECLARE filhas[6]
   filhas[1]=9
   filhas[2]=6
   filhas[3]=11
   filhas[4]=9
   filhas[5]=4
   filhas[6]=4

   DECLARE colhas[6]
   colhas[1]=17
   colhas[2]=34
   colhas[3]=47
   colhas[4]=60
   colhas[5]=67
   colhas[6]=69

   DECLARE SUBMENU1[6]
   SUBMENU1[1]=' INGRESO      '
   SUBMENU1[2]=' BORRADO      '
   SUBMENU1[3]=' MODIFICACION '
   SUBMENU1[4]=' CONSULTAS    '
   SUBMENU1[5]=' LISTADO      '
   SUBMENU1[6]=' CLASIFICACION'

   DECLARE SUBMENU2[3]
   SUBMENU2[1]=' INGRESO      '
   SUBMENU2[2]=' MODIFICACION '
   SUBMENU2[3]=' LISTADOS     '

   DECLARE SUBMENU3[8]
   SUBMENU3[1]=' HACER VENTA   '
   SUBMENU3[2]=' LISTAR VENTAS '
   SUBMENU3[3]=' MODIFICA VTAS '
   SUBMENU3[4]=' CAJA DE TURNO '
   SUBMENU3[5]=' LISTADOS CAJA '
   SUBMENU3[6]=' ARQUEO CAJA   '
   SUBMENU3[7]=' AGREGAR CAJA  '
   SUBMENU3[8]=' GASTOS VARIOS '

   DECLARE SUBMENU4[6]
   SUBMENU4[1]=' REPARAR        '
   SUBMENU4[2]=' HACER COPIA    '
   SUBMENU4[3]=' CAMPO MEMO     '
   SUBMENU4[4]=' RESTAURA COPIA '
   SUBMENU4[5]=' CAMBIAR CLAVE  '
   SUBMENU4[6]=' LEER FACTURAS  '

   DECLARE SUBMENU5[1]
   SUBMENU5[1]='OPERADORES'

   DECLARE SUBMENU6[1]
   SUBMENU6[1]=' SALIR '

   DECLARE POPUPS[6]
   POPUPS[1]='ACHOICE(3,3,8,16,SUBMENU1)'
   POPUPS[2]='ACHOICE(3,20,5,33,SUBMENU2)'
   POPUPS[3]='ACHOICE(3,32,10,46,SUBMENU3)'
   POPUPS[4]='ACHOICE(3,44,8,59,SUBMENU4)'
   POPUPS[5]='ACHOICE(3,57,3,66,SUBMENU5)'
   POPUPS[6]='ACHOICE(3,70,3,76,SUBMENU6)'
   OP=POPUP(POPUPS,MENUP,FILAS,COLS,coldes,filhas,colhas)

   SET COLOR TO COLOR0
   vuelve=0
   SAVE SCREEN TO RAUL
   PUBLIC KK
   STORE '' TO KK

   DO CASE
      case pepe='11'
         DO PASS
         IF LASTKEY()=27
            RESTORE SCREEN FROM LAUTI
            LOOP
         ENDIF
         IF CORRECTO=0
            RESTORE SCREEN FROM LAUTI
            LOOP
         ENDIF

         DO INGMERC

      case pepe='12'
         set color to COLOR8
         @4,3 say ' BORRADO      '
         set color to COLOR0
         DO PASS
         IF LASTKEY()=27
            RESTORE SCREEN FROM LAUTI
            LOOP
         ENDIF
         IF CORRECTO=0
            RESTORE SCREEN FROM LAUTI
            LOOP
         ENDIF
         USE MERCA
         INDEX ON DETALLE TO ORDDET
         GO TOP
         DO BAJMERC

      case pepe='13'
         set color to COLOR8
         @5,3 say ' MODIFICACION '
         set color to COLOR0
         DO PASS
         IF LASTKEY()=27
            RESTORE SCREEN FROM LAUTI
            LOOP
         ENDIF
         IF CORRECTO=0
            RESTORE SCREEN FROM LAUTI
            LOOP
         ENDIF
         DO MODMERC
         RESTORE SCREEN FROM LAUTI
         LOOP

      case pepe='14'
         set color to COLOR8
         @6,3 say ' CONSULTAS    '
         set color to COLOR0
         DO PASS
         IF LASTKEY()=27
            RESTORE SCREEN FROM LAUTI
            LOOP
         ENDIF
         IF CORRECTO=0
            RESTORE SCREEN FROM LAUTI
            LOOP
         ENDIF
         DO CONMERC
         RESTORE SCREEN FROM LAUTI
         LOOP

      case pepe='15'
         SET COLOR TO COLOR8
         @7,3 SAY ' LISTADO      '
         SET COLOR TO COLOR0
         SAVE SCREEN TO ROMI
         DO PASS
         IF LASTKEY()=27
            RESTORE SCREEN FROM LAUTI
            LOOP
         ENDIF
         IF CORRECTO=0
            RESTORE SCREEN FROM LAUTI
            LOOP
         ENDIF
         RESTORE SCREEN FROM ROMI
         DO LISTMERC
         RESTORE SCREEN FROM LAUTI
         LOOP

      case pepe='16'
         SET COLOR TO COLOR8
         @8,3 SAY ' CLASIFICACION'
         SET COLOR TO COLOR0
         SAVE SCREEN TO ROMI
         DO PASS
         IF LASTKEY()=27
            RESTORE SCREEN FROM LAUTI
            LOOP
         ENDIF
         IF CORRECTO=0
            RESTORE SCREEN FROM LAUTI
            LOOP
         ENDIF
         RESTORE SCREEN FROM ROMI
         DO CLAS_ING
         RESTORE SCREEN FROM LAUTI
         LOOP

      case pepe='21'
*         set color to COLOR5
*         @10,10, 20,70 BOX '€€€€€€€€€'
         set color to COLOR8
         @3,20 say ' INGRESO      '
         SET COLOR TO COLOR0
         SAVE SCREEN TO ROMI
         DO PASS
         IF LASTKEY()=27
            RESTORE SCREEN FROM LAUTI
            LOOP
         ENDIF
         IF CORRECTO=0
            RESTORE SCREEN FROM LAUTI
            LOOP
         ENDIF
         RESTORE SCREEN FROM ROMI
         DO INGSTOCK
         RESTORE SCREEN FROM LAUTI
         LOOP

      case pepe='22'
         SET COLOR TO COLOR8
         @4,20 SAY ' MODIFICACION '
         SET COLOR TO COLOR0
         SAVE SCREEN TO ROMI
         DO PASS
         IF LASTKEY()=27
            RESTORE SCREEN FROM LAUTI
            LOOP
         ENDIF
         IF CORRECTO=0
            RESTORE SCREEN FROM LAUTI
            LOOP
         ENDIF
         RESTORE SCREEN FROM ROMI
         DO MODSTOCK
         RESTORE SCREEN FROM LAUTI
         LOOP

      case pepe='23'
         SET COLOR TO COLOR8
         @5,20 SAY ' LISTADOS     '
         SET COLOR TO COLOR0
         SAVE SCREEN TO ROMI
         DO PASS
         IF LASTKEY()=27
            RESTORE SCREEN FROM LAUTI
            LOOP
         ENDIF
         IF CORRECTO=0
            RESTORE SCREEN FROM LAUTI
            LOOP
         ENDIF
         RESTORE SCREEN FROM ROMI
         DO LISTOCK
         RESTORE SCREEN FROM LAUTI
         LOOP

      case pepe='31'
         SET COLOR TO COLOR8
         @3,32 SAY ' HACER VENTA   '
         SET COLOR TO COLOR0
         DO HACEVTA
         RESTORE SCREEN FROM LAUTI
         LOOP

      case pepe='32'
         SET COLOR TO COLOR8
         @4,32 SAY ' LISTAR VENTAS '
         SET COLOR TO COLOR0
         DO LISTVTA
         RESTORE SCREEN FROM LAUTI
         LOOP

      case pepe='33'
         SET COLOR TO COLOR8
         @5,32 SAY ' MODIFICA VTAS '
         SET COLOR TO COLOR0
         DO PASS
         IF LASTKEY()=27
            RESTORE SCREEN FROM LAUTI
            LOOP
         ENDIF
         IF CORRECTO=0
            RESTORE SCREEN FROM LAUTI
            LOOP
         ENDIF
         DO MODVTAS
         RESTORE SCREEN FROM LAUTI
         LOOP

      case pepe='34'
         SET COLOR TO COLOR8
         @6,32 SAY ' CAJA DE TURNO '
         SET COLOR TO COLOR0
*         DO CAJA
         RESTORE SCREEN FROM LAUTI
         LOOP

      case pepe='35'

         SET COLOR TO COLOR8
         @7,32 SAY ' LISTADOS CAJA '
         SET COLOR TO COLOR0
         DO PASS
         IF LASTKEY()=27
            RESTORE SCREEN FROM LAUTI
            LOOP
         ENDIF
         IF CORRECTO=0
            RESTORE SCREEN FROM LAUTI
            LOOP
         ENDIF
         RESTORE SCREEN FROM LAUTI
         DO LISCAJA






      case pepe='36'
         SET COLOR TO COLOR8
         @8,32 SAY ' ARQUEO CAJA   '
         SET COLOR TO COLOR0
         DO CIERRE
*         DO PASS
         IF LASTKEY()=27
            RESTORE SCREEN FROM LAUTI
            LOOP
         ENDIF
         IF CORRECTO=0
            RESTORE SCREEN FROM LAUTI
            LOOP
         ENDIF
         RESTORE SCREEN FROM LAUTI
         LOOP

      case pepe='37'
         SET COLOR TO COLOR8
         @9,32 SAY ' AGREGAR CAJA  '
         SET COLOR TO COLOR0
         DO PASS
         IF LASTKEY()=27
            RESTORE SCREEN FROM LAUTI
            LOOP
         ENDIF
         IF CORRECTO=0
            RESTORE SCREEN FROM LAUTI
            LOOP
         ENDIF
         DO AGRECAJA
         RESTORE SCREEN FROM LAUTI
         LOOP

      case pepe='38'
         SET COLOR TO COLOR8
         @10,32 SAY ' GASTOS VARIOS '
         SET COLOR TO COLOR0
         DO PASS
         IF LASTKEY()=27
            RESTORE SCREEN FROM LAUTI
            LOOP
         ENDIF
         IF CORRECTO=0
            RESTORE SCREEN FROM LAUTI
            LOOP
         ENDIF
         DO INGASTOS
         RESTORE SCREEN FROM LAUTI
         LOOP

      case pepe='41'
         set color to COLOR8
         @3,44 say ' REPARAR        '
         set color TO COLOR6
         @19,14 SAY ' VER DONDE ESTA '
         tone(1200,2)
         SET COLOR TO COLOR4
         @13,24,19,54 BOX CUADRO1
         SET CURSO OFF
         SET COLOR TO COLOR6
         @15,30 SAY 'ORDENANDO LAS BASES'
         set color to COLOR8
         @17,28 SAY '...ESPERE UN MOMENTO...'
         SET COLOR TO COLOR0

          DO REPNTX

         SET COLOR TO COLOR2
         @13,24,19,54 BOX CUADRO1
         SET CURSO OFF
         set color to COLOR8
         @16,29 SAY 'BASES ORDENADAS...OK!'
         SET COLOR TO COLOR0
         tone(1200,1)
         tone(1200,1)
         tone(1200,1)
         INKEY(3)

      case pepe='42'
         set color to COLOR8
         @4,44 say ' HACER COPIA    '
         set color to COLOR0
         DO HACECOPY

      case pepe='43'
         set color to COLOR8
         @5,44 say ' CAMPO MEMO     '
         set color to COLOR0
         DO MIAYUDA

      case pepe='44'
         set color to COLOR8
         @6,44 say ' RESTAURA COPIA '
         set color to COLOR0
         DO RESTAURA

      case pepe='45'
         set color to COLOR8
         @7,44 say ' CAMBIAR CLAVE  '
         set color to COLOR0
         DO PASS1

      case pepe='46'
         set color to COLOR8
         @8,44 say ' LEER FACTURAS  '
         set color to COLOR0
         DO PASS
         IF LASTKEY()=27
            RESTORE SCREEN FROM LAUTI
            LOOP
         ENDIF
         IF CORRECTO=0
            RESTORE SCREEN FROM LAUTI
            LOOP
         ENDIF
         *DO LEER

      case pepe='51'
         set color to COLOR8
         @3,57 say 'OPERADORES'
         set color to COLOR0
         DO PASS
         IF LASTKEY()=27
            RESTORE SCREEN FROM LAUTI
            LOOP
         ENDIF
         IF CORRECTO=0
            RESTORE SCREEN FROM LAUTI
            LOOP
         ENDIF
         DO OPERAD

      case pepe='61'
         RESTORE SCREEN FROM LAUTI
         SET COLOR TO FONDO0
         @0,0,8,79 BOX INTER2
         set color TO COLOR10
         @0,0 TO 2,79
         @1,1 CLEAR TO 1,78
         set color TO LETRASC0
         @1,3 SAY 'Mercader°a'
         @1,20 SAY 'Stock'
         @1,32 SAY 'Venta'
         @1,44 SAY 'Utiles'
         @1,56 say 'Operadores'
         @1,70 SAY 'Salir'
         set color to LETRASC1
         @3,70 say ' SALIR '
         set color to FONDO0
         @0,69 TO 2,76
         @2,69 TO 4,77 
         set color to COLOR0
         tone(500,2)
         SET COLOR TO COLOR15
         @14,24,18,58 BOX INTER4
         SET COLOR TO COLOR4
         @13,23,17,56 BOX INTER2
         SET COLOR TO COLOR10
         @14,24,16,55 BOX CUADRO3
         SET CURSOR OFF
         SET COLOR TO COLOR1
         @15,26 SAY '®Est† seguro de Salir? ( / )'
         SET COLOR TO COLOR8
         @15,50 SAY 'S'
         @15,52 SAY 'N'
         SET COLOR TO COLOR0
         INKEY(0)
         IF LASTKEY()=83.OR.LASTKEY()=115
            RETURN
         ELSE
            RESTORE SCREEN FROM RAUL
            LOOP
         ENDIF
      OTHERWISE
         RESTORE SCREEN FROM RAUL
         LOOP
   endcase
   RESTORE SCREEN FROM RAUL
   LOOP
ENDDO
