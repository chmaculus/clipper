STORE LASTREC() TO HAS
GO TOP
STORE 0 TO TTT
FOR KK=1 TO HAS
   IF MARCA='*'
      TTT=TTT+IMPORTE
      SET COLOR TO BG/B
      @LINEA,5 SAY '�'
      SET COLOR TO B/W
      @LINEA,2 SAY '1'
      SET COLOR TO BG/B
      @LINEA,61 SAY '�'
      @LINEA,70 SAY '�'
      SET COLOR TO W+/B
      @LINEA,6 SAY DESCRIP
      @LINEA,63 SAY IMPORTE PICTURE '9999.99'
      @LINEA,72 SAY IMPORTE PICTURE '9999.99'
      LINEA=LINEA+1
   ENDIF
   SKIP
NEXT
SET COLOR TO RG+/B
@22,72 SAY TTT PICTURE '9999.99'
SET COLOR TO W+/B
IF LINEA>7
   TONE(1200,1)
   @24,18
   SET CURSOR OFF
   SET COLOR TO W+/B
   @24,27  SAY '� Est� todo correcto (S/N) ?'
   SET COLOR TO *R+/B
   @24,49  SAY 'S'
   @24,51  SAY 'N'
   SET COLOR TO W+/B
   TONE(1200,1)
   DO WHILE .T.
      INKEY(0)
      IF LASTKEY()<>83.AND.LASTKEY()<>115.AND.LASTKEY()<>78.AND.LASTKEY()<>110
         TONE(1200,1)
         LOOP
      ENDIF
      EXIT
   ENDDO
   IF LASTKEY()=83.OR.LASTKEY()=115
      COPY TO TMPCTA2 FOR DELETED()
      PACK
      USE REMITOS
      PACK
      APPEND FROM TMPCTA
      ERASE 'TMPCTA.DBF'
      IF VIVA='RI'
         USE NFA
         GO TOP
         REPLACE NUMERO WITH NUMFA
         STORE NUMFA TO NFAC
         USE FACT_A
      ELSE
         USE NFB
         GO TOP
         REPLACE NUMERO WITH NUMFB
         STORE NUMFB TO NFAC
         USE FACT_B
      ENDIF
      USE TMPCTA2
      RECALL ALL
      INDEX ON FECHA TO ORDFEC
      GO TOP
      DO WHILE .T.
         IF EOF()
            EXIT
         ENDIF
         STORE NOMBRE TO VNOM
         STORE DOMICILIO TO VDOM
         STORE DNI TO VDOC
         STORE CUIT TO VCUI
         STORE SITUIVA TO VSIT
         STORE TELEFONO TO VTEL
         STORE FECHA TO VFEC
         STORE DEBE TO VDEB
         STORE DESCRIP TO VDES
         DELETE
         PACK
         IF VIVA='RI'
            USE FACT_A
            APPEND BLANK
            REPLACE NUMERO WITH NUMFA,FECHA WITH VFEC,CLIENTE WITH VNOM
            REPLACE DOMICILIO WITH VDOM,TELEFONO WITH VTEL,DNI WITH VDOC
            REPLACE CUIT WITH VCUI,SITUIVA WITH VSIT,CODIGO WITH 0
            REPLACE DETALLE WITH VDES,CANTIDAD WITH 1,PRECIO WITH VDEB,TOTAL WITH VDEB
         ELSE
            USE FACT_B
            APPEND BLANK
            REPLACE NUMERO WITH NUMFB,FECHA WITH VFEC,CLIENTE WITH VNOM
            REPLACE DOMICILIO WITH VDOM,TELEFONO WITH VTEL,DNI WITH VDOC
            REPLACE CUIT WITH VCUI,SITUIVA WITH VSIT,CODIGO WITH 0
            REPLACE DETALLE WITH VDES,CANTIDAD WITH 1,PRECIO WITH VDEB,TOTAL WITH VDEB
         ENDIF
         USE TMPCTA2
         INDEX ON FECHA TO ORDFEC
         GO TOP
         LOOP
      ENDDO
      @24,0
      SET CURSOR OFF
      SET COLOR TO W+/B
      @24,28  SAY '� Imprimir Factura (S/N) ?'
      SET COLOR TO *R+/B
      @24,48  SAY 'S'
      @24,50  SAY 'N'
      SET COLOR TO W+/B
      TONE(1200,1)
      DO WHILE .T.
         INKEY(0)
         IF LASTKEY()<>83.AND.LASTKEY()<>115.AND.LASTKEY()<>78.AND.LASTKEY()<>110
            TONE(1200,1)
            LOOP
         ENDIF
         EXIT
      ENDDO
      @24,0
      IF LASTKEY()=83.OR.LASTKEY()=115
         DO PRNF_REM
      ENDIF
      ERASE 'TMPCTA2.DBF'
      USE VTASTMP
      ZAP
      RETURN
   ELSE
      USE CTASCTES
      RECALL ALL
      ERASE 'TMPCTA.DBF'
   ENDIF
   STORE 7 TO LINEA
   STORE 0 TO VTOTAL
   RESTORE SCREEN FROM INICIO
ENDIF
RETURN
