SAVE SCREEN TO TOMAFIRM
PUBLIC VFIRM,VTELE,PULSO
IF LASTKEY()=-1
   CLEAR GETS
   PULSO=1
   @7,0 CLEAR TO 24,79
ELSE
   PULSO=0
ENDIF
USE FIRMAS
INDEX ON NOMBRES TO O_N_FIRM
GO TOP
IF EOF()
   SAVE SCREEN TO ANDRES
   TONE(500,2)
   SET COLOR TO W+/B
   @13,24 TO 15,53
   @14,25 CLEAR TO 14,52
   SET COLOR TO *R+/B
   @14,26 SAY 'NO EXISTEN DATOS DE FIRMAS'
   SET COLOR TO W+/B
   INKEY(3)
   RESTORE SCREEN FROM ANDRES
   @18,1 TO 22,78
   @19,2 CLEAR TO 21,77
   STORE SPACE(40) TO VFIRM
   STORE SPACE(35) TO VTELE
   SET CURSOR ON
   SET COLOR TO BG+/B,B/W
   @19,6 SAY 'Ingrese nombre de la Firma:'GET VFIRM PICTURE '@!'
   READ
   @21,6 SAY 'Ingrese Tel�fonos la Firma:'GET VTELE PICTURE '@!'
   READ
   SET CURSOR OFF
   SET COLOR TO W+/B
   IF LASTKEY()=27
      RETURN
   ENDIF
   RESTORE SCREEN FROM ANDRES
   APPEND BLANK
   REPLACE NOMBRES WITH VFIRM,CODIGO WITH 1,TELEFONO WITH VTELE
   GO TOP
ENDIF
SET COLOR TO W+/B
@6,20 TO 15,59
@7,21 CLEAR TO 14,58
@16,16 SAY '        Tomar'
@16,33 SAY '     Nuevo'
@16,48 SAY '       Eliminar'
SET COLOR TO BG+/B
@16,16 SAY '<ENTER>'
@16,33 SAY '<F5>'
@16,48 SAY '<SUPR>'
DECLARE CAMP[1]
CAMP[1]='NOMBRES'
DECLARE CABEZ[1]
CABEZ[1]='         Firmas Proveedoras'
DECLARE SEPAR[1]
SEPAR[1]='�'
SET CURSOR OFF
CLEAR TYPEAHEAD
SET COLOR TO BG/B
@23,1 TO 23,78
SET COLOR TO B+/B
@24,1 SAY 'Buscar:                                                                       '
SET COLOR TO BG/B,B/W
DBEDIT(7,21,14,58,CAMP,'FUNCAJA','',CABEZ,SEPAR)
IF LASTKEY()=27
   RETURN
ENDIF
STORE NOMBRES TO VFIRM
STORE TELEFONO TO VTELE
RESTORE SCREEN FROM TOMAFIRM
IF PULSO=1
   SET COLOR TO BG/B
   @7,1 SAY 'Firma:                                     Rubro:'
   SET COLOR TO W+/B
   @7,8 CLEAR TO 7,40
   @7,51 CLEAR TO 7,79
   @7,8 SAY LEFT(VFIRM,32)
   @7,51 SAY LEFT(VRUBR,28)
ENDIF
SET CURSOR ON
RETURN
