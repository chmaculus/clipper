#include "colores.ch"
SAVE SCREEN TO ROMINA

DO WHILE .T.
   SET COLOR TO COLOR4
   @8,1 TO 23,78
   @9,2 CLEAR TO 22,76
   @21,2 TO 21,77
   @19,2 TO 19,77
   @20,2 CLEAR TO 20,77
   @22,2 CLEAR TO 22,77
   @22,5 SAY '        Marcar para borrar'
   @22,46 SAY '      Sale y borra lo marcado'
   @20,48 SAY 'Por C¢digo -      Por Detalle'
   SET COLOR TO COLOR10
   @20,5 SAY 'Art¡culos ordenados:'
   @20,43 SAY '<F2>'
   @20,61 SAY '<F3>'
   @22,5 SAY '<ENTER>'
   @22,46 SAY '<ESC>'
   DECLARE CAMP[4]
   CAMP[1]='MARCA'
   CAMP[2]='CODIGO'
   CAMP[3]='DETALLE'
   CAMP[4]='PCOSTO'
   DECLARE MASCARA[4]
   MASCARA[1]='9'
   MASCARA[2]='999999'
   MASCARA[3]='999999999999999999999999999999999999999999999999999'
   MASCARA[4]='9999.999'
   DECLARE CABEZ[4]
   CABEZ[1]='M'
   CABEZ[2]=' C¢digo'
   CABEZ[3]='                  Detalle'
   CABEZ[4]='P.Costo'
   DECLARE SEPAR[4]
   SEPAR[1]='Ä'
   SEPAR[2]='Ä'
   SEPAR[3]='Ä'
   SEPAR[4]='Ä'
   SET CURSOR OFF
   CLEAR TYPEAHEAD
   SET COLOR TO COLOR6
   @24,1 SAY 'Buscar:                                                                       '

   SET COLOR TO COLOR7
   DBEDIT(9,2,18,77,CAMP,'FUNBAJ',MASCARA,CABEZ,SEPAR)

   IF LASTKEY()=-1
      INDEX ON CODIGO TO ORDCOD
      GO TOP
      LOOP
   ENDIF

   IF LASTKEY()=-2
      INDEX ON DETALLE TO ORDDET
      GO TOP
      LOOP
   ENDIF

   IF LASTKEY()=27

         TONE(1200,1)
         TONE(1200,1)
         TONE(1200,1)
         @22,16 TO 24,61
         @23,17 CLEAR TO 23,60
         SET COLOR TO COLOR0
         @23,18 SAY '¨ Est  seguro de borrar lo marcado (S/N) ?'
         SET COLOR TO COLOR3
         @23,54 SAY 'S'
         @23,56 SAY 'N'
         SET COLOR TO COLOR0
         INKEY(0)

         IF LASTKEY()=83.OR.LASTKEY()=115
            @23,17 CLEAR TO 23,60
            SET COLOR TO COLOR9
            @23,23 SAY 'BORRANDO MERCADERIA ...ESPERE...'
            SET COLOR TO COLOR0
            
            BORRA_MER()

            @23,17 CLEAR TO 23,60
            SET COLOR TO COLOR9
            @23,27 SAY '...ACTUALIZANDO STOCK...'
            SET COLOR TO COLOR0

         ELSE
            USE MERCA
            RECALL ALL
            REPLACE ALL MARCA WITH ' '
            USE STOCK
            RECALL ALL
            USE COD_SWP
            ZAP
         ENDIF

   ENDIF
   RETURN
ENDDO


FUNCTION FUNBAJ
PARAMETERS MODE
PUBLIC NODATO,INTER,ART

STORE 0 TO NODATO
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
        IF MARCA=' '
           REPLACE MARCA WITH '*'
*           DELETE
        ELSE
           REPLACE MARCA WITH ' '
*           RECALL
        ENDIF
        RETURN(2)

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
            SET COLOR TO COLOR6
            @24,46 SAY 'Pulse <ÄÄÄ para volver a empezar'
            SET COLOR TO COLOR13
            @24,52 SAY '<ÄÄÄ'
            SET COLOR TO COLOR0
        ENDIF
        RETURN(1)
ENDCASE



FUNCTION BORRA_MER

USE MERCA
INDEX ON MARCA TO MARCA

GO TOP
STORE 1 TO IR

DO WHILE .T.
   USE MERCA
   SET INDEX TO MARCA
   GO IR

IF MARCA='*'
   STORE CODIGO TO VCODIGO
   DELETE
   USE .\ESC\COD_SWP
   APPEND BLANK
   REPLACE CODIGO WITH VCODIGO

   USE MERCA
   SET INDEX TO MARCA
   GO IR
   IF EOF()
      EXIT
   ENDIF

   STORE IR+1 TO IR
   LOOP
ENDIF

USE MERCA
SET INDEX TO MARCA
GO IR

IF EOF()
   EXIT
ENDIF

STORE IR+1 TO IR
LOOP

ENDDO
USE MERCA
PACK

USE STOCK
INDEX ON CODIGO TO STOCK
STORE 1 TO IR

DO WHILE .T.
   USE .\ESC\COD_SWP
   GO IR
   STORE CODIGO TO VCODIGO

   USE STOCK
   SET INDEX TO STOCK
   GO TOP

   SEEK VCODIGO
   IF FOUND()=.T.
      DELETE
   ENDIF

   USE .\ESC\COD_SWP
   GO IR

   IF EOF()
      EXIT
   ENDIF

   STORE IR+1 TO IR
   LOOP
ENDDO

USE STOCK
PACK

USE .\ESC\COD_SWP
ZAP

RETURN NIL

