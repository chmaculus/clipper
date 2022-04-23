DO WHILE .T.
   SET COLOR TO W+/B
   CLEAR
   @2,20 TO 4,59
   @6,20 TO 15,59
   @7,21 CLEAR TO 14,58
   @16,16 SAY '        Tomar'
   @16,33 SAY '     Nuevo'
   @16,48 SAY '       Eliminar'
   SET COLOR TO BG+/B
   @3,22 SAY 'MODIFICACION DE FIRMAS Y/O TELEFONOS'
   @16,16 SAY '<ENTER>'
   @16,33 SAY '<F5>'
   @16,48 SAY '<SUPR>'
   DECLARE CAMP[1]
   CAMP[1]='NOMBRES'
   DECLARE CABEZ[1]
   CABEZ[1]='         Firmas Proveedoras'
   DECLARE SEPAR[1]
   SEPAR[1]='Ä'
   SET CURSOR OFF
   CLEAR TYPEAHEAD
   SET COLOR TO BG/B
   @23,1 TO 23,78
   SET COLOR TO B+/B
   @24,1 SAY 'Buscar:                                                                       '
   SET COLOR TO BG/B,B/W
   USE FIRMAS
   INDEX ON NOMBRES TO O_N_FIRM
   GO TOP
   DBEDIT(7,21,14,58,CAMP,'FUNCAJA','',CABEZ,SEPAR)
   IF LASTKEY()=27
      RETURN
   ENDIF
   STORE NOMBRES TO VFIRM,OLDFIRM
   STORE TELEFONO TO VTELE,OLDTELE
   STORE RECNO() TO REGISTRO
   DO WHILE .T.
      SAVE SCREEN TO TOMAFIRM
      SET CURSOR ON
      SET COLOR TO B+/B
      @18,1 TO 22,78
      @19,2 CLEAR TO 21,77
      SET CURSOR ON
      SET COLOR TO BG+/B,B/W
      @19,4 SAY 'Ingrese Nuevo Nombre de Firma:'GET VFIRM PICTURE '@!K'
      READ
      IF LASTKEY()=27
         EXIT
      ENDIF
      GO TOP
      LOCATE FOR NOMBRES=VFIRM.AND.NOMBRES<>OLDFIRM
      IF .NOT. EOF()
         SET CURSOR OFF
         TONE(1200,1)
         SET COLOR TO W+/B
         @19,2 CLEAR TO 21,77
         SET COLOR TO *R+/B
         @20,30 SAY 'FIRMA EXISTENTE'
         INKEY(3)
         STORE OLDFIRM TO VFIRM
         STORE OLDTELE TO VTELE
         RESTORE SCREEN FROM TOMAFIRM
         LOOP
      ENDIF
      @21,4 SAY 'Ingrese Nuevos Tel‚fonos la Firma:'GET VTELE PICTURE '@!K'
      READ
      SET CURSOR OFF
      IF LASTKEY()=27
         EXIT
      ENDIF
      GO TOP
      GO REGISTRO
      REPLACE NOMBRES WITH VFIRM,TELEFONO WITH VTELE

      USE MERCA
      REPLACE ALL FIRMA WITH VFIRM FOR FIRMA=OLDFIRM

      EXIT
   ENDDO
   LOOP
ENDDO
