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
      INKEY(1)
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
SET FILTER TO CATEGORIA='C'.AND.FECHA>=DESDE.AND.FECHA<=HASTA
GO TOP
SAVE SCREEN TO ROMINA
DO WHILE .T.
   SET COLOR TO W+/B
   @8,0 TO 23,79
   @9,1 CLEAR TO 22,78
   @21,1 TO 21,78
   @19,1 TO 19,78
   @20,1 CLEAR TO 20,78
   @22,1 CLEAR TO 22,78
   @22,5 SAY '        Marcar como Ingresado'
   @22,46 SAY '      Sale y guarda lo marcado'
   SET COLOR TO BG+/B
   @20,25 SAY 'Fichero de Cheques Emitidos'
   @22,5 SAY '<ENTER>'
   @22,46 SAY '<ESC>'
   DECLARE CAMP[6]
   CAMP[1]='CHEQUE'
   CAMP[2]='F_EMI'
   CAMP[3]='NUMCHEQUE'
   CAMP[4]='BANCO'
   CAMP[5]='F_VTO'
   CAMP[6]='IMPORTE'
   DECLARE MASCARA[6]
   MASCARA[1]='9'
   MASCARA[2]='99/99/99'
   MASCARA[3]='9999999999'
   MASCARA[4]='9999999999999999999999999'
   MASCARA[5]='99/99/99'
   MASCARA[6]='99999.99'
   DECLARE CABEZ[6]
   CABEZ[1]='M'
   CABEZ[2]='Fec Emi'
   CABEZ[3]='   N£mero'
   CABEZ[4]='              Banco'
   CABEZ[5]='Fec Vto'
   CABEZ[6]='Importe'
   DECLARE SEPAR[6]
   SEPAR[1]='Ä'
   SEPAR[2]='Ä'
   SEPAR[3]='Ä'
   SEPAR[4]='Ä'
   SEPAR[5]='Ä'
   SEPAR[6]='Ä'
   SET CURSOR OFF
   CLEAR TYPEAHEAD
   SET COLOR TO B+/B
   @24,1 SAY 'Buscar N£mero:                                                                '
   SET COLOR TO BG/B,N/W
   DBEDIT(9,1,18,78,CAMP,'MARCARC',MASCARA,CABEZ,SEPAR)
   IF LASTKEY()=27
      GO TOP
      DO WHILE .NOT. EOF()
         STORE 0 TO SEBORRO
         IF CHEQUE='#'
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
         @23,19 SAY '¨ Quiere registrar esas entradas (S/N) ?'
         SET COLOR TO *R+/B
         @23,53 SAY 'S'
         @23,55 SAY 'N'
         SET COLOR TO W+/B
         INKEY(0)
         IF LASTKEY()=83.OR.LASTKEY()=115
            **
         ELSE
            REPLACE ALL CHEQUE WITH ' '
         ENDIF
      ENDIF
   ENDIF
   SET FILTER TO
   RETURN
ENDDO

FUNCTION MARCARC
PARAMETERS MODE
PUBLIC NODATO,INTER,ART
STORE 0 TO NODATO
DO CASE
    CASE MODE=3
        TONE(500,2)
        SET COLOR TO W+/B
        @13,29 TO 15,48
        @14,30 CLEAR TO 14,47
        SET COLOR TO *R+/B
        @14,31 SAY 'NO EXISTEN DATOS'
        SET COLOR TO W+/B
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
        STORE '' TO KK
        IF CHEQUE=' '
           REPLACE CHEQUE WITH '#'
        ELSE
           REPLACE CHEQUE WITH ' '
        ENDIF
        RETURN(2)
    CASE LASTKEY()=27
        STORE '' TO KK
        RETURN(0)
    OTHERWISE
        IF LASTKEY()=8
           STORE '' TO KK
           SET COLOR TO B+/B
           @24,1 SAY 'Buscar N£mero:                                                                '
           @24,1 SAY ''
           SET COLOR TO
           GO TOP
           RETURN(1)
        ENDIF
        SET CURSOR OFF
        SET COLOR TO B+/B
        @24,1 SAY 'Buscar N£mero:                                                                '
        @24,1 SAY ''
        STORE KK+UPPER(CHR(LASTKEY())) TO KK
        STORE LEN(KK) TO LL
        @24,16 SAY KK
        SET COLOR TO W+/B
        GO TOP
        LOCATE FOR LEFT(NUMCHEQUE,LL)=KK
        IF .NOT. FOUND()
            SET COLOR TO W+/B
            @24,46 SAY 'Pulse <ÄÄÄ para volver a empezar'
            SET COLOR TO *W+/B
            @24,52 SAY '<ÄÄÄ'
            SET COLOR TO W+/B
        ENDIF
        RETURN(1)
ENDCASE
