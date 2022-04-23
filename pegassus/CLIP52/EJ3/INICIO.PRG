SET SCOREBOARD OFF
SET DATE FRENCH
SET CONFIRM ON
DO WHILE .T.
        CLEAR
        SET COLOR TO BG+/N
        @8,5 TO 16,74 DOUBLE
        SET COLOR TO B+/N
        @10,7 TO 14,72
        SET CURSOR ON
        SET COLOR TO W+/N
        @24,29 SAY 'Pulse <ESC> para salir'
        SET COLOR TO BG+/N
        @24,36 SAY 'ESC'
        SET COLOR TO W+/N,B/W
        STORE SPACE(30) TO VNOMBRE
        @12,16 SAY 'INGRESE AQUI SU NOMBRE:' GET VNOMBRE PICTURE '@!'
        READ
        IS LASTKEY()=27
                EXIT
        ENDIF
        @24,0
        SET CURSOR OFF
        CLEAR
        SET COLOR TO G+/N
        @9, TO 15,74 
        SET COLOR TO W+/N
        @11,26 SAY 'EL NOMBRE DEL OPERADOR ES:'
        SET COLOR TO *RG+/N
        CC=LEN(ALLTRIM(VNOMBRE))/2
        @13,69-CC SAY ALLTRIM(VNOMBRE)
        SET COLOR TO W+/N
@24,26 SAY 'GUARDAR ESTE DATO?'
INKEY(0)

CLEAR
QUIT
