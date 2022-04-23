*** RUTINA DE AYUDA - CAMPO MEMO ***

STORE 0 TO T_INS,T_MAY,T_BNU
USE AYUDA
GO TOP
STORE AYUDITA TO MEM
SET COLOR TO B+/B
@0,0,24,79 BOX INTER2
IF !FILE('DATAS.HLP')
   SET COLOR TO W+/B
   CLEAR
   TONE(500,2)
   SET COLOR TO *R+/B
   @12,22 SAY 'No se puede abrir el archivo DATAS.HLP'
   INKEY(5)
   SET COLOR TO W+/B
   CLEAR
   RETURN
ENDIF
STORE MEMOREAD('DATAS.HLP') TO MEM2
SET COLOR TO W+/B
tone(1200,3)
@1,26 TO 3,44
@1,2 TO 5,16
@1,55 TO 5,77
@2,3 CLEAR TO 4,15
@2,56 CLEAR TO 4,76
SET COLOR TO BG+/B
@5,2,19,77 BOX INTER7
SET COLOR TO W+/B
@2,9 SAY 'Ayuda'
@3,9 SAY 'Graba'
@4,9 SAY 'Sale'
@2,61 SAY 'Imprimir'
SET COLOR TO BG+/B
@2,27 SAY '  AYUDA MEMORIA  '
@1,58 SAY '     EDICION     '
@2,3 SAY '<F1>'
@3,3 SAY '<F2>'
@4,3 SAY '<ESC>'
@2,56 SAY '<F5>'
SET CURSOR ON
@3,69 SAY '<INS>'
SET COLOR TO W/B
@4,70 SAY '���' 
@5,2 TO 19,77
SET COLOR TO W+/B
SETCURSOR(3)
MEM=MEMOEDIT(MEM,6,3,18,76,.T.,'FUFI',73,3,7,0,7,0)
SET CURSOR OFF
REPLACE AYUDITA WITH MEM
CLEAR
RETURN

FUNCTION FUFI
PARAMETERS MOD,FIL,COL
SAVE SCREEN TO ARGO
DO CASE
  CASE MOD=0
    SET COLOR TO W+/B
    @3,57 SAY 'Fil :    '
    @4,57 SAY 'Col :    '
    SET COLOR TO BG+/B
    @3,63 SAY +ALLTRIM(STR(FIL))
    @4,63 SAY +ALLTRIM(STR(COL))
    SET COLOR TO W+/B
    RETURN(0)
  CASE LASTKEY()=28
    SET COLOR TO W+/B
    @0,49 TO 17,78 DOUBLE
    SET COLOR TO BG+/B
    @0,61 SAY 'AYUDA'
    SET COLOR TO W+/B
    @2,50 CLEAR TO 16,77
    DO WHILE LASTKEY()<>27
       SET CURSOR OFF
       MEM2=MEMOEDIT(MEM2,1,50,16,77,.F.,'',29,1,16,0,16,0)
       IF LASTKEY()=27
         EXIT
       ENDIF
       LOOP
    ENDDO
    SET COLOR TO W+/B
    RESTORE SCREEN FROM ARGO
    SET CURSOR ON
    RETURN(0)
  CASE LASTKEY()=-4
    SALE=0
    SAVE SCREEN TO CRIS
    SET COLOR TO W+/B
    @9,12 TO 17,65 DOUBLE 
    @10,13 CLEAR TO 16,64 
    do while .t. 
      SET COLOR TO W+/B
      @16,24 SAY '<ENTER> Toma Todo   <ESC> Sale'
      SET COLOR TO BG+/B
      @16,24 SAY '<ENTER>'
      @16,44 SAY '<ESC>'
      store 0 to DRENGLON,HRENGLON
      SET CURSOR ON
      SET COLOR TO W+/B
      @12,14 TO 14,63
      SET COLOR TO BG+/B,B/W
      @13,16 say 'Desde rengl�n:' get DRENGLON picture '99999' RANGE 0,99999
      read
      SET COLOR TO W+/B
      IF LASTKEY()=27
         SET CURSOR ON
         RESTORE SCREEN FROM CRIS
         RETURN(0)
      ENDIF
      IF DRENGLON=0
         STORE MLCOUNT(MEM,73) TO HRENGLON
         @13,15 CLEAR TO 13,62
         @16,15 CLEAR TO 16,62
         SET COLOR TO *RG+/B
         @13,28 SAY 'IMPRIMIR MEMO COMPLETO'
         SET COLOR TO W+/B
         TONE(1200,1)
         TONE(1200,1)
         TONE(1200,1)
      ELSE
         SET COLOR TO W+/B
         @16,20 CLEAR TO 16,59
         SET COLOR TO BG+/B,B/W
         @13,41 say 'Hasta rengl�n:'get HRENGLON picture '99999' RANGE 0,99999
         read
         SET COLOR TO W+/B
         IF DRENGLON>HRENGLON
            TONE(500,2)
            @10,13 CLEAR TO 16,64 
            LOOP
         ENDIF
      ENDIF
      exit
    enddo
    SET COLOR TO W+/B
    @21,9 TO 23,70
    @22,10 CLEAR TO 22,69
    DO WHILE .T.
       SET CURSOR OFF
       SET COLOR TO W+/B
       @22,23 SAY 'Prepare la Impresora y pulse <ENTER>'
       SET COLOR TO BG+/B
       @22,52 SAY '<ENTER>'
       SET COLOR TO W+/B
       INKEY(0)
       IF LASTKEY()=27
         SALE=1
         EXIT
       ENDIF
       IF ISPRINTER()
         EXIT
       ELSE
         TONE(500,2)
         @22,10 CLEAR TO 22,69
         SET COLOR TO W+/B
         @22,20 SAY 'La Impresora NO ESTA LISTA...'
         SET COLOR TO *RG+/B
         @22,49 SAY 'VERIFIQUE...'
         INKEY(3)
         SET COLOR TO W+/B
         @22,10 CLEAR TO 22,69
         LOOP
       ENDIF
     ENDDO
     IF SALE=1
       SET CURSOR ON
       RESTORE SCREEN FROM CRIS
       RETURN(0)
     ENDIF
     SET COLOR TO W+/B
     @22,10 CLEAR TO 22,69
     SET CURSOR OFF
     SET COLOR TO *RG+/B
     @22,34 SAY 'IMPRIMIENDO'
     SET COLOR TO W+/B
     SET DEVICE TO PRINT
     FOR XX=DRENGLON TO HRENGLON
        IMP=MEMOLINE(MEM,73,XX)
        @PROW()+1,5 SAY IMP
     NEXT
     EJECT
     SET DEVICE TO SCREEN
     RETURN(27)
  CASE LASTKEY()=22
    IF T_INS=0
      STORE 1 TO T_INS
      SET COLOR TO G+/B
      @4,70 SAY '���' 
      SET COLOR TO W+/B
      SETCURSOR(1)
    ELSE
      STORE 0 TO T_INS
      SET COLOR TO W/B
      @4,70 SAY '���' 
      SET COLOR TO W+/B
      SETCURSOR(3)
    ENDIF
    RETURN(0)
  CASE LASTKEY()=-1
    RETURN(23)
  OTHERWISE
    RETURN(0)
ENDCASE
