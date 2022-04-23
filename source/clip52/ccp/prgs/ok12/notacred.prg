DO WHILE .T.
   CLEAR
   SET COLOR TO W+/B
   @1,0 SAY 'CENTRO COMERCIAL DEL PLASTICO'
   NUMDIA=LEFT(DTOC(DATE()),2)
   DIA=TDIAS(CDOW(DATE()))
   MES=TMES(CMONTH(DATE()))
   ANIO=ALLTRIM(STR(YEAR(DATE())))
   VFECHA=DIA+' '+NUMDIA+' de '+MES+' de '+ANIO
   LL=79-LEN(VFECHA)
   @1,LL SAY VFECHA
   SET COLOR TO BG/B
   @2,0 SAY REPLICATE('Ä',29)
   @2,LL SAY REPLICATE('Ä',LEN(VFECHA))
   @3,29 TO 5,47
   SET COLOR TO W+/B
   @4,31 SAY 'NOTA DE CREDITO'
   SAVE SCREEN TO MELLI
   SET COLOR TO W+/B
   USE CLIENTES
   INDEX ON NOMBRE TO ORDNOM
   GO TOP
   SET COLOR TO BG/B
   @6,0 TO 21,79
   @7,1 CLEAR TO 20,78
   @19,1 TO 19,78
   @17,1 TO 17,78
   @18,1 CLEAR TO 18,78
   @20,1 CLEAR TO 20,78
   SET COLOR TO W+/B
   @20,12 SAY '        Tomar'
   @20,35 SAY '     Otros'
   @20,55 SAY '      Salir'
   SET COLOR TO BG+/B
   @18,30 SAY 'Datos de Clientes'
   @20,12 SAY '<ENTER>'
   @20,35 SAY '<F5>'
   @20,55 SAY '<ESC>'
   DECLARE CAMP[3]
   CAMP[1]='NOMBRE'
   CAMP[2]='DOMICILIO'
   CAMP[3]='SITUIVA'
   DECLARE CABEZ[3]
   CABEZ[1]='     Apellido y Nombres'
   CABEZ[2]='          Domicilio'
   CABEZ[3]='Sit. IVA'
   DECLARE SEPAR[3]
   SEPAR[1]='Ä'
   SEPAR[2]='Ä'
   SEPAR[3]='Ä'
   SET CURSOR OFF
   CLEAR TYPEAHEAD
   SET COLOR TO B+/B
   @24,1 SAY 'Buscar:                                                                       '
   SET COLOR TO BG/B,B/W
   DBEDIT(7,1,16,78,CAMP,'FUNCI','',CABEZ,SEPAR)
   IF LASTKEY()=27
      RETURN
   ENDIF
   IF LASTKEY()=13
      STORE DNI TO VDOCU
      STORE NOMBRE TO VNOMBRE
      STORE DOMICILIO TO VDOMI
      STORE TELEFONO TO VTELE
      STORE CUIT TO VCUIT
      STORE SITUIVA TO VIVA
   ENDIF
   IF LASTKEY()=-4
      SAVE SCREEN TO ANDRES
      INDEX ON DNI TO ORDDOCU
      GO TOP
      DO WHILE .T.
         SET COLOR TO B+/B
         @13,0 TO 21,79
         @14,1 CLEAR TO 20,78
         STORE SPACE(30) TO VNOMBRE,VDOMI
         STORE SPACE(15) TO VTELE
         STORE SPACE(2) TO VIVA
         STORE 0 TO VDOCU,VCUIT
         SET CURSOR ON
         SET COLOR TO BG/B,B/W
         @15,2 SAY 'Ingrese D.N.I.:'GET VDOCU PICTURE '99,999,999'
         READ
         IF LASTKEY()=27
            RESTORE SCREEN FROM ANDRES
            RETURN
         ENDIF
         IF VDOCU=0
            EXIT
         ENDIF
         SEEK VDOCU
         IF .NOT. EOF()
            TONE(1200,1)
            SET COLOR TO W+/B
            @22,2 CLEAR TO 22,77
            SET COLOR TO *R+/B
            @22,30 SAY 'CLIENTE EXISTENTE'
            INKEY(3)
            RESTORE SCREEN FROM ANDRES
            LOOP
         ENDIF
         @15,31 SAY 'Ingrese Cliente:'GET VNOMBRE PICTURE '@!'
         @17,2 SAY 'Ingrese Domicilio:'GET VDOMI PICTURE '@!'
         @17,53 SAY 'Tel‚fono:'GET VTELE PICTURE '@!'
         READ
         IF LASTKEY()=27
            RESTORE SCREEN FROM ANDRES
            RETURN
         ENDIF
         @19,2 SAY 'Situaci¢n frente al IVA:'
         SAVE SCREEN TO HIJO
         @18,30 TO 20,73
         SET WRAP ON
         SET COLOR TO W+/B,B/W
         @19,32 PROMPT '  RI  '
         @19,40 PROMPT '  NR  '
         @19,48 PROMPT '  MT  '
         @19,56 PROMPT '  EX  '
         @19,64 PROMPT '  CF  '
         MENU TO STIV
         SET COLOR TO W+/B,B/W
         DO CASE
            CASE STIV=1
               VIVA='RI'
               VVI='RESPONSABLE INSCRIPTO'
            CASE STIV=2
               VIVA='NR'
               VVI='NO RESPONSABLE'
            CASE STIV=3
               VIVA='MT'
               VVI='MONOTRIBUTISTA'
            CASE STIV=4
               VIVA='EX'
               VVI='EXENTO'
            CASE STIV=5
               VIVA='CF'
               VVI='CONSUMIDOR FINAL'
         ENDCASE
         RESTORE SCREEN FROM HIJO
         SET COLOR TO B/W
         @19,27 SAY VVI
         SET COLOR TO BG/B,B/W
         @19,53 SAY 'C.U.I.T.:'GET VCUIT PICTURE '99-99999999-9'
         READ
         IF LASTKEY()=27
            RESTORE SCREEN FROM ANDRES
            LOOP
         ENDIF
         SET COLOR TO W+/B
         SET CURSOR OFF
         TONE(500,1)
         SET COLOR TO W+/B
         @22,25 SAY '¨ Guarda Este Cliente (S/N) ?'
         SET COLOR TO *R+/B
         @22,48 SAY 'S'
         @22,50 SAY 'N'
         SET COLOR TO W+/B
         DO WHILE .T.
            INKEY(0)
            IF LASTKEY()<>78.AND.LASTKEY()<>83.AND.LASTKEY()<>110.AND.LASTKEY()<>115
               TONE(500,1)
               LOOP
            ENDIF
            EXIT
         ENDDO
         IF LASTKEY()=83.OR.LASTKEY()=115
            APPEND BLANK
            REPLACE NOMBRE WITH VNOMBRE,DOMICILIO WITH VDOMI,DNI WITH VDOCU,TELEFONO WITH VTELE
            REPLACE CUIT WITH VCUIT,SITUIVA WITH VIVA
         ENDIF
         RESTORE SCREEN FROM ANDRES
         EXIT
      ENDDO
   ENDIF
   IF VIVA='RI'
      STORE 'A' TO FACTURACION
      USE NFA
      GO TOP
      STORE NUMERO+1 TO NUMFA
      CARTEL='Fact '+FACTURACION+' '+ALLTRIM(STR(NUMFA))
   ELSE
      STORE 'B' TO FACTURACION
      USE NFB
      GO TOP
      STORE NUMERO+1 TO NUMFB
      CARTEL='Fact '+FACTURACION+' '+ALLTRIM(STR(NUMFB))
   ENDIF
   CLEAR
   SET COLOR TO W+/B
   @1,0 SAY 'CENTRO COMERCIAL DEL PLASTICO'
   NUMDIA=LEFT(DTOC(DATE()),2)
   DIA=TDIAS(cdow(DATE()))
   MES=TMES(CMONTH(DATE()))
   ANIO=ALLTRIM(STR(YEAR(DATE())))
   VFECHA=DIA+' '+NUMDIA+' de '+MES+' de '+ANIO
   LL=79-LEN(VFECHA)
   @1,LL SAY VFECHA
   SET COLOR TO BG/B
   @2,0 SAY REPLICATE('Ä',29)
   @2,LL SAY REPLICATE('Ä',LEN(VFECHA))
   @3,29 TO 5,48
   SET COLOR TO *W+/B
   @4,31 SAY 'NOTA DE CREDITO'
   SET COLOR TO BG/B
   @8,0 SAY '  Cant.                       Detalle                             Importe'
   @8,8 SAY '³'
   @8,61 SAY '³'
   @7,0 SAY REPLICATE('Ä',79)
   @9,0 SAY REPLICATE('Ä',79)
   @21,0 SAY REPLICATE('Ä',79)
   SET COLOR TO W+/B
   @23,0 SAY REPLICATE('Ä',79)
   @22,30 SAY '<ESC> Sale/Guarda'
   @6,1 SAY 'Cliente:                                                CUIT:'
   SET COLOR TO BG+/B
   @6,10 SAY LEFT(VNOMBRE,45)
   IF VCUIT=0
      @6,63 SAY '  -        - '
   ELSE
      @6,63 SAY VCUIT PICTURE '99-99999999-9'
   ENDIF
   @22,31 SAY 'ESC'
   SET COLOR TO RG+/B
   @24,1 SAY CARTEL
   SET COLOR TO BG+/B
   @24,17 SAY '³'
   STORE 0 TO VALOR
   SET CURSOR ON
   SET COLOR TO B/W
   @10,4 SAY ' 1 '
   STORE 'NOTA DE CREDITO                                   ' TO ESNOTA
   SET COLOR TO BG/B
   @10,8 SAY '³'
   @10,61 SAY '³'
   SET COLOR TO W+/B,B/W
   @10,9 SAY ''GET ESNOTA PICTURE '@!'
   KEYBOARD CHR(6)
   @10,65 SAY ''GET VALOR PICTURE '9999.99'
   READ
   IF LASTKEY()=27.OR.VALOR=0
      RETURN
   ENDIF
   @22,10 CLEAR TO 22,70
   SET CURSOR OFF
   SET COLOR TO W+/B
   @22,27  SAY '¨ Guardar el cr‚dito (S/N) ?'
   SET COLOR TO *R+/B
   @22,49  SAY 'S'
   @22,51  SAY 'N'
   SET COLOR TO W+/B
   TONE(1200,1)
   DO WHILE .T.
      INKEY(0)
      IF LASTKEY()<>83.AND.LASTKEY()<>115.AND.LASTKEY()<>78.AND.LASTKEY()<>110
         TONE(1200,1)
         LOOP
      ENDIF
      EXIT
   ENDDO
   IF LASTKEY()=83.OR.LASTKEY()=115
      IF VIVA='RI'
         USE NFA
         GO TOP
         REPLACE NUMERO WITH NUMFA
         STORE NUMFA TO NUM_FACT
         USE FACT_A
      ELSE
         USE NFB
         GO TOP
         REPLACE NUMERO WITH NUMFB
         STORE NUMFB TO NUM_FACT
         USE FACT_B
      ENDIF
      APPEND BLANK
      REPLACE NUMERO WITH NUM_FACT,FECHA WITH DATE(),CLIENTE WITH VNOMBRE
      REPLACE DOMICILIO WITH VDOMI,TELEFONO WITH VTELE,DNI WITH VDOCU
      REPLACE CUIT WITH VCUIT,SITUIVA WITH VIVA,CODIGO WITH 0
      REPLACE DETALLE WITH ESNOTA,CANTIDAD WITH 1,PRECIO WITH VALOR
      REPLACE TOTAL WITH VALOR
      DO PRNCREDI
   ENDIF
   RESTORE SCREEN FROM MELLI
   LOOP
ENDDO
