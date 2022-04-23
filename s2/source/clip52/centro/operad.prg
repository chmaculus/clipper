#include "colores.ch"
SAVE SCREEN TO AA

SET COLOR TO COLOR0
@4,44 TO 8,54

PUBLIC OPCION

SET COLOR TO SELECT1
@5,45 PROMPT 'AGREGAR  '

SET COLOR TO SELECT1
@6,45 PROMPT 'ELIMINAR '

SET COLOR TO SELECT1
@7,45 PROMPT 'CLAVES   '

MENU TO OPCION
DO CASE
   CASE OPCION=1
      SET COLOR TO COLOR8
      @9,48 SAY 'AGREGAR'
      SET COLOR TO N/W+
      save screen to aa
      DO AGRE_OPER
      restore screen from aa

   CASE OPCION=2
      SET COLOR TO N/W+
      @10,48 SAY 'ELIMINAR'
      SET COLOR TO LETRASC0
      save screen to aa
      DO ELIMIN_OPER
      restore screen from aa

   CASE OPCION=3
      SET COLOR TO N/W+
      @10,48 SAY 'CAMBIAR CLAVE'
      SET COLOR TO LETRASC0
      save screen to aa
      DO CAMBIA_CLAVE
      restore screen from aa

   OTHERWISE
      RETURN
ENDCASE

PROCEDURE AGRE_OPER
DO WHILE .T.
save screen to aa

        STORE SPACE(10) TO VNOPER
        STORE SPACE(10) TO VCLAVE


        @7,13 clear to 11,52
        set color to b
        @7,13,11,52 BOX 'ллллллллл'
        set color to w
        @8,14 to 10,51

        set color to w/b
        @9,16 SAY 'Nombre operador:'GET VNOPER PICTURE '@!'
        READ

        IF LASTKEY()=27
           EXIT
        ENDIF

        USE .\ESC\OPERA
        INDEX ON OPERADOR TO .\ESC\OPERA
        GO TOP
        SEEK VNOPER

        IF LASTKEY()=27
           EXIT
        ENDIF

        IF VNOPER=SPACE(10)
           EXIT
        ENDIF

        IF .NOT. EOF()
                TONE(1200,1)
                TONE(1200,1)
                TONE(1200,1)
                SET CURSOR OFF
                SET COLOR TO COLOR9
                @15,22 SAY 'EL Operador ya EXISTE'
                SET COLOR TO COLOR0
                INKEY(3)
                CLEAR
                STORE SPACE(10) TO VNOPER
                LOOP
        ENDIF
EXIT
restore screen from aa
ENDDO


STORE SPACE(10) TO VCLAVE
STORE SPACE(10) TO VCLAVE2

@7,13 clear to 11,52
set color to b
@7,13,11,52 BOX 'ллллллллл'
set color to w
@8,14 to 10,51
set color to w/b
@9,16 SAY 'Ingrese Clave:'

SET COLOR TO N/N,N/N
@9,31  SAY ''GET VCLAVE PICTURE '@!'
READ

IF VCLAVE=SPACE(10)
   RETURN
ENDIF

@7,13 clear to 11,52
set color to b
@7,13,11,52 BOX 'ллллллллл'
set color to w
@8,14 to 10,51
set color to w/b
@9,16  SAY 'RE-Ingrese Clave:'

SET COLOR TO N/N,N/N
@9,34 SAY ''GET VCLAVE2 PICTURE '@!'
READ

set color to w/b

IF VCLAVE=VCLAVE2
          USE .\ESC\OPERA
          REPLACE PASWORD WITH VCLAVE
          APPEND BLANK
          REPLACE operador with VNOPER, pasword with VCLAVE

          @7,13 clear to 11,52
          set color to b
          @7,13,11,52 BOX 'ллллллллл'
          set color to w
          @8,14 to 10,51
          set color to *w+/b
          @9,15 SAY 'El Operador se agrego correctamente!'
          INKEY(5)
          set color to w/b

   ELSE

   TONE(1200,1)
   TONE(1200,1)
   TONE(1200,1)

   @7,13 clear to 11,52
   set color to b
   @7,13,11,52 BOX 'ллллллллл'
   set color to w
   @8,14 to 10,51
   set color to *w+/b
   @9,16 SAY 'Las Claves Ingresadas no coinciden'
   INKEY(3)
   set color to w/b
ENDIF
RETURN

PROCEDURE ELIMIN_OPER
save screen to aa

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
        SEPAR[1]='Ф'

        SET CURSOR OFF
        CLEAR TYPEAHEAD
        SET COLOR TO COLOR7
        DBEDIT(12,17,20,54,CAMP,'','',CABEZ,SEPAR)

        IF LASTKEY()=27
           EXIT
        ENDIF

        STORE OPERADOR TO VOPERA


        @7,13 clear to 11,52
        set color to b
        @7,13,11,52 BOX 'ллллллллл'
        set color to w
        @8,14 to 10,51
        set color to w/b
        @9,16 SAY 'ЈEliminar Operador ( / )'
        SET COLOR TO COLOR8
        @9,36 SAY 'S'
        @9,38 SAY 'N'

        SET COLOR TO COLOR0
         INKEY(0)
         IF LASTKEY()=83.OR.LASTKEY()=115

            USE .\ESC\OPERA
            INDEX ON OPERADOR TO .\ESC\OPERA
            GO TOP
            SEEK VOPERA
            DELETE
            PACK
         ELSE
         ENDIF

restore screen from aa
ENDDO
RETURN



PROCEDURE CAMBIA_CLAVE
save screen to aa

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
   SEPAR[1]='Ф'

   SET CURSOR OFF
   CLEAR TYPEAHEAD
   SET COLOR TO COLOR7
*@11,15 TO 23,55
   DBEDIT(12,16,20,54,CAMP,'','',CABEZ,SEPAR)

   IF LASTKEY()=27
      EXIT
   ENDIF

   STORE OPERADOR TO VOPERA
   STORE SPACE(10) TO VCLAVE
   STORE SPACE(10) TO VCLAVE2


        @7,13 clear to 11,52
        set color to b
        @7,13,11,52 BOX 'ллллллллл'
        set color to w
        @8,14 to 10,51
        set color to w/b
        @9,16 SAY 'Ingrese Clave:'

        SET COLOR TO N/N,N/N
        @9,31  SAY ''GET VCLAVE PICTURE '@!'
        READ

        IF VCLAVE=SPACE(10)
           RETURN
        ENDIF

        @7,13 clear to 11,52
        set color to b
        @7,13,11,52 BOX 'ллллллллл'
        set color to w
        @8,14 to 10,51
        set color to w/b
        @9,16  SAY 'RE-Ingrese Clave:'


        SET COLOR TO N/N,N/N
        @9,34 SAY ''GET VCLAVE2 PICTURE '@!'
        READ

        set color to w/b

IF VCLAVE=VCLAVE2
          USE .\ESC\OPERA
          INDEX ON OPERADOR TO .\ESC\OPERA
          SEEK VOPERA
          REPLACE PASWORD WITH VCLAVE

          @7,13 clear to 11,52
          set color to b
          @7,13,11,52 BOX 'ллллллллл'
          set color to w
          @8,14 to 10,51
          set color to *w+/b
          @9,15 SAY 'La CLAVE se cambio correctamente!'
          INKEY(5)
          set color to w/b

   ELSE

   TONE(1200,1)
   TONE(1200,1)
   TONE(1200,1)

   @7,13 clear to 11,52
   set color to b
   @7,13,11,52 BOX 'ллллллллл'
   set color to w
   @8,14 to 10,51
   set color to *w+/b
   @9,16 SAY 'Las Claves Ingresadas no coinciden'
   INKEY(3)
   set color to w/b
ENDIF

restore screen from aa
ENDDO
RETURN
restore screen from aa

