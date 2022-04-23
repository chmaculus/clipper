#include "common.ch"
#include "inkey.ch"

static Static1:= {}

********************************
function __ATPROMPT(Arg1, Arg2, Arg3, Arg4)

   AAdd(Static1, {Arg1, Arg2, Arg3, Arg4})
   SetPos(Arg1, Arg2)
   dispout(Arg3)
   return .F.

********************************
function __MENUTO(Arg1, Arg2)

   local Local1, Local2, Local3, Local4, Local5, Local6, Local7, ;
      Local8, Local9, Local10, Local11, Local12, Local13, Local14, ;
      Local15, Local16
   Local13:= Static1
   Local14:= Set(_SET_MESSAGE)
   Local15:= Set(_SET_MCENTER)
   Local16:= readvar(Upper(Arg2))
   Static1:= {}
   Local11:= errorblock({|_1| break(_1)})
   begin sequence
      Local2:= eval(Arg1)
      Local12:= .F.
   recover
      Local12:= .T.
   end sequence
   errorblock(Local11)
   if (Local12)
      __qqpub(Arg2)
   endif
   if (ValType(Local2) != "N" .OR. Local2 < 1)
      Local2:= 1
   endif
   if (Local2 > Len(Local13))
      Local2:= Len(Local13)
   endif
   if (Set(_SET_INTENSITY))
      Local8:= setcursor(0)
   endif
   Local7:= .F.
   Local6:= ""
   Local9:= 0
   do while (Local2 != 0)
      Local5:= 0
      Local1:= Local13[Local2]
      if (Set(_SET_INTENSITY))
         colorselec(1)
      endif
      SetPos(Local1[1], Local1[2])
      dispout(Local1[3])
      if (Set(_SET_INTENSITY))
         colorselec(0)
      endif
      if (Local14 != 0)
         if (!Empty(Local6))
            SetPos(Local14, Local9)
            dispout(Space(Len(Local6)))
         endif
         Local6:= Local1[4]
         if (ISBLOCK(Local6))
            Local6:= eval(Local6)
         elseif (ValType(Local6) == "U")
            Local6:= ""
         endif
         if (Local15)
            Local9:= Int((MaxCol() - Len(Local6)) / 2)
         endif
         SetPos(Local14, Local9)
         dispout(Local6)
         SetPos(Local1[1], Local1[2])
      endif
      if (Local7)
         exit
      endif
      do while (Local5 == 0)
         Local5:= InKey(0)
         if ((Local10:= SetKey(Local5)) != Nil)
            eval(Arg1, Local2)
            eval(Local10, procname(1), procline(1), Upper(Arg2))
            Local2:= eval(Arg1)
            Local5:= 0
         endif
      enddo
      if (Local2 > Len(Local13))
         Local2:= Len(Local13)
      endif
      do case
      case Local5 == 5 .OR. Local5 == 19
         if (--Local2 < 1)
            Local2:= iif(Set(_SET_WRAP), Len(Local13), 1)
         endif
      case Local5 == 24 .OR. Local5 == 4
         if (++Local2 > Len(Local13))
            Local2:= iif(Set(_SET_WRAP), 1, Len(Local13))
         endif
      case Local5 == 1
         Local2:= 1
      case Local5 == 6
         Local2:= Len(Local13)
      case Local5 == 18
         Local7:= .T.
      case Local5 == 3
         Local7:= .T.
      case Local5 == 13
         Local7:= .T.
      case Local5 == 27
         Local2:= 0
      otherwise
         Local4:= Upper(Chr(Local5))
         Local3:= ascan(Local13, {|_1| Local4 == ;
            Left(Upper(LTrim(_1[3])), 1)})
         if (Local3 != 0)
            Local2:= Local3
            Local7:= .T.
         endif
      endcase
      if (Local2 != 0)
         SetPos(Local1[1], Local1[2])
         dispout(Local1[3])
      endif
   enddo
   setcursor(Local8)
   eval(Arg1, Local2)
   if (Local12)
      release (Arg2)
   endif
   if (!Empty(Local16))
      readvar(Local16)
   endif
   SetPos(MaxRow() - 1, 0)
   return Local2

* EOF
