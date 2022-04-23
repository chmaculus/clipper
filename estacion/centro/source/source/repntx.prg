         USE MERCA
         INDEX ON CODIGO TO ORDCOD
         REINDEX
         INDEX ON DETALLE TO ORDDET
         REINDEX
         INDEX ON CODIGBARRA TO ORDBARRA
         REINDEX
         CLOSE
         USE STOCK
         INDEX ON CODIGO TO ORDCOD
         REINDEX
         USE MERCA
         INDEX ON CODIGBARRA TO ORDBARRA
         REINDEX
         INDEX ON DETALLE TO ORDDET
         REINDEX
         CLOSE
         USE GASTOS
         INDEX ON FECHA TO ORDFEC
         REINDEX
         CLOSE
         USE VENTAS
         INDEX ON NUMEROCAJA TO ORDCAJA
         REINDEX
         INDEX ON FECHA TO ORDFEC
         REINDEX
         CLOSE
         USE CAJAS
         INDEX ON NUMEROCAJA TO ORDCAJA
         REINDEX
         INDEX ON FECHA TO O_CAJFEC
         REINDEX
         CLOSE
         USE ACTUAL
         INDEX ON OPERADOR TO INDXNOM
         REINDEX
         CLOSE
         USE OPERA
         INDEX ON OPERADOR TO INDXNOM
         REINDEX
         CLOSE
         USE CLASIFIC
         INDEX ON ID TO ID_CLASI
