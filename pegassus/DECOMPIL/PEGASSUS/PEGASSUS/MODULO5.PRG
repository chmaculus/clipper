#include "common.ch"
#include "inkey.ch"

********************************
*procedure MODULO5


********************************
procedure FUN_51_1

   use EST01
   jcbox(7, 7, 12, 56, "N/W", 20, 1, .T., .F., .F., "W+/B", ;
      alltrim(&bas[opcj3][2]))
   if (iscolor())
      set color to N/W,W+/B
   endif
   jjbox(8, 9, 10, 22, "N/W", 20, 2, .F., .T., .T.)
   jjbox(10, 9, 12, 22, "N/W", 20, 3, .F., .T., .T.)
   opcfun:= 1
   do while (opcfun != 0)
      set message to 24 center
      if (iusuar)
         @  9, 25 say "Claves de acceso activadas   "
         @  9, 10 prompt " Desactivar "
      else
         @  9, 25 say "Claves de acceso desactivadas"
         @  9, 10 prompt "  Activar   "
      endif
      if (inoacc)
         @ 11, 25 say "Items sin acceso no visibles"
         @ 11, 10 prompt "  Mostrar   "
      else
         @ 11, 25 say "Items sin acceso visibles   "
         @ 11, 10 prompt "  Ocultar   "
      endif
      set wrap on
      menu to opcfun
      if (opcfun = 1)
         if (iusuar)
            replace usuarios with .F.
            iusuar:= usuarios
         else
            replace usuarios with .T.
            iusuar:= usuarios
         endif
      elseif (opcfun = 2)
         if (inoacc)
            replace col_acces with .F.
            inoacc:= col_acces
         else
            replace col_acces with .T.
            inoacc:= col_acces
         endif
      endif
   enddo
   close databases
   return

********************************
procedure FUN_51_2

   set default to (idireca)
   select 2
   use EST03 index NUMMOD3
   select 1
   use EST02
   nelem:= 0
   totlen:= Len(aestad) + Len(asmenu1) + Len(asmenu2) + Len(asmenu3) ;
      + Len(asmenu4) + Len(asmenu5) + Len(asmenu6)
   private aacceso[totlen, 5]
   private aacceso1[totlen]
   y:= 1
   o:= 1
   u:= 1
   for y:= 1 to Len(aestad)
      aacceso[u][1]:= 1
      aacceso[u][2]:= Str(y, 2)
      aacceso[u][3]:= Str(y, 2) + " " + aestad[y][2] + " => " + ;
         Str(aestad[y][6], 2)
      aacceso[u][4]:= aestad[y][6]
      aacceso[u][5]:= "AESTAD"
      aacceso1[u]:= " " + Str(y, 2) + ")Í" + ;
         SubStr(alltrim(Upper(aestad[y][2])) + Replicate("Í", 40), ;
         1, 36) + " => " + Str(aestad[y][6], 2)
      u:= u + 1
      nwbase:= "ASMENU" + Str(y, 1)
      o:= 1
      for o:= 1 to Len(&nwbase)
         aacceso[u][1]:= 2
         aacceso[u][2]:= Str(y, 2) + Str(o, 3)
         aacceso[u][3]:= "   " + Str(o, 2) + " " + &nwbase[o][2] + ;
            " => " + Str(&nwbase[o][4], 2)
         aacceso[u][4]:= &nwbase[o][4]
         aacceso[u][5]:= nwbase
         aacceso1[u]:= "        " + Str(o, 2) + "-" + &nwbase[o][2] ;
            + " => " + Str(&nwbase[o][4], 2)
         u:= u + 1
      next
   next
   col513:= "N/W*,W+/B"
   set key K_ENTER to modif
   keyboard Chr(24)
   achoi01("AACCESO1", 8, 10, 21, 60, 1, "N/W", "N/W", col513, ;
      alltrim(&bas[opcj3][2]))
   SetKey(K_ENTER, Nil)
   close databases
   set default to (idirec)
   select 1
   return

********************************
procedure FUN_51_3

   @ 24,  0
   use BASE001
   col513:= "N/W*,W+/B"
   brow01("' '+STR(RECNO(),2)+' '+USUARIO+' '+STR(NIV_ACCESO,2)+' '", ;
      " N§   " + SubStr(afrases[1], 1, 7) + "                   " + ;
      SubStr(afrases[5], 1, 5) + " ", 9, 15, 19, 56, 3, "N/W", ;
      "N/W", col513, alltrim(&bas[opcj3][2]), "ABM_USU", .T., ;
      "DEL_USU")
   close databases
   select 1
   return

********************************
procedure ABM_USU

   save screen to pabm_usu
   set color to N/W,R/W*
   @ 19, 16 say SubStr(afrases[1], 1, 8) + ;
      "                               "
   @ 21, 16 say SubStr(afrases[2], 1, 16) + "      " + ;
      SubStr(afrases[3], 1, 6) + "   ********"
   setcursor(1)
   @ 19, 25 get USUARIO picture "@!"
   @ 21, 33 get NIV_ACCESO picture "99"
   @ 21, 47 get CLAVE
   read
   setcursor(0)
   set color to (col513)
   restore screen from pabm_usu
   return

********************************
procedure DEL_USU

   replace usuario with Space(30)
   replace clave with "        "
   replace niv_acceso with 0
   return

********************************
procedure BROW01

   colbrow:= SetColor()
   parameters campos, titulo, barr1, bizq1, baba1, bder1, talon, ;
      bcol1, bcol2, bcol3, titu, bfunc1, borro, bfunc2
   private aprov[1]
   private tit1[1]
   aprov:= {campos}
   tit1:= {titulo}
   jcbox(barr1, bizq1, baba1 + talon, bder1, bcol1, 20, 1, .T., .F., ;
      .F., "W+/B", titu)
   jjbox(barr1 + 1, bizq1 + 1, baba1 - 1, bder1 - 1, bcol2, 20, 4, ;
      .F.)
   set color to (bcol1)
   if (borro)
      @ baba1, bizq1 + 2 say SubStr(afrases[4], 1, 7)
   endif
   @ baba1, bizq1 + 12 say SubStr(afrases[6], 1, 14)
   set color to (bcol3)
   dbedit(barr1 + 2, bizq1 + 2, baba1 - 2, bder1 - 2, aprov, ;
      "funprov", .T., tit1)
   set color to (colbrow)
   return

********************************
function FUNPROV(Arg1, Arg2)

   alfa:= aprov[Arg2]
   do case
   case Arg1 = 0 .OR. Arg1 = 1
      return 1
   case LastKey() = 66 .OR. LastKey() = 98
      if (borro)
         &bfunc2()
      endif
      return 1
   case LastKey() = K_ESC
      return 0
   case LastKey() = K_ENTER
      &bfunc1()
      return 1
   case Arg1 = 2
      return 1
   case Arg1 = 3
      return 1
   otherwise
      return 1
   endcase
   return 1

********************************
procedure MODIF

   SetKey(K_ENTER, Nil)
   h:= Row()
   save screen to pmod_acc
   set color to N/W,R/W*
   qniv:= aacceso[nelem][4]
   setcursor(1)
   @ baba1, bizq1 + 3 say "Ingrese Nivel de acceso: " get qNiv ;
      picture "99"
   read
   setcursor(0)
   if (LastKey() != K_ESC)
      linx:= aacceso1[nelem]
      linx:= SubStr(linx, 1, Len(linx) - 2) + Str(qniv, 2)
      aacceso1[nelem]:= linx
      aacceso[nelem][4]:= qniv
      if (aacceso[nelem][1] == 2)
         fbs:= aacceso[nelem][5]
         &fbs[Val(SubStr(aacceso[nelem][2], 3, 3))][4]:= qniv
         select 2
         seek aacceso[nelem][2]
         if (Found())
            replace niv_acceso with qniv
         endif
         select 1
      else
         aestad[Val(aacceso[nelem][2])][6]:= qniv
         select 1
         goto top
         locate for nro_modulo = Val(aacceso[nelem][2])
         if (!EOF())
            replace niv_acceso with qniv
         endif
      endif
      if (nelem == 1)
         keyboard Chr(24) + Chr(5)
      else
         keyboard Chr(5) + Chr(24)
      endif
   endif
   restore screen from pmod_acc
   set color to (col513)
   set key K_ENTER to modif
   return

********************************
procedure FUN_53_2

   @ 24,  0
   use BASE002
   far:= 3
   fiz:= 10
   jcbox(far, fiz, far + 17, fiz + 49, "N/W", 20, 1, .T., .F., .F., ;
      "W+/B", "Datos del Titular")
   jjbox(far + 1, fiz + 17, far + 3, fiz + 48, "N/W", 20, 4, .F.)
   jjbox(far + 3, fiz + 17, far + 5, fiz + 48, "N/W", 20, 7, .F.)
   jjbox(far + 5, fiz + 17, far + 7, fiz + 48, "N/W", 20, 7, .F.)
   jjbox(far + 7, fiz + 17, far + 11, fiz + 48, "N/W", 20, 7, .F.)
   jjbox(far + 11, fiz + 17, far + 17, fiz + 48, "N/W", 20, 6, .F.)
   set color to N/W
   dato1:= comercio
   dato2:= empresa
   dato3:= dequien
   dato4:= direccion
   dato5:= localidad
   dato6:= provincia
   dato7:= cuit
   dato8:= ibruto
   dato9:= estable
   dato10:= timbrado
   dato11:= codact
   set color to N/W,R/W*
   @ far + 2, fiz + 2 say SubStr(afrases[7], 1, 15) get dato1 valid ;
      Len(alltrim(dato1)) > 0
   @ far + 4, fiz + 2 say SubStr(afrases[8], 1, 15) get dato2 valid ;
      Len(alltrim(dato2)) > 0
   @ far + 6, fiz + 2 say SubStr(afrases[9], 1, 15) get dato3
   @ far + 8, fiz + 2 say SubStr(afrases[10], 1, 15) get dato4
   @ far + 9, fiz + 2 say SubStr(afrases[11], 1, 15) get dato5
   @ far + 10, fiz + 2 say SubStr(afrases[12], 1, 15) get dato6
   @ far + 12, fiz + 2 say SubStr(afrases[13], 1, 15) get dato7
   @ far + 13, fiz + 2 say SubStr(afrases[14], 1, 15) get dato8
   @ far + 14, fiz + 2 say SubStr(afrases[15], 1, 15) get dato9
   @ far + 15, fiz + 2 say SubStr(afrases[16], 1, 15) get dato10
   @ far + 16, fiz + 2 say SubStr(afrases[17], 1, 15) get dato11
   read
   resp:= " "
   if (LastKey() != K_ESC)
      confirm0(19, 42)
      if (resp = "S")
         replace comercio with dato1
         replace empresa with dato2
         replace dequien with dato3
         replace direccion with dato4
         replace localidad with dato5
         replace provincia with dato6
         replace cuit with dato7
         replace ibruto with dato8
         replace estable with dato9
         replace timbrado with dato10
         replace codact with dato11
      endif
   endif
   return

********************************
procedure FUN_53_1

   opbasexc("BASE013")
   nelem:= 0
   private estac[5]
   y:= 1
   for y:= 1 to 5
      estac[y]:= Str(numero, 2) + " " + puerto + "ÄÄ>" + nombre + ;
         " " + impresor
      skip 
   next
   totlen:= Len(estac)
   col513:= "N/W*,W+/B"
   set key K_ENTER to modif531
   keyboard Chr(24)
   achoi01("ESTAC", 8, 8, 16, 73, 3, "N/W", "N/W", col513, ;
      "Estaciones de impresi¢n")
   SetKey(K_ENTER, Nil)
   select 1
   close
   opbassha("BASE013")
   private impresoras[0, 9]
   goto top
   y:= 1
   for y:= 1 to 5
      AAdd(impresoras, {numero, puerto, nombre, impresor, comp_1, ;
         comp_0, largo_1, largo_0, registro})
      skip 
   next
   close
   select 1
   return

********************************
procedure MODIF531

   goto top
   locate for RecNo() = nelem
   enureg:= registro
   SetKey(K_ENTER, Nil)
   olcol:= SetColor()
   save screen to pm531
   nest:= Val(SubStr(estac[nelem], 1, 2))
   setcursor(1)
   do while (.T.)
      set color to N/W,R/W*
      dato0:= registro
      dato1:= nombre
      dato2:= impresor
      dato3:= comp_1
      dato4:= comp_0
      dato5:= largo_1
      dato6:= largo_0
      @ 16, 11 say "                                 (BORRAR=Elimina)"
      @ 17, 11 say "Impresora:                            "
      @ 16, 11 say "Nombre   :" get dato1 picture "@!" valid ;
         Len(alltrim(dato1)) > 0
      read
      if (LastKey() == K_ESC)
         exit
      endif
      if (nelem <= 2)
         if (alltrim(dato1) = "BORRAR")
            dato0:= 0
            dato1:= Space(20)
            dato2:= Space(20)
         else
            select 2
            opbassha("FISCAL")
            if (enureg > 0)
               locate for numero = enureg
               if (EOF())
                  goto top
               endif
            endif
            campy:= "SUBSTR(STR(NUMERO,3)+' '+NOMBRE,1,35)"
            cuanhay:= LastRec()
            save screen to p13_2
            boxshadow(16, 10, 16, 19)
            brow03(campy, 14, 22, "N/BG", "N/BG,W+/R", "NOME", 2)
            restore screen from p13_2
            dato0:= numero
            dato2:= nombre
            set color to R/W*
            @ 17, 22 say dato2
            close
            select 1
            if (LastKey() == K_ESC)
               loop
            endif
         endif
      elseif (alltrim(dato1) = "BORRAR")
         dato0:= 0
         dato1:= Space(20)
         dato2:= Space(20)
         dato3:= Space(80)
         dato4:= Space(80)
         dato5:= Space(80)
         dato6:= Space(80)
      else
         select 2
         opbassha("PRINTER")
         if (enureg > 0)
            locate for numero = enureg
            if (EOF())
               goto top
            endif
         endif
         campy:= "SUBSTR(STR(NUMERO,3)+' '+NOME,1,35)"
         cuanhay:= LastRec()
         save screen to p13_2
         boxshadow(16, 10, 16, 19)
         brow03(campy, 8, 22, "N/BG", "N/BG,W+/R", "NOME", 2)
         restore screen from p13_2
         dato0:= numero
         dato2:= nome
         dato3:= comp_1
         dato4:= comp_0
         dato5:= largo_1
         dato6:= largo_0
         set color to R/W*
         @ 17, 22 say dato2
         close
         select 1
         if (LastKey() == K_ESC)
            loop
         endif
      endif
      resp:= " "
      confirm0(19, 42)
      if (resp = "S")
         replace nombre with dato1
         replace impresor with dato2
         replace comp_1 with dato3
         replace comp_0 with dato4
         replace largo_1 with dato5
         replace largo_0 with dato6
         replace registro with dato0
         estac[nelem]:= Str(numero, 2) + " " + puerto + "ÄÄ>" + ;
            nombre + " " + impresor
         keyboard Chr(19)
      endif
      exit
   enddo
   setcursor(0)
   set key K_ENTER to modif531
   set color to (olcol)
   restore screen from pm531
   return

********************************
procedure FUN_52_1

   alert("Copia de seguridad actualizada")
   return

********************************
procedure FUN_52_2

   alert("Copia de seguridad actualizada")
   return

* EOF
