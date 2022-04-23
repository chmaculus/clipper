#include "common.ch"
#include "inkey.ch"

********************************
function __TSETCARG(Arg1)

   return qself()[1]:= Arg1

********************************
function __TSETCOLU(Arg1, Arg2)

   if (!(ISNIL(Arg1)) .AND. !(ISNIL(Arg2)))
      Arg1:= _einstvar(qself(), "COLUMN", Arg1, "N", 1001)
      qself()[6][Arg1]:= _einstvar(qself(), "COLUMN", Arg2, "O", 1001)
      qself():configure(2)
   endif
   return qself()

********************************
function __TCARGO

   return qself()[1]

********************************
function __TCOLUMN(Arg1)

   return qself()[6][Arg1]

********************************
function __TCOLCOUN

   return Len(qself()[6])

********************************
function __TSETRTOP(Arg1)

   if (!(ISNIL(Arg1)))
      qself()[2]:= _einstvar(qself(), "NTOP", Arg1, "N", 1001, 0, Nil)
      qself():configure(2)
   endif
   return qself()[2]

********************************
function __TSETRLEF(Arg1)

   if (!(ISNIL(Arg1)))
      qself()[3]:= _einstvar(qself(), "NLEFT", Arg1, "N", 1001, 0, ;
         Nil)
      qself():configure(2)
   endif
   return qself()[3]

********************************
function __TSETRBOT(Arg1)

   if (!(ISNIL(Arg1)))
      qself()[4]:= _einstvar(qself(), "NBOTTOM", Arg1, "N", 1001, ;
         qself():ntop(), Nil)
      qself():configure(2)
   endif
   return qself()[4]

********************************
function __TSETRRIG(Arg1)

   if (!(ISNIL(Arg1)))
      qself()[5]:= _einstvar(qself(), "NRIGHT", Arg1, "N", 1001, ;
         qself():nleft(), Nil)
      qself():configure(2)
   endif
   return qself()[5]

********************************
function __TSETHEAD(Arg1)

   if (!(ISNIL(Arg1)))
      qself()[7]:= _einstvar(qself(), "HEADSEP", Arg1, "C", 1001)
   endif
   return qself()[7]

********************************
function __TSETCOLS(Arg1)

   if (!(ISNIL(Arg1)))
      qself()[8]:= _einstvar(qself(), "COLSEP", Arg1, "C", 1001)
   endif
   return qself()[8]

********************************
function __TSETFOOT(Arg1)

   if (!(ISNIL(Arg1)))
      qself()[9]:= _einstvar(qself(), "FOOTSEP", Arg1, "C", 1001)
   endif
   return qself()[9]

********************************
function __TSETCOLO(Arg1)

   if (!(ISNIL(Arg1)))
      qself()[10]:= _einstvar(qself(), "COLORSPEC", Arg1, "C", 1001)
      qself():configure(1)
   endif
   return qself()[10]

********************************
function __TSETSKIP(Arg1)

   if (!(ISNIL(Arg1)))
      qself()[11]:= _einstvar(qself(), "SKIPBLOCK", Arg1, "B", 1001)
   endif
   return qself()[11]

********************************
function __TSETTOP(Arg1)

   if (!(ISNIL(Arg1)))
      qself()[12]:= _einstvar(qself(), "GOTOPBLOCK", Arg1, "B", 1001)
   endif
   return qself()[12]

********************************
function __TSETBOTT(Arg1)

   if (!(ISNIL(Arg1)))
      qself()[13]:= _einstvar(qself(), "GOBOTTOMBL", Arg1, "B", 1001)
   endif
   return qself()[13]

********************************
function __TADDCOLU(Arg1)

   AAdd(qself()[6], Arg1)
   qself():configure(2)
   return qself()

********************************
function __TINSCOLU(Arg1, Arg2)

   asize(qself()[6], Len(qself()[6]) + 1)
   ains(qself()[6], Arg1)
   qself()[6][Arg1]:= Arg2
   qself():configure(2)
   return Arg2

********************************
function __TDELCOLU(Arg1)

   local Local1
   Local1:= qself()[6][Arg1]
   adel(qself()[6], Arg1)
   asize(qself()[6], Len(qself()[6]) - 1)
   qself():configure(2)
   return Local1

********************************
function __CSETWIDT(Arg1)

   if (Arg1 != Nil)
      qself()[2]:= _einstvar(qself(), "WIDTH", Arg1, "N", 1001)
   endif
   return qself()[2]

********************************
function __CSETBLOC(Arg1)

   if (Arg1 != Nil)
      qself()[3]:= _einstvar(qself(), "BLOCK", Arg1, "B", 1001)
   endif
   return qself()[3]

********************************
function __CSETDEFC(Arg1)

   if (Arg1 != Nil)
      qself()[4]:= _einstvar(qself(), "DEFCOLOR", Arg1, "A", 1001)
   endif
   return qself()[4]

********************************
function __CSETCOLO(Arg1)

   if (Arg1 != Nil)
      qself()[5]:= _einstvar(qself(), "COLORBLOCK", Arg1, "B", 1001)
   endif
   return qself()[5]

********************************
function __CSETHEAD(Arg1)

   if (Arg1 != Nil)
      qself()[6]:= _einstvar(qself(), "HEADING", Arg1, "C", 1001)
   endif
   return qself()[6]

********************************
function __CSETFOOT(Arg1)

   if (Arg1 != Nil)
      qself()[10]:= _einstvar(qself(), "FOOTING", Arg1, "C", 1001)
   endif
   return qself()[10]

********************************
function __CSETHSEP(Arg1)

   local Local1
   if (Arg1 != Nil)
      Local1:= _einstvar(qself(), "HEADSEP", Arg1, "C", 1001)
   endif
   if (PCount() == 1)
      qself()[7]:= Local1
   endif
   return qself()[7]

********************************
function __CSETFSEP(Arg1)

   local Local1
   if (Arg1 != Nil)
      Local1:= _einstvar(qself(), "FOOTSEP", Arg1, "C", 1001)
   endif
   if (PCount() == 1)
      qself()[9]:= Local1
   endif
   return qself()[9]

********************************
function __CSETCOLS(Arg1)

   local Local1
   if (Arg1 != Nil)
      Local1:= _einstvar(qself(), "COLSEP", Arg1, "C", 1001)
   endif
   if (PCount() == 1)
      qself()[8]:= Local1
   endif
   return qself()[8]

********************************
function __CSETPICT(Arg1)

   if (!(ISNIL(Arg1)))
      qself()[11]:= Arg1
   endif
   return qself()[11]

********************************
function TBCOLUMNNE(Arg1, Arg2)

   local Local1[11]
   Local1[6]:= Arg1
   Local1[3]:= Arg2
   Local1[4]:= {1, 2}
   Local1[5]:= {|| Nil}
   Local1[8]:= Nil
   Local1[10]:= ""
   Local1[9]:= Nil
   Local1[7]:= Nil
   __totbcolu(Local1)
   return Local1

* EOF
