       IDENTIFICATION DIVISION.
       PROGRAM-ID. PRUEBA.
       AUTHOR. CDA.
      * Desarrollado por:
      *                          Carlos Daniel Al‚s
      *                          Juan Carlos Al‚s
      *                            Alberdi 430
      *                            (B 7000 ACJ) TANDIL
      *                            Pcia. de Buenos Aires
      *                            TE (02293) 425748
      *                            mailto <jcales@infovia.com.ar>
      ********************************************************
       ENVIRONMENT DIVISION.
       CONFIGURATION SECTION.
       SPECIAL-NAMES.
      ********************************************************
       DATA DIVISION.
      *********************************************************
       WORKING-STORAGE SECTION.
       01 param-fis      pic x(512) value zeros.
       01 stat-f.
         05 filler       pic x value "*". 
         05 filler       pic x value x"0d".
       01 cier-x.
         05 filler       pic x value "9". 
         05 filler       pic x value x"1C". 
         05 filler       pic x value "X". 
         05 filler       pic x value x"0d". 
         05 filler       pic x(500) value zeros.
      **********************************************************
       PROCEDURE DIVISION.
      **********************************************************
       INICIO.
           move cier-x to param-fis.
      *     move stat-f to param-fis.
           display param-fis.
           CALL "C_FISDRV" using param-fis.
           display param-fis.
           STOP RUN.
