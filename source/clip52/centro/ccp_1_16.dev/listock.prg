#include "colores.ch"
SAVE SCREEN TO JERI

PUBLIC DESDE
PUBLIC HASTA

DO WHILE .T.
   SET COLOR TO COLOR0
   @3,34 TO 8,46
   @4,36 SAY 'pedir por'

   SET COLOR TO SELECT1
   @6,35 PROMPT ' CODIGO    '
   @7,35 PROMPT ' A REPONER '

   PUBLIC OPC2
   MENU TO OPC2

   DO CASE
      CASE OPC2=1
         STORE 0 TO DESDE,HASTA
         SET CURSOR ON
         SET COLOR TO COLOR13
         @6,35 SAY ' CODIGO    '

         SET COLOR TO COLOR3
         @16,14 TO 20,64 DOUBLE
         @17,15 CLEAR TO 19,63

         SET COLOR TO COLOR0
         @17,16 SAY 'Desde c¢digo:      Hasta c¢digo:      '
         @19,26 SAY 'Pulse <ENTER> para tomar todos'
         SET COLOR TO COLOR9
         @19,32 SAY '<ENTER>'
         SET COLOR TO COLOR0

         @17,29 SAY ''GET DESDE PICTURE '99999'
         READ

         IF LASTKEY()=27
            RESTORE SCREEN FROM JERI
            LOOP
         ENDIF

         IF DESDE=0
            @17,15 CLEAR TO 19,63
            SET COLOR TO COLOR9
            @17,35 SAY 'Tomando TODO'
            SET COLOR TO COLOR0
            STORE 0 TO DESDE
         ELSE
            @19,15 CLEAR TO 19,63
            SET COLOR TO COLOR9
            @19,33 SAY 'Tomando FRACCION'
            SET COLOR TO COLOR0
            @17,54 SAY ''GET HASTA PICTURE '99999'
            READ
         ENDIF

         DO CRLISTCK

         USE .\ESC\LISTOCK
         INDEX ON DETALLE TO ORDETT
         SET INDEX TO ORDETT
         GO TOP
         DO WHILE .T.
            SET COLOR TO COLOR4
            @8,1 TO 23,78
            @9,2 CLEAR TO 22,76
            @21,2 TO 21,77
            @19,2 TO 19,77

            @20,2 CLEAR TO 20,77
            @22,2 CLEAR TO 22,77

            @22,4 SAY '        Real'
            @22,19 SAY '      Sale/Imprime'
            @22,46 SAY 'Por C¢digo -      Por Detalle'
            @20,49 SAY 'Total Faltante $'
            SET COLOR TO COLOR10
            @20,10 SAY 'Fichero de Art¡culos'
*            @20,68 SAY TOTFALTA PICTURE '999.99'

            @22,4 SAY '<ENTER>'
            @22,19 SAY '<ESC>'
            @22,41 SAY '<F2>'
            @22,59 SAY '<F3>'

            DECLARE CAMP[6]
            CAMP[1]='CODIGO'
            CAMP[2]='LEFT(DETALLE,25)'
            CAMP[3]='CONIVA'
            CAMP[4]='CANTIDAD'
            CAMP[5]='REAL'
            CAMP[6]='FALTANTE'

            DECLARE MASCARA[6]
            MASCARA[1]='999999'
            MASCARA[2]='99999999999999'
            MASCARA[3]='9999.99'
            MASCARA[4]='9999'
            MASCARA[5]='9999'
            MASCARA[6]='9999.99'

            DECLARE CABEZ[6]
            CABEZ[1]='C¢d.'
            CABEZ[2]='       Detalle'
            CABEZ[3]='$ Venta'
            CABEZ[4]='Stock'
            CABEZ[5]='Real'
            CABEZ[6]='Faltan $'

            DECLARE SEPAR[6]
            SEPAR[1]='Ä'
            SEPAR[2]='Ä'
            SEPAR[3]='Ä'
            SEPAR[4]='Ä'
            SEPAR[5]='Ä'
            SEPAR[6]='Ä'

            SET CURSOR OFF
            CLEAR TYPEAHEAD
            SET COLOR TO COLOR6
            @24,1 SAY 'Buscar:                                                                       '
            SET COLOR TO COLOR7

            DBEDIT(9,2,18,77,CAMP,'FUNI',MASCARA,CABEZ,SEPAR)

            IF LASTKEY()=-1
               INDEX ON CODIGO TO ORDCOD
               GO TOP
               LOOP
            ENDIF

            IF LASTKEY()=-2
               INDEX ON DETALLE TO ORDDET
               GO TOP
               LOOP
            ENDIF

            EXIT
         ENDDO

         GO TOP
         SUM FALTANTE TO TOTFALTA
         GO TOP

      CASE OPC2=2
         SET COLOR TO COLOR13
         @7,35 SAY ' A REPONER '
         USE .\ESC\LISTOCK
         INDEX ON DETALLE TO ORDDET
         GO TOP

      OTHERWISE
         EXIT
   ENDCASE

   USE LISTOCK
   SET CURSOR OFF
   SET COLOR TO COLOR3
   @19,17 TO 21,60 DOUBLE
   @20,18 CLEAR TO 20,59
   SET COLOR TO COLOR0
   @20,24 SAY 'Por pantalla o impresora (P/I)'
   SET COLOR TO COLOR9
   @20,50 SAY 'P'
   @20,52 SAY 'I'
   SET COLOR TO COLOR0

   DO WHILE .T.
      INKEY(0)
      IF LASTKEY()=27
         EXIT
      ENDIF
      IF LASTKEY()<>80.AND.LASTKEY()<>112.AND.LASTKEY()<>73.AND.LASTKEY()<>105
         TONE(1200,2)
         LOOP
      ENDIF
      EXIT
   ENDDO

   IF LASTKEY()=27
      RESTORE SCREEN FROM JERI
      LOOP
   ENDIF

   IF LASTKEY()=73.OR.LASTKEY()=105
      SET COLOR TO COLOR0
      @20,50 SAY 'P'
      SET COLOR TO COLOR9
      @20,52 SAY 'I'

      USE .\ESC\LISTOCK
      SET INDEX TO ORDETT

      DO PRNSTOCK
      CLOSE
      USE .\ESC\LISTOCK
      RESTORE SCREEN FROM JERI
      LOOP
   ENDIF

   SET COLOR TO COLOR4
   @8,1 TO 23,78
   @9,2 CLEAR TO 22,76
   @21,2 TO 21,77
   @19,2 TO 19,77
   @20,2 CLEAR TO 20,77
   @22,2 CLEAR TO 22,77
   @22,35 SAY '      Salir'
   @20,49 SAY 'Total Faltante $'
   SET COLOR TO COLOR10
   @20,10 SAY 'Fichero de Art¡culos'
   @20,68 SAY TOTFALTA PICTURE '999.99'
   @22,35 SAY '<ESC>'

   DECLARE CAMP[6]
   CAMP[1]='CODIGO'
   CAMP[2]='LEFT(DETALLE,25)'
   CAMP[3]='CONIVA'
   CAMP[4]='CANTIDAD'
   CAMP[5]='REAL'
   CAMP[6]='FALTANTE'

   DECLARE MASCARA[6]
   MASCARA[1]='999999'
   MASCARA[2]='99999999999999'
   MASCARA[3]='9999.99'
   MASCARA[4]='9999'
   MASCARA[5]='9999'
   MASCARA[6]='9999.99'

   DECLARE CABEZ[6]
   CABEZ[1]='C¢d.'
   CABEZ[2]='       Detalle'
   CABEZ[3]='$ Venta'
   CABEZ[4]='Stock'
   CABEZ[5]='Real'
   CABEZ[6]='Faltan $'

   DECLARE SEPAR[6]
   SEPAR[1]='Ä'
   SEPAR[2]='Ä'
   SEPAR[3]='Ä'
   SEPAR[4]='Ä'
   SEPAR[5]='Ä'
   SEPAR[6]='Ä'

   SET CURSOR OFF
   CLEAR TYPEAHEAD
   SET COLOR TO COLOR6
   @24,1 SAY 'Buscar:                                                                       '
   SET COLOR TO COLOR7
   SET CURSOR OFF
   CLEAR TYPEAHEAD
   SET COLOR TO COLOR6
   @24,1 SAY 'Buscar:                                                                       '
   SET COLOR TO COLOR7

   IF OPC2=1
      DBEDIT(9,2,18,77,CAMP,'MOD2',MASCARA,CABEZ,SEPAR)
   ENDIF

   IF OPC2=2
      DBEDIT(9,2,18,77,CAMP,'FUNMOD',MASCARA,CABEZ,SEPAR)
   ENDIF
   CLOSE

   USE .\ESC\LISTOCK

   RESTORE SCREEN FROM JERI
   LOOP
ENDDO

FUNCTION FUNI(MODE,POS)

PUBLIC CAMPOACT
CAMPOACT=CAMP[POS]

DO CASE
    CASE MODE=3
        TONE(500,2)
        SET COLOR TO COLOR4
        @13,29 TO 15,48
        @14,30 CLEAR TO 14,47
        SET COLOR TO COLOR8
        @14,31 SAY 'NO EXISTEN DATOS'
        SET COLOR TO COLOR0
        INKEY(3)
        RETURN(0)

    CASE MODE=1
        TONE(500,2)
        RETURN(1)

    CASE MODE=2
        TONE(500,2)
        RETURN(1)

    CASE MODE=0
        RETURN(1)

    CASE LASTKEY()=13
        STORE RECNO() TO REG2
        IF POS<>5
           TONE(500,2)
           RETURN(1)
        ENDIF
        SET CURSOR ON
        @ROW(),COL() GET &CAMPOACT
        READ
        STORE (CANTIDAD-REAL)*CONIVA TO VHK
        STORE REAL TO VREAL
        REPLACE FALTANTE WITH VHK,CANTIDAD WITH VREAL
        SET CURSOR OFF
        GO TOP
        SUM FALTANTE TO TOTFALTA
        SET COLOR TO COLOR10
        @20,68 SAY TOTFALTA PICTURE '9999.999'
        SET COLOR TO COLOR0
        GO TOP
        GO REG2
        RETURN(2)

    CASE LASTKEY()=27
        STORE '' TO KK
        RETURN(0)

    CASE LASTKEY()=-1
        STORE '' TO KK
        RETURN(0)

    CASE LASTKEY()=-2
        STORE '' TO KK
        RETURN(0)

    OTHERWISE
        IF LASTKEY()=8
           STORE '' TO KK
           SET COLOR TO COLOR6
           @24,1 SAY 'Buscar:                                                                       '
           @24,1 SAY ''
           SET COLOR TO COLOR0
           GO TOP
           RETURN(1)
        ENDIF
        SET CURSOR OFF
        SET COLOR TO COLOR6
        @24,1 SAY 'Buscar:                                                                       '
        @24,1 SAY ''
        STORE KK+UPPER(CHR(LASTKEY())) TO KK
        STORE LEN(KK) TO LL
        @24,9 SAY KK
        SET COLOR TO COLOR0
        GO TOP
        SEEK KK

        IF .NOT. FOUND()
            STORE '' TO KK
            SET COLOR TO COLOR6
            @24,46 SAY 'Pulse <ÄÄÄ para volver a empezar'
            SET COLOR TO COLOR13
            @24,52 SAY '<ÄÄÄ'
            SET COLOR TO COLOR0
        ENDIF

        RETURN(1)
ENDCASE
