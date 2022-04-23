#include "colores.ch"

*do veriprot
DO COLOREA

SET SCOREBOARD OFF
SET STATUS OFF
SET ECHO OFF
SET TALK OFF
SET DATE FRENCH
SET CENTURY ON
SET CONFIRM ON
SET KEY -9 TO R_CALC
STORE DATE() TO FEC
SET DEFAULT TO .\ESC
SET PATH TO .\ESC;.
STORE  '.\ESC\' TO CAMINO
PUBLIC VCLAVE

DO BACKUPVT

USE PARAMETR
GO TOP
PEPE=''

PUBLIC NOMBOPER,CLOP,NUMACT,HIZO,F_ACTUAL,H_ACTUAL
CLEAR

VERIFICA_OP()

DO ESC

SET COLOR TO
CLEAR
SET CURSOR ON
QUIT

FUNCTION POPUP

PARAMETERS TABLA1,TABLA2,TABLA3,TABLA4,coldes,filhas,colhas
PRIVATE PANTALLA,CONT,OPCION,OP
public pepe

@0,0 clear to 1,79
set color TO COLOR10
@0,0 to 2,79
set color to COLOR0
SAVE SCREEN TO PANTALLA
KEYBOARD CHR(13)
save screen to churti

DO WHILE .t.
   restore screen from churti
   FOR CONT= 1 TO LEN(TABLA1)
      set color TO COLOR4,COLOR12
      @TABLA3[CONT],TABLA4[CONT] PROMPT TABLA2[CONT] 
   NEXT
   MENU TO OP
   set color TO COLOR4,COLOR12
   @0,tabla4[iif(op>0,op,1)]-1 to 2,tabla4[iif(op>0,op,1)]+len(tabla2[iif(op>0,op,1)])
   set color TO COLOR6
   @2,coldes[iif(op>0,op,1)] to filhas[iif(op>0,op,1)],colhas[iif(op>0,op,1)]
   UNPOPUP = TABLA1[IIF(OP>0,OP,1)]
   opcion=str(op,1)+str(&unpopup,1)
   DO CASE
      CASE LASTKEY()=27
         opcion ='61'
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
public cuadro,cuadro1,cuadro2,inter1,inter2,inter3,inter4,inter5,inter6,inter7,cuadro3
 CUADRO1="…"+"Õ"+"ª"+"∫"+"º"+"Õ"+"»"+"∫"+" "
 CUADRO3="…"+"Õ"+"ª"+"∫"+"º"+"Õ"+"»"+"∫"+" "
 CUADRO="…"+"Õ"+"ª"+"∫"+"º"+"Õ"+"»"+"∫"+"≤"
 CUADRO2="…"+"Õ"+"ª"+"∫"+"º"+"Õ"+"»"+"∫"+"∞"
 INTER1=" "+" "+" "+" "+" "+" "+" "+" "+" "
 INTER2="€"+"€"+"€"+"€"+"€"+"€"+"€"+"€"+"€"
 INTER3="€"+"€"+"€"+"€"+"€"+"€"+"€"+"€"+"€"
 INTER4="€"+"€"+"€"+"€"+"€"+"€"+"€"+"€"+"€"
 INTER5="€"+"€"+"€"+"€"+"€"+"€"+"€"+"€"+"€"
 INTER6="€"+"€"+"€"+"€"+"€"+"€"+"€"+"€"+"€"
 INTER7=" "+" "+" "+" "+" "+" "+" "+" "+" "
return


FUNCTION FUNMOD

PARAMETERS MODE
PUBLIC INTER

DO CASE
    CASE MODE=3
        TONE(500,2)
        SET COLOR TO COLOR4
        @13,29 TO 15,48
        @14,30 CLEAR TO 14,47
        SET COLOR TO COLOR8
        @14,31 SAY 'NO EXISTEN DATOS'
        SET COLOR TO COLOR0
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
    CASE LASTKEY()=-1
        STORE '' TO KK
        RETURN(0)
    CASE LASTKEY()=-2
        STORE '' TO KK
        RETURN(0)
    CASE LASTKEY()=13
        STORE '' TO KK
        RETURN(0)
    CASE LASTKEY()=27
        STORE '' TO KK
        RETURN(0)
    CASE LASTKEY()=-1
        STORE '' TO KK
        RETURN(0)
    CASE LASTKEY()=-2
        STORE '' TO KK
        RETURN(0)
    OTHERWISE
        IF LASTKEY()=8
           STORE '' TO KK
           SET COLOR TO COLOR6
           @24,1 SAY 'Buscar:                                                                       '
           @24,1 SAY ''
           SET COLOR TO COLOR0
           GO TOP
           RETURN(1)
        ENDIF
        SET CURSOR OFF
        SET COLOR TO COLOR6
        @24,1 SAY 'Buscar:                                                                       '
        @24,1 SAY ''
        STORE KK+UPPER(CHR(LASTKEY())) TO KK
        STORE LEN(KK) TO LL
        @24,9 SAY KK
        SET COLOR TO COLOR0
        GO TOP
        SEEK KK
        IF .NOT. FOUND()
            STORE '' TO KK
            SET COLOR TO COLOR6
            @24,46 SAY 'Pulse <ƒƒƒ para volver a empezar'
            SET COLOR TO COLOR13
            @24,52 SAY '<ƒƒƒ'
            SET COLOR TO COLOR0
        ENDIF
        RETURN(1)
ENDCASE

FUNCTION MOD2
PARAMETERS MODE
PUBLIC INTER

DO CASE
    CASE MODE=3
        TONE(500,2)
        SET COLOR TO COLOR4
        @13,29 TO 15,48
        @14,30 CLEAR TO 14,47
        SET COLOR TO COLOR8
        @14,31 SAY 'NO EXISTEN DATOS'
        SET COLOR TO COLOR0
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
           SET COLOR TO COLOR6
           @24,1 SAY 'Buscar:                                                                       '
           @24,1 SAY ''
           SET COLOR TO COLOR0
           GO TOP
           RETURN(1)
        ENDIF
        SET CURSOR OFF
        SET COLOR TO COLOR6
        @24,1 SAY 'Buscar:                                                                       '
        @24,1 SAY ''
        STORE KK+ALLTRIM(CHR(LASTKEY())) TO KK
        STORE LEN(KK) TO LL
        @24,9 SAY KK
        SET COLOR TO COLOR0
        GO TOP
        SEEK KK
        IF .NOT. FOUND()
            SET COLOR TO COLOR6
            @24,46 SAY 'Pulse <ƒƒƒ para volver a empezar'
            SET COLOR TO COLOR13
            @24,52 SAY '<ƒƒƒ'
            SET COLOR TO COLOR0
        ENDIF
        RETURN(1)
ENDCASE

FUNCTION MOD3

PARAMETERS MODE
PUBLIC INTER

DO CASE
    CASE MODE=3
        TONE(500,2)
        SET COLOR TO COLOR4
        @13,29 TO 15,48
        @14,30 CLEAR TO 14,47
        SET COLOR TO COLOR8
        @14,31 SAY 'NO EXISTEN DATOS'
        SET COLOR TO COLOR0
        INKEY(3)
        KEYBOARD CHR(27)
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
           SET COLOR TO COLOR6
           @24,1 SAY 'Buscar:                                                                       '
           @24,1 SAY ''
           SET COLOR TO COLOR0
           GO TOP
           RETURN(1)
        ENDIF
        SET CURSOR OFF
        SET COLOR TO COLOR6
        @24,1 SAY 'Buscar:                                                                       '
        @24,1 SAY ''
        STORE KK+ALLTRIM(CHR(LASTKEY())) TO KK
        STORE LEN(KK) TO LL
        @24,9 SAY KK
        SET COLOR TO COLOR0
        GO TOP
        SEEK KK
        IF .NOT. FOUND()
            SET COLOR TO COLOR6
            @24,46 SAY 'Pulse <ƒƒƒ para volver a empezar'
            SET COLOR TO COLOR13
            @24,52 SAY '<ƒƒƒ'
            SET COLOR TO COLOR0
        ENDIF
        RETURN(1)
ENDCASE

FUNCTION tdias(dia)
ingles := {"Monday","Tuesday","Wednesday","Thursday","Friday","Saturday","Sunday"}
castel := {"Lunes","Martes","MiÇrcoles","Jueves","Viernes","S†bado","Domingo"}
return(castel[ASCAN(ingles,dia)])

FUNCTION tmes(mes)
ingles := {"January","February","March","April","May","June","July","August","September","October","November","December"}
castel := {"Enero","Febrero","Marzo","Abril","Mayo","Junio","Julio","Agosto","Septiembre","Octubre","Noviembre","Diciembre"}
return(castel[ASCAN(ingles,mes)])

#include "Inkey.ch"
#include "Setcurs.ch"
#define D_HEIGHT        12
#define D_WIDTH         21
#define D_DECIMALS      3
#define D_MAINCOLOR     'N/COLOR3'
#define D_DISPCOLOR     'COLOR3/N'

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
      DevOut ( ' Us†: ' + CHR(27) + CHR(26) + CHR(24) + CHR(25) + '=Mover, <Enter>=Detener, <Esc>=Salir' )
      cScrn := SaveScreen ( rc_r, rc_c, rc_r + D_HEIGHT - 1, rc_c + D_WIDTH - 1 )
      Scroll  ( rc_r, rc_c, rc_r + D_HEIGHT - 1, rc_c + D_WIDTH - 1 )
      DispBox ( rc_r, rc_c, rc_r + D_HEIGHT - 1, rc_c + D_WIDTH - 1 )
      DevPos ( rc_r   , rc_c ); DevOut ( '⁄ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒø' )
      DevPos ( row()+1, rc_c ); DevOut ( '≥                   ≥' )
      DevPos ( row()+1, rc_c ); DevOut ( '≥                   ≥' )
      DevPos ( row()+1, rc_c ); DevOut ( '√ƒƒƒ¬ƒƒƒ¬ƒƒƒ¬ƒƒƒ¬ƒƒƒ¥' )
      DevPos ( row()+1, rc_c ); DevOut ( '≥ 7 ≥ 8 ≥ 9 ≥ C ≥ * ≥' )
      DevPos ( row()+1, rc_c ); DevOut ( '√ƒƒƒ≈ƒƒƒ≈ƒƒƒ≈ƒƒƒ≈ƒƒƒ¥' )
      DevPos ( row()+1, rc_c ); DevOut ( '≥ 4 ≥ 5 ≥ 6 ≥ E ≥ / ≥' )
      DevPos ( row()+1, rc_c ); DevOut ( '√ƒƒƒ≈ƒƒƒ≈ƒƒƒ≈ƒƒƒ≈ƒƒƒ¥' )
      DevPos ( row()+1, rc_c ); DevOut ( '≥ 1 ≥ 2 ≥ 3 ≥ ^ ≥ - ≥' )
      DevPos ( row()+1, rc_c ); DevOut ( '√ƒƒƒ≈ƒƒƒ≈ƒƒƒ≈ƒƒƒ≈ƒƒƒ¥' )
      DevPos ( row()+1, rc_c ); DevOut ( '≥ 0 ≥ . ≥ = ≥Esc≥ + ≥' )
      DevPos ( row()+1, rc_c ); DevOut ( '¿ƒƒƒ¡ƒƒƒ¡ƒƒƒ¡ƒƒƒ¡ƒƒƒŸ' )
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
#define MW_COLOR        'COLOR3/N'

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
   DevOut ( 'ƒƒƒƒƒƒƒƒƒƒ' )
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
PUBLIC INTER,CLOP
INTER=0
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
        SAVE SCREEN TO ANDRES
        @19,0 CLEAR TO 19,79
        STORE SPACE(30) TO OPER
        STORE '' TO CLOP
        SET CURSOR ON
        @19,8 SAY 'Ingrese nombre del Operador:'GET OPER PICTURE '@!'
        READ
        IF LASTKEY()=27
           INTER=1
           RETURN(0)
        ENDIF
        @21,19 SAY 'Ingrese Clave:  _____  (cinco d°gitos)'
        SET COLOR TO COLOR6
        @21,35 SAY ''
        SET COLOR TO COLOR0
        FOR K=1 TO 5
           INKEY(0)
           TONE(500,1)
           STORE CLOP+CHR(LASTKEY()) TO CLOP
           @21,34+K SAY '≤'
        NEXT
        SET CURSOR OFF
        @23,25 SAY '® Datos correctos (S/N) ?'
        SET COLOR TO COLOR3
        @23,44 SAY 'S'
        @23,46 SAY 'N'
        SET COLOR TO COLOR0
        DO WHILE .T.
           INKEY(0)
           IF LASTKEY()<>83.AND.LASTKEY()<>115.AND.LASTKEY()<>78.AND.LASTKEY()<>110
              TONE(1200,1)
              LOOP
           ENDIF
           EXIT
        ENDDO
        RESTORE SCREEN FROM ANDRES
        IF LASTKEY()=83.OR.LASTKEY()=115
           APPEND BLANK
           REPLACE OPERADOR WITH OPER,PASWORD WITH CLOP
        ENDIF
        GO TOP
        RETURN (2)
    CASE LASTKEY()=7
        SAVE SCREEN TO ANDRES
        STORE '' TO CLOP
        SET CURSOR ON
        @19,0 CLEAR TO 19,79
        @19,19 SAY 'Ingrese Clave:  _____  (cinco d°gitos)'
        SET COLOR TO COLOR6
        @19,35 SAY ''
        SET COLOR TO COLOR0
        FOR K=1 TO 5
           INKEY(0)
           TONE(500,1)
           STORE CLOP+CHR(LASTKEY()) TO CLOP
           @19,34+K SAY '≤'
        NEXT
        SET CURSOR OFF
        RESTORE SCREEN FROM ANDRES
        IF PASWORD=CLOP
           DELETE
           PACK
        ENDIF
        RETURN (2)
    CASE LASTKEY()=13
        RETURN(0)
    OTHERWISE
        TONE(1200,1)
        RETURN(1)
ENDCASE



FUNCTION VERIFICA_OP
DO WHILE .T.
     USE ACTUAL
     INDEX ON OPERADOR TO INDXNOM
     REINDEX
     GO TOP

     IF EOF()
        SET CURSOR OFF
        TONE(500,2)
        @7,13 clear to 11,52
        SET COLOR TO B
        @7,13,11,52 BOX '€€€€€€€€€'
        set color to W/b
        @7,13 TO 11,52 
        SET COLOR TO COLOR8
        @9,16 SAY 'NO EXISTEN OPERADORES ACTIVOS'
        SET COLOR TO COLOR0
        INKEY(3)
        OPERADOR_ACTIVO()
     LOOP
     ELSE
     EXIT
     ENDIF
ENDDO
RETURN NIL



FUNCTION OPERADOR_ACTIVO

        DO WHILE .T.
                set color to b
                @11,15 TO 23,55
                @12,16 CLEAR TO 21,54
                @21,16 TO 23,54
                @22,17 CLEAR TO 22,53

                set color to w
                @22,26 SAY 'Tomar'
                @22,48 SAY 'Salir'

                SET COLOR TO w+
                @22,18 SAY '<ENTER>'
                @22,42 SAY '<ESC>'

USE .\ESC\OPERA
INDEX ON OPERADOR TO .\ESC\OPERA

DECLARE CAMP[1]
CAMP[1]='OPERADOR'

DECLARE CABEZ[1]
CABEZ[1]=' OPERADOR'

DECLARE SEPAR[1]
SEPAR[1]='ƒ'

SET CURSOR OFF
CLEAR TYPEAHEAD
SET COLOR TO COLOR7
DBEDIT(12,16,20,54,CAMP,'','',CABEZ,SEPAR)

IF LASTKEY()=27
    RETURN NIL
ENDIF

   STORE OPERADOR TO VOPERA
   STORE SPACE(10) TO VCLAVE
   STORE PASWORD TO VCLAVE2
   STORE DATE() TO F_ACTUAL
   STORE TIME() TO H_ACTUAL

   ALTA_OP()
EXIT
ENDDO

RETURN NIL




FUNCTION ALTA_OP

STORE 0 TO VEFINICIAL

DO WHILE .T.
   @7,13 clear to 11,52
   SET COLOR TO B
   @7,13,11,52 BOX '€€€€€€€€€'
   set color to W/b
   @7,13 TO 11,52 

   set color to w/b
   SET CURSOR ON
   @9,16 SAY 'Ingrese Ef.Inicial:'
   SET COLOR TO GET01
   @9,36 SAY ''GET VEFINICIAL PICTURE '99999.99'
   READ
   SET COLOR TO

   IF VEFINICIAL=0
       @7,13 clear to 11,52
       SET COLOR TO B
       @7,13,11,52 BOX '€€€€€€€€€'
       set color to W/b
       @7,13 TO 11,52 
       set color to *w+/b
       @9,16 SAY 'NO HA INGRESADO UNA CIFRA VALIDA'
       LOOP
   ENDIF

   IF LASTKEY()=27
      RETURN NIL
   ENDIF

   SET COLOR TO
   USE .\ESC\ACTUAL
   APPEND BLANK
   REPLACE OPERADOR WITH VOPERA
   REPLACE FECHA WITH DATE(),HORA WITH TIME()
   REPLACE INICIAL WITH VEFINICIAL
   SET COLOR TO
*   CLEAR
*   ?
*   ? VEFINICIAL
*   ?
*   QUIT
EXIT
ENDDO

RETURN NIL


