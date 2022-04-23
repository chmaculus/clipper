#include "colores.ch"
SAVE SCREEN TO ROMI
DO WHILE .T.
   SET COLOR TO COLOR0
   @3,17 TO 8,30
   SET COLOR TO COLOR5
   @4,18, 7,29 BOX 'ÛÛÛÛÛÛÛÛÛ'
   SET COLOR TO COLOR0
   @4,19 SAY 'ordena por'
   SET COLOR TO SELECT1
   @6,18 PROMPT ' CODIGO     '
   @7,18 PROMPT ' MERCADERIA '
   SET COLOR TO COLOR0
   PUBLIC OPC
   MENU TO OPC
   DO CASE
      CASE OPC=1
         SET COLOR TO COLOR13
         @6,18 SAY ' CODIGO     '
         USE MERCA
         INDEX ON CODIGO TO ORDCOD
         GO TOP
      CASE OPC=2
         SET COLOR TO COLOR13
         @7,18 SAY ' MERCADERIA '
         USE MERCA
         INDEX ON DETALLE TO ORDDET
         GO TOP
      OTHERWISE
         RETURN
   ENDCASE
   SET COLOR TO COLOR3
   @18,14 CLEAR TO 20,66
   @18,20 TO 20,60 DOUBLE
   SET COLOR TO COLOR0
   @19,26 SAY 'Por pantalla o impresora (P/I)'
   SET COLOR TO COLOR9
   @19,52 SAY 'P'
   @19,54 SAY 'I'
   SET COLOR TO COLOR0
   DO WHILE .T.
      INKEY(0)
      IF LASTKEY()=27
         RETURN
      ENDIF
      IF LASTKEY()<>80.AND.LASTKEY()<>112.AND.LASTKEY()<>73.AND.LASTKEY()<>105
         TONE(1200,2)
         LOOP
      ENDIF
      EXIT
   ENDDO
   IF LASTKEY()=73.OR.LASTKEY()=105
      SET COLOR TO COLOR0
      @19,52 SAY 'P'
      SET COLOR TO COLOR9
      @19,54 SAY 'I'
      DO PRNMERC
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
   @20,28 SAY 'Fichero de Art¡culos'
   @22,35 SAY '<ESC>'
   DECLARE CAMP[7]
   CAMP[1]='CODIGO'
   CAMP[2]='DETALLE'
   CAMP[3]='CODIGBARRA'
   CAMP[4]='PCOSTO'
   CAMP[5]='GANANCIA'
   CAMP[6]='SINIVA'
   CAMP[7]='CONIVA'
   DECLARE CABEZ[7]
   CABEZ[1]=' C¢digo'
   CABEZ[2]='                       Detalle'
   CABEZ[3]='C¢d de Barra'
   CABEZ[4]='P. Costo'
   CABEZ[5]='% Gan'
   CABEZ[6]='Sin IVA'
   CABEZ[7]='Con IVA'
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
   SET COLOR TO COLOR6
   @24,1 SAY 'Buscar:                                                                       '
   SET COLOR TO COLOR7
   IF OPC=1
      DBEDIT(9,2,18,77,CAMP,'MOD2','',CABEZ,SEPAR)
   ENDIF
   IF OPC=2
      DBEDIT(9,2,18,77,CAMP,'FUNMOD','',CABEZ,SEPAR)
   ENDIF
   RESTORE SCREEN FROM ROMI
   LOOP
ENDDO
