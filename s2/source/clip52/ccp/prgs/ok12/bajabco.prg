SAVE SCREEN TO ROMI
DO WHILE .T.
   SET COLOR TO BG/B
   @8,33 TO 13,44
   @9,34 CLEAR TO 12,43
   SET COLOR TO BG+/B
   @9,35 SAY ' Borrar '
   SET COLOR TO BG/B,W+/B
   @11,34 PROMPT ' CHEQUE   '
   @12,34 PROMPT ' DEPOSITO '
   PUBLIC OPC2
   MENU TO OPC2
   SET COLOR TO BG/B,W+/B
   DO CASE
      CASE OPC2=1
         SAVE SCREEN TO AAA
         DO WHILE .T.
            SET COLOR TO BG/B
            @16,15 TO 20,65
            @17,16 CLEAR TO 19,64
            SET COLOR TO W+/B
            @17,18 SAY 'Desde Fecha:            Hasta Fecha:'
            @19,28 SAY 'Pulse <ENTER> para tomar todo'
            SET COLOR TO B/W
            @17,55 SAY '  /  /  '
            SET COLOR TO *BG+/B
            @19,35 SAY 'ENTER'
            SET CURSOR ON
            STORE CTOD('  /  /  ') TO DESDE,HASTA
            SET COLOR TO BG/B,B/W
            @17,30 SAY ''GET DESDE PICTURE '99/99/99'
            READ
            IF LASTKEY()=27
               RETURN
            ENDIF
            IF DESDE=CTOD('  /  /  ')
               SET CURSOR OFF
               STORE CTOD('01/01/80') TO DESDE
               STORE DATE() TO HASTA
               @19,16 CLEAR TO 19,64
               SET COLOR TO *BG+/B
               @19,34 SAY 'Tomando TODO'
               SET COLOR TO
            ELSE
               @19,16 CLEAR TO 19,64
               SET COLOR TO *BG+/B
               @19,32 SAY 'Tomando FRACCION'
               SET COLOR TO BG/B,B/W
               @17,54 SAY ''GET HASTA PICTURE '99/99/99'
               READ
               IF HASTA=CTOD('  /  /  ')
                  STORE DATE() TO HASTA
               ENDIF
            ENDIF
            SET CURSOR OFF
            IF DESDE>HASTA
               TONE(1200,1)
               SET COLOR TO *R+/B
               @19,16 CLEAR TO 19,64
               @19,34 SAY 'Mal Ingresado'
               SET COLOR TO W+/B
               SET CURSOR OFF
               INKEY(1)
               @19,16 CLEAR TO 19,64
               LOOP
            ENDIF
            EXIT
         ENDDO
         USE BANCOS
         INDEX ON FECHA TO ORDFEC
         DELETE ALL FOR CATEGORIA='C'.AND.FECHA>=DESDE.AND.FECHA<=HASTA
         COPY TO TEMPO FOR CATEGORIA='C'.AND.FECHA>=DESDE.AND.FECHA<=HASTA
         EXIT
      CASE OPC2=2
         SAVE SCREEN TO AAA
         DO WHILE .T.
            SET COLOR TO BG/B
            @16,15 TO 20,65
            @17,16 CLEAR TO 19,64
            SET COLOR TO W+/B
            @17,18 SAY 'Desde Fecha:            Hasta Fecha:'
            @19,28 SAY 'Pulse <ENTER> para tomar todo'
            SET COLOR TO B/W
            @17,55 SAY '  /  /  '
            SET COLOR TO *BG+/B
            @19,35 SAY 'ENTER'
            SET CURSOR ON
            STORE CTOD('  /  /  ') TO DESDE,HASTA
            SET COLOR TO BG/B,B/W
            @17,30 SAY ''GET DESDE PICTURE '99/99/99'
            READ
            IF LASTKEY()=27
               RETURN
            ENDIF
            IF DESDE=CTOD('  /  /  ')
               SET CURSOR OFF
               STORE CTOD('01/01/80') TO DESDE
               STORE DATE() TO HASTA
               @19,16 CLEAR TO 19,64
               SET COLOR TO *BG+/B
               @19,34 SAY 'Tomando TODO'
               SET COLOR TO
            ELSE
               @19,16 CLEAR TO 19,64
               SET COLOR TO *BG+/B
               @19,32 SAY 'Tomando FRACCION'
               SET COLOR TO BG/B,B/W
               @17,54 SAY ''GET HASTA PICTURE '99/99/99'
               READ
               IF HASTA=CTOD('  /  /  ')
                  STORE DATE() TO HASTA
               ENDIF
            ENDIF
            SET CURSOR OFF
            IF DESDE>HASTA
               TONE(1200,1)
               SET COLOR TO *R+/B
               @19,16 CLEAR TO 19,64
               @19,34 SAY 'Mal Ingresado'
               SET COLOR TO W+/B
               SET CURSOR OFF
               INKEY(1)
               @19,16 CLEAR TO 19,64
               LOOP
            ENDIF
            EXIT
         ENDDO
         USE BANCOS
         INDEX ON FECHA TO ORDFEC
         DELETE ALL FOR CATEGORIA='D'.AND.FECHA>=DESDE.AND.FECHA<=HASTA
         COPY TO TEMPO FOR CATEGORIA='D'.AND.FECHA>=DESDE.AND.FECHA<=HASTA
         EXIT
      OTHERWISE
         RETURN
   ENDCASE
   RESTORE SCREEN FROM ROMI
   LOOP
ENDDO
USE TEMPO
INDEX ON FECHA TO ORDFEC
GO TOP
IF EOF()
   TONE(1200,1)
   SET CURSOR OFF
   SET COLOR TO W+/B
   @20,15 TO 22,65
   @21,16 CLEAR TO 21,64
   SET COLOR TO *R+/B
   @21,27 SAY 'NO EXISTEN DATOS EN ESE RANGO'
   SET COLOR TO W+/B
   INKEY(3)
   RETURN
ENDIF
SET COLOR TO BG/B
@8,0 TO 23,79
@9,1 CLEAR TO 22,78
@10,1 TO 10,78
@9,1 SAY ' Fechas ³                         Detalles                     ³   Importes   '
SET COLOR TO
STORE 11 TO LINEA
DO WHILE .T.
   IF EOF()
      SET COLOR TO BG/B
      @LINEA,1 SAY REPLICATE('Ä',78)
      @24,0 CLEAR TO 24,79
      SET CURSOR OFF
      SET COLOR TO W+/B
      @24,25 SAY '¨ Eliminar esos Datos (S/N) ?'
      SET COLOR TO *R+/B
      @24,48 SAY 'S'
      @24,50 SAY 'N'
      SET COLOR TO W+/B
      DO WHILE .T.
         INKEY(0)
         IF LASTKEY()<>78.AND.LASTKEY()<>83.AND.LASTKEY()<>110.AND.LASTKEY()<>115
            TONE(500,1)
            LOOP
         ENDIF
         EXIT
      ENDDO
      USE BANCOS
      IF LASTKEY()=83.OR.LASTKEY()=115
         PACK
      ELSE
         RECALL ALL
      ENDIF
      CLOSE
      RETURN
   ENDIF
   SET COLOR TO W+/B
   @LINEA,1 SAY FECHA
   SET COLOR TO BG/B
   @LINEA,9 SAY '³'
   SET COLOR TO W+/B
   IF CATEGORIA='C'
      @LINEA,11 SAY 'N§: '+ALLTRIM(NUMCHEQUE)+' - VENCIMIENTO: '+DTOC(F_VTO)
   ELSE
      IF IMPORTE<>0
         @LINEA,11 SAY 'EFECTIVO'
      ELSE
         @LINEA,11 SAY 'CHEQUE N§: '+ALLTRIM(TER_NUM)+' - '+LEFT(ALLTRIM(TER_BAN),25)
      ENDIF
   ENDIF
   SET COLOR TO BG/B
   @LINEA,64 SAY '³'
   SET COLOR TO W+/B
   IF CATEGORIA='C'
      SET COLOR TO W+/B
      @LINEA,68 SAY IMPORTE PICTURE '99999.99'
   ELSE
      IF IMPORTE<>0
         SET COLOR TO W+/B
         @LINEA,68 SAY IMPORTE PICTURE '99999.99'
      ELSE
         SET COLOR TO W+/B
         @LINEA,68 SAY TER_IMP PICTURE '99999.99'
      ENDIF
   ENDIF
   SET COLOR TO W+/B
   LINEA=LINEA+1
   SKIP
   IF LINEA>=21
      @24,0 CLEAR TO 24,79
      @24,31 SAY '<ENTER> Continuar'
      SET COLOR TO BG+/B
      @24,32 SAY 'ENTER'
      DO WHILE .T.
         INKEY(0)
         IF LASTKEY()<>13
            TONE(1200,1)
            LOOP
         ENDIF
         EXIT
      ENDDO
      SET COLOR TO BG/B
      @24,0 CLEAR TO 24,79
      @9,1 CLEAR TO 22,78
      @9,1 SAY ' Fechas ³                         Detalles                     ³   Importes   '
      @10,1 TO 10,78
      STORE 11 TO LINEA
   ENDIF
   LOOP
ENDDO
