USE VTASTMP
GO TOP

DO WHILE .T.
  IF LASTKEY()=27
  EXIT
  ELSE

XCANTIDAD=CANTIDAD*1000

VPRECIO=PRECIO/1.21
XPRECIO=VPRECIO*100
set decimal to
ROUND(XPRECIO,-1)
vprecio=alltrim(str(XPRECIO,0))

vcuit=alltrim(str(ncuit))
vcantidad=alltrim(str(XCANTIDAD))
vprecio=alltrim(str(XPRECIO,0))
? PRECIO
? VPRECIO
? CANTIDAD
? VCANTIDAD

INKEY(0)
SKIP
 ENDIF
LOOP
ENDDO
