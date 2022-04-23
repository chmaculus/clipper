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
   DO PRNPREC
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
@20,28 SAY 'Fichero de Art¡culos'
@22,35 SAY '<ESC>'
DECLARE CAMP[4]
CAMP[1]='DETALLE'
CAMP[2]='PUBLICO'
CAMP[3]='RUBRO'
CAMP[4]='FIRMA'
DECLARE CABEZ[4]
CABEZ[1]='                       Detalle'
CABEZ[2]='P.P£blico'
CABEZ[3]='             Rubro'
CABEZ[4]='                  Firma'
DECLARE SEPAR[4]
SEPAR[1]='Ä'
SEPAR[2]='Ä'
SEPAR[3]='Ä'
SEPAR[4]='Ä'
SET CURSOR OFF
CLEAR TYPEAHEAD
SET COLOR TO B+/B
@24,1 SAY 'Buscar:                                                                       '
SET COLOR TO BG/B,N/W
DBEDIT(9,2,18,77,CAMP,'FUNMOD','',CABEZ,SEPAR)
RETURN
