#include "colores.ch"
***  RUTINA DE RESTAURACION DE COPIA DE SEGURIDAD ***         

INKEY(1)
IF !FILE('.\ESC\PKUNZIP.EXE')
   SET COLOR TO  COLOR0
   @12,12 TO 14,66
   @13,13 CLEAR TO 13,65
   TONE(500,2)
   @13,17 SAY 'El archivo descompresor             no existe'
   SET COLOR TO COLOR8
   @13,41 SAY 'PKUNZIP.EXE'
   SET COLOR TO COLOR0
   INKEY(8)
   RETURN
ENDIF
SET COLOR TO COLOR0
CLEAR
SET CURSOR OFF
@3,10 TO 21,69 DOUBLE 
@6,11 to 6,68
@17,11 to 17,68
@4,11 CLEAR to 5,68
@18,11 CLEAR to 20,68
SET COLOR TO COLOR10
@4,29 SAY 'RESTAURACION DE COPIAS' 
@5,20 SAY '*** PARA ESTACION DE SERVICIO CENTRO ***'
SET COLOR TO COLOR0
DO WHILE .T. 
  SAVE SCREEN TO PANPAN
  SET COLOR TO COLOR0
  @7,11 CLEAR TO 16,68
  @10,11 to 10,68
  @7,24 SAY 'Se restaurar  las BASES de DATOS'
  SET COLOR TO COLOR8
  @7,42 SAY 'BASES'
  @7,51 SAY 'DATOS'
  SET COLOR TO COLOR0
  @11,19 CLEAR to 16,60
  @19,17 say 'Confirme con <ENTER>       o cancele con <ESC>'
  SET COLOR TO COLOR10
  @19,30 say '<ENTER>'
  @19,58 say '<ESC>'
  SET COLOR TO COLOR0
  STORE 'A:\' TO DISCO
  @12,20 CLEAR TO 12,58
  @12,36 SAY 'Copiar en'
  CLOSE ALL
  SAVE SCREEN TO JJ
  DO WHILE .T.
     SET COLOR TO COLOR10
     @14,40 SAY LEFT(DISCO,2)
     SET COLOR TO COLOR0
     @18,11 CLEAR to 20,68
     @18,19 SAY 'Inserte el diskette de BASES en la unidad'
     @20,32 SAY 'y pulse'
     SET COLOR TO COLOR8
     @18,61 SAY LEFT(DISCO,2)
     SET COLOR TO COLOR10
     @20,41 SAY '<ENTER>'
     SET COLOR TO COLOR0
     INKEY(0)
     IF LASTKEY()=27
        RETURN
     ENDIF
     SET COLOR TO COLOR0
     @18,11 CLEAR to 20,68
     @19,20 SAY 'Restaurando BASES de datos'
     SET COLOR TO COLOR8
     @19,47 SAY '­ ESPERE !'
     SET COLOR TO COLOR0
     KKK=FCREATE('A:\BASES.RA0',0)
     MANI='123'
     FWRITE(KKK,MANI)
     FCLOSE(KKK)
     IF FERROR()<>0
        @18,11 CLEAR to 20,68
        SET COLOR TO COLOR8
        @19,33 SAY ' NO HAY DISCO '
        SET COLOR TO COLOR0
        INKEY(3)
        LOOP
     ENDIF
     IF !FILE('A:\BASES.ZIP')
        @12,12 TO 14,66
        @13,13 CLEAR TO 13,65
        TONE(500,2)
        SET COLOR TO COLOR8
        @13,28 SAY 'Ese Disco no contiene BASES'
        SET COLOR TO COLOR0
        INKEY(4)
        RESTORE SCREEN FROM JJ
        LOOP
     ENDIF
     IF FILE('A:\BASES.RA0')
        RUN DEL A:\BASES.RA0 >NUL
     ENDIF
     EXIT
  ENDDO
  RUTA='COPY A:\BASES.ZIP .\ESC >NUL'
  RUTA2='COPY A:\INDICES.ZIP .\ESC >NUL'
  SET COLOR TO COLOR0
  RUN &RUTA
  RUN PKUNZIP -o .\ESC\BASES.ZIP .\ESC >NUL
  RUN DEL .\ESC\BASES.ZIP >NUL
  @7,18 SAY 'Se restauraron copias de las BASES de DATOS.'
  @8,38 SAY 'ahora'
  @9,19 SAY 'Se restaurar n los INDICES de ORDENAMIENTO'
  SET COLOR TO COLOR8
  @9,38 SAY 'INDICES'
  @9,49 SAY 'ORDENAMIENTO'
  TONE(1200,1)
  TONE(1200,1)
  TONE(1200,1)
  SAVE SCREEN TO GG
  DO WHILE .T.
     SET COLOR TO COLOR0
     @18,11 CLEAR to 20,68
     @18,15 SAY 'Inserte el diskette de los INDICES en la unidad'
     @20,32 SAY 'y pulse'
     SET COLOR TO COLOR8
     @18,63 SAY LEFT(DISCO,2)
     SET COLOR TO COLOR10
     @20,41 SAY '<ENTER>'
     SET COLOR TO COLOR0
     INKEY(0)
     IF LASTKEY()=27
        RETURN
     ENDIF
     @18,11 CLEAR to 20,68
     @19,18 SAY 'Copiando INDICES de ordenamiento '
     SET COLOR TO COLOR8
     @19,51 SAY '­ ESPERE !'
     SET COLOR TO COLOR0
     KKK=FCREATE('A:\BASES.RA0',0)
     MANI='123'
     FWRITE(KKK,MANI)
     FCLOSE(KKK)
     IF FERROR()<>0
        @18,11 CLEAR to 20,68
        SET COLOR TO COLOR8
        @19,33 SAY ' NO HAY DISCO '
        SET COLOR TO COLOR0
        INKEY(3)
        LOOP
     ENDIF
     IF !FILE('A:\INDICES.ZIP')
        @12,12 TO 14,66
        @13,13 CLEAR TO 13,65
        TONE(500,2)
        SET COLOR TO COLOR8
        @13,27 SAY 'Ese Disco no contiene INDICES'
        SET COLOR TO COLOR0
        INKEY(4)
        RESTORE SCREEN FROM GG
        LOOP
     ENDIF
     IF FILE('A:\BASES.RA0')
        RUN DEL A:\BASES.RA0 >NUL
     ENDIF
     EXIT
  ENDDO
  SET COLOR TO COLOR0
  RUN &RUTA2
  RUN PKUNZIP -o .\ESC\INDICES.ZIP .\ESC >NUL
  RUN DEL .\ESC\INDICES.ZIP >NUL
  @8,38 SAY '     '
  @9,16 SAY 'Se restauraron copias de INDICES de ORDENAMIENTO'
  @12,20 CLEAR TO 12,58
  @12,36 SAY 'de unidad'
  @18,11 CLEAR to 20,68
  SET COLOR TO COLOR8
  @18,25 SAY '...RESTAURACION  FINALIZADA...'
  SET COLOR TO COLOR0
  @20,27 SAY 'Pulse <ENTER> para salir'
  SET COLOR TO COLOR10
  @20,33 SAY '<ENTER>'
  SET COLOR TO COLOR0
  tone(1200,1)
  tone(1200,1)
  tone(1200,1)
  INKEY(0)
  CLEAR
  RETURN
ENDDO
