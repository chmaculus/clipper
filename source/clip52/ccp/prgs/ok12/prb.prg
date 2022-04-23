USE VTASTMP
GO TOP
XCANTIDAD=CANTIDAD*1000
XPRECIO=PRECIO*100
*ROUND(XCANTIDAD,-1)
ROUND(XPRECIO,-1)
set decimal to
? XPRECIO
? XCANTIDAD

vcuit=alltrim(str(ncuit))
vcanti=alltrim(str(XCANTIDAD))
vprecio=alltrim(str(XPRECIO,0))

? VPRECIO
? VCANTI
? ""
