SAVE SCREEN TO ROMINA
DO WHILE .T.
   SET COLOR TO W+/B
   @8,1 TO 23,78
   @9,2 CLEAR TO 22,76
   @21,2 TO 21,77
   @19,2 TO 19,77
   @20,2 CLEAR TO 20,77
   @22,2 CLEAR TO 22,77
   @22,5 SAY '        Marcar para borrar'
   @22,46 SAY '      Sale y borra lo marcado'
   SET COLOR TO BG+/B
   @20,28 SAY 'Fichero de Art¡culos'
   @22,5 SAY '<ENTER>'
   @22,46 SAY '<ESC>'
   DECLARE CAMP[3]
   CAMP[1]='MARCA'
   CAMP[2]='DETALLE'
   CAMP[3]='COSTO'
   DECLARE MASCARA[3]
   MASCARA[1]='9'
   MASCARA[2]='999999999999999999999999999999999999999999999999999'
   MASCARA[3]='9999.99'
   DECLARE CABEZ[3]
   CABEZ[1]='M'
   CABEZ[2]='                  Detalle'
   CABEZ[3]='P.Costo'
   DECLARE SEPAR[3]
   SEPAR[1]='Ä'
   SEPAR[2]='Ä'
   SEPAR[3]='Ä'
   SET CURSOR OFF
   CLEAR TYPEAHEAD
   SET COLOR TO B+/B
   @24,1 SAY 'Buscar:                                                                       '
   SET COLOR TO BG/B,N/W
   DBEDIT(9,2,18,77,CAMP,'FUNBAJ',MASCARA,CABEZ,SEPAR)
   IF LASTKEY()=27
      GO TOP
      DO WHILE .NOT. EOF()
         STORE 0 TO SEBORRO
         IF DELETED()
            STORE 1 TO SEBORRO
            EXIT
         ENDIF
         SKIP
         LOOP
      ENDDO
      IF SEBORRO=1
         TONE(1200,1)
         TONE(1200,1)
         TONE(1200,1)
         SET COLOR TO W+/B
         @22,16 TO 24,61
         @23,17 CLEAR TO 23,60
         @23,18 SAY '¨ Est  seguro de borrar lo marcado (S/N) ?'
         SET COLOR TO *R+/B
         @23,54 SAY 'S'
         @23,56 SAY 'N'
         SET COLOR TO W+/B
         INKEY(0)
         IF LASTKEY()=83.OR.LASTKEY()=115
            @23,17 CLEAR TO 23,60
            SET COLOR TO *RG+/B
            @23,23 SAY 'BORRANDO MERCADERIA ...ESPERE...'
            SET COLOR TO W+/B
            COPY TO TEMPO FOR DELETED()
            PACK
            USE TEMPO
            GO TOP
            STORE LASTREC() TO SON
            FOR T=1 TO SON
               STORE 'REG'+ALLTRIM(STR(T)) TO K
               STORE CODIGO TO &K
               SKIP
            NEXT
            CLOSE
            FERASE('TEMPO.DBF')
            @23,17 CLEAR TO 23,60
            SET COLOR TO *G+/B
            @23,27 SAY '...ACTUALIZANDO STOCK...'
            SET COLOR TO W+/B
            USE STOCK
            INDEX ON CODIGO TO ORDCOD
            GO TOP
            FOR T=1 TO SON
               STORE 'REG'+ALLTRIM(STR(T)) TO K
               DELETE FOR CODIGO=&K
            NEXT
            PACK
         ELSE
            RECALL ALL
            REPLACE ALL MARCA WITH ' '
         ENDIF
      ENDIF
   ENDIF
   RETURN
ENDDO
