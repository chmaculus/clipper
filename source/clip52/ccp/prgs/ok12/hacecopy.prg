***  RUTINA DE COPIA DE SEGURIDAD ***

INKEY(1)
IF !FILE('PKZIP.EXE')
   SET COLOR TO W+/B
   @12,12 TO 14,66
   @13,13 CLEAR TO 13,65
   TONE(500,2)
   SET COLOR TO *R+/B
   @13,14 SAY 'El Archivo para compresi¢n PKZIP.EXE no existe'
   SET COLOR TO W+/B
   INKEY(4)
   RETURN
ENDIF
SET COLOR TO W+/B
CLEAR
SET CURSOR OFF
@3,10 TO 21,69 DOUBLE 
@6,11 to 6,68
@17,11 to 17,68
@4,11 CLEAR to 5,68
@18,11 CLEAR to 20,68
SET COLOR TO BG+/B
@4,31 SAY 'COPIA DE SEGURIDAD' 
@5,20 SAY '*** CENTRO PLASTICO  GENERAL ALVEAR ***'
DO WHILE .T. 
  SAVE SCREEN TO PANPAN
  SET COLOR TO W+/B
  @7,11 CLEAR TO 16,68
  @10,11 to 10,68
  @7,22 SAY 'Se har n copia de las BASES de DATOS'
  SET COLOR TO *BG+/B
  @7,44 SAY 'BASES'
  @7,53 SAY 'DATOS'
  @11,19 CLEAR to 16,60
  SET COLOR TO W+/B
  @19,17 say 'Confirme con <ENTER>       o cancele con <ESC>'
  SET COLOR TO BG+/B
  @19,30 say '<ENTER>'
  @19,58 say '<ESC>'
  STORE 'IVA\' TO DISCO
  SET COLOR TO W+/B
  @12,20 CLEAR TO 12,58
  @12,34 SAY 'Copiar en'
  CLOSE ALL
  DO WHILE .T.
     SET COLOR TO RG+/B
     @12,44 SAY LEFT(DISCO,2)
     SET COLOR TO W+/B
     @18,11 CLEAR to 20,68
     @14,18 SAY 'Inserte un diskete para BASES en la unidad'
     @16,32 SAY 'y pulse'
     SET COLOR TO *BG+/B
     @14,61 SAY LEFT(DISCO,2)
     SET COLOR TO B/W
     @16,41 SAY '<ENTER>'
     SET COLOR TO *R+/B
     @18,11 SAY ' ­ ATENCION ! '
     SET COLOR TO W+/B
     @18,26 SAY 'SI EL DISKETE QUE VA A USAR CONTIENE DATOS,'
     @20,26 SAY 'ESTOS SERAN ELIMINADOS PARA CREAR LA COPIA.'
     INKEY(0)
     IF LASTKEY()=27
        RETURN
     ENDIF
     KKK=FCREATE('A:\BASES.RA0',0)
     MANI='123'
     FWRITE(KKK,MANI)
     FCLOSE(KKK)
     IF FERROR()<>0
        SET COLOR TO W+/B
        @18,11 CLEAR to 20,68
        SET COLOR TO *R+/B
        @19,33 SAY ' NO HAY DISCO '
        SET COLOR TO W+/B
        INKEY(3)
        LOOP
     ENDIF
     IF FILE('A:\BASES.RA0')
        RUN DEL A:\BASES.RA0 >NUL
     ENDIF
     EXIT
  ENDDO
  RUTA='COPY BASES.ZIP A:\ >NUL'
  RUTA2='COPY INDICES.ZIP A:\ >NUL'
  SET COLOR TO W+/B
  @18,11 CLEAR to 20,68
  @11,11 CLEAR to 16,68
  @12,33 SAY 'Copiando en'
  SET COLOR TO BG+/B
  @12,45 SAY LEFT(DISCO,2)
  @19,23 SAY 'Copiando BASES de datos'
  SET COLOR TO *RG+/B
  @19,47 SAY '­ ESPERE !'
  SET COLOR TO W+/B
  RUN DELTREE /Y A:\*.* >NUL
  RUN PKZIP BASES *.DB* >NUL
  RUN &RUTA
  RUN DEL BASES.ZIP >NUL
  SET COLOR TO W+/B
  @7,18 SAY 'Se crearon las copias de las BASES de DATOS.'
  @8,38 SAY 'ahora'
  @9,18 SAY 'Se har  copia de los INDICES de ORDENAMIENTO'
  @11,11 CLEAR to 16,68
  SET COLOR TO *BG+/B
  @9,39 SAY 'INDICES'
  @9,50 SAY 'ORDENAMIENTO'
  TONE(1200,1)
  TONE(1200,1)
  TONE(1200,1)
  SET COLOR TO W+/B
  DO WHILE .T.
     SET COLOR TO W+/B
     @18,11 CLEAR to 20,68
     @14,17 SAY 'Inserte un diskete para INDICES en la unidad'
     @16,32 SAY 'y pulse'
     SET COLOR TO *BG+/B
     @14,62 SAY LEFT(DISCO,2)
     SET COLOR TO B/W
     @16,41 SAY '<ENTER>'
     SET COLOR TO *R+/B
     @18,11 SAY ' ­ ATENCION ! '
     SET COLOR TO W+/B
     @18,26 SAY 'SI EL DISKETE QUE VA A USAR CONTIENE DATOS,'
     @20,26 SAY 'ESTOS SERAN ELIMINADOS PARA CREAR LA COPIA.'
     INKEY(0)
     SET COLOR TO W+/B
     IF LASTKEY()=27
        RETURN
     ENDIF
     KKK=FCREATE('A:\BASES.RA0',0)
     MANI='123'
     FWRITE(KKK,MANI)
     FCLOSE(KKK)
     IF FERROR()<>0
        @18,11 CLEAR to 20,68
        SET COLOR TO *R+/B
        @19,33 SAY ' NO HAY DISCO '
        SET COLOR TO W+/B
        INKEY(3)
        LOOP
     ENDIF
     IF FILE('A:\BASES.RA0')
        RUN DEL A:\BASES.RA0 >NUL
     ENDIF
     EXIT
  ENDDO
  SET COLOR TO W+/B
  @18,11 CLEAR to 20,68
  @11,11 CLEAR to 16,68
  @12,33 SAY 'Copiando en'
  SET COLOR TO BG+/B
  @12,45 SAY LEFT(DISCO,2)
  @19,18 SAY 'Copiando INDICES de ordenamiento '
  SET COLOR TO *RG+/B
  @19,51 SAY '­ ESPERE !'
  SET COLOR TO W+/B
  RUN DELTREE /Y A:\*.* >NUL
  RUN PKZIP INDICES *.NTX >NUL
  RUN &RUTA2
  RUN DEL INDICES.ZIP >NUL
  @8,38 SAY '     '
  @9,18 SAY 'Se crearon copias de INDICES de ORDENAMIENTO'
  @12,20 CLEAR TO 12,58
  @12,36 SAY 'en unidad'
  @18,11 CLEAR to 20,68
  @11,11 CLEAR to 16,68
  TONE(1200,1)
  TONE(1200,1)
  TONE(1200,1)
  SET COLOR TO *RG+/B
  @18,29 SAY '...COPIA FINALIZADA...'
  SET COLOR TO W+/B
  @20,33 SAY 'pulse'
  SET COLOR TO BG+/B
  @20,40 SAY '<ENTER>'
  SET COLOR TO W+/B
  tone(1200,1)
  tone(1200,1)
  tone(1200,1)
  INKEY(0)
  USE PARAMETR
  GO TOP
  REPLACE FECHACOPIA WITH DATE()
  CLEAR
  RETURN
ENDDO
