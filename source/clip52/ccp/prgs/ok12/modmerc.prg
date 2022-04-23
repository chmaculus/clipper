SAVE SCREEN TO JERI
DO WHILE .T.
   USE MERCA
   INDEX ON DETALLE TO ORDDET
   GO TOP
   IF EOF()
      TONE(500,2)
      SET COLOR TO W+/B
      @13,30 CLEAR TO 13,47
      SET COLOR TO *R+/B
      @13,31 SAY 'NO EXISTEN DATOS'
      SET COLOR TO W+/B
      INKEY(3)
      RETURN
   ENDIF
   SET COLOR TO W+/B
   @8,1 TO 23,78
   @9,2 CLEAR TO 22,76
   @21,2 TO 21,77
   @19,2 TO 19,77
   @20,2 CLEAR TO 20,77
   @22,2 CLEAR TO 22,77
   @22,11 SAY '        Tomar'
   @22,58 SAY '      Salir'
   SET COLOR TO BG+/B
   @20,28 SAY 'Fichero de Art¡culos'
   @22,11 SAY '<ENTER>'
   @22,58 SAY '<ESC>'
   SET COLOR TO W+/B
   DECLARE CAMP[2]
   CAMP[1]='DETALLE'
   CAMP[2]='COSTO'
   DECLARE CABEZ[2]
   CABEZ[1]='                       Detalle'
   CABEZ[2]='P.Costo'
   DECLARE SEPAR[2]
   SEPAR[1]='Ä'
   SEPAR[2]='Ä'
   SET CURSOR OFF
   CLEAR TYPEAHEAD
   SET COLOR TO B+/B
   @24,1 SAY 'Buscar:                                                                       '
   SET COLOR TO BG/B,B/W
   DBEDIT(9,2,18,77,CAMP,'FUNMOD','',CABEZ,SEPAR)
   IF LASTKEY()=27
      RETURN
   ENDIF
   STORE CODIGO TO VCODMERC,VC
   STORE DETALLE TO VDETALLE,VD
   STORE COSTO TO VCOSTO,VP
   STORE PUBLICO TO VPUBLICO,VB
   STORE FIRMA TO VFIRM,VF
   STORE RUBRO TO VRUBR,VR
   DO WHILE .T.
      CLEAR
      STORE RECNO() TO REGISTRO
      @0,0 TO 2,30
      SET COLOR TO BG+/B
      @1,2 SAY '* * * CENTRO PLASTICO * * *'
      numero=LEFT(DTOC(DATE()),2)
      DIA=TDIAS(cdow(DATE()))
      MES=TMES(CMONTH(DATE()))
      ANIO=ALLTRIM(STR(YEAR(DATE())))
      VFECHA=DIA+' '+numero+' de '+MES+' de '+ANIO
      LL=79-LEN(VFECHA)
      SET COLOR TO W+/B
      @1,LL-7 SAY 'Fecha: '
      @3,0 TO 5,39
      CARTEL='Art¡culo N§ '
      @4,44 SAY CARTEL
      SET COLOR TO BG+/B
      @4,3 SAY 'PANTALLA PARA MODIFICAR MERCADERIA'
      @1,LL SAY VFECHA
      @4,56 SAY ALLTRIM(STR(VCODMERC))
      SAVE SCREEN TO APOLO
      SET COLOR TO *BG+/B
      XL=LEN(ALLTRIM(VFIRM))+14
      XL=INT(XL/2)
      @18,39-XL+14 SAY VFIRM
      SET COLOR TO W+/B
      @18,39-XL SAY 'Firma actual:'
      DO INGFIRM
      IF LASTKEY()=27
         EXIT
      ENDIF
      RESTORE SCREEN FROM APOLO
      SET COLOR TO *BG+/B
      XL=LEN(ALLTRIM(VRUBR))+14
      XL=INT(XL/2)
      @18,39-XL+14 SAY VRUBR
      SET COLOR TO W+/B
      @18,39-XL SAY 'Rubro actual:'
      DO INGRUBR
      IF LASTKEY()=27
         EXIT
      ENDIF
      RESTORE SCREEN FROM APOLO
      SET COLOR TO BG/B
      @7,1 SAY 'Firma:                                     Rubro:'
      SET COLOR TO W+/B
      @7,8 SAY LEFT(VFIRM,32)
      @7,51 SAY LEFT(VRUBR,28)
      SET COLOR TO BG+/B
      @6,0 SAY REPLICATE('Ä',79)
      @8,0 SAY REPLICATE('Ä',79)
      SET CURSOR ON
      @11,0 SAY REPLICATE('Ä',79)
      @13,0 SAY REPLICATE('Ä',79)
      @15,0 SAY REPLICATE('Ä',79)
      @17,0 SAY REPLICATE('Ä',79)
      SET COLOR TO W+/B,B/W
      @12,5 SAY 'Detalle:'GET VDETALLE PICTURE '@!'
      @14,5 SAY 'Precio de Costo:'GET VCOSTO PICTURE '9999.99'
      @16,5 SAY 'Precio  P£blico:'GET VPUBLICO PICTURE '9999.99'
      SET COLOR TO W+/B
      SAVE SCREEN TO PANLISTO
      READ
      IF LASTKEY()=27
         EXIT
      ENDIF
      USE MERCA
      INDEX ON DETALLE TO ORDDET
      GO TOP
      IF VDETALLE<>VD
         SEEK VDETALLE
         IF .NOT. EOF()
            SET CURSOR OFF
            TONE(1200,1)
            TONE(1200,1)
            TONE(1200,1)
            SET COLOR TO *R+/B
            @19,25 SAY 'El detalle de art¡culo ya EXISTE'
            SET COLOR TO W+/B
            STORE SPACE(60) TO VDETALLE
            INKEY(3)
            RESTORE SCREEN FROM PANLISTO
            LOOP
         ENDIF
      ENDIF
      SET COLOR TO W+/B
      SET CURSOR OFF
      @23,25 SAY '¨ Guarda modificaci¢n (S/N) ?'
      SET COLOR TO *R+/B
      @23,48 SAY 'S'
      @23,50 SAY 'N'
      SET COLOR TO W+/B
      DO WHILE .T.
         INKEY(0)
         IF LASTKEY()<>78.AND.LASTKEY()<>83.AND.LASTKEY()<>110.AND.LASTKEY()<>115
            TONE(500,1)
            LOOP
         ENDIF
         EXIT
      ENDDO
      IF LASTKEY()=83.OR.LASTKEY()=115
         GO TOP
         GO REGISTRO
         REPLACE DETALLE WITH VDETALLE,PUBLICO WITH VPUBLICO,COSTO WITH VCOSTO
         REPLACE FIRMA WITH VFIRM,RUBRO WITH VRUBR
   
         ** USE STOCK
         ** INDEX ON CODIGO TO ORDCOD
         ** GO TOP
         ** SEEK VCODIGO
         ** REPLACE DETALLE WITH VDETALLE,CODIGBARRA WITH VBARRA,PCOSTO WITH VPCOSTO

         EXIT
      ENDIF
      RESTORE SCREEN FROM APOLO
      STORE VC TO VCODMERC
      STORE VD TO VDETALLE
      STORE VP TO VCOSTO
      STORE VB TO VPUBLICO
      STORE VF TO VFIRM
      STORE VR TO VRUBR
      LOOP
   ENDDO
   RESTORE SCREEN FROM JERI
   LOOP
ENDDO
