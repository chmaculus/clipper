DO COLOREA
SET SCOREBOARD OFF
SET STATUS OFF
SET ECHO OFF
SET TALK OFF
SET DATE FRENCH
** STORE CHR(48)+CHR(56)+CHR(47)+CHR(49)+CHR(48)+CHR(47)+CHR(57)+CHR(57) TO VXNOVA
**                  
** Fecha l¡mite 08/10/99
**              
SET CONFIRM ON
*SET KEY -9 TO R_CALC
STORE DATE() TO FEC
*SET DEFAULT TO C:\CCP
*SET PATH TO C:\CCP
*STORE  'C:\CCP\' TO CAMINO
STORE  '' TO CAMINO
USE PARAMETR
GO TOP
DO ccp

****** SE PUEDE ANULAR DESDE AQUI

** STORE SYSTEM TO VXD
** IF DATE()>=CTOD(VXNOVA).OR.VXD<>13467003781
**    CLEAR
**    SET COLOR TO BG+
**    @0,0 SAY 'Por favor llame a su programador...'
**    SET COLOR TO W+
**    @2,0 SAY 'Este programa no ha sido ABONADO o ha sido COPIADO a otro usuario.'
**    SET COLOR TO *R+
**    @2,25 SAY 'ABONADO'
**    @2,43 SAY 'COPIADO'
**    SET COLOR TO
**    REPLACE SYSTEM WITH 10101010101
**    @4,0 say ''
**    INKEY(10)
**    CLEAR
**    QUIT
** ENDIF

****** HASTA AQUI

PEPE=''
SET COLOR TO
CLEAR
*DO NOVA1

PROCEDURE NOVA1
IF FECHACOPIA+15<=DATE()
    SET CURSOR OFF
    FOR K=1 TO 15
       SET COLOR TO W+/R
       @12,21 SAY 'TIENE QUE HACER COPIA DE SEGURIDAD'
       TONE(1200,.5)
       INKEY(.05)
       SET COLOR TO R/W
       @12,21 SAY 'TIENE QUE HACER COPIA DE SEGURIDAD'
       TONE(300,.5)
       INKEY(.05)
    NEXT
ENDIF

USE BAJABASE
GO TOP
STORE MONTH(DATE()) TO MESACTUAL
STORE NUMEROMES TO MESANTERIOR
STORE DAY(DATE()) TO ESDIA
IF MESACTUAL=1.AND.MESANTERIOR=12
   STORE 13 TO MESACTUAL
ENDIF
IF MESANTERIOR<MESACTUAL.AND.ESDIA>=10
   SET COLOR TO
   CLEAR
   STORE ALLTRIM(STR(MESANTERIOR)) TO MES_ANT
   IF LEN(MES_ANT)<2
      STORE '0'+MES_ANT TO MES_ANT
   ENDIF
   SET CURSOR OFF
   SET COLOR TO W+
   @0,0 SAY 'DEBE BAJAR LOS DATOS DEL MES ANTERIOR'
   @1,0 SAY 'INSERTE UN DISKETTE EN LA UNIDAD A: Y PULSE <ENTER>'
   @2,0 SAY 'PULSE <ESC> PARA SALIR'
   SET COLOR TO BG+
   @1,45 SAY 'ENTER'
   @2,7 SAY 'ESC'
   SET COLOR TO W+
   SAVE SCREEN TO MAURO
   DO WHILE .T.
      INKEY(0)
      IF LASTKEY()<>27.AND.LASTKEY()<>13
         TONE(500,1)
         LOOP
      ENDIF
      IF LASTKEY()=27
         SET COLOR TO
         CLEAR
         SET CURSOR ON
         QUIT
      ENDIF
      STORE 'A:\' TO DISCO
      KKK=FCREATE('A:\BASES.RA0',0)
      MANI='123'
      FWRITE(KKK,MANI)
      FCLOSE(KKK)
      IF FERROR()<>0
         SET COLOR TO
         CLEAR
         SET COLOR TO *R+
         @0,0 SAY ' NO HAY DISCO...'
         SET COLOR TO W+
         INKEY(4)
         RESTORE SCREEN FROM MAURO
         LOOP
      ENDIF
      SET COLOR TO
      CLEAR
      SET COLOR TO R+
      @0,0 SAY ' COPIANDO ...ESPERE POR FAVOR...'
      SET COLOR TO W+
      IF FILE('A:\BASES.RA0')
         RUN DEL A:\BASES.RA0 >NUL
      ENDIF
      RUN DELTREE /Y A:\*.* >NUL
      USE FACT_A
      INDEX ON FECHA TO ORDFEC
      GO TOP
      STORE 'FA'+MES_ANT+ALLTRIM(STR(YEAR(DATE())))+'.DBF' TO ESBASE
      STORE DTOC(DATE()) TO VDT
      STORE CTOD('01'+RIGHT(VDT,6)) TO VVDT
      COPY TO &ESBASE FOR FECHA<VVDT
      RUTA='COPY '+ESBASE+' A:\ >NUL'
      RUN &RUTA
      ERASE &ESBASE
      DELETE ALL FOR FECHA<VVDT
      PACK
      USE FACT_B
      INDEX ON FECHA TO ORDFEC
      GO TOP
      STORE 'FB'+MES_ANT+ALLTRIM(STR(YEAR(DATE())))+'.DBF' TO ESBASE
      STORE DTOC(DATE()) TO VDT
      STORE CTOD('01'+RIGHT(VDT,6)) TO VVDT
      COPY TO &ESBASE FOR FECHA<VVDT
      RUTA='COPY '+ESBASE+' A:\ >NUL'
      RUN &RUTA
      ERASE &ESBASE
      DELETE ALL FOR FECHA<VVDT
      PACK

      IF MESACTUAL=13.AND.MESANTERIOR=12
         STORE 1 TO MESACTUAL
      ENDIF
      USE BAJABASE
      GO TOP
      REPLACE NUMEROMES WITH MESACTUAL
      EXIT
   ENDDO
   CLEAR
   SET COLOR TO *R+
   @8,2 TO 16,77 DOUBLE
   SET COLOR TO RG+
   @11,17 SAY 'POR FAVOR: SAQUE EL DISKETTE DE LA UNIDAD Y PROTEJALO.'
   @13,4 SAY 'COLOQUELE UNA ETIQUETA QUE INDIQUE MES Y A¥O DE LOS DATOS ALMACENADOS.'
   SET COLOR TO W+
   INKEY(20)
ENDIF
RETURN

PUBLIC NOMBOPER,CLOP,NUMACT,HIZO,F_ACTUAL,H_ACTUAL
SET COLOR TO W+/B
CLEAR
DO CCP
SET COLOR TO
CLEAR
SET CURSOR ON
QUIT






FUNCTION POPUP
PARAMETERS TABLA1,TABLA2,TABLA3,TABLA4,coldes,filhas,colhas
PRIVATE PANTALLA,CONT,OPCION,OP
public pepe
set color to w+/B
@0,0 clear to 1,79
@0,0 to 2,79
SAVE SCREEN TO PANTALLA
KEYBOARD CHR(13)
save screen to churti
DO WHILE .t.
   restore screen from churti
   FOR CONT= 1 TO LEN(TABLA1)
      set color to B+/B,BG+/B
      @TABLA3[CONT],TABLA4[CONT] PROMPT TABLA2[CONT] 
   NEXT
   MENU TO OP
   set color to B+/B,W+/B
   @0,tabla4[iif(op>0,op,1)]-1 to 2,tabla4[iif(op>0,op,1)]+len(tabla2[iif(op>0,op,1)])
   set color to BG/B
   @2,coldes[iif(op>0,op,1)] to filhas[iif(op>0,op,1)],colhas[iif(op>0,op,1)]
   UNPOPUP = TABLA1[IIF(OP>0,OP,1)]
   opcion=str(op,1)+str(&unpopup,1)
   DO CASE
      CASE LASTKEY()=27
         opcion ='71'
         EXIT
      CASE LASTKEY()=13
         EXIT
      OTHERWISE
         KEYBOARD CHR(LASTKEY())+CHR(13)
   ENDCASE
   RESTORE SCREEN FROM PANTALLA
enddo
pepe=opcion
RETURN opcion

FUNCTION A
RETURN ACHOICE()

procedure colorea
public cuadro,cuadro1,cuadro2,cuadro9,inter1,inter2,inter3,inter4,inter5,inter6,inter7,cuadro3
 CUADRO9="Ú"+"Ä"+"¿"+"³"+"Ù"+"Ä"+"À"+"³"+" "
 CUADRO1="É"+"Í"+"»"+"º"+"¼"+"Í"+"È"+"º"+" "
 CUADRO3="É"+"Í"+"»"+"º"+"¼"+"Í"+"È"+"º"+" "
 CUADRO="É"+"Í"+"»"+"º"+"¼"+"Í"+"È"+"º"+"²"
 CUADRO2="É"+"Í"+"»"+"º"+"¼"+"Í"+"È"+"º"+"°"
 INTER1=" "+" "+" "+" "+" "+" "+" "+" "+" "
 INTER2="Û"+"Û"+"Û"+"Û"+"Û"+"Û"+"Û"+"Û"+"Û"
 INTER3="Û"+"Û"+"Û"+"Û"+"Û"+"Û"+"Û"+"Û"+"Û"
 INTER4="Û"+"Û"+"Û"+"Û"+"Û"+"Û"+"Û"+"Û"+"Û"
 INTER5="Û"+"Û"+"Û"+"Û"+"Û"+"Û"+"Û"+"Û"+"Û"
 INTER6="Û"+"Û"+"Û"+"Û"+"Û"+"Û"+"Û"+"Û"+"Û"
 INTER7=" "+" "+" "+" "+" "+" "+" "+" "+" "
return

FUNCTION FUNBAJ
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
        IF MARCA=' '
           REPLACE MARCA WITH '*'
           DELETE
        ELSE
           REPLACE MARCA WITH ' '
           RECALL
        ENDIF
        RETURN(2)
    CASE LASTKEY()=27
        STORE '' TO KK
        RETURN(0)
    OTHERWISE
        IF LASTKEY()=8
           STORE '' TO KK
           SET COLOR TO B+/B
           @24,1 SAY 'Buscar:                                                                       '
           @24,1 SAY ''
           SET COLOR TO
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
        LOCATE FOR LEFT(DETALLE,LL)=KK
        IF .NOT. FOUND()
            SET COLOR TO W+/B
            @24,46 SAY 'Pulse <ÄÄÄ para volver a empezar'
            SET COLOR TO *W+/B
            @24,52 SAY '<ÄÄÄ'
            SET COLOR TO W+/B
        ENDIF
        RETURN(1)
ENDCASE

FUNCTION FUNMOD
PARAMETERS MODE
PUBLIC INTER
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
        RETURN(0)
    CASE LASTKEY()=27
        STORE '' TO KK
        RETURN(0)
    OTHERWISE
        IF LASTKEY()=8
           STORE '' TO KK
           SET COLOR TO B+/B
           @24,1 SAY 'Buscar:                                                                       '
           @24,1 SAY ''
           SET COLOR TO
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
        LOCATE FOR LEFT(DETALLE,LL)=KK
        IF .NOT. FOUND()
            STORE '' TO KK
            SET COLOR TO W+/B
            @24,46 SAY 'Pulse <ÄÄÄ para volver a empezar'
            SET COLOR TO *W+/B
            @24,52 SAY '<ÄÄÄ'
            SET COLOR TO W+/B
        ENDIF
        RETURN(1)
ENDCASE

FUNCTION MOD2
PARAMETERS MODE
PUBLIC INTER
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
        RETURN(0)
    CASE LASTKEY()=27
        RETURN(0)
    OTHERWISE
        IF LASTKEY()=8
           STORE '' TO KK
           SET COLOR TO B+/B
           @24,1 SAY 'Buscar:                                                                       '
           @24,1 SAY ''
           SET COLOR TO W+/B
           GO TOP
           RETURN(1)
        ENDIF
        SET CURSOR OFF
        SET COLOR TO B+/B
        @24,1 SAY 'Buscar:                                                                       '
        @24,1 SAY ''
        STORE KK+ALLTRIM(CHR(LASTKEY())) TO KK
        STORE LEN(KK) TO LL
        @24,9 SAY KK
        SET COLOR TO W+/B
        GO TOP
        LOCATE FOR LEFT(CODIGO,LL)=KK
        IF .NOT. FOUND()
            SET COLOR TO W+/B
            @24,46 SAY 'Pulse <ÄÄÄ para volver a empezar'
            SET COLOR TO *W+/B
            @24,52 SAY '<ÄÄÄ'
            SET COLOR TO W+/B
        ENDIF
        RETURN(1)
ENDCASE

FUNCTION MOD3
PARAMETERS MODE
PUBLIC INTER
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
        RETURN(0)
    CASE LASTKEY()=27
        RETURN(0)
    CASE LASTKEY()=-4
        RETURN(0)
    OTHERWISE
        IF LASTKEY()=8
           STORE '' TO KK
           SET COLOR TO B+/B
           @24,1 SAY 'Buscar:                                                                       '
           @24,1 SAY ''
           SET COLOR TO W+/B
           GO TOP
           RETURN(1)
        ENDIF
        SET CURSOR OFF
        SET COLOR TO B+/B
        @24,1 SAY 'Buscar:                                                                       '
        @24,1 SAY ''
        STORE KK+ALLTRIM(CHR(LASTKEY())) TO KK
        STORE LEN(KK) TO LL
        @24,9 SAY KK
        SET COLOR TO W+/B
        GO TOP
        LOCATE FOR LEFT(DTOC(FECHA),LL)=KK
        IF .NOT. FOUND()
            SET COLOR TO W+/B
            @24,46 SAY 'Pulse <ÄÄÄ para volver a empezar'
            SET COLOR TO *W+/B
            @24,52 SAY '<ÄÄÄ'
            SET COLOR TO W+/B
        ENDIF
        RETURN(1)
ENDCASE

FUNCTION tdias(dia)
ingles := {"Monday","Tuesday","Wednesday","Thursday","Friday","Saturday","Sunday"}
castel := {"Lunes","Martes","Mi‚rcoles","Jueves","Viernes","S bado","Domingo"}
return(castel[ASCAN(ingles,dia)])

FUNCTION tmes(mes)
ingles := {"January","February","March","April","May","June","July","August","September","October","November","December"}
castel := {"Enero","Febrero","Marzo","Abril","Mayo","Junio","Julio","Agosto","Septiembre","Octubre","Noviembre","Diciembre"}
return(castel[ASCAN(ingles,mes)])

#include "inkey.ch"
#include "setcurs.ch"
#define D_HEIGHT        12
#define D_WIDTH         21
#define D_DECIMALS      2
#define D_MAINCOLOR     'BG+/B'
#define D_DISPCOLOR     'W+/B'

#IFDEF TEST
   FUNCTION Main ()
      R_Calc ()
   RETURN nil
#ENDIF

FUNCTION R_Calc

LOCAL   cOldScrn
LOCAL   nOldRow
LOCAL   nOldColumn
LOCAL   cOldColor
LOCAL   nOldCur

LOCAL   nKey := 255
LOCAL   cKey
LOCAL   cScrn
LOCAL   eExpr

STATIC  rc_a := ''
STATIC  rc_b := ''
STATIC  rc_o := ' '
STATIC  rc_r
STATIC  rc_c

cOldScrn   := SaveScreen ( 0, 0, MaxRow(), MaxCol() )
nOldRow    := Row ()
nOldColumn := Col ()
cOldColor  := SetColor ()
nOldCur    := SetCursor ( SC_NONE )
IF rc_r = NIL
   rc_r := Int ( ( MaxRow() - D_HEIGHT ) / 2 )
ENDIF
IF rc_c = NIL
   rc_c := Int ( ( MaxCol() - D_WIDTH ) / 2 )
ENDIF

PRIVATE nRegA
PRIVATE nRegB
DO WHILE .T.
   SetColor ( D_MAINCOLOR )
   IF nKey = 255
      Scroll ( MaxRow(), 0 )
      DevPos ( MaxRow(), 18 )
      DevOut ( ' Us : ' + CHR(27) + CHR(26) + CHR(24) + CHR(25) + '=Mover, <Enter>=Detener, <Esc>=Salir' )
      cScrn := SaveScreen ( rc_r, rc_c, rc_r + D_HEIGHT - 1, rc_c + D_WIDTH - 1 )
      Scroll  ( rc_r, rc_c, rc_r + D_HEIGHT - 1, rc_c + D_WIDTH - 1 )
      DispBox ( rc_r, rc_c, rc_r + D_HEIGHT - 1, rc_c + D_WIDTH - 1 )
      DevPos ( rc_r   , rc_c ); DevOut ( 'ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿' )
      DevPos ( row()+1, rc_c ); DevOut ( '³                   ³' )
      DevPos ( row()+1, rc_c ); DevOut ( '³                   ³' )
      DevPos ( row()+1, rc_c ); DevOut ( 'ÃÄÄÄÂÄÄÄÂÄÄÄÂÄÄÄÂÄÄÄ´' )
      DevPos ( row()+1, rc_c ); DevOut ( '³ 7 ³ 8 ³ 9 ³ C ³ * ³' )
      DevPos ( row()+1, rc_c ); DevOut ( 'ÃÄÄÄÅÄÄÄÅÄÄÄÅÄÄÄÅÄÄÄ´' )
      DevPos ( row()+1, rc_c ); DevOut ( '³ 4 ³ 5 ³ 6 ³ E ³ / ³' )
      DevPos ( row()+1, rc_c ); DevOut ( 'ÃÄÄÄÅÄÄÄÅÄÄÄÅÄÄÄÅÄÄÄ´' )
      DevPos ( row()+1, rc_c ); DevOut ( '³ 1 ³ 2 ³ 3 ³ ^ ³ - ³' )
      DevPos ( row()+1, rc_c ); DevOut ( 'ÃÄÄÄÅÄÄÄÅÄÄÄÅÄÄÄÅÄÄÄ´' )
      DevPos ( row()+1, rc_c ); DevOut ( '³ 0 ³ . ³ = ³Esc³ + ³' )
      DevPos ( row()+1, rc_c ); DevOut ( 'ÀÄÄÄÁÄÄÄÁÄÄÄÁÄÄÄÁÄÄÄÙ' )
   ENDIF
   DevPos ( rc_r + 1, rc_c + 18 )
   DevOut ( rc_o )
   DevPos ( rc_r + 1, rc_c + 3 )
   DevOut ( Str ( Val ( rc_a ), 15, D_DECIMALS ) )
   DevPos ( rc_r + 2, rc_c + 3 )
   DevOut ( Str ( Val ( rc_b ), 15, D_DECIMALS ), D_DISPCOLOR )
   nKey := InKey ( 0 )
   cKey := IF ( nKey = K_RETURN, '=' , Upper ( Chr ( nKey ) ) )
   cKey := IF ( cKey = ',', '.', cKey )
   DO CASE
      CASE nKey = K_ESC
         EXIT
      CASE nKey = K_BS
         IF Len ( rc_b ) > 0
            rc_b := Left ( rc_b, Len ( rc_b ) - 1 )
         ENDIF
         LOOP
      CASE nKey = K_LEFT .or. nKey = K_RIGHT .or. nKey = K_UP   .or. nKey = K_DOWN
         RestScreen ( rc_r, rc_c, rc_r + D_HEIGHT - 1, rc_c + D_WIDTH - 1, cScrn )
         __KeyBoard ( Chr ( 1 ) ); Inkey ( 0 )
      
         R_MvWin ( @rc_r, @rc_c, rc_r + D_HEIGHT - 1, rc_c + D_WIDTH - 1 )
         nKey := 255
         LOOP
      CASE cKey = 'C'
         rc_a := rc_b := ''
         rc_o := ' '
      CASE cKey = 'E'
         rc_b := ''
      CASE cKey $ '+-*^=/'
         IF rc_o $ '+-*^/' .or. cKey = '='
            IF rc_o != '/' .or. Val ( rc_b ) != 0
               IF rc_o $ '+-*^/'
                  M->nRegA := rc_a
                  M->nRegB := rc_b
                  eExpr := 'VAL(nRegA)' + rc_o + 'VAL(nRegB)'
                  rc_a  := Str ( &eExpr., 15, D_DECIMALS )
               ENDIF
            ENDIF
         ELSE
            IF !Empty ( rc_b )
               rc_a := rc_b
            ENDIF
         ENDIF
         rc_o := IF ( cKey = '=', ' ', cKey )
         rc_b := ''
      CASE cKey $ '0123456789.'
         rc_b += cKey
   ENDCASE
ENDDO

__KeyBoard ( Chr ( 1 ) ); Inkey ( 0 )
RestScreen ( 0, 0, MaxRow(), MaxCol(), cOldScrn )
SetCursor ( nOldCur )
SetColor ( cOldColor )
DevPos ( nOldRow, nOldColumn )
RETURN nil

FUNCTION R_MvWin ( nR1, nC1, nR2, nC2 )
#define	MW_MINROW	2
#define	MW_MAXROW	MaxRow() - 2
#define	MW_MINCOL	0
#define	MW_MAXCOL	MaxCol()
#define MW_COLOR        'W+/N'
LOCAL   nTop      := nR1
LOCAL	nBottom   := nR2
LOCAL	nLeft     := nC1
LOCAL	nRight    := nC2
LOCAL	nKey      := 0
LOCAL	nMinRow   := MW_MINROW
LOCAL	nMaxRow   := MW_MAXROW
LOCAL	nMinCol   := MW_MINCOL
LOCAL	nMaxCol   := MW_MAXCOL
LOCAL	cScr      := SaveScreen ( nMinRow, nMinCol, nMaxRow, nMaxCol )
LOCAL	cMaxRow   := SaveScreen ( MaxRow(), 0, MaxRow(), MaxCol() )
LOCAL	cOldColor := SetColor ( MW_COLOR )
Scroll ( MaxRow () )
DevPos ( MaxRow(), 3 )
DO WHILE ( nKey != K_ESC .and. nKey != K_RETURN )
   RestScreen ( nMinRow, nMinCol, nMaxRow, nMaxCol, cScr )
   DispBox ( nTop, nLeft, nBottom, nRight )
   DevPos ( nBottom, nLeft + ( nRight - nLeft - 6 ) / 2 )
   DevOut ( 'ÄÄÄÄÄÄÄÄÄÄ' )
   nKey = InKey ( 0 )
   IF nKey = K_DOWN
      IF nBottom < nMaxRow
         nTop++ ; nBottom++
      ENDIF
   ELSEIF nKey = K_RIGHT
      IF nRight < nMaxCol
         nRight++ ; nLeft++
      ENDIF
   ELSEIF nKey = K_LEFT
      IF nLeft > nMinCol
         nLeft-- ; nRight--
      ENDIF
   ELSEIF nKey = K_UP
      IF nTop > nMinRow
         nTop-- ; nBottom--
      ENDIF
   ELSEIF nKey = K_PGUP
      IF nTop > nMinRow .and. nRight < nMaxCol
         nTop--   ; nBottom--
         nRight++ ; nLeft ++
      ENDIF
   ELSEIF nKey = K_PGDN
      IF nBottom < nMaxRow .and. nRight < nMaxCol
         nBottom++; nTop++
         nRight++ ; nLeft ++
      ENDIF
   ELSEIF nKey = K_END
      IF nBottom < nMaxRow .and. nLeft > nMinCol
         nBottom++ ; nTop++
         nLeft--   ; nRight--
      ENDIF
   ELSEIF nKey = K_HOME
      IF nTop > nMinRow .and. nLeft > nMinCol
         nTop--  ; nBottom--
         nLeft-- ; nRight--
      ENDIF
   ENDIF
ENDDO

RestScreen ( nMinRow, nMinCol, nMaxRow, nMaxCol, cScr )
RestScreen ( MaxRow(), 0, MaxRow(), MaxCol(), cMaxRow )
SetColor ( cOldColor )
IF nKey = K_ENTER
   nR1 := nTop
   nC1 := nLeft
ENDIF
RETURN nil

FUNCTION FUNCAJA
PARAMETERS MODE
DO CASE
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
           @18,1 TO 22,78
           @19,2 CLEAR TO 21,77
           STORE SPACE(40) TO VFIRM
           STORE SPACE(35) TO VTELE
           SET CURSOR ON
           SET COLOR TO BG+/B,B/W
           @19,6 SAY 'Ingrese nombre de la Firma:'GET VFIRM PICTURE '@!'
           READ
           @21,6 SAY 'Ingrese Tel‚fonos la Firma:'GET VTELE PICTURE '@!'
           READ
           SET CURSOR OFF
           IF LASTKEY()=27
              RESTORE SCREEN FROM ANDRES
              EXIT
           ENDIF
           GO TOP
           LOCATE FOR NOMBRES=VFIRM
           IF .NOT. EOF()
               TONE(1200,1)
               SET COLOR TO W+/B
               @19,2 CLEAR TO 19,77
               SET COLOR TO *R+/B
               @19,30 SAY 'FIRMA EXISTENTE'
               INKEY(3)
               RESTORE SCREEN FROM ANDRES
               LOOP
           ENDIF
           RESTORE SCREEN FROM ANDRES
           USE FIRMAS
           INDEX ON CODIGO TO O_C_FIRM
           GO BOTTOM
           STORE CODIGO+1 TO VCOD
           APPEND BLANK
           REPLACE NOMBRES WITH VFIRM,CODIGO WITH VCOD,TELEFONO WITH VTELE
           EXIT
        ENDDO
        INDEX ON NOMBRES TO O_N_FIRM
        GO TOP
        RETURN (2)
    CASE LASTKEY()=7
        STORE '' TO KK
        DELETE
        PACK
        RETURN (2)
    CASE LASTKEY()=13
        STORE '' TO KK
        RETURN(0)
    CASE LASTKEY()=27
        STORE '' TO KK
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

FUNCTION FUNCAJA2
PARAMETERS MODE
DO CASE
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
           STORE SPACE(40) TO VRUBR
           SET CURSOR ON
           SET COLOR TO BG+/B,B/W
           @19,7 SAY 'Ingrese nombre del Rubro:'GET VRUBR PICTURE '@!'
           READ
           SET CURSOR OFF
           IF LASTKEY()=27
              RESTORE SCREEN FROM ANDRES
              EXIT
           ENDIF
           GO TOP
           LOCATE FOR NOMBRES=VRUBR
           IF .NOT. EOF()
               TONE(1200,1)
               SET COLOR TO W+/B
               @19,2 CLEAR TO 19,77
               SET COLOR TO *R+/B
               @19,30 SAY 'RUBRO EXISTENTE'
               INKEY(3)
               RESTORE SCREEN FROM ANDRES
               LOOP
           ENDIF
           RESTORE SCREEN FROM ANDRES
           USE RUBROS
           INDEX ON CODIGO TO O_C_RUBR
           GO BOTTOM
           STORE CODIGO+1 TO VCOD
           APPEND BLANK
           REPLACE NOMBRES WITH VRUBR,CODIGO WITH VCOD
           EXIT
        ENDDO
        INDEX ON NOMBRES TO O_N_RUBR
        GO TOP
        RETURN (2)
    CASE LASTKEY()=7
        STORE '' TO KK
        DELETE
        PACK
        RETURN (2)
    CASE LASTKEY()=13
        STORE '' TO KK
        RETURN(0)
    CASE LASTKEY()=27
        STORE '' TO KK
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

FUNCTION FUNCAP
PARAMETERS MODE
DO CASE
    CASE MODE=1
        TONE(500,2)
        RETURN(1)
    CASE MODE=2
        TONE(500,2)
        RETURN(1)
    CASE MODE=0
        RETURN(1)
    CASE MODE=3
        RETURN(1)
    CASE LASTKEY()=13
        STORE '' TO KK
        RETURN(0)
    CASE LASTKEY()=27
        STORE '' TO KK
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
        LOCATE FOR LEFT(NOMBRE,LL)=KK
        IF .NOT. FOUND()
            SET COLOR TO W+/B
            @24,46 SAY 'Pulse <ÄÄÄ para volver a empezar'
            SET COLOR TO *W+/B
            @24,52 SAY '<ÄÄÄ'
            SET COLOR TO W+/B
        ENDIF
        RETURN(1)
ENDCASE

FUNCTION FUNCI
PARAMETERS MODE
DO CASE
    CASE MODE=1
        TONE(500,2)
        RETURN(1)
    CASE MODE=2
        TONE(500,2)
        RETURN(1)
    CASE MODE=0
        RETURN(1)
    CASE MODE=3
        RETURN(1)
    CASE LASTKEY()=13
        STORE '' TO KK
        RETURN(0)
    CASE LASTKEY()=27
        STORE '' TO KK
        RETURN(0)
    CASE LASTKEY()=-4
        STORE '' TO KK
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
        LOCATE FOR LEFT(NOMBRE,LL)=KK
        IF .NOT. FOUND()
            SET COLOR TO W+/B
            @24,46 SAY 'Pulse <ÄÄÄ para volver a empezar'
            SET COLOR TO *W+/B
            @24,52 SAY '<ÄÄÄ'
            SET COLOR TO W+/B
        ENDIF
        RETURN(1)
ENDCASE
