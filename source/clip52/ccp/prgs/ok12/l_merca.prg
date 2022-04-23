DO WHILE .T.
   SET COLOR TO BG/B
   @4,17 TO 10,28
   @5,18 CLEAR TO 9,27
   SET COLOR TO BG+/B
   @5,19 SAY 'pedir por'
   SET COLOR TO BG/B,W+/B
   @7,18 PROMPT ' ARTICULO '
   @8,18 PROMPT ' FIRMAS   '
   @9,18 PROMPT ' RUBROS   '
   PUBLIC OPC2
   MENU TO OPC2
   SET COLOR TO BG/B,W+/B
   DO CASE
      CASE OPC2=1
         STORE '' TO ESTEMEN
         STORE SPACE(15) TO DESDE,HASTA
         SET CURSOR ON
         SET COLOR TO *W+/B
         @7,18 SAY ' ARTICULO '
         SET COLOR TO W+/B
         @16,6 TO 20,72 DOUBLE
         @17,7 CLEAR TO 19,71
         @17,7 SAY 'Desde Art¡culo:                   Hasta Art¡culo:'
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
         SET CURSOR OFF
         LD=LEN(ALLTRIM(DESDE))
         LH=LEN(ALLTRIM(HASTA))
         USE MERCA
         INDEX ON DETALLE TO ORDDET
         GO TOP
         COPY TO TEMPO FOR LEFT(DETALLE,LD)>=ALLTRIM(DESDE).AND.LEFT(DETALLE,LH)<=ALLTRIM(HASTA)
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
      CASE OPC2=2
         SET COLOR TO *W+/B
         @8,18 SAY ' FIRMAS   '
         SET COLOR TO W+/B
         SAVE SCREEN TO KIKO
         @11,11 CLEAR TO 20,67
         @23,0 CLEAR TO 24,79
         SAVE SCREEN TO DIANA
         DO WHILE .T.
            USE FIRMAS
            INDEX ON NOMBRES TO O_N_FIRM
            GO TOP
            SET COLOR TO W+/B
            @10,20 TO 19,59
            @11,21 CLEAR TO 18,58
            @20,16 SAY '        Tomar'
            @20,33 SAY '     Nuevo'
            @20,48 SAY '       Eliminar'
            SET COLOR TO BG+/B
            @20,16 SAY '<ENTER>'
            @20,33 SAY '<F5>'
            @20,48 SAY '<SUPR>'
            DECLARE CAMP[1]
            CAMP[1]='NOMBRES'
            DECLARE CABEZ[1]
            CABEZ[1]='         Firmas Proveedoras'
            DECLARE SEPAR[1]
            SEPAR[1]='Ä'
            SET CURSOR OFF
            CLEAR TYPEAHEAD
            SET COLOR TO BG/B
            @23,1 TO 23,78
            SET COLOR TO B+/B
            @24,1 SAY 'Buscar:                                                                       '
            SET COLOR TO BG/B,B/W
            DBEDIT(11,21,18,58,CAMP,'FUNCAJA','',CABEZ,SEPAR)
            IF LASTKEY()=27
               EXIT
            ENDIF
            STORE NOMBRES TO VFIRM
            STORE TELEFONO TO VTELE
            USE MERCA
            INDEX ON FIRMA TO ORDFIRM
            COPY TO TEMPO FOR FIRMA=VFIRM
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
               RESTORE SCREEN FROM DIANA
               LOOP
            ENDIF
            STORE ' DE FIRMA '+ALLTRIM(VFIRM) TO ESTEMEN
            EXIT
         ENDDO
         IF LASTKEY()=27
            RESTORE SCREEN FROM ROMI
            LOOP
         ENDIF
      CASE OPC2=3
         SET COLOR TO *W+/B
         @9,18 SAY ' RUBROS   '
         SET COLOR TO W+/B
         SAVE SCREEN TO KIKO
         @11,11 CLEAR TO 20,67
         @23,0 CLEAR TO 24,79
         SAVE SCREEN TO DIANA
         DO WHILE .T.
            USE RUBROS
            INDEX ON NOMBRES TO O_N_RUBR
            GO TOP
            SET COLOR TO W+/B
            @10,20 TO 19,59
            @11,21 CLEAR TO 18,58
            @20,16 SAY '        Tomar'
            @20,33 SAY '     Nuevo'
            @20,48 SAY '       Eliminar'
            SET COLOR TO BG+/B
            @20,16 SAY '<ENTER>'
            @20,33 SAY '<F5>'
            @20,48 SAY '<SUPR>'
            DECLARE CAMP[1]
            CAMP[1]='NOMBRES'
            DECLARE CABEZ[1]
            CABEZ[1]='               Rubros'
            DECLARE SEPAR[1]
            SEPAR[1]='Ä'
            SET CURSOR OFF
            CLEAR TYPEAHEAD
            SET COLOR TO BG/B
            @23,1 TO 23,78
            SET COLOR TO B+/B
            @24,1 SAY 'Buscar:                                                                       '
            SET COLOR TO BG/B,B/W
            DBEDIT(11,21,18,58,CAMP,'FUNCAJA2','',CABEZ,SEPAR)
            IF LASTKEY()=27
               EXIT
            ENDIF
            STORE NOMBRES TO VRUBR
            USE MERCA
            INDEX ON RUBRO TO ORDRUBR
            COPY TO TEMPO FOR RUBRO=VRUBR
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
               RESTORE SCREEN FROM DIANA
               LOOP
            ENDIF
            STORE ' DE RUBRO '+ALLTRIM(VRUBR) TO ESTEMEN
            EXIT
         ENDDO
         IF LASTKEY()=27
            RESTORE SCREEN FROM ROMI
            LOOP
         ENDIF
      OTHERWISE
         EXIT
   ENDCASE
   DO LISTMERC
   RESTORE SCREEN FROM ROMI
   LOOP
ENDDO
