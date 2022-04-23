SAVE SCREEN TO ROMI
DO WHILE .T.
   SET COLOR TO BG/B
   @3,41 TO 8,53
   @4,42 CLEAR TO 7,52
   SET COLOR TO BG+/B
   @4,42 SAY ' Consultar '
   SET COLOR TO BG/B,W+/B
   @6,42 PROMPT ' FACTURA A '
   @7,42 PROMPT ' FACTURA B '
   PUBLIC OPC2
   MENU TO OPC2
   SET COLOR TO BG/B,W+/B
   DO CASE
      CASE OPC2=1
         USE FACT_A
      CASE OPC2=2
         USE FACT_B
      OTHERWISE
         RETURN
   ENDCASE
   INDEX ON FECHA TO ORDFEC
   GO TOP
   SET COLOR TO W+/B
   CLEAR
   SET CURSOR OFF
   @3,10 TO 23,69 DOUBLE 
   @6,11 to 6,68
   @17,11 to 17,68
   @4,11 CLEAR to 5,68
   @18,11 CLEAR to 22,68
   SET COLOR TO BG+/B
   @4,30 SAY 'CONSULTA DE FACTURAS' 
   @5,20 SAY '*** CENTRO PLASTICO  GENERAL ALVEAR ***'
   SET COLOR TO W+/B
   @7,11 CLEAR TO 16,68
   @18,11 CLEAR to 22,68
   @21,34 SAY '<   > Salir'
   SET COLOR TO BG+/B
   @19,31 SAY 'Datos de Facturas'
   @21,35 SAY 'ESC'
   DECLARE CAMP[12]
   CAMP[1]='NUMERO'
   CAMP[2]='FECHA'
   CAMP[3]='CLIENTE'
   CAMP[4]='DOMICILIO'
   CAMP[5]='TELEFONO'
   CAMP[6]='DNI'
   CAMP[7]='CUIT'
   CAMP[8]='SITUIVA'
   CAMP[9]='DETALLE'
   CAMP[10]='CANTIDAD'
   CAMP[11]='PRECIO'
   CAMP[12]='TOTAL'
   DECLARE CABEZ[13]
   CABEZ[1]='N§ factura'
   CABEZ[2]='Fecha'
   CABEZ[3]='Nombre del Cliente'
   CABEZ[4]='Domicilio del Cliente'
   CABEZ[5]='Tel‚fono'
   CABEZ[6]='Documento'
   CABEZ[7]='N§ de CUIT'
   CABEZ[8]='Iva'
   CABEZ[9]='Detalle de la Mercader¡a'
   CABEZ[10]='Cantidad'
   CABEZ[11]='Precio Unit'
   CABEZ[12]='Precio Total'
   DECLARE SEPAR[12]
   SEPAR[1]='Ä'
   SEPAR[2]='Ä'
   SEPAR[3]='Ä'
   SEPAR[4]='Ä'
   SEPAR[5]='Ä'
   SEPAR[6]='Ä'
   SEPAR[7]='Ä'
   SEPAR[8]='Ä'
   SEPAR[9]='Ä'
   SEPAR[10]='Ä'
   SEPAR[11]='Ä'
   SEPAR[12]='Ä'
   SET CURSOR OFF
   CLEAR TYPEAHEAD
   SET COLOR TO BG/B,B/W
   DBEDIT(7,11,16,68,CAMP,'FUNMIA','',CABEZ,SEPAR)
   RESTORE SCREEN FROM ROMI
   LOOP
ENDDO
