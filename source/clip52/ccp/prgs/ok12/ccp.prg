CORRECTO=0
DO WHILE .T.
   SET CURSOR OFF
   STORE 'N' TO SINO
   SET COLOR TO B+
   @0,0,24,79 BOX INTER2
   SET COLOR TO N/N
   @10,11,23,71 BOX INTER4
   SET COLOR TO B
   @9,9,22,69 BOX INTER4
   SET COLOR TO W+/B
   @10,10 TO 21,68 DOUBLE
   SET COLOR TO W/B
   @11,24 SAY '€€€€€€'
   @12,24 SAY '€€'
   @13,24 SAY '€€'
   @14,24 SAY '€€'
   @15,24 SAY '€€€€€€'

   @11,37 SAY '€€€€€€'
   @12,37 SAY '€€'
   @13,37 SAY '€€'
   @14,37 SAY '€€'
   @15,37 SAY '€€€€€€'

   @11,51 SAY '€€€€€€'
   @12,51 SAY '€€  €€'
   @13,51 SAY '€€€€€€'
   @14,51 SAY '€€'
   @15,51 SAY '€€'

   @17,12 SAY 'Centro Comercial del Pl†stico - G. ALVEAR - Tel: 425538'
   SET COLOR TO W+/B
   @20,12 SAY 'por Churti Morales '
   @20,12 SAY '      Modificado por Christian M†culus 15663290'
   @22,58 SAY 'Calculadora'
   SET COLOR TO BG+/B
   @22,52 SAY '<F10>'
   set color to *BG/B
   @19,14 SAY ' SISTEMAS MARKET SOFTWARE - GRAL.ALVEAR - MENDOZA '
   SET COLOR TO W+/B
   SAVE SCREEN TO LAUTI
   DECLARE MENUP[7]
   MENUP[1]='Mercader°a'
   MENUP[2]='Stock'
   MENUP[3]='Facturar'
   MENUP[4]='CtasCtes'
   MENUP[5]='Bancos'
   MENUP[6]='Utiles'
   MENUP[7]='Abandonar'
   DECLARE FILAS[7]
   FILAS [1] = 1
   FILAS [2] = 1
   FILAS [3] = 1
   FILAS [4] = 1
   FILAS [5] = 1
   FILAS [6] = 1
   FILAS [7] = 1
   DECLARE COLS [7]
   COLS [1] = 2
   COLS [2] = 15
   COLS [3] = 23
   COLS [4] = 34
   COLS [5] = 45
   COLS [6] = 54
   COLS [7] = 67
   DECLARE SUBMENU1[6]
   SUBMENU1[1]=' INGRESO      '
   SUBMENU1[2]=' BORRADO      '
   SUBMENU1[3]=' MODIFICACION '
   SUBMENU1[4]=' CONSULTAS    '
   SUBMENU1[5]=' LISTADO      '
   SUBMENU1[6]=' PRECIOS      '
   DECLARE SUBMENU2[3]
   SUBMENU2[1]=' INGRESO      '
   SUBMENU2[2]=' MODIFICACION '
   SUBMENU2[3]=' LISTADOS     '
   DECLARE SUBMENU3[3]
   SUBMENU3[1]=' FACTURAR A - B   '
   SUBMENU3[2]=' CONSULTA FACTURA '
   SUBMENU3[3]=' FACTURAR REMITOS '
   DECLARE SUBMENU4[4]
   SUBMENU4[1]=' ING. DATOS A CTAS '
   SUBMENU4[2]=' IMPRIMIR CUENTAS  '
   SUBMENU4[3]=' MODIFICAR CLIENTE '
   SUBMENU4[4]=' HACER REMITOS     '
   DECLARE SUBMENU5[6]
   SUBMENU5[1]=' EMITIR CHEQUE   '
   SUBMENU5[2]=' HACER DEPOSITO  '
   SUBMENU5[3]=' ENTRAR CHEQUES  '
   SUBMENU5[4]=' ACRED. DEPOSITO '
   SUBMENU5[5]=' RESUMEN BANCO   '
   SUBMENU5[6]=' BAJAS CHEQ/DEP  '
   DECLARE SUBMENU6[7]
   SUBMENU6[1]=' REPARAR        '
   SUBMENU6[2]=' HACER COPIA    '
   SUBMENU6[3]=' CAMPO MEMO     '
   SUBMENU6[4]=' RESTAURA COPIA '
   SUBMENU6[5]=' CAMBIAR CLAVE  '
   SUBMENU6[6]=' NUMERO FACTURA '
   SUBMENU6[7]=' LEER FACTURAS  '
   DECLARE SUBMENU7[2]
   SUBMENU7[1]=' ABANDONAR '
   SUBMENU7[2]=' CIERRES '
   DECLARE coldes[7]
   coldes[1]=1
   coldes[2]=14
   coldes[3]=22
   coldes[4]=33
   coldes[5]=44
   coldes[6]=53
   coldes[7]=66
   DECLARE filhas[7]
   filhas[1]=9
   filhas[2]=6
   filhas[3]=6
   filhas[4]=7
   filhas[5]=9
   filhas[6]=10
   filhas[7]=5
   DECLARE colhas[7]
   colhas[1]=16
   colhas[2]=29
   colhas[3]=41
   colhas[4]=53
   colhas[5]=62
   colhas[6]=70
   colhas[7]=78
   DECLARE POPUPS[7]
   POPUPS[1]='ACHOICE(3,2,8,15,SUBMENU1)'
   POPUPS[2]='ACHOICE(3,15,5,28,SUBMENU2)'
   POPUPS[3]='ACHOICE(3,23,5,40,SUBMENU3)'
   POPUPS[4]='ACHOICE(3,34,6,52,SUBMENU4)'
   POPUPS[5]='ACHOICE(3,45,8,61,SUBMENU5)'
   POPUPS[6]='ACHOICE(3,54,9,69,SUBMENU6)'
   POPUPS[7]='ACHOICE(3,67,4,77,SUBMENU7)'
   OP=POPUP(POPUPS,MENUP,FILAS,COLS,coldes,filhas,colhas)
   SET COLOR TO W+/B
   vuelve=0
   SAVE SCREEN TO RAUL
   PUBLIC KK
   STORE '' TO KK
   DO CASE
      case pepe='11'
         set color to *W+/B
         @3,2 say ' INGRESO      '
         set color to W+/B
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
         set color to *W+/B
         @4,2 say ' BORRADO      '
         set color to W+/B
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
         set color to *W+/B
         @5,2 say ' MODIFICACION '
         set color to W+/B
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
         DO MODIFICA
         RESTORE SCREEN FROM LAUTI
         LOOP
      case pepe='14'
         set color to *W+/B
         @6,2 say ' CONSULTAS    '
         set color to W+/B
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
         SET COLOR TO *W+/B
         @7,2 SAY ' LISTADO      '
         set color to W+/B
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
         DO L_MERCA
         RESTORE SCREEN FROM LAUTI
         LOOP
      case pepe='16'
         SET COLOR TO *W+/B
         @8,2 SAY ' PRECIOS      '
         set color to W+/B
         DO PRECIOS
         RESTORE SCREEN FROM LAUTI
         LOOP
      case pepe='21'
         set color to *W+/B
         @3,15 say ' INGRESO      '
         set color to W+/B
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
         SET COLOR TO *W+/B
         @4,15 SAY ' MODIFICACION '
         set color to W+/B
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
         SET COLOR TO *W+/B
         @5,15 SAY ' LISTADOS     '
         set color to W+/B
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
         DO WHILE .T.
            SET COLOR TO BG/B
            @4,29 TO 9,42
            @5,30 CLEAR TO 8,41
            SET COLOR TO BG+/B
            @5,32 SAY ' Listar '
            SET COLOR TO BG/B,W+/B
            @7,30 PROMPT ' EXISTENCIA '
            @8,30 PROMPT ' FALTANTES  '
            PUBLIC OPC2
            MENU TO OPC2
            SET COLOR TO BG/B,W+/B
            SAVE SCREEN TO KAKA
            DO CASE
               CASE OPC2=1
                  SET COLOR TO *W+/B
                  @7,30 SAY ' EXISTENCIA '
                  SET COLOR TO W+/B
                  SAVE SCREEN TO KAKA
                  STORE SPACE(15) TO DESDE,HASTA
                  SET CURSOR ON
                  @16,6 TO 20,72 DOUBLE
                  @17,7 CLEAR TO 19,71
                  @17,7 SAY 'Desde Art°culo:                   Hasta Art°culo:'
                  @19,26 SAY 'Pulse <ENTER> para tomar todos'
                  SET COLOR TO B/W
                  SET COLOR TO *BG+/B
                  @19,33 SAY 'ENTER'
                  SET COLOR TO BG/B,B/W
                  @17,22 SAY ''GET DESDE PICTURE '@!'
                  READ
                  SET CURSOR OFF
                  IF LASTKEY()=27
                     RESTORE SCREEN FROM ROMI
                     LOOP
                  ENDIF
                  IF DESDE=SPACE(15)
                     @17,7 CLEAR TO 19,71
                     SET COLOR TO *RG+/B
                     @17,35 SAY 'Tomando TODO'
                     SET COLOR TO W+/B
                     STORE '0' TO DESDE
                     STORE 'ZZZZZZZZZZZZZZZ' TO HASTA
                  ELSE
                     SET CURSOR ON
                     @19,7 CLEAR TO 19,71
                     SET COLOR TO *RG+/B
                     @19,33 SAY 'Tomando FRACCION'
                     SET COLOR TO BG/B,B/W
                     @17,56 SAY ''GET HASTA PICTURE '@!'
                     READ
                     IF LASTKEY()=27
                        RESTORE SCREEN FROM ROMI
                        LOOP
                     ENDIF
                  ENDIF
                  LD=LEN(ALLTRIM(DESDE))
                  LH=LEN(ALLTRIM(HASTA))
                  SET CURSOR OFF
                  USE STOCK
                  INDEX ON DETALLE TO ORDDET
                  GO TOP
                  COPY TO TEMPO FOR LEFT(DETALLE,LD)>=ALLTRIM(DESDE).AND.LEFT(DETALLE,LH)<=ALLTRIM(HASTA)
               CASE OPC2=2
                  SET COLOR TO *W+/B
                  @8,30 SAY ' FALTANTES  '
                  SET COLOR TO W+/B
                  SAVE SCREEN TO KAKA
                  INKEY(1)
                  USE STOCK
                  INDEX ON CANTIDAD TO ORDCANT
                  GO TOP
                  COPY TO TEMPO FOR CANTIDAD<=LIMITE
               OTHERWISE
                  EXIT
            ENDCASE
            RESTORE SCREEN FROM KAKA
            USE TEMPO
            INDEX ON DETALLE TO ORDDET
            GO TOP
            IF EOF()
               TONE(500,2)
               SET COLOR TO W+/B
               @18,29 TO 20,48
               @19,30 CLEAR TO 19,47
               SET COLOR TO *R+/B
               @19,31 SAY 'NO EXISTEN DATOS'
               SET COLOR TO W+/B
               INKEY(3)
               RESTORE SCREEN FROM ROMI
               LOOP
            ENDIF
            DO LISSTOCK
            RESTORE SCREEN FROM ROMI
            LOOP
         ENDDO
         RESTORE SCREEN FROM LAUTI
         LOOP
      case pepe='31'
         SET COLOR TO *W+/B
         @3,23 SAY ' FACTURAR         '
         set color to W+/B
         DO FACTU
         RESTORE SCREEN FROM LAUTI
         LOOP
      case pepe='32'
         SET COLOR TO *W+/B
         @4,23 SAY ' CONSULTA FACTURA '
         set color to W+/B
         DO CONSFAC
         RESTORE SCREEN FROM LAUTI
         LOOP
      case pepe='33'
         SET COLOR TO *W+/B
         @5,23 SAY ' FACTURAR REMITOS '
         set color to W+/B
         DO FACRM
         RESTORE SCREEN FROM LAUTI
         LOOP
      case pepe='41'
         SET COLOR TO *W+/B
         @3,34 SAY ' ING. DATOS A CTAS '
         set color to W+/B
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
         DO INGCTAS
         RESTORE SCREEN FROM LAUTI
         LOOP
      case pepe='42'
         SET COLOR TO *W+/B
         @4,34 SAY ' IMPRIMIR CUENTAS  '
         set color to W+/B
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
         DO IMPCTAS
         RESTORE SCREEN FROM LAUTI
         LOOP
      case pepe='43'
         SET COLOR TO *W+/B
         @5,34 SAY ' MODIFICAR CLIENTE '
         set color to W+/B
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
         DO MODCTAS
         RESTORE SCREEN FROM LAUTI
         LOOP
      case pepe='44'
         SET COLOR TO *W+/B
         @6,34 SAY ' HACER REMITOS     '
         set color to W+/B
         DO REMI
         RESTORE SCREEN FROM LAUTI
         LOOP
      case pepe='51'
         set color to *W+/B
         @3,45 say ' EMITIR CHEQUE   '
         set color to B/W
         DO PASS
         IF LASTKEY()=27
            RESTORE SCREEN FROM LAUTI
            LOOP
         ENDIF
         IF CORRECTO=0
            RESTORE SCREEN FROM LAUTI
            LOOP
         ENDIF
         DO EMICHE
      case pepe='52'
         set color to *W+/B
         @4,45 say ' HACER DEPOSITO  '
         set color to W+/B
         DO PASS
         IF LASTKEY()=27
            RESTORE SCREEN FROM LAUTI
            LOOP
         ENDIF
         IF CORRECTO=0
            RESTORE SCREEN FROM LAUTI
            LOOP
         ENDIF
         DO EMIDEP
      case pepe='53'
         set color to *W+/B
         @5,45 say ' ENTRAR CHEQUES  '
         set color to W+/B
         DO PASS
         IF LASTKEY()=27
            RESTORE SCREEN FROM LAUTI
            LOOP
         ENDIF
         IF CORRECTO=0
            RESTORE SCREEN FROM LAUTI
            LOOP
         ENDIF
         DO MARCACHE
      case pepe='54'
         set color to *W+/B
         @6,45 say ' ACRED. DEPOSITO '
         set color to W+/B
         DO PASS
         IF LASTKEY()=27
            RESTORE SCREEN FROM LAUTI
            LOOP
         ENDIF
         IF CORRECTO=0
            RESTORE SCREEN FROM LAUTI
            LOOP
         ENDIF
         DO ACREDITA
      case pepe='55'
         set color to *W+/B
         @7,45 say ' RESUMEN BANCO   '
         set color to W+/B
         DO PASS
         IF LASTKEY()=27
            RESTORE SCREEN FROM LAUTI
            LOOP
         ENDIF
         IF CORRECTO=0
            RESTORE SCREEN FROM LAUTI
            LOOP
         ENDIF
         DO ESTADO
      case pepe='56'
         set color to *W+/B
         @8,45 say ' BAJAS CHEQ/DEP  '
         set color to W+/B
         DO PASS
         IF LASTKEY()=27
            RESTORE SCREEN FROM LAUTI
            LOOP
         ENDIF
         IF CORRECTO=0
            RESTORE SCREEN FROM LAUTI
            LOOP
         ENDIF
         DO BAJABCO
      case pepe='61'
         set color to *W+/B
         @3,54 say ' REPARAR        '
         set color to B/W
         @19,14 SAY ' SISTEMAS MARKET SOFTWARE - GRAL.ALVEAR - MENDOZA '
         tone(1200,2)
         SET COLOR TO W+/B
         @13,24,19,54 BOX CUADRO1
         SET CURSO OFF
         SET COLOR TO BG+/B
         @15,30 SAY 'ORDENANDO LAS BASES'
         set color to *RG+/B
         @17,28 SAY '...ESPERE UN MOMENTO...'
         set color to W+/B
         USE MERCA
         INDEX ON CODIGO TO ORDCOD
         REINDEX
         INDEX ON DETALLE TO ORDDET
         REINDEX
         INDEX ON FIRMA TO ORDFIRM
         REINDEX
         INDEX ON RUBRO TO ORDRUBR
         REINDEX
         CLOSE
         USE STOCK
         INDEX ON CODIGO TO ORDCOD
         REINDEX
         CLOSE
         USE BANCOS
         INDEX ON FECHA TO ORDFEC
         REINDEX
         CLOSE
         USE DESTINOS
         INDEX ON NOMBRES TO ORDNOM
         REINDEX
         CLOSE
         USE CTASCTES
         INDEX ON NOMBRE TO ORDNOM
         REINDEX
         CLOSE
         USE FIRMAS
         INDEX ON NOMBRES TO O_N_FIRM
         REINDEX
         INDEX ON CODIGO TO O_C_FIRM
         REINDEX
         CLOSE
         USE RUBROS
         INDEX ON NOMBRES TO O_N_RUBR
         REINDEX
         INDEX ON CODIGO TO O_C_RUBR
         REINDEX
         CLOSE
         ** USE GASTOS
         ** INDEX ON FECHA TO ORDFEC
         ** REINDEX
         ** CLOSE
         ** USE VENTAS
         ** INDEX ON NUMEROCAJA TO ORDCAJA
         ** REINDEX
         ** INDEX ON FECHA TO ORDFEC
         ** REINDEX
         ** CLOSE
         ** USE BASECAJA
         ** INDEX ON NUMEROCAJA TO ORDCAJA
         ** REINDEX
         ** INDEX ON FECHA TO O_CAJFEC
         ** REINDEX
         ** CLOSE
         ** USE ACTUAL
         ** INDEX ON OPERADOR TO INDXNOM
         ** REINDEX
         ** CLOSE
         ** USE OPERA
         ** INDEX ON OPERADOR TO INDXNOM
         ** REINDEX
         ** CLOSE
         set color to W+/B
         @13,24,19,54 BOX CUADRO1
         SET CURSO OFF
         set color to *G+/B
         @16,29 SAY 'BASES ORDENADAS...OK!'
         set color to W+/B
         tone(1200,1)
         tone(1200,1)
         tone(1200,1)
         INKEY(3)
      case pepe='62'
         set color to *W+/B
         @4,54 say ' HACER COPIA    '
         set color to W+/B
         DO HACECOPY
      case pepe='63'
         set color to *W+/B
         @5,54 say ' CAMPO MEMO     '
         set color to W+/B
         DO MIAYUDA
      case pepe='64'
         set color to *W+/B
         @6,54 say ' RESTAURA COPIA '
         set color to W+/B
         DO RESTAURA
      case pepe='65'
         set color to *W+/B
         @7,54 say ' CAMBIAR CLAVE  '
         set color to W+/B
         DO PASS1
      case pepe='66'
         set color to *W+/B
         @8,54 say ' NUMERO FACTURA '
         set color to W+/B
         DO PASS
         IF LASTKEY()=27
            RESTORE SCREEN FROM LAUTI
            LOOP
         ENDIF
         IF CORRECTO=0
            RESTORE SCREEN FROM LAUTI
            LOOP
         ENDIF
         DO ENUMERAR
      case pepe='67'
         set color to *W+/B
         @9,54 say ' LEER FACTURAS  '
         set color to W+/B
         DO PASS
         IF LASTKEY()=27
            RESTORE SCREEN FROM LAUTI
            LOOP
         ENDIF
         IF CORRECTO=0
            RESTORE SCREEN FROM LAUTI
            LOOP
         ENDIF
         DO LEER
      case pepe='71'
         RESTORE SCREEN FROM LAUTI
         SET COLOR TO B+/B
         @0,0,8,79 BOX INTER2
         SET COLOR TO B/B
         @9,15 SAY '€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€'
         set color to W+/B
         @0,0 TO 2,79
         @1,1 CLEAR TO 1,78
         set color to B+/B
         @1,2 SAY 'Mercader°a'
         @1,15 SAY 'Stock'
         @1,23 SAY 'Facturar'
         @1,34 SAY 'CtasCtes'
         @1,45 SAY 'Bancos'
         @1,54 SAY 'Utiles'
         set color to BG+/B
         @1,67 SAY 'Abandonar'
         set color to *W+/B
         @3,67 say ' ABANDONAR '
         set color to B+/B
         @0,66 TO 2,76
         set color to BG/B
         @2,66 TO 4,78 
         tone(500,2)
         SET COLOR TO N/B
         @14,22,18,60 BOX INTER4
         SET COLOR TO R/B
         @13,21,17,58 BOX INTER2
         SET COLOR TO BG+/N
         @14,22,16,57 BOX CUADRO9
         SET CURSOR OFF
         SET COLOR TO W+/N
         @15,24 SAY '®Est† seguro de Abandonar? ( / )'
         SET COLOR TO *R+/N
         @15,52 SAY 'S'
         @15,54 SAY 'N'
         SET COLOR TO W+/B
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
