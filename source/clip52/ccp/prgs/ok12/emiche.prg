SET COLOR TO W+/B
CLEAR
STORE DATE() TO VFEC,VFEM
STORE SPACE(35) TO VDES
STORE 'BCO BANSUD S.A. SUCURSAL SAN RAFAEL' TO VBAN
STORE SPACE(10) TO VNUM
STORE CTOD('  /  /  ') TO VFVT
STORE 0 TO VIMP
DO WHILE .T.
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
   @3,0 TO 5,35
   SET COLOR TO BG+/B
   @4,3 SAY 'PANTALLA DE EMISION DE CHEQUES'
   @1,LL SAY VFECHA
   SET CURSOR ON
   @8,0 SAY REPLICATE('Ä',79)
   SET COLOR TO BG/B,B/W
   @9,6 SAY 'Ingrese Fecha de Emisi¢n:ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ>'GET VFEM PICTURE '  /  /  '
   READ
   IF LASTKEY()=27
      RETURN
   ENDIF
   SET COLOR TO BG+/B
   @10,0 SAY REPLICATE('Ä',79)
   SET COLOR TO BG/B,B/W
   @11,6 SAY 'Ingrese Nombre Banco:ÄÄÄÄÄÄÄÄ>'GET VBAN PICTURE '@!K'
   READ
   IF LASTKEY()=27
      RETURN
   ENDIF
   SET COLOR TO BG+/B
   @12,0 SAY REPLICATE('Ä',79)
   SET COLOR TO BG/B,B/W
   @13,6 SAY 'Ingrese N§ de Cheque:ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ>'GET VNUM PICTURE '@!'
   READ
   IF LASTKEY()=27
      RETURN
   ENDIF
   SAVE SCREEN TO MIKI
   USE DESTINOS
   INDEX ON NOMBRES TO ORDNOM
   GO TOP
   SET COLOR TO W+/B
   @6,20 TO 15,59
   @7,21 CLEAR TO 14,58
   @16,16 SAY '        Tomar'
   @16,33 SAY '     Nuevo'
   @16,48 SAY '       Otro'
   SET COLOR TO BG+/B
   @16,16 SAY '<ENTER>'
   @16,33 SAY '<F5>'
   @16,48 SAY '<ESC>'
   DECLARE CAMP[1]
   CAMP[1]='NOMBRES'
   DECLARE CABEZ[1]
   CABEZ[1]='      Nombres de los Tenedores'
   DECLARE SEPAR[1]
   SEPAR[1]='Ä'
   SET CURSOR OFF
   CLEAR TYPEAHEAD
   SET COLOR TO BG/B
   @23,1 TO 23,78
   SET COLOR TO B+/B
   @24,1 SAY 'Buscar:                                                                       '
   SET COLOR TO BG/B,B/W
   DBEDIT(7,21,14,58,CAMP,'FUNCHE','',CABEZ,SEPAR)
   RESTORE SCREEN FROM MIKI
   SET CURSOR ON
   SET COLOR TO BG+/B
   @14,0 SAY REPLICATE('Ä',79)
   IF ENTRO=2
      SET COLOR TO BG/B,B/W
      @15,6 SAY 'Ingrese Tenedor:ÄÄÄÄÄÄÄÄÄÄÄÄÄ>'GET VDES PICTURE '@!'
      READ
      IF LASTKEY()=27
         RETURN
      ENDIF
   ENDIF
   IF ENTRO=1
      SET COLOR TO BG/B,B/W
      @15,6 SAY 'Ingrese Tenedor:ÄÄÄÄÄÄÄÄÄÄÄÄÄ>'GET VDES PICTURE '@!'
      READ
      IF LASTKEY()=27
         RETURN
      ENDIF
   ENDIF
   IF ENTRO=0
      STORE NOMBRES TO VDES
      SET COLOR TO BG/B,B/W
      @15,6 SAY 'Ingrese Tenedor:ÄÄÄÄÄÄÄÄÄÄÄÄÄ>'
      SET COLOR TO B/W
      @15,37 SAY VDES PICTURE '@!'
      SET COLOR TO W+/B
   ENDIF
   SET COLOR TO BG+/B
   @16,0 SAY REPLICATE('Ä',79)
   SET COLOR TO BG/B,B/W
   DO WHILE .T.
      SET CURSOR ON
      @17,6 SAY 'Ingrese Fecha de Vencimiento:ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ>'GET VFVT PICTURE '  /  /  '
      READ
      SAVE SCREEN TO TATIANA
      IF LASTKEY()=27
         RETURN
      ENDIF
      IF VFVT<DATE()
         SET CURSOR OFF
         TONE(500,2)
         SET COLOR TO W+/B
         @22,5 TO 24,73
         @23,6 CLEAR TO 23,72
         SET COLOR TO RG+/B
         @23,7 SAY 'LA FECHA DE VENCIMIENTO ES ANTERIOR A HOY...¨  Continuar  (S/N) ?'
         SET COLOR TO *R+/B
         @23,66 SAY 'S'
         @23,68 SAY 'N'
         SET COLOR TO BG/B
         DO WHILE .T.
            INKEY(0)
            IF LASTKEY()<>78.AND.LASTKEY()<>83.AND.LASTKEY()<>110.AND.LASTKEY()<>115
               TONE(500,1)
               LOOP
            ENDIF
            EXIT
         ENDDO
         RESTORE SCREEN FROM TATIANA
         IF LASTKEY()=83.OR.LASTKEY()=115
            EXIT
         ENDIF
         STORE CTOD('  /  /  ') TO VFVT
         LOOP
      ENDIF
      EXIT
   ENDDO
   SET CURSOR ON
   SET COLOR TO BG+/B
   @18,0 SAY REPLICATE('Ä',79)
   SET COLOR TO BG/B,B/W
   @19,6 SAY 'Ingrese Importe del Cheque:ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ>'GET VIMP PICTURE '999999.99'
   READ
   IF LASTKEY()=27
      RETURN
   ENDIF
   SET COLOR TO BG+/B
   @20,0 SAY REPLICATE('Ä',79)
   SET COLOR TO W+/B
   SAVE SCREEN TO PANLISTO
   SET CURSOR OFF
   @22,25 SAY '¨ Guardar  Movimiento (S/N) ?'
   SET COLOR TO *R+/B
   @22,48 SAY 'S'
   @22,50 SAY 'N'
   SET COLOR TO W+/B
   DO WHILE .T.
      INKEY(0)
      IF LASTKEY()<>78.AND.LASTKEY()<>83.AND.LASTKEY()<>110.AND.LASTKEY()<>115
         TONE(500,1)
         LOOP
      ENDIF
      EXIT
   ENDDO
   IF LASTKEY()=83.OR.LASTKEY()=115
      IF ENTRO=1
         USE DESTINOS
         APPEND BLANK
         REPLACE NOMBRES WITH VDES
         ENTRO=0
      ENDIF

      USE BANCOS
      APPEND BLANK
      REPLACE FECHA WITH VFEC,DESTINO WITH VDES,NUMCHEQUE WITH VNUM
      REPLACE BANCO WITH VBAN,CHEQUE WITH ' ',CATEGORIA WITH 'C'
      REPLACE F_EMI WITH VFEM,F_VTO WITH VFVT,IMPORTE WITH VIMP

      STORE DATE() TO VFEM
      STORE SPACE(35) TO VDES
      STORE 'BANCO DE LA NACION ARGENTINA'+SPACE(7) TO VBAN
      STORE SPACE(10) TO VNUM
      STORE CTOD('  /  /  ') TO VFVT
      STORE 0 TO VIMP
   ENDIF
   SET COLOR TO W+/B
   CLEAR
   LOOP
ENDDO

FUNCTION FUNCHE
PARAMETERS MODE
PUBLIC ENTRO
ENTRO=0
DO CASE
    CASE MODE=3
        TONE(500,2)
        SET COLOR TO W+/B
        @10,29 TO 12,48
        @11,30 CLEAR TO 11,47
        SET COLOR TO *R+/B
        @11,31 SAY 'NO EXISTEN DATOS'
        SET COLOR TO W+/B
        INKEY(3)
        ENTRO=1
        RETURN(0)
    CASE MODE=1
        TONE(500,2)
        RETURN(1)
    CASE MODE=2
        TONE(500,2)
        RETURN(1)
    CASE MODE=0
        RETURN(1)
    CASE LASTKEY()=-4
        STORE '' TO KK
        SAVE SCREEN TO ANDRES
        DO WHILE .T.
           SET COLOR TO B+/B
           @18,1 TO 20,78
           @19,2 CLEAR TO 19,77
           STORE SPACE(35) TO VDES
           SET CURSOR ON
           SET COLOR TO BG+/B,B/W
           @19,10 SAY 'Ingrese Tenedor:'GET VDES PICTURE '@!'
           READ
           SET CURSOR OFF
           IF LASTKEY()=27
              RESTORE SCREEN FROM ANDRES
              EXIT
           ENDIF
           GO TOP
           LOCATE FOR NOMBRES=VDES
           IF .NOT. EOF()
               TONE(1200,1)
               SET COLOR TO W+/B
               @19,2 CLEAR TO 19,77
               SET COLOR TO *R+/B
               @19,30 SAY 'NOMBRE EXISTENTE'
               INKEY(3)
               RESTORE SCREEN FROM ANDRES
               LOOP
           ENDIF
           RESTORE SCREEN FROM ANDRES
           APPEND BLANK
           REPLACE NOMBRES WITH VDES
           EXIT
        ENDDO
        GO TOP
        RETURN (2)
    CASE LASTKEY()=13
        STORE '' TO KK
        RETURN(0)
    CASE LASTKEY()=27
        STORE '' TO KK
        ENTRO=2
        RETURN(0)
    OTHERWISE
        IF LASTKEY()=8
           STORE '' TO KK
           SET COLOR TO B+/B
           @24,1 SAY 'Buscar:                                                                       '
           @24,1 SAY ''
           GO TOP
           RETURN(1)
        ENDIF
        SET CURSOR OFF
        SET COLOR TO B+/B
        @24,1 SAY 'Buscar:                                                                       '
        @24,1 SAY ''
        STORE KK+UPPER(CHR(LASTKEY())) TO KK
        STORE LEN(KK) TO LL
        @24,9 SAY KK
        SET COLOR TO W+/B
        GO TOP
        LOCATE FOR LEFT(NOMBRES,LL)=KK
        IF .NOT. FOUND()
            SET COLOR TO W+/B
            @24,46 SAY 'Pulse <ÄÄÄ para volver a empezar'
            SET COLOR TO *W+/B
            @24,52 SAY '<ÄÄÄ'
            SET COLOR TO W+/B
        ENDIF
        RETURN(1)
ENDCASE
