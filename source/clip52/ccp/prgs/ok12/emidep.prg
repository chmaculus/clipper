SET COLOR TO W+/B
CLEAR
STORE DATE() TO VFEC,VFEM
STORE 0 TO VIMP
DO WHILE .T.
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
   @3,0 TO 5,36
   SET COLOR TO BG+/B
   @4,3 SAY 'PANTALLA DE EMISION DE DEPOSITO'
   @1,LL SAY VFECHA
   SET CURSOR ON
   @6,0 SAY REPLICATE('Ä',79)
   SET COLOR TO BG/B,B/W
   @7,6 SAY 'Ingrese Fecha de Emisi¢n:ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ>'GET VFEM PICTURE '  /  /  '
   READ
   IF LASTKEY()=27
      RETURN
   ENDIF
   @8,0 SAY REPLICATE('Ä',79)
   SAVE SCREEN TO JOLI
   SET COLOR TO BG/B
   @12,23 TO 14,49
   SET COLOR TO BG/B,W+/B
   @13,25 PROMPT 'EFECTIVO'
   @13,35 PROMPT 'CHEQUE'
   @13,43 PROMPT 'AMBOS'
   PUBLIC OPC2
   MENU TO OPC2
   SET COLOR TO BG/B,W+/B
   STORE 0 TO SONCHE
   RESTORE SCREEN FROM JOLI
   DO CASE
      CASE OPC2=1
         SET COLOR TO BG/B,B/W
         @9,6 SAY 'Ingrese Importe a Depositar:ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ>'GET VIMP PICTURE '999999.99'
         READ
         IF LASTKEY()=27
            RETURN
         ENDIF
         @10,0 SAY REPLICATE('Ä',79)
      CASE OPC2=2
         SET COLOR TO BG/B,B/W
         @14,20 SAY '¨ Cuantos Cheques Depositar  ?'GET SONCHE PICTURE '99'RANGE 1,7
         READ
         IF LASTKEY()=27
            RETURN
         ENDIF
         @14,0
         @10,0 TO 13+SONCHE,79
         @12,1 TO 12,78
         @9,30 SAY 'Datos de los Cheques'
         @11,1 SAY '          Banco          ³  N£mero  ³          Firma          ³   Importes'
         FOR H=1 TO SONCHE
             STORE 'BCO'+ALLTRIM(STR(H)) TO VB
             STORE 'NUM'+ALLTRIM(STR(H)) TO VN
             STORE 'FIR'+ALLTRIM(STR(H)) TO VF
             STORE 'IMP'+ALLTRIM(STR(H)) TO VI
             STORE SPACE(25) TO &VB,&VF
             STORE SPACE(10) TO &VN
             STORE 0 TO &VI
             @12+H,1 SAY '                         ³          ³                         ³'
             @12+H,0 SAY ''GET &VB PICTURE '@!'
             @12+H,26 SAY ''GET &VN PICTURE '@!'
             @12+H,37 SAY ''GET &VF PICTURE '@!'
             @12+H,66 SAY ''GET &VI PICTURE '99999.99'
             READ
         NEXT
      CASE OPC2=3
         STORE 0 TO SONCHE
         SET COLOR TO BG/B,B/W
         @14,20 SAY '¨ Cuantos Cheques Depositar  ?'GET SONCHE PICTURE '99'RANGE 1,7
         READ
         IF LASTKEY()=27
            RETURN
         ENDIF
         @14,0
         @10,0 TO 13+SONCHE,79
         @12,1 TO 12,78
         @9,30 SAY 'Datos de los Cheques'
         @11,1 SAY '          Banco          ³  N£mero  ³          Firma          ³   Importes'
         FOR H=1 TO SONCHE
             STORE 'BCO'+ALLTRIM(STR(H)) TO VB
             STORE 'NUM'+ALLTRIM(STR(H)) TO VN
             STORE 'FIR'+ALLTRIM(STR(H)) TO VF
             STORE 'IMP'+ALLTRIM(STR(H)) TO VI
             STORE SPACE(25) TO &VB,&VF
             STORE SPACE(10) TO &VN
             STORE 0 TO &VI
             @12+H,1 SAY '                         ³         ³                         ³'
             @12+H,0 SAY ''GET &VB PICTURE '@!'
             @12+H,26 SAY ''GET &VN PICTURE '@!'
             @12+H,37 SAY ''GET &VF PICTURE '@!'
             @12+H,66 SAY ''GET &VI PICTURE '99999.99'
             READ
         NEXT
         SET COLOR TO BG/B,B/W
         @13+H,0 SAY REPLICATE('Ä',79)
         H=H+1
         @13+H,6 SAY 'Ingrese Importe en Efectivo:ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ>'GET VIMP PICTURE '999999.99'
         READ
         IF LASTKEY()=27
            RETURN
         ENDIF
         H=H+1
         @13+H,0 SAY REPLICATE('Ä',79)
      OTHERWISE
         RETURN
   ENDCASE
   SET COLOR TO W+/B
   SAVE SCREEN TO PANLISTO
   SET CURSOR OFF
   @24,25 SAY '¨ Guardar  Movimiento (S/N) ?'
   SET COLOR TO *R+/B
   @24,48 SAY 'S'
   @24,50 SAY 'N'
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
      USE BANCOS
      IF OPC2=1
         APPEND BLANK
         REPLACE FECHA WITH VFEC,DEPOSITO WITH ' ',CATEGORIA WITH 'D'
         REPLACE IMPORTE WITH VIMP
      ELSEIF OPC2=2
         FOR H=1 TO SONCHE
             STORE 'BCO'+ALLTRIM(STR(H)) TO VB
             STORE 'NUM'+ALLTRIM(STR(H)) TO VN
             STORE 'FIR'+ALLTRIM(STR(H)) TO VF
             STORE 'IMP'+ALLTRIM(STR(H)) TO VI
             APPEND BLANK
             REPLACE FECHA WITH VFEC,DEPOSITO WITH ' ',CATEGORIA WITH 'D'
             REPLACE IMPORTE WITH 0,TER_IMP WITH &VI,TER_BAN WITH &VB
             REPLACE TER_NUM WITH &VN,TER_DES WITH &VF
         NEXT
      ELSEIF OPC2=3
         FOR H=1 TO SONCHE
             STORE 'BCO'+ALLTRIM(STR(H)) TO VB
             STORE 'NUM'+ALLTRIM(STR(H)) TO VN
             STORE 'FIR'+ALLTRIM(STR(H)) TO VF
             STORE 'IMP'+ALLTRIM(STR(H)) TO VI
             APPEND BLANK
             REPLACE FECHA WITH VFEC,DEPOSITO WITH ' ',CATEGORIA WITH 'D'
             REPLACE IMPORTE WITH 0,TER_IMP WITH &VI,TER_BAN WITH &VB
             REPLACE TER_NUM WITH &VN,TER_DES WITH &VF
         NEXT
         APPEND BLANK
         REPLACE FECHA WITH VFEC,DEPOSITO WITH ' ',CATEGORIA WITH 'D'
         REPLACE IMPORTE WITH VIMP
      ENDIF
   ENDIF
   STORE DATE() TO VFEC,VFEM
   STORE 0 TO VIMP
   CLEAR
   LOOP
ENDDO
