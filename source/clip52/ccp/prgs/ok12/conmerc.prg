USE MERCA
INDEX ON DETALLE TO ORDDET
SAVE SCREEN TO JERI
DO WHILE .T.
   GO TOP
   IF EOF()
      TONE(500,2)
      SET COLOR TO W+/B
      @13,30 CLEAR TO 13,47
      SET COLOR TO *R+/B
      @13,31 SAY 'NO EXISTEN DATOS'
      SET COLOR TO W+/B
      INKEY(3)
      RETURN
   ENDIF
   SET COLOR TO W+/B
   @8,1 TO 23,78
   @9,2 CLEAR TO 22,76
   @21,2 TO 21,77
   @19,2 TO 19,77
   @20,2 CLEAR TO 20,77
   @22,2 CLEAR TO 22,77
   @22,11 SAY '        Tomar'
   @22,58 SAY '      Salir'
   SET COLOR TO BG+/B
   @20,28 SAY 'Fichero de Art¡culos'
   @22,11 SAY '<ENTER>'
   @22,58 SAY '<ESC>'
   DECLARE CAMP[2]
   CAMP[1]='DETALLE'
   CAMP[2]='COSTO'
   DECLARE CABEZ[2]
   CABEZ[1]='                       Detalle'
   CABEZ[2]='P.Costo'
   DECLARE SEPAR[2]
   SEPAR[1]='Ä'
   SEPAR[2]='Ä'
   SET CURSOR OFF
   CLEAR TYPEAHEAD
   SET COLOR TO B+/B
   @24,1 SAY 'Buscar:                                                                       '
   SET COLOR TO BG/B,B/W
   DBEDIT(9,2,18,77,CAMP,'FUNMOD','',CABEZ,SEPAR)
   IF LASTKEY()=27
      RETURN
   ENDIF
   STORE CODIGO TO VCODMERC
   STORE DETALLE TO VDETALLE
   STORE COSTO TO VCOSTO
   STORE PUBLICO TO VPUBLICO
   STORE FIRMA TO VFIRM
   STORE RUBRO TO VRUBR
   SET COLOR TO W+/B
   CLEAR
   @0,0 TO 2,30
   SET COLOR TO BG+/B
   @1,2 SAY '* * * CENTRO PLASTICO * * *'
   numero=LEFT(DTOC(DATE()),2)
   DIA=TDIAS(cdow(DATE()))
   MES=TMES(CMONTH(DATE()))
   ANIO=ALLTRIM(STR(YEAR(DATE())))
   VFECHA=DIA+' '+numero+' de '+MES+' de '+ANIO
   LL=79-LEN(VFECHA)
   SET COLOR TO W+/B
   @1,LL-7 SAY 'Fecha: '
   @3,0 TO 5,39
   CARTEL='Art¡culo N§ '
   @4,44 SAY CARTEL
   SET COLOR TO BG+/B
   @4,3 SAY 'PANTALLA DE CONSULTA DE MERCADERIA'
   @1,LL SAY VFECHA
   @4,56 SAY ALLTRIM(STR(VCODMERC))
   SET COLOR TO BG/B
   @7,1 SAY 'Firma:                                     Rubro:'
   SET COLOR TO W+/B
   @7,8 SAY LEFT(VFIRM,32)
   @7,51 SAY LEFT(VRUBR,28)
   SET COLOR TO BG+/B
   @6,0 SAY REPLICATE('Ä',79)
   @8,0 SAY REPLICATE('Ä',79)
   @11,0 SAY REPLICATE('Ä',79)
   @13,0 SAY REPLICATE('Ä',79)
   @15,0 SAY REPLICATE('Ä',79)
   @17,0 SAY REPLICATE('Ä',79)
   @12,14 SAY VDETALLE
   @14,22 SAY ALLTRIM(STR(VCOSTO))
   @16,22 SAY ALLTRIM(STR(VPUBLICO))
   SET COLOR TO W+/B
   @12,5 SAY 'Detalle:'
   @14,5 SAY 'Precio de Costo:'
   @16,5 SAY 'Precio  P£blico:'
   SET CURSOR OFF
   @23,26 SAY 'Pulse una tecla para Salir'
   INKEY(0)
   RESTORE SCREEN FROM JERI
   LOOP
ENDDO
