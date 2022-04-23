SET COLOR TO W+/B
@18,20 TO 20,60 DOUBLE
@19,21 CLEAR TO 19,59
@19,26 SAY 'Por pantalla o impresora (P/I)'
SET COLOR TO *R+/B
@19,52 SAY 'P'
@19,54 SAY 'I'
SET COLOR TO W+/B
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
   SET COLOR TO R/B
   @19,52 SAY 'P'
   SET COLOR TO *R+/B
   @19,54 SAY 'I'
   DO PRNMERC
   RETURN
ENDIF
SET COLOR TO W+/B
@8,1 TO 23,78
@9,2 CLEAR TO 22,76
@21,2 TO 21,77
@19,2 TO 19,77
@20,2 CLEAR TO 20,77
@22,2 CLEAR TO 22,77
@22,35 SAY '      Salir'
SET COLOR TO BG+/B
@22,35 SAY '<ESC>'
IF OPC2=1
   SET COLOR TO BG+/B
   @20,28 SAY 'Fichero de Art¡culos'
ELSEIF OPC2=2
   SET COLOR TO W+/B
   @20,38 SAY 'Tel:'
   SET COLOR TO  BG+/B
   @20,3 SAY LEFT(VFIRM,33)
   @20,43 SAY VTELE
   SET COLOR TO W+/B
ELSE
   LLX1=LEN('Fichero de Art¡culos de Rubro: ')
   LLX2=LEN(ALLTRIM(VRUBR))
   LLX3=LLX1+LLX2
   LLX=39-INT(LLX3/2)
   SET COLOR TO W+/B
   @20,LLX SAY 'Fichero de Art¡culos de Rubro:'
   SET COLOR TO BG+/B
   @20,LLX+LLX1 SAY ALLTRIM(VRUBR)
   SET COLOR TO W+/B
ENDIF
IF OPC2=1
   DECLARE CAMP[5]
   CAMP[1]='DETALLE'
   CAMP[2]='PUBLICO'
   CAMP[3]='COSTO'
   CAMP[4]='RUBRO'
   CAMP[5]='FIRMA'
   DECLARE CABEZ[5]
   CABEZ[1]='                       Detalle'
   CABEZ[2]='P.P£blico'
   CABEZ[3]='P. Costo'
   CABEZ[4]='             Rubro'
   CABEZ[5]='                  Firma'
   DECLARE SEPAR[5]
   SEPAR[1]='Ä'
   SEPAR[2]='Ä'
   SEPAR[3]='Ä'
   SEPAR[4]='Ä'
   SEPAR[5]='Ä'
ELSEIF OPC2=2
   DECLARE CAMP[4]
   CAMP[1]='DETALLE'
   CAMP[2]='PUBLICO'
   CAMP[3]='COSTO'
   CAMP[4]='RUBRO'
   DECLARE CABEZ[4]
   CABEZ[1]='                       Detalle'
   CABEZ[2]='P.P£blico'
   CABEZ[3]='P. Costo'
   CABEZ[4]='             Rubro'
   DECLARE SEPAR[4]
   SEPAR[1]='Ä'
   SEPAR[2]='Ä'
   SEPAR[3]='Ä'
   SEPAR[4]='Ä'
ELSE
   DECLARE CAMP[4]
   CAMP[1]='DETALLE'
   CAMP[2]='PUBLICO'
   CAMP[3]='COSTO'
   CAMP[4]='FIRMA'
   DECLARE CABEZ[4]
   CABEZ[1]='                       Detalle'
   CABEZ[2]='P.P£blico'
   CABEZ[3]='P. Costo'
   CABEZ[4]='                  Firma'
   DECLARE SEPAR[4]
   SEPAR[1]='Ä'
   SEPAR[2]='Ä'
   SEPAR[3]='Ä'
   SEPAR[4]='Ä'
ENDIF
SET CURSOR OFF
CLEAR TYPEAHEAD
SET COLOR TO B+/B
@24,1 SAY 'Buscar:                                                                       '
SET COLOR TO BG/B,N/W
DBEDIT(9,2,18,77,CAMP,'FUNMOD','',CABEZ,SEPAR)
RETURN
