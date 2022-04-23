#include "colores.ch"
SAVE SCREEN TO ROMI
*********


SET COLOR TO COLOR0
@4,44 TO 7,56

PUBLIC OPCION

SET COLOR TO SELECT1
@5,45 PROMPT 'PENDIENTES'

SET COLOR TO SELECT1
@6,45 PROMPT 'TODAS     '

MENU TO OPCION
DO CASE
   CASE OPCION=1
      SET COLOR TO COLOR8
      @5,45 SAY 'PENDIENTES'
      SET COLOR TO N/W+
      save screen to aa
      PENDIENTES()
      restore screen from aa

   CASE OPCION=2
      SET COLOR TO COLOR8
      @6,45 SAY 'TODAS     '
      SET COLOR TO LETRASC0
      save screen to aa
      TOD_VTAS()
      restore screen from aa

   OTHERWISE
      RETURN
ENDCASE





















FUNCTION PENDIENTES
DO WHILE .T.
   SET CURSOR OFF
   USE VTANRO
   STORE VTANRO TO VVTANRO

   USE VTASPEND
   GO TOP

   SUM SUBTOTAL TO VSUBTOTAL
   GO TOP

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
      RESTORE SCREEN FROM ROMI
      EXIT
   ENDIF

   IF LASTKEY()=73.OR.LASTKEY()=105
      SET COLOR TO COLOR0
      @20,50 SAY 'P'
      SET COLOR TO COLOR9
      @20,52 SAY 'I'
      DO PRNVENTA
      CLOSE
      FERASE('.\ESC\TEMPO.DBF')
      RESTORE SCREEN FROM ROMI
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
   SET COLOR TO COLOR10
   @22,35 SAY '<ESC>'

   SET COLOR TO COLOR0
   @20,4 SAY 'Cant. Ventas:'
   @20,30 SAY 'Total Ventas:'

   SET COLOR TO COLOR10
   @20,18 SAY VVTANRO
   @20,44 SAY VSUBTOTAL

   DECLARE CAMP[7]
   CAMP[1]='FECHA'
   CAMP[2]='HORA'
   CAMP[3]='CANTIDAD'
   CAMP[4]='LEFT(DETALLE,40)'
   CAMP[5]='PRECIO'
   CAMP[6]='SUBTOTAL'
   CAMP[7]='OPERADOR'

   DECLARE CABEZ[7]
   CABEZ[1]='  Fecha'
   CABEZ[2]='  Hora  '
   CABEZ[3]='Cant'
   CABEZ[4]='             Detalle'
   CABEZ[5]='Precio'
   CABEZ[6]='Sub Tot'
   CABEZ[7]='     Operador de turno'

   DECLARE SEPAR[7]
   SEPAR[1]='Ä'
   SEPAR[2]='Ä'
   SEPAR[3]='Ä'
   SEPAR[4]='Ä'
   SEPAR[5]='Ä'
   SEPAR[6]='Ä'
   SEPAR[7]='Ä'

   SET CURSOR OFF
   CLEAR TYPEAHEAD

   SET COLOR TO COLOR7
   DBEDIT(9,2,18,77,CAMP,'LVTA','',CABEZ,SEPAR)
   CLOSE
   FERASE('.\ESC\TEMPO.DBF')
   RESTORE SCREEN FROM ROMI
   LOOP
ENDDO

*******************************************

PARAMETERS MODE
PUBLIC INTER

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
        RETURN(0)
    CASE LASTKEY()=27
        RETURN(0)
    OTHERWISE
        RETURN(1)
ENDCASE
RETURN NIL



FUNCTION TOD_VTAS
SAVE SCREEN TO ROMI
DO WHILE .T.
   STORE DATE() TO DESDE,HASTA
   SET CURSOR ON
   SET COLOR TO COLOR3
   @16,14 TO 20,64 DOUBLE
   @17,15 CLEAR TO 19,63
   SET COLOR TO COLOR0
   @17,17 SAY 'Desde Fecha:            Hasta Fecha:'
   @19,26 SAY 'Pulse <ENTER> para tomar todo'
   SET COLOR TO COLOR9
   @19,32 SAY '<ENTER>'
   SET COLOR TO COLOR0
   @17,29 SAY ''GET DESDE PICTURE '99/99/99'
   READ
   IF LASTKEY()=27
      RETURN
   ENDIF
   IF DESDE=CTOD('  /  /  ')
      SET CURSOR OFF
      @17,15 CLEAR TO 19,63
      SET COLOR TO COLOR9
      @17,35 SAY 'Tomando TODO'
      SET COLOR TO COLOR0
      STORE CTOD('01/01/80') TO DESDE
      STORE DATE() TO HASTA
   ELSE
      @19,15 CLEAR TO 19,63
      SET COLOR TO COLOR9
      @19,33 SAY 'Tomando FRACCION'
      SET COLOR TO COLOR0
      @17,53 SAY ''GET HASTA PICTURE '99/99/99'
      READ
   ENDIF
   IF DESDE>HASTA
      TONE(1200,1)
      LOOP
   ENDIF
   SET CURSOR OFF
   USE VENTAS
   INDEX ON FECHA TO ORDFEC
   GO TOP
   COPY TO TEMPO FOR FECHA>=DESDE.AND.FECHA<=HASTA
   USE TEMPO
   GO TOP
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
      RESTORE SCREEN FROM ROMI
      LOOP
   ENDIF
   IF LASTKEY()=73.OR.LASTKEY()=105
      SET COLOR TO COLOR0
      @20,50 SAY 'P'
      SET COLOR TO COLOR9
      @20,52 SAY 'I'
      DO PRNVENTA
      CLOSE
      FERASE('.\ESC\TEMPO.DBF')
      RESTORE SCREEN FROM ROMI
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
   SET COLOR TO COLOR10
   @20,27 SAY 'Comprobantes de Ventas'
   @22,35 SAY '<ESC>'
   DECLARE CAMP[7]
   CAMP[1]='FECHA'
   CAMP[2]='HORA'
   CAMP[3]='CANTIDAD'
   CAMP[4]='LEFT(DETALLE,40)'
   CAMP[5]='PRECIO'
   CAMP[6]='SUBTOTAL'
   CAMP[7]='OPERADOR'
   DECLARE CABEZ[7]
   CABEZ[1]='  Fecha'
   CABEZ[2]='  Hora  '
   CABEZ[3]='Cant'
   CABEZ[4]='             Detalle'
   CABEZ[5]='Precio'
   CABEZ[6]='Sub Tot'
   CABEZ[7]='     Operador de turno'
   DECLARE SEPAR[7]
   SEPAR[1]='Ä'
   SEPAR[2]='Ä'
   SEPAR[3]='Ä'
   SEPAR[4]='Ä'
   SEPAR[5]='Ä'
   SEPAR[6]='Ä'
   SEPAR[7]='Ä'
   SET CURSOR OFF
   CLEAR TYPEAHEAD
   SET COLOR TO COLOR7
   DBEDIT(9,2,18,77,CAMP,'LVTA','',CABEZ,SEPAR)
   CLOSE
   FERASE('.\ESC\TEMPO.DBF')
   RESTORE SCREEN FROM ROMI
   LOOP
ENDDO

FUNCTION LVTA
PARAMETERS MODE
PUBLIC INTER
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
        RETURN(0)
    CASE LASTKEY()=27
        RETURN(0)
    OTHERWISE
        RETURN(1)
ENDCASE
RETURN NIL
