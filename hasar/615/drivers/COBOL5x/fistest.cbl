       IDENTIFICATION DIVISION.
       PROGRAM-ID. "FisTest".
       AUTHOR. Leandro Fanzone
       ENVIRONMENT DIVISION.
       CONFIGURATION SECTION.
       SOURCE-COMPUTER. RMCOBOL-85.
       OBJECT-COMPUTER. RMCOBOL-85.
       DATA DIVISION.
       WORKING-STORAGE SECTION.
       01  AREA1.
	       03 ANUEVE   PIC 9 VALUE 9.
		   03 AHEXA    PIC X VALUE H"1C".
		   03 AEQUIS   PIC X VALUE "X".
           03 CARRET   PIC X VALUE H"0D".
       01  AREA2.
	       03 ANUEVE   PIC X VALUE "*".
           03 CARRET   PIC X VALUE H"0D".
       77  CHARACTER-STRING    PIC     X(512) VALUE ZEROS.
       77  STRING-LENGTH       PIC     99 BINARY.
       PROCEDURE DIVISION.
       MAIN-PROC.
           PERFORM INITIALIZATION.
           MOVE AREA1 TO CHARACTER-STRING.
           CALL "PUTCMD" USING CHARACTER-STRING, STRING-LENGTH.
           DISPLAY "Respuesta Impresor Fiscal: ", STRING-LENGTH, CONVERT.
           CALL "GETANS" USING CHARACTER-STRING, STRING-LENGTH.
           DISPLAY "Respuesta Impresor Fiscal: ",
                   CHARACTER-STRING, SIZE STRING-LENGTH,
                   " Longitud: ",
                   STRING-LENGTH, CONVERT.
           MOVE AREA2 TO CHARACTER-STRING.
           CALL "PUTCMD" USING CHARACTER-STRING, STRING-LENGTH.
           DISPLAY "Respuesta Impresor Fiscal: ", STRING-LENGTH, CONVERT.
           CALL "GETANS" USING CHARACTER-STRING, STRING-LENGTH.
           DISPLAY "Respuesta Impresor Fiscal: ",
                   CHARACTER-STRING, SIZE STRING-LENGTH,
                   " Longitud: ",
                   STRING-LENGTH, CONVERT.
           GO TO STOP-PARA.
       INITIALIZATION.
           DISPLAY "    Comunicando con impresor fiscal..."
            LINE 5 POSITION 5 ERASE.
       STOP-PARA.
           EXIT PROGRAM.
           STOP RUN.
