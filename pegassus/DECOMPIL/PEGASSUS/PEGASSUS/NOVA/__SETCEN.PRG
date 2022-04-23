#include "common.ch"
#include "inkey.ch"

********************************
function __SETCENTU(Arg1)

   local Local1, Local2, Local3, Local4, Local5
   Local2:= Upper(Set(_SET_DATEFORMAT))
   Local1:= "YYYY" $ Local2
   if (ISCHARACTER(Arg1))
      Arg1:= Upper(Arg1) = "ON"
   endif
   if (ISLOGICAL(Arg1) .AND. Arg1 != Local1)
      Local5:= At("Y", Local2)
      Local3:= SubStr(Local2, 1, Local5 - 1)
      do while (SubStr(Local2, Local5, 1) == "Y")
         Local5++
      enddo
      Local4:= SubStr(Local2, Local5)
      set date format to Local3 + iif(Arg1, "YYYY", "YY") + Local4
   endif
   return Local1

* EOF
