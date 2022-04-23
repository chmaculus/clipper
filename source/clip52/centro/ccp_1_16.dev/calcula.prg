#include "colores.ch"
PROCEDURE CALCU

#include "Inkey.ch"
#include "Setcurs.ch"
#define D_HEIGHT        12
#define D_WIDTH         21
#define D_DECIMALS      2
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
**      DevOut ( ' Calculadora: ' + CHR(27) + CHR(26) + CHR(24) + CHR(25) + '=Mover, <Esc>=Salir' )
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
** DevOut ( 'MOVER CALCULADOR: Use ' + CHR(27) + ' ' + CHR(26) + ' ' + CHR(24) + ' ' + CHR(25) + ' PgUp,PgDn,Home,End        <ÄÙ=CALCULADOR <Esc>=Cancela' )
DO WHILE ( nKey != K_ESC .and. nKey != K_RETURN )
   RestScreen ( nMinRow, nMinCol, nMaxRow, nMaxCol, cScr )
   DispBox ( nTop, nLeft, nBottom, nRight )
   DevPos ( nBottom, nLeft + ( nRight - nLeft - 6 ) / 2 )
   DevOut ( '> MOVER <' )
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
RETURN
