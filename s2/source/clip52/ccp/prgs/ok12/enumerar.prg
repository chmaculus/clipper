SAVE SCREEN TO MELLI
USE NFA
GO TOP
STORE NUMERO TO NUMFA
CLOSE
USE NFB
GO TOP
STORE NUMERO TO NUMFB
CLOSE
DO WHILE .T.
   SET CURSOR OFF
   SET COLOR TO BG+/B
   @6,0 TO 14,79
   @7,1 CLEAR TO 13,78
   SET WRAP ON
   SET COLOR TO BG/B,B/W
   @08,23 SAY 'N£mero de 1§ Factura A:'
   @10,23 SAY 'N£mero de 1§ Factura B:'
   @12,20 SAY 'Aceptar'
   @12,50 SAY 'Cancelar'

         SET CURSOR ON
         @8,47 CLEAR TO 8,67
         @8,46 SAY ''GET NUMFA PICTURE '99999999'
         READ
*         STORE RIGHT(STR(NUMFA),8) TO PROA
         SET CURSOR ON
         @10,47 CLEAR TO 10,67
         @10,46 SAY ''GET NUMFB PICTURE '99999999'
         READ
*         STORE RIGHT(STR(NUMFB),8) TO PROB

   @12,20 PROMPT 'Aceptar'
   @12,50 PROMPT 'Cancelar'
   MENU TO STIV
   SET COLOR TO BG/B,B/W
   DO CASE
      CASE STIV=1
         USE NFA
         GO TOP
         REPLACE NUMERO WITH NUMFA
         USE NFB
         GO TOP
         REPLACE NUMERO WITH NUMFB
         EXIT
      CASE STIV=2
         EXIT
      OTHERWISE
        RESTORE SCREEN FROM MELLI
        RETURN
   ENDCASE
ENDDO
RETURN
