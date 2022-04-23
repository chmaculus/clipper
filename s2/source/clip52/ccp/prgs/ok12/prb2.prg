USE VTASTMP
GO TOP
vcuit=alltrim(str(ncuit))
STORE 1 TO ITEMVEN
 DO WHILE .T.
  IF EOF()
  EXIT
  ELSE
XCANTIDAD=CANTIDAD*1000
XPRECIO=PRECIO*100
ROUND(XPRECIO,-1)
set decimal to
vcuit=alltrim(str(ncuit))
vcantidad=alltrim(str(XCANTIDAD))
vprecio=alltrim(str(XPRECIO,0))
? VPRECIO
? VCANTIDAD

? "Item Vendido N§",ITEMVEN
ITEMVEN=ITEMVEN+1
 SKIP
 LOOP
 ENDIF
ENDDO
