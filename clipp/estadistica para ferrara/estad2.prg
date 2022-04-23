set date to french

store 0 to vcodven
store 0 to vtotali
store 0 to row
store 0 to sale
store "" to vfecha
store "" to vclase

public vcodven,vtotali,row,ir

set printer to salida.txt
*set device to print

use detven alias("base1")
use vended alias("base2")
select base2
? select()
use vended index 201 alias("base22")
quit
select(base1)
? select(0)
? "indexando por codigovendedor"
index on codven to 101u unique

?
? "indexando por codigovendedor"
index on codven to 101

?
? "indexando por fecha"
index on fecha to 102

?
? "indexando por codigoarticulo"
index on codart to 105u unique

?
? "indexando por clase"
index on clase to 109


select(1)
? 
? "indexando vendedore por codigo"
index on codigo to 201

?
? "run"

store 1 to ir
do while .t.
   use detven index 101u alias 3
   go ir
   store codven to vcodven
   cc1()

   if eof()=.t.
      exit
   endif

   store ir+1 to ir
   store row+1 to row
   loop
enddo


function cc1
   select(2)
   seek vcodven
   store nombre to vnombre

   store alltrim(vnombre) to vnombre
   store alltrim(str(vcodven)) to vcodven

   @row,0 say "vcod:"
   @row,7 say vcodven
   @row,10 say "nom:" 
   @row,18 say vnombre
   @row,40 say ir
return nil


function calcula
   store 1 to ir
   store 0 to sale
   store 100 to irr

   *use detven
   select(0)
   set index to 102,101u,109

   do while .t.
      *use detven
      select(0)
      set index to 102,101u,109
      go ir

      if ir=irr
         ?
         ? ir
         store irr+100 to irr
      endif
         
      if vcodven=codven
      else
         *use vended
         select(0)
         set index to 201
         seek vcodven
         store nombre to vnombre

         *use detven
         select(0)
         go ir

         store alltrim(vnombre) to vnombre
         store alltrim(str(vcodven)) to vcodven
         store alltrim(str(vtotali)) to vtotali
         
         @row,0 say "vcod:"
         @row,7 say vcodven
         @row,10 say "total:" 
         @row,18 say vtotali
         @row,26 say vfecha
         @row,35 say vclase
         @row,38 say vnombre
         store row+1 to row

         store codven to vcodven
         store 0 to vtotite
         store 0 to vtotali
      endif

      store fecha to vfecha
      store clase to vclase
      store totite to vtotite
      store vtotite+vtotali to vtotali

      if sale=1
         exit
      endif
      
      if eof()=.t.
         store 1 to sale
      endif

      store ir+1 to ir
      loop
   enddo

   set device to screen
return nil
