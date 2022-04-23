#include "common.ch"
#include "inkey.ch"

********************************
function GETNEW(Arg1, Arg2, Arg3, Arg4, Arg5, Arg6)

   local Local1[10]
   default Arg4 to ""
   default Arg6 to .T.
   __toget(Local1)
   Local1:row(Arg1)
   Local1:col(Arg2)
   Local1[1]:= Arg3
   Local1[7]:= Arg4
   Local1[3]:= Arg5
   Local1:colorspec(Arg6)
   return Local1

********************************
function __GETHASFO

   return Len(qself()) == 13

********************************
function __GETBUFFE

   return iif(Len(qself()) == 13, qself()[12], Nil)

********************************
function __GETORIGI

   return iif(Len(qself()) == 13, qself()[13], Nil)

********************************
function __GETSETCA(Arg1)

   if (PCount() == 1)
      qself()[6]:= Arg1
   endif
   return qself()[6]

********************************
function __GETSETBL(Arg1)

   if (!(ISNIL(Arg1)))
      qself()[1]:= Arg1
   endif
   return qself()[1]

********************************
function __GETSETNA(Arg1)

   if (!(ISNIL(Arg1)))
      qself()[7]:= Arg1
   endif
   return qself()[7]

********************************
function __GETSETPI(Arg1)

   if (!(ISNIL(Arg1)))
      qself()[3]:= Arg1
   endif
   return qself()[3]

********************************
function __GETSETPB(Arg1)

   if (!(ISNIL(Arg1)))
      qself()[4]:= Arg1
   endif
   return qself()[4]

********************************
function __GETSETPR(Arg1)

   if (!(ISNIL(Arg1)))
      qself()[5]:= Arg1
   endif
   return qself()[5]

********************************
function __GETSETSU(Arg1)

   if (!(ISNIL(Arg1)))
      qself()[2]:= Arg1
   endif
   return qself()[2]

********************************
function __GETSETEX(Arg1)

   if (!(ISNIL(Arg1)))
      qself()[9]:= Arg1
   endif
   return qself()[9]

********************************
function __GETSETRE(Arg1)

   if (!(ISNIL(Arg1)))
      qself()[10]:= Arg1
   endif
   return qself()[10]

********************************
function __GETSETBU(Arg1)

   return iif(Len(qself()) == 13, qself()[12]:= Arg1, Arg1)

********************************
function __GETBADDA

   local Local1
   if ((Local1:= qself():untransfor(), Len(qself()) == 13 .AND. ;
         qself():type() == "D" .AND. Local1 == CToD("") .AND. ;
         !(qself()[12] == Transform(Local1, qself()[3]))))
      return .T.
   endif
   return .F.

********************************
function __GETUNDO

   if (Len(qself()) == 13)
      qself():varput(qself()[13])
      qself():reset()
      qself():changed(.F.)
   endif
   return qself()

********************************
function __GETTODEC

   local Local1
   if (Len(qself()) == 13)
      if (qself():clear())
         qself():delend()
      endif
      qself():reform()
      qself():pos(qself():decpos())
      qself():changed(.T.)
      if (qself():untransfor() == 0 .AND. qself():minus())
         qself():backspace()
         qself():overstrike("-")
      endif
      qself():display()
   endif
   return qself()

********************************
function __GETDWLEF

   qself():wordleft()
   qself():delwordrig()
   return qself()

* EOF
