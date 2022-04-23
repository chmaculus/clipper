#include "common.ch"
#include "inkey.ch"

********************************
procedure CARGATECLA

   set key K_F1 to tf1
   set key K_F2 to tf2
   set key K_F3 to tf3
   set key K_F4 to tf4
   set key K_F5 to tf5
   set key K_F6 to tf6
   set key K_F7 to tf7
   set key K_F8 to tf8
   return

********************************
procedure DESCATECLA

   SetKey(K_F1, Nil)
   SetKey(K_F2, Nil)
   SetKey(K_F3, Nil)
   SetKey(K_F4, Nil)
   SetKey(K_F5, Nil)
   SetKey(K_F6, Nil)
   SetKey(K_F7, Nil)
   SetKey(K_F8, Nil)
   return

********************************
procedure FLOGO

   parameters larr, lizq, lcol1, lcol2, lcol3, lmarc, lcol4
   viecol:= SetColor()
   if (lmarc)
      set color to (lcol4)
      jjbox(larr - 1, lizq - 1, larr + 1, lizq + 3, lcol4, 20, 4, .F.)
   endif
   set color to (lcol1)
   @ larr, lizq say "¬"
   set color to (lcol2)
   @ larr, lizq + 1 say "®"
   set color to (lcol3)
   @ larr, lizq + 2 say "¬"
   set color to (viecol)
   return

********************************
procedure CANCELA0

   parameters par, piz
   confcol:= SetColor()
   confir:= 2
   loncf1:= Len(alltrim("Contin£a"))
   loncf2:= Len(alltrim("Cancela"))
   do while (confir != 0)
      jjbox(par, piz, par + 2, piz + loncf1 + loncf2 + 6 + 1, ;
         "W+/R", 20, 5, .T.)
      set color to W+/R,W+/B
      @ par + 1, piz + 2 prompt " " + alltrim("Contin£a") + " "
      @ par + 1, piz + 2 + loncf1 + 2 prompt " " + ;
         alltrim("Cancela") + " "
      set wrap on
      menu to confir
      if (confir = 1)
         resp:= "S"
         exit
      elseif (confir = 2)
         resp:= "N"
         exit
      endif
   enddo
   set color to (confcol)
   return

********************************
procedure BROW02

   colbrow:= SetColor()
   parameters campos, coord, talon, bcol1, bcol2, cref, tref
   barr1:= coord
   bizq1:= 75 - Len(&campos) - 1
   baba1:= 23 - talon
   bder1:= 75
   private aprov[1]
   private tit1[1]
   aprov:= {campos}
   tit1:= {" " + alltrim(afrases[39])}
   jjbox(barr1, bizq1, baba1 + talon, bder1, bcol1, 20, 1, .T.)
   set color to (bcol1)
   @ baba1 + 1, bizq1 + 2 say alltrim(afrases[38])
   set color to (bcol2)
   dbedit(barr1 + 1, bizq1 + 1, baba1, bder1 - 1, aprov, "funprov2", ;
      .T., tit1)
   set color to (colbrow)
   return

********************************
procedure ACHOI02

   colbrow:= SetColor()
   parameters bloke, barr1, bizq1, baba1, bder1, bcol, shad
   if (shad == 0)
      jjbox(barr1, bizq1, baba1, bder1, bcol, 20, 1, .F.)
   else
      jjbox(barr1, bizq1, baba1, bder1, bcol, 20, 1, .T.)
   endif
   set color to (bcol)
   set color to (bcol)
   achoice(barr1 + 1, bizq1 + 1, baba1 - 1, bder1 - 1, &bloke, .T., ;
      "UserFun2")
   set color to (colbrow)
   return

********************************
procedure FUN_15_1

   set confirm on
   private opcion[3]
   opcion[1]:= "E: Edita  "
   opcion[2]:= "M: Muestra"
   opcion[3]:= "O: Oculta "
   opbasexc("BASE014", "BASE014A")
   z:= LastRec()
   private comprob[z]
   goto top
   y:= 1
   for y:= 1 to z
      comprob[y]:= Str(numero, 2) + " " + nombre
      skip 
   next
   opbasexc("BASE015", "BASE015A")
   z:= LastRec()
   private condven[z]
   goto top
   y:= 1
   for y:= 1 to z
      condven[y]:= Str(numero, 2) + " " + nombre
      skip 
   next
   opbasexc("BASE008", "BASE008A")
   z:= LastRec()
   private codvend[z]
   goto top
   y:= 1
   for y:= 1 to z
      codvend[y]:= Str(numero, 2) + " " + nombre
      skip 
   next
   opbasexc("BASE012", "BASE012A")
   z:= LastRec()
   private coddepo[z]
   goto top
   y:= 1
   for y:= 1 to z
      coddepo[y]:= Str(numero, 2) + " " + nombre
      skip 
   next
   opbasexc("BASE010", "BASE010A")
   z:= LastRec()
   private lista[z]
   goto top
   y:= 1
   for y:= 1 to z
      lista[y]:= Str(numero, 2) + " " + nombre
      skip 
   next
   close
   private credit[3]
   credit[1]:= "A confirmar"
   credit[2]:= "Estricto   "
   credit[3]:= "Ignora     "
   @ 24,  0
   far:= 0
   fiz:= 1
   fab:= 22
   fde:= 70
   ancho1:= 20
   ancho2:= 44
   l1:= far + 2
   l2:= far + 3
   l4:= far + 4
   l5:= far + 5
   l6:= far + 6
   l7:= far + 7
   l8:= far + 8
   l9:= far + 9
   l10:= far + 10
   l11:= far + 11
   l12:= far + 12
   l13:= far + 13
   l14:= far + 14
   l15:= far + 15
   l16:= far + 16
   l17:= far + 17
   l18:= far + 18
   l19:= far + 19
   l20:= far + 20
   l21:= far + 21
   set color to N/W
   jcbox(far, fiz, fab, fde, "N/W", 20, 1, .T., .F., .T., "W+/B", ;
      alltrim(&bas[opcj3][2]))
   jjbox(fab, fiz, fab, fde, "W/B", 20, 5, .F.)
   jjbox(far + 1, fiz + ancho1 + 2, far + 13, fiz + ancho1 + ancho2 ;
      + 3, "N/W", 20, 4, .F.)
   jjbox(far + 13, fiz + ancho1 + 2, far + 19, fiz + ancho1 + ancho2 ;
      + 3, "N/W", 20, 7, .F.)
   jjbox(far + 19, fiz + ancho1 + 2, far + 21, fiz + ancho1 + ancho2 ;
      + 3, "N/W", 20, 6, .F.)
   select 2
   opbassha("BASE009", "BASE009A")
   select 1
   opbasexc("BASE016", "BASE016A")
   goto bottom
   ultnum:= numero
   goto top
   opc27:= 1
   do while (opc27 != 0)
      setblink(.F.)
      ver_15_1()
      set message to 24 center
      set color to R/W*,R/W*
      @ 24,  0 say ;
         "                                                                                "
      set color to W+/B,B/W*
      abm_p151(fab, fiz)
      set wrap on
      menu to opc27
      do case
      case opc27 = 1
         set color to R/W*,R/W*
         save screen to pantabm
         aca:= numero
         dato1:= ultnum + 1
         dato2:= Space(30)
         dato3a:= " "
         dato3b:= 0
         dato4a:= 0
         dato4b:= Space(30)
         dato5a:= " "
         dato6a:= " "
         dato6b:= 0
         dato7a:= " "
         dato7b:= 0
         dato8a:= " "
         dato8b:= 0
         dato10a:= " "
         dato10b:= 0
         dato11a:= 0
         dato12a:= " "
         dato13a:= " "
         dato13b:= 0
         dato14a:= " "
         dato15a:= " "
         dato16a:= " "
         dato17a:= " "
         dato18a:= " "
         mtr15_1()
         do while (.T.)
            set color to R/W*,R/W*
            @ l1, fiz + ancho1 + 3 get dato1 picture "99" valid ;
               dato1 > 0 .AND. dato1 <= 10
            read
            if (LastKey() = K_ESC .OR. dato1 = 0)
               alert(alltrim(afrases[35]))
               exit
            endif
            seek dato1
            if (Found())
               alert(alltrim(afrases[36]))
               dato1:= 0
               loop
            endif
            do while (.T.)
               set key K_ENTER to ord_15_1
               set key K_F10 to f10_15_1
               get15_1()
               read
               SetKey(K_ENTER, Nil)
               SetKey(K_F10, Nil)
               if (LastKey() == K_ESC)
                  alert(alltrim(afrases[35]))
                  seek aca
                  exit
               endif
               exit
            enddo
            if (LastKey() == K_ESC)
               seek aca
               exit
            endif
            resp:= " "
            confirm0(15, 35)
            if (resp = "S")
               append blank
               rpl15_1()
               goto bottom
               ultnum:= numero
               seek dato1
            else
               seek aca
            endif
            exit
         enddo
         restore screen from pantabm
      case opc27 = 2
         save screen to pantabm
         resp:= " "
         refperf:= numero
         confirm0(15, 35)
         if (resp = "S")
            delete
            pack
            goto bottom
            ultnum:= numero
            select 3
            opbasexc("BASE001")
            xperf:= "PERFIL" + alltrim(Str(refperf, 2))
            DBEval(&("{|| _FIELD->&XPERF := 0}"), Nil, Nil, Nil, ;
               Nil, .F.)
            close
            select 1
         endif
         restore screen from pantabm
      case opc27 = 3
         set color to R/W*,R/W*
         save screen to pantabm
         aca:= numero
         dato1:= numero
         dato2:= nombre
         dato3a:= var3a
         dato3b:= var3b
         dato4a:= var4a
         dato4b:= var4b
         dato5a:= var5a
         dato6a:= var6a
         dato6b:= var6b
         dato7a:= var7a
         dato7b:= var7b
         dato8a:= var8a
         dato8b:= var8b
         dato10a:= var10a
         dato10b:= var10b
         dato11a:= var11a
         dato12a:= var12a
         dato13a:= var13a
         dato13b:= var13b
         dato14a:= var14a
         dato15a:= var15a
         dato16a:= var16a
         dato17a:= var17a
         dato18a:= var18a
         mtr15_1()
         do while (.T.)
            set color to R/W*,R/W*
            set key K_ENTER to ord_15_1
            set key K_F10 to f10_15_1
            get15_1()
            read
            SetKey(K_ENTER, Nil)
            SetKey(K_F10, Nil)
            if (LastKey() == K_ESC)
               alert(alltrim(afrases[35]))
               seek aca
               exit
            endif
            resp:= " "
            confirm0(15, 30)
            if (resp = "S")
               rpl15_1()
            else
               seek aca
            endif
            exit
         enddo
         restore screen from pantabm
      case opc27 = 4
      case opc27 = 5
         aca:= numero
         save screen to pantabm
         campos:= "SUBSTR(STR(NUMERO,3)+' '+NOMBRE,1,34)"
         brow02(campos, 10, 3, "N/BG+", "N/W*,W+/R", "numero", 1)
         if (LastKey() == K_ESC)
            seek aca
         endif
         restore screen from pantabm
      case opc27 = 6
         save screen to pantabm
         skip 
         if (EOF())
            goto bottom
         endif
         restore screen from pantabm
      case opc27 = 7
         save screen to pantabm
         skip -1
         restore screen from pantabm
      case opc27 = 8
         save screen to pantabm
         refperf:= numero
         nomperf:= nombre
         asig15_1()
         restore screen from pantabm
      endcase
   enddo
   set color to (icolora)
   return

********************************
procedure VER_15_1

   set color to N/W
   @ l1, fiz + 2 say "C¢digo de perfil   :"
   @ l2, fiz + 2 say "Descripci¢n        :"
   @ l4, fiz + ancho1 + 3 say "Config.   Valores por defecto"
   @ l5, fiz + 2 say "Tipo comprobante   :"
   @ l6, fiz + 2 say "Cliente            :"
   @ l7, fiz + 2 say "Bonific. al cliente:"
   @ l8, fiz + 2 say "Condici¢n de venta :"
   @ l9, fiz + 2 say "C¢digo del vendedor:"
   @ l10, fiz + 2 say "C¢digo del dep¢sito:"
   @ l11, fiz + 2 say "Lista de precios   :"
   @ l12, fiz + 2 say "L¡mite de cr‚dito  :"
   @ l14, fiz + 2 say "Carga r pida       :"
   @ l15, fiz + 2 say "Cantidad del art¡c.:"
   @ l16, fiz + 2 say "Precio de art¡culo :"
   @ l17, fiz + 2 say "% bonific.del art¡c:"
   @ l18, fiz + 2 say "Edita descrip.¡tem?:"
   @ l20, fiz + 2 say "Edita leyenda?     :"
   set color to B/W*
   @ l1, fiz + ancho1 + 3 say numero picture "99"
   @ l2, fiz + ancho1 + 3 say nombre
   @ l5, fiz + ancho1 + 3 say var3a
   @ l5, fiz + ancho1 + 13 say var3b picture "99"
   @ l6, fiz + ancho1 + 10 say var4a picture "99999"
   @ l7, fiz + ancho1 + 3 say var5a
   @ l8, fiz + ancho1 + 3 say var6a
   @ l8, fiz + ancho1 + 13 say var6b picture "99"
   @ l9, fiz + ancho1 + 3 say var7a
   @ l9, fiz + ancho1 + 13 say var7b picture "99"
   @ l10, fiz + ancho1 + 3 say var8a
   @ l10, fiz + ancho1 + 13 say var8b picture "99"
   @ l11, fiz + ancho1 + 3 say var10a
   @ l11, fiz + ancho1 + 13 say var10b picture "99"
   @ l12, fiz + ancho1 + 13 say var11a picture "99"
   @ l14, fiz + ancho1 + 3 say var12a
   @ l15, fiz + ancho1 + 3 say var13a
   @ l15, fiz + ancho1 + 13 say var13b picture "99999.999"
   @ l16, fiz + ancho1 + 3 say var14a
   @ l17, fiz + ancho1 + 3 say var15a
   @ l18, fiz + ancho1 + 3 say var16a
   @ l20, fiz + ancho1 + 3 say var18a
   set color to B/W
   if (var3a = " ")
      @ l5, fiz + ancho1 + 3 say "         "
   else
      @ l5, fiz + ancho1 + 5 say ;
         SubStr(opcion[ascan(opcion, var3a)], 4, 7)
   endif
   if (var3b == 0)
      @ l5, fiz + ancho1 + 16 say Space(20)
   else
      @ l5, fiz + ancho1 + 16 say ;
         SubStr(comprob[ascan(comprob, Str(var3b, 2))], 4, 20)
   endif
   @ l6, fiz + ancho1 + 16 say var4b
   if (var5a = " ")
      @ l7, fiz + ancho1 + 3 say "         "
   else
      @ l7, fiz + ancho1 + 5 say ;
         SubStr(opcion[ascan(opcion, var5a)], 4, 7)
   endif
   if (var6a = " ")
      @ l8, fiz + ancho1 + 3 say "         "
   else
      @ l8, fiz + ancho1 + 5 say ;
         SubStr(opcion[ascan(opcion, var6a)], 4, 7)
   endif
   if (var6b == 0)
      @ l8, fiz + ancho1 + 16 say Space(20)
   else
      @ l8, fiz + ancho1 + 16 say ;
         SubStr(condven[ascan(condven, Str(var6b, 2))], 4, 20)
   endif
   if (var7a = " ")
      @ l9, fiz + ancho1 + 3 say "         "
   else
      @ l9, fiz + ancho1 + 5 say ;
         SubStr(opcion[ascan(opcion, var7a)], 4, 7)
   endif
   if (var7b == 0)
      @ l9, fiz + ancho1 + 16 say Space(30)
   else
      @ l9, fiz + ancho1 + 16 say ;
         SubStr(codvend[ascan(codvend, Str(var7b, 2))], 4, 30)
   endif
   if (var8a = " ")
      @ l10, fiz + ancho1 + 3 say "         "
   else
      @ l10, fiz + ancho1 + 5 say ;
         SubStr(opcion[ascan(opcion, var8a)], 4, 7)
   endif
   if (var8b == 0)
      @ l10, fiz + ancho1 + 16 say Space(30)
   else
      @ l10, fiz + ancho1 + 16 say ;
         SubStr(coddepo[ascan(coddepo, Str(var8b, 2))], 4, 30)
   endif
   if (var10a = " ")
      @ l11, fiz + ancho1 + 3 say "         "
   else
      @ l11, fiz + ancho1 + 5 say ;
         SubStr(opcion[ascan(opcion, var10a)], 4, 7)
   endif
   if (var10b == 0)
      @ l11, fiz + ancho1 + 16 say Space(20)
   else
      @ l11, fiz + ancho1 + 16 say ;
         SubStr(lista[ascan(lista, Str(var10b, 2))], 4, 20)
   endif
   if (var11a == 0)
      @ l12, fiz + ancho1 + 16 say Space(20)
   else
      @ l12, fiz + ancho1 + 16 say credit[var11a]
   endif
   if (var13a = " ")
      @ l15, fiz + ancho1 + 3 say "         "
   else
      @ l15, fiz + ancho1 + 5 say ;
         SubStr(opcion[ascan(opcion, var13a)], 4, 7)
   endif
   if (var14a = " ")
      @ l16, fiz + ancho1 + 3 say "         "
   else
      @ l16, fiz + ancho1 + 5 say ;
         SubStr(opcion[ascan(opcion, var14a)], 4, 7)
   endif
   if (var15a = " ")
      @ l17, fiz + ancho1 + 3 say "         "
   else
      @ l17, fiz + ancho1 + 5 say ;
         SubStr(opcion[ascan(opcion, var15a)], 4, 7)
   endif
   return

********************************
procedure RPL15_1

   replace numero with dato1
   replace nombre with dato2
   replace var3a with dato3a
   replace var3b with dato3b
   replace var4a with dato4a
   replace var4b with dato4b
   replace var5a with dato5a
   replace var6a with dato6a
   replace var6b with dato6b
   replace var7a with dato7a
   replace var7b with dato7b
   replace var8a with dato8a
   replace var8b with dato8b
   replace var10a with dato10a
   replace var10b with dato10b
   replace var11a with dato11a
   replace var12a with dato12a
   if (dato12a = "S")
      dato13a:= "M"
      dato13b:= 1
      dato14a:= "M"
      dato15a:= "M"
      dato16a:= "M"
   endif
   replace var13a with dato13a
   replace var13b with dato13b
   replace var14a with dato14a
   replace var15a with dato15a
   replace var16a with dato16a
   replace var18a with dato18a
   return

********************************
procedure MTR15_1

   @ l1, fiz + ancho1 + 3 say dato1 picture "99"
   @ l2, fiz + ancho1 + 3 say dato2
   @ l5, fiz + ancho1 + 3 say dato3a
   @ l5, fiz + ancho1 + 13 say dato3b picture "99"
   @ l6, fiz + ancho1 + 10 say dato4a picture "99999"
   @ l7, fiz + ancho1 + 3 say dato5a
   @ l8, fiz + ancho1 + 3 say dato6a
   @ l8, fiz + ancho1 + 13 say dato6b picture "99"
   @ l9, fiz + ancho1 + 3 say dato7a
   @ l9, fiz + ancho1 + 13 say dato7b picture "99"
   @ l10, fiz + ancho1 + 3 say dato8a
   @ l10, fiz + ancho1 + 13 say dato8b picture "99"
   @ l11, fiz + ancho1 + 3 say dato10a
   @ l11, fiz + ancho1 + 13 say dato10b picture "99"
   @ l12, fiz + ancho1 + 13 say dato11a picture "99"
   @ l14, fiz + ancho1 + 3 say dato12a
   @ l15, fiz + ancho1 + 3 say dato13a
   @ l15, fiz + ancho1 + 13 say dato13b picture "99999.999"
   @ l16, fiz + ancho1 + 3 say dato14a
   @ l17, fiz + ancho1 + 3 say dato15a
   @ l18, fiz + ancho1 + 3 say dato16a
   @ l20, fiz + ancho1 + 3 say dato18a
   set color to B/W
   if (dato3a = " ")
      @ l5, fiz + ancho1 + 3 say "         "
   else
      @ l5, fiz + ancho1 + 5 say ;
         SubStr(opcion[ascan(opcion, dato3a)], 4, 7)
   endif
   if (dato3b == 0)
      @ l5, fiz + ancho1 + 16 say Space(20)
   else
      @ l5, fiz + ancho1 + 16 say ;
         SubStr(comprob[ascan(comprob, Str(dato3b, 2))], 4, 20)
   endif
   if (dato5a = " ")
      @ l7, fiz + ancho1 + 3 say "         "
   else
      @ l7, fiz + ancho1 + 5 say ;
         SubStr(opcion[ascan(opcion, dato5a)], 4, 7)
   endif
   if (dato6a = " ")
      @ l8, fiz + ancho1 + 3 say "         "
   else
      @ l8, fiz + ancho1 + 5 say ;
         SubStr(opcion[ascan(opcion, dato6a)], 4, 7)
   endif
   if (dato6b == 0)
      @ l8, fiz + ancho1 + 16 say Space(20)
   else
      @ l8, fiz + ancho1 + 16 say ;
         SubStr(condven[ascan(condven, Str(dato6b, 2))], 4, 20)
   endif
   if (dato7a = " ")
      @ l9, fiz + ancho1 + 3 say "         "
   else
      @ l9, fiz + ancho1 + 5 say ;
         SubStr(opcion[ascan(opcion, dato7a)], 4, 7)
   endif
   if (dato7b == 0)
      @ l9, fiz + ancho1 + 16 say Space(30)
   else
      @ l9, fiz + ancho1 + 16 say ;
         SubStr(codvend[ascan(codvend, Str(dato7b, 2))], 4, 30)
   endif
   if (dato8a = " ")
      @ l10, fiz + ancho1 + 3 say "         "
   else
      @ l10, fiz + ancho1 + 5 say ;
         SubStr(opcion[ascan(opcion, dato8a)], 4, 7)
   endif
   if (dato8b == 0)
      @ l10, fiz + ancho1 + 16 say Space(30)
   else
      @ l10, fiz + ancho1 + 16 say ;
         SubStr(coddepo[ascan(coddepo, Str(dato8b, 2))], 4, 30)
   endif
   if (dato10a = " ")
      @ l11, fiz + ancho1 + 3 say "         "
   else
      @ l11, fiz + ancho1 + 5 say ;
         SubStr(opcion[ascan(opcion, dato10a)], 4, 7)
   endif
   if (dato10b == 0)
      @ l11, fiz + ancho1 + 16 say Space(20)
   else
      @ l11, fiz + ancho1 + 16 say ;
         SubStr(lista[ascan(lista, Str(dato10b, 2))], 4, 20)
   endif
   if (dato11a == 0)
      @ l12, fiz + ancho1 + 16 say Space(20)
   else
      @ l12, fiz + ancho1 + 16 say credit[dato11a]
   endif
   if (dato13a = " ")
      @ l15, fiz + ancho1 + 3 say "         "
   else
      @ l15, fiz + ancho1 + 5 say ;
         SubStr(opcion[ascan(opcion, dato13a)], 4, 7)
   endif
   if (dato14a = " ")
      @ l16, fiz + ancho1 + 3 say "         "
   else
      @ l16, fiz + ancho1 + 5 say ;
         SubStr(opcion[ascan(opcion, dato14a)], 4, 7)
   endif
   if (dato15a = " ")
      @ l17, fiz + ancho1 + 3 say "         "
   else
      @ l17, fiz + ancho1 + 5 say ;
         SubStr(opcion[ascan(opcion, dato15a)], 4, 7)
   endif
   return

********************************
procedure GET15_1

   @ l2, fiz + ancho1 + 3 get dato2 picture "@!" valid ;
      Len(alltrim(dato2)) > 0
   @ l5, fiz + ancho1 + 3 get dato3A picture "@!" valid dato3a = "E" ;
      .OR. dato3a = "M" .OR. dato3a = "O"
   @ l5, fiz + ancho1 + 13 get dato3B picture "99" valid dato3b > 0 ;
      .AND. ascan(comprob, Str(dato3b, 2)) > 0
   @ l6, fiz + ancho1 + 10 get dato4A picture "99999"
   @ l7, fiz + ancho1 + 3 get dato5A picture "@!" valid dato5a = "E" ;
      .OR. dato5a = "M" .OR. dato5a = "O"
   @ l8, fiz + ancho1 + 3 get dato6A picture "@!" valid dato6a = "E" ;
      .OR. dato6a = "M" .OR. dato6a = "O"
   @ l8, fiz + ancho1 + 13 get dato6B picture "99" valid dato6b > 0 ;
      .AND. ascan(condven, Str(dato6b, 2)) > 0
   @ l9, fiz + ancho1 + 3 get dato7A picture "@!" valid dato7a = "E" ;
      .OR. dato7a = "M" .OR. dato7a = "O"
   @ l9, fiz + ancho1 + 13 get dato7B picture "99" valid ;
      ascan(codvend, Str(dato7b, 2)) > 0 .OR. dato7b = 0
   @ l10, fiz + ancho1 + 3 get dato8A picture "@!" valid dato8a = ;
      "E" .OR. dato8a = "M" .OR. dato8a = "O"
   @ l10, fiz + ancho1 + 13 get dato8B picture "99" valid dato8b > 0 ;
      .AND. ascan(coddepo, Str(dato8b, 2)) > 0
   @ l11, fiz + ancho1 + 3 get dato10A picture "@!" valid dato10a = ;
      "E" .OR. dato10a = "M" .OR. dato10a = "O"
   @ l11, fiz + ancho1 + 13 get dato10B picture "99" valid dato10b > ;
      0 .AND. ascan(lista, Str(dato10b, 2)) > 0
   @ l12, fiz + ancho1 + 13 get dato11A picture "99" valid dato11a > ;
      0 .AND. dato11a <= 3
   @ l14, fiz + ancho1 + 3 get dato12A picture "@!" valid dato12a = ;
      "S" .OR. dato12a = "N"
   @ l15, fiz + ancho1 + 3 get dato13A picture "@!" valid dato13a = ;
      "E" .OR. dato13a = "M" .OR. dato13a = "O" when dato12a = "N"
   @ l15, fiz + ancho1 + 13 get dato13B picture "99999.999" when ;
      dato12a = "N"
   @ l16, fiz + ancho1 + 3 get dato14A picture "@!" valid dato14a = ;
      "E" .OR. dato14a = "M" .OR. dato14a = "O" when dato12a = "N"
   @ l17, fiz + ancho1 + 3 get dato15A picture "@!" valid dato15a = ;
      "E" .OR. dato15a = "M" .OR. dato15a = "O" when dato12a = "N"
   @ l18, fiz + ancho1 + 3 get dato16A picture "@!" valid dato16a = ;
      "S" .OR. dato16a = "N" when dato12a = "N"
   @ l20, fiz + ancho1 + 3 get dato18A picture "@!" valid dato18a = ;
      "S" .OR. dato18a = "N"
   return

********************************
procedure ORD_15_1

   h:= Row()
   f:= Col()
   qpn:= SubStr(SaveScreen(h, f, h, f), 1, 1)
   tecl:= ""
   queali:= 0
   olcol:= SetColor()
   do case
   case h >= l5 .AND. h <= l11 .AND. f < fiz + ancho1 + 6
      @ 24,  0 say ;
         "    F10=opciones                                                                "
      qpn:= alltrim(qpn)
      if (qpn = "E" .OR. qpn = "M" .OR. qpn = "O")
         set color to b/w
         @ h, fiz + ancho1 + 5 say ;
            SubStr(opcion[ascan(opcion, qpn)], 4, 7)
         keyboard Chr(24)
      else
         datou:= bus15_1a(qpn)
         if (LastKey() != K_ESC)
            datou:= datou + Chr(13)
            keyboard datou
         endif
      endif
   case h >= l15 .AND. h <= l17 .AND. f < fiz + ancho1 + 6
      @ 24,  0 say ;
         "    F10=opciones                                                                "
      qpn:= alltrim(qpn)
      if (qpn = "E" .OR. qpn = "M" .OR. qpn = "O")
         set color to b/w
         @ h, fiz + ancho1 + 5 say ;
            SubStr(opcion[ascan(opcion, qpn)], 4, 8)
         keyboard Chr(24)
      else
         datou:= bus15_1a(qpn)
         if (LastKey() != K_ESC)
            datou:= datou + Chr(13)
            keyboard datou
         endif
      endif
   case h = l5 .AND. f > fiz + ancho1 + 6
      rpn:= ascan(comprob, Str(dato3b, 2))
      if (dato3b > 0 .AND. rpn > 0)
         set color to b/w
         @ h, fiz + ancho1 + 16 say ;
            SubStr(comprob[ascan(comprob, Str(dato3b, 2))], 4, 20)
         keyboard Chr(24)
      else
         datou:= bus15_1b(rpn, "Comprob")
         if (LastKey() != K_ESC)
            datou:= Str(datou, 2) + Chr(13)
            keyboard datou
         endif
      endif
   case h = l8 .AND. f > fiz + ancho1 + 6
      rpn:= ascan(condven, Str(dato6b, 2))
      if (dato6b > 0 .AND. rpn > 0)
         set color to b/w
         @ h, fiz + ancho1 + 16 say ;
            SubStr(condven[ascan(condven, Str(dato6b, 2))], 4, 20)
         keyboard Chr(24)
      else
         datou:= bus15_1b(rpn, "Condven")
         if (LastKey() != K_ESC)
            datou:= Str(datou, 2) + Chr(13)
            keyboard datou
         endif
      endif
   case h = l9 .AND. f > fiz + ancho1 + 6
      rpn:= ascan(codvend, Str(dato7b, 2))
      if (dato7b > 0)
         if (rpn > 0)
            set color to b/w
            @ h, fiz + ancho1 + 16 say ;
               SubStr(codvend[ascan(codvend, Str(dato7b, 2))], 4, 30)
            keyboard Chr(24)
         else
            datou:= bus15_1b(rpn, "Codvend")
            if (LastKey() != K_ESC)
               datou:= Str(datou, 2) + Chr(13)
               keyboard datou
            endif
         endif
      else
         set color to b/w
         @ h, fiz + ancho1 + 16 say Space(30)
         keyboard Chr(24)
      endif
   case h = l10 .AND. f > fiz + ancho1 + 6
      rpn:= ascan(coddepo, Str(dato8b, 2))
      if (dato8b > 0 .AND. rpn > 0)
         set color to b/w
         @ h, fiz + ancho1 + 16 say ;
            SubStr(coddepo[ascan(coddepo, Str(dato8b, 2))], 4, 30)
         keyboard Chr(24)
      else
         datou:= bus15_1b(rpn, "Coddepo")
         if (LastKey() != K_ESC)
            datou:= Str(datou, 2) + Chr(13)
            keyboard datou
         endif
      endif
   case h = l11 .AND. f > fiz + ancho1 + 6
      rpn:= ascan(lista, Str(dato10b, 2))
      if (dato10b > 0 .AND. rpn > 0)
         set color to b/w
         @ h, fiz + ancho1 + 16 say ;
            SubStr(lista[ascan(lista, Str(dato10b, 2))], 4, 20)
         keyboard Chr(24)
      else
         datou:= bus15_1b(rpn, "Lista")
         if (LastKey() != K_ESC)
            datou:= Str(datou, 2) + Chr(13)
            keyboard datou
         endif
      endif
   case h = l12 .AND. f > fiz + ancho1 + 6
      if (dato11a > 0 .AND. dato11a <= 3)
         set color to b/w
         @ h, fiz + ancho1 + 16 say credit[dato11a]
         keyboard Chr(24)
      else
         nelem:= 0
         rpn:= " "
         datou:= bus15_1b(rpn, "Credit")
         if (LastKey() != K_ESC)
            datou:= Str(nelem, 2) + Chr(13)
            keyboard datou
         endif
      endif
   case h = l6 .AND. f > fiz + ancho1 + 6
      if (dato4a > 0)
         select 2
         seek dato4a
         if (Found())
            dato4a:= nro_client
            dato4b:= empresa
            @ l6, fiz + ancho1 + 10 say dato4a picture "99999"
            set color to b/w
            @ l6, fiz + ancho1 + 16 say dato4b
            select 1
            keyboard Chr(24)
         else
            rpn:= " "
            datou:= bus15_1c(dato4a)
            if (LastKey() != K_ESC)
               datou:= Str(datou, 2) + Chr(13)
               set color to b/w
               @ l6, fiz + ancho1 + 16 say dato4b
               keyboard Chr(24)
            endif
         endif
      else
         set color to b/w
         @ h, fiz + ancho1 + 16 say Space(30)
         dato4b:= Space(30)
         keyboard Chr(24)
      endif
   case h = l20
      SetKey(K_ENTER, Nil)
      SetKey(K_F10, Nil)
      keyboard Chr(13)
   otherwise
      keyboard Chr(24)
   endcase
   set color to (olcol)
   @ 24,  0 say ;
      "                                                                                "
   select 1
   return

********************************
procedure F10_15_1

   h:= Row()
   f:= Col()
   tecl:= ""
   do case
   case h >= l5 .AND. h <= l11 .AND. f < fiz + ancho1 + 6
      qpn:= " "
      datou:= bus15_1a(qpn)
      if (LastKey() != K_ESC)
         datou:= datou + Chr(13)
         keyboard datou
      endif
   case h >= l15 .AND. h <= l17 .AND. f < fiz + ancho1 + 6
      qpn:= " "
      datou:= bus15_1a(qpn)
      if (LastKey() != K_ESC)
         datou:= datou + Chr(13)
         keyboard datou
      endif
   case h = l5 .AND. f > fiz + ancho1 + 6
      rpn:= " "
      datou:= bus15_1b(rpn, "Comprob")
      if (LastKey() != K_ESC)
         datou:= Str(datou, 2) + Chr(13)
         keyboard datou
      endif
   case h = l8 .AND. f > fiz + ancho1 + 6
      rpn:= " "
      datou:= bus15_1b(rpn, "Condven")
      if (LastKey() != K_ESC)
         datou:= Str(datou, 2) + Chr(13)
         keyboard datou
      endif
   case h = l9 .AND. f > fiz + ancho1 + 6
      rpn:= " "
      datou:= bus15_1b(rpn, "Codvend")
      if (LastKey() != K_ESC)
         datou:= Str(datou, 2) + Chr(13)
         keyboard datou
      endif
   case h = l10 .AND. f > fiz + ancho1 + 6
      rpn:= " "
      datou:= bus15_1b(rpn, "Coddepo")
      if (LastKey() != K_ESC)
         datou:= Str(datou, 2) + Chr(13)
         keyboard datou
      endif
   case h = l11 .AND. f > fiz + ancho1 + 6
      rpn:= " "
      datou:= bus15_1b(rpn, "Lista")
      if (LastKey() != K_ESC)
         datou:= Str(datou, 2) + Chr(13)
         keyboard datou
      endif
   case h = l12 .AND. f > fiz + ancho1 + 6
      nelem:= 0
      rpn:= " "
      datou:= bus15_1b(rpn, "Credit")
      if (LastKey() != K_ESC)
         datou:= Str(nelem, 2) + Chr(13)
         keyboard datou
      endif
   case h = l6 .AND. f > fiz + ancho1 + 6
      rpn:= " "
      datou:= bus15_1c(dato4a)
      if (LastKey() != K_ESC)
         datou:= Str(datou, 2) + Chr(13)
         set color to b/w
         @ l6, fiz + ancho1 + 16 say dato4b
         keyboard Chr(24)
      endif
   endcase
   select 1
   return

********************************
function BUS15_1A

   parameters nalic
   SetKey(K_ENTER, Nil)
   SetKey(K_F10, Nil)
   save screen to p15_1
   nelem:= 0
   totlen:= Len(opcion)
   wa:= Len(opcion)
   hh:= h
   if (h + wa > 23)
      hh:= 23 - wa
   endif
   boxshadow(h - 1, fiz, h - 1, fiz + ancho1)
   achoi02("Opcion", hh - 1, fiz + ancho1 + 3, hh + wa, fiz + ancho1 ;
      + 3 + 11, "N/BG,W+/R", 1)
   restore screen from p15_1
   if (LastKey() != K_ESC)
      nalic:= SubStr(opcion[nelem], 1, 1)
   endif
   set key K_ENTER to ord_15_1
   set key K_F10 to f10_15_1
   return nalic

********************************
function BUS15_1B

   parameters nalic, quearr
   SetKey(K_ENTER, Nil)
   SetKey(K_F10, Nil)
   save screen to p15_1
   nelem:= 0
   totlen:= Len(&quearr)
   wa:= Len(&quearr)
   hh:= h
   if (h + wa > 23)
      hh:= 23 - wa
   endif
   boxshadow(h - 1, fiz, h - 1, fiz + ancho1)
   achoi02(quearr, hh - 1, fiz + ancho1 + 16, hh + wa, fiz + ancho1 ;
      + 3 + 40, "N/BG,W+/R", 1)
   restore screen from p15_1
   if (LastKey() != K_ESC)
      nalic:= Val(SubStr(&quearr[nelem], 1, 2))
   endif
   set key K_ENTER to ord_15_1
   set key K_F10 to f10_15_1
   return nalic

********************************
function BUS15_1C

   parameters nalic
   select 2
   SetKey(K_ENTER, Nil)
   goto top
   campy:= "SUBSTR(STR(NRO_CLIENT,3)+' '+EMPRESA,1,35)"
   cuanhay:= LastRec()
   save screen to p13_2
   boxshadow(h - 1, fiz + 1, h - 1, fiz + ancho1)
   brow03(campy, h - 3, fiz + ancho1 + 16, "N/BG", "N/BG,W+/R", ;
      "EMPRESA", 2)
   restore screen from p13_2
   if (LastKey() != K_ESC)
      dato4a:= nro_client
      nalic:= nro_client
      dato4b:= empresa
   endif
   set color to R/W*
   select 1
   set key K_ENTER to ord_15_1
   return nalic

********************************
procedure ABM_P151

   parameters abmlin, abmcol
   @ abmlin, abmcol + 1 prompt " " + alltrim(afrases[25]) + " "
   @ abmlin, abmcol + 1 + Len(alltrim(afrases[25])) + 2 prompt " " + ;
      alltrim(afrases[26]) + " "
   @ abmlin, abmcol + 1 + Len(alltrim(afrases[25])) + 2 + ;
      Len(alltrim(afrases[26])) + 2 prompt " " + ;
      alltrim(afrases[27]) + " "
   @ abmlin, abmcol + 1 + Len(alltrim(afrases[25])) + 2 + ;
      Len(alltrim(afrases[26])) + 2 + Len(alltrim(afrases[27])) + 2 ;
      prompt " " + alltrim(afrases[28]) + " "
   @ abmlin, abmcol + 1 + Len(alltrim(afrases[25])) + 2 + ;
      Len(alltrim(afrases[26])) + 2 + Len(alltrim(afrases[27])) + 2 ;
      + Len(alltrim(afrases[28])) + 2 prompt " " + ;
      alltrim(afrases[29]) + " "
   @ abmlin, abmcol + 1 + Len(alltrim(afrases[25])) + 2 + ;
      Len(alltrim(afrases[26])) + 2 + Len(alltrim(afrases[27])) + 2 ;
      + Len(alltrim(afrases[28])) + 2 + Len(alltrim(afrases[29])) + ;
      2 prompt " " + alltrim(afrases[30]) + " "
   @ abmlin, abmcol + 1 + Len(alltrim(afrases[25])) + 2 + ;
      Len(alltrim(afrases[26])) + 2 + Len(alltrim(afrases[27])) + 2 ;
      + Len(alltrim(afrases[28])) + 2 + Len(alltrim(afrases[29])) + ;
      2 + Len(alltrim(afrases[30])) + 2 prompt " " + ;
      alltrim(afrases[31]) + " "
   @ abmlin, abmcol + 1 + Len(alltrim(afrases[25])) + 2 + ;
      Len(alltrim(afrases[26])) + 2 + Len(alltrim(afrases[27])) + 2 ;
      + Len(alltrim(afrases[28])) + 2 + Len(alltrim(afrases[29])) + ;
      2 + Len(alltrim(afrases[30])) + 2 + Len(alltrim(afrases[31])) ;
      + 2 prompt " Asignaciones "
   return

********************************
procedure ASIG15_1

   select 3
   opbasexc("BASE001")
   cuanhay:= LastRec()
   xperf:= "PERFIL" + alltrim(Str(refperf, 2))
   t:= 0
   DBEval(&("{|| T := T + &XPERF}"), Nil, Nil, Nil, Nil, .F.)
   if (t == 0)
      private aperfil[1]
      aperfil[1]:= "                                 "
   else
      private aperfil[t]
   endif
   y:= 1
   goto top
   do while (!EOF())
      if (&xperf == 1)
         xnuv:= RecNo()
         xnov:= usuario
         replace &xperf with 0
         aperfil[y]:= Str(RecNo(), 2) + " " + usuario
         y:= y + 1
      endif
      skip 
   enddo
   select 1
   nelem:= 0
   col513:= "N/W*,W+/B"
   do while (.T.)
      totlen:= Len(aperfil)
      keyboard Chr(24)
      achoi05("Aperfil", 5, 10, 19, 60, 2, "N/W", "N/W", col513, ;
         "Asignaci¢n de este perfil")
      if (LastKey() == K_ESC)
         exit
      endif
   enddo
   select 3
   if (Len(aperfil) > 0 .AND. Len(alltrim(aperfil[1])) > 0)
      yy:= Len(aperfil)
      y:= 1
      for y:= 1 to yy
         xnup:= Val(SubStr(aperfil[y], 1, 2))
         goto top
         locate for RecNo() = xnup
         if (!EOF())
            replace &xperf with 1
         else
            alert("Sonamos, no encontr‚ el operador")
         endif
      next
   endif
   close
   select 1
   return

********************************
procedure ACHOI05

   colbrow:= SetColor()
   parameters bloke, barr1, bizq1, baba1, bder1, talon, bcol1, ;
      bcol2, bcol3, titu
   jcbox(barr1, bizq1, baba1 + talon, bder1, bcol1, 20, 1, .T., .F., ;
      .F., "W+/B", titu)
   jjbox(barr1 + 1, bizq1 + 1, baba1 - 1, bder1 - 1, bcol2, 20, 4, ;
      .F.)
   set color to (bcol1)
   @ baba1, bizq1 + 3 say "[A]=asigna a un nuevo operador."
   @ baba1 + 1, bizq1 + 3 say "[B]=quita el operador se¤alado."
   set color to (bcol3)
   achoice(barr1 + 2, bizq1 + 2, baba1 - 2, bder1 - 2, &bloke, .T., ;
      "UserFun5")
   set color to (colbrow)
   return

********************************
function USERFUN5(Arg1, Arg2, Arg3)

   local Local1
   Local1:= 2
   if (LastKey() == K_ESC)
      return 0
   else
      k:= 1
      for k:= 1 to totlen
         if (Arg2 == k)
            nelem:= k
            if (LastKey() = 66 .OR. LastKey() = 98)
               if (Len(alltrim(aperfil[1])) >= 0)
                  save screen to pasig
                  resp:= " "
                  confirm0(15, 30)
                  if (resp = "S")
                     if (Len(aperfil) = 1 .AND. ;
                           Len(alltrim(aperfil[1])) >= 0)
                        aperfil[1]:= Space(33)
                        setcursor(0)
                     else
                        adel(aperfil, nelem)
                        asize(&bloke, totlen - 1)
                        return 0
                     endif
                  endif
                  setcursor(0)
                  restore screen from pasig
               endif
            elseif (LastKey() = 65 .OR. LastKey() = 97)
               save screen to pasig
               select 3
               goto top
               xnuve:= 0
               xnove:= Space(30)
               campy:= "SUBSTR(STR(RECNO(),3)+' '+USUARIO,1,24)"
               brow03(campy, 9, 40, "N/BG", "N/BG,W+/R", "USUARIO", 2)
               xnuve:= RecNo()
               xnove:= usuario
               select 1
               if (LastKey() != K_ESC)
                  if (ascan(aperfil, Str(xnuve, 2)) > 0)
                     alert("El perfil ya fue asignado a este operador.")
                  elseif (Len(aperfil) = 1 .AND. ;
                        Len(alltrim(aperfil[1])) = 0)
                     aperfil[1]:= Str(xnuve, 2) + " " + xnove
                  else
                     AAdd(aperfil, 1)
                     aperfil[totlen + 1]:= Str(xnuve, 2) + " " + xnove
                     restore screen from pasig
                     return 0
                  endif
               endif
               setcursor(0)
               restore screen from pasig
            endif
         endif
      next
   endif
   return Local1

********************************
function USERFAC(Arg1, Arg2, Arg3)

   local Local1
   Local1:= 2
   h:= Row()
   sal:= 0
   set color to R/W*
   @ 24,  0 say ;
      "     F10=finalizar carga       B=borra ¡tem                                     "
   set color to B/W
   if (LastKey() == K_ESC)
      save screen to pcancel
      resp:= " "
      cancela0(12, 30)
      setcursor(0)
      if (resp = "N")
         salida:= 1
         return 0
      endif
      restore screen from pcancel
   else
      k:= 1
      for k:= 1 to totlen
         if (Arg2 == k)
            nelem:= k
            qsalto:= 0
            do case
            case LastKey() = K_ENTER
               fun0006()
               if (LastKey() = K_ESC .AND. Len(alotes) = 1 .AND. ;
                     alotes[nelem][1] = 0)
                  salida:= 1
                  return 0
               endif
               if (LastKey() = K_ESC .AND. alotes[nelem][1] = 0)
                  adel(alote, nelem)
                  adel(alotes, nelem)
                  asize(alote, totlen - 1)
                  asize(alotes, totlen - 1)
                  salida:= 3
                  @ h,  1 say ;
                     "             ³                    ³         ³    ³          ³     ³          "
                  if (sal == 4)
                     salida:= 4
                  endif
                  return 0
               endif
            case LastKey() = K_DOWN .AND. Arg1 == 2
               salida:= 2
               return 0
            case LastKey() = -9
               salida:= 4
               return 0
            case LastKey() = 98 .OR. LastKey() = 66
               if (Len(alotes) > 1)
                  if (nelem = totlen)
                     qsal5:= totlen - 2
                  else
                     qsal5:= nelem - 1
                  endif
                  adel(alote, nelem)
                  adel(alotes, nelem)
                  asize(alote, totlen - 1)
                  asize(alotes, totlen - 1)
                  salida:= 5
                  return 0
               endif
            endcase
         endif
      next
   endif
   return Local1

********************************
procedure FUN0002

   do case
   case dato5 = 1
      qpr:= cg7
      qimp:= Round(cg7 * cg1 * (1 - cg18 / 100), 2)
   case dato5 = 2
      qpr:= cg8
      qimp:= Round(cg8 * cg1 * (1 - cg18 / 100), 2)
   case dato5 = 3
      qpr:= cg9
      qimp:= Round(cg9 * cg1 * (1 - cg18 / 100), 2)
   case dato5 = 4
      qpr:= cg10
      qimp:= Round(cg10 * cg1 * (1 - cg18 / 100), 2)
   case dato5 = 5
      qpr:= cg11
      qimp:= Round(cg11 * cg1 * (1 - cg18 / 100), 2)
   endcase
   alote[nelem]:= "   " + cg2 + "  ³" + cg3 + "³" + Str(cg1, 9, 2) + ;
      "³" + SubStr(cg4, 1, 4) + "³" + Str(qpr, 9, 2) + " ³" + ;
      Str(cg18, 5, 2) + "³" + Str(qimp, 10, 2)
   alotes[nelem][1]:= cg1
   alotes[nelem][2]:= cg2
   alotes[nelem][3]:= cg3
   alotes[nelem][4]:= cg4
   alotes[nelem][5]:= cg5
   alotes[nelem][6]:= cg6
   alotes[nelem][7]:= cg7
   alotes[nelem][8]:= cg8
   alotes[nelem][9]:= cg9
   alotes[nelem][10]:= cg10
   alotes[nelem][11]:= cg11
   alotes[nelem][12]:= cg12
   alotes[nelem][13]:= cg13
   alotes[nelem][14]:= cg14
   alotes[nelem][15]:= cg15
   alotes[nelem][16]:= cg16
   alotes[nelem][17]:= cg17
   alotes[nelem][18]:= cg18
   alotes[nelem][19]:= cg19
   alotes[nelem][20]:= cg20
   return

********************************
procedure FUN0004

   h:= Row()
   f:= Col()
   qpn:= SubStr(SaveScreen(h, f, h, f), 1, 1)
   tecl:= ""
   queali:= 0
   olcol:= SetColor()
   do case
   case h = 2 .AND. f > 40
      rpn:= ascan(codvend, Str(dato2a, 2))
      if (rpn > 0)
         set color to b/w
         dato2b:= SubStr(codvend[ascan(codvend, Str(dato2a, 2))], 4, ;
            30)
         @ h, 59 say SubStr(codvend[ascan(codvend, Str(dato2a, 2))], ;
            4, 20)
         if (aperfil[queperfi][8] != "E" .AND. aperfil[queperfi][12] ;
               != "E" .AND. aperfil[queperfi][14] != "E")
            SetKey(K_ENTER, Nil)
            keyboard Chr(13)
         else
            keyboard Chr(24)
         endif
      else
         datou:= fun0004a(rpn, "Codvend")
         if (LastKey() != K_ESC)
            datou:= strzero(datou, 2) + Chr(13)
            keyboard datou
         endif
      endif
   case h = 3 .AND. f > 40
      rpn:= ascan(condven, Str(dato3, 2))
      if (dato3 > 0 .AND. rpn > 0)
         set color to b/w
         @ h, 59 say SubStr(condven[ascan(condven, Str(dato3, 2))], ;
            4, 20)
         if (aperfil[queperfi][12] != "E" .AND. ;
               aperfil[queperfi][14] != "E")
            SetKey(K_ENTER, Nil)
            keyboard Chr(13)
         else
            keyboard Chr(24)
         endif
      else
         datou:= fun0004a(rpn, "Condven")
         if (LastKey() != K_ESC)
            datou:= strzero(datou, 2) + Chr(13)
            keyboard datou
         endif
      endif
   case h = 4 .AND. f > 40
      rpn:= ascan(coddepo, Str(dato4, 2))
      if (dato4 > 0 .AND. rpn > 0)
         set color to b/w
         @ h, 59 say SubStr(coddepo[ascan(coddepo, Str(dato4, 2))], ;
            4, 20)
         if (aperfil[queperfi][14] != "E")
            SetKey(K_ENTER, Nil)
            keyboard Chr(13)
         else
            keyboard Chr(24)
         endif
      else
         datou:= fun0004a(rpn, "Coddepo")
         if (LastKey() != K_ESC)
            datou:= strzero(datou, 2) + Chr(13)
            keyboard datou
         endif
      endif
   case h = 5 .AND. f > 40
      rpn:= ascan(lista, Str(dato5, 2))
      if (dato5 > 0 .AND. rpn > 0)
         set color to b/w
         @ h, 59 say SubStr(lista[ascan(lista, Str(dato5, 2))], 4, 20)
         SetKey(K_ENTER, Nil)
         keyboard Chr(13)
      else
         datou:= fun0004a(rpn, "Lista")
         if (LastKey() != K_ESC)
            datou:= strzero(datou, 2) + Chr(13)
            keyboard datou
         endif
      endif
   otherwise
      keyboard Chr(24)
   endcase
   set color to R/W*
   @ 24,  0 say ;
      "                                                                                "
   set color to (olcol)
   select 1
   return

********************************
function FUN0004A

   parameters nalic, quearr
   SetKey(K_ENTER, Nil)
   save screen to p15_1
   nelem:= 0
   totlen:= Len(&quearr)
   wa:= Len(&quearr)
   hh:= h
   if (h + wa > 23)
      hh:= 23 - wa
   endif
   boxshadow(h - 1, 43, h - 1, 53)
   achoi02(quearr, hh - 1, 56, hh + wa, 78, "N/BG,W+/R", 1)
   restore screen from p15_1
   if (LastKey() != K_ESC)
      nalic:= Val(SubStr(&quearr[nelem], 1, 2))
   endif
   set key K_ENTER to fun0004
   return nalic

********************************
procedure FUN0005

   cg2:= cod
   cg3:= nombrered
   cg4:= unidad
   cg5:= llevastk
   cg6:= stkasoc
   cg7:= precio1
   cg8:= precio2
   cg9:= precio3
   cg10:= precio4
   cg11:= precio5
   cg12:= numiva
   cg13:= sosutaiva
   cg14:= nimpint
   cg15:= impintfij
   cg16:= sosutai_i
   cg17:= ret_a_rni
   cg18:= bonific
   cg19:= selec1
   cg20:= nombrecom
   return

********************************
function FUN0006

   setcursor(1)
   if (alotes[nelem][1] == 0)
      cg1:= aperfil[queperfi][19]
   else
      cg1:= alotes[nelem][1]
   endif
   cg2:= alotes[nelem][2]
   cg3:= alotes[nelem][3]
   cg4:= alotes[nelem][4]
   cg5:= alotes[nelem][5]
   cg6:= alotes[nelem][6]
   cg7:= alotes[nelem][7]
   cg8:= alotes[nelem][8]
   cg9:= alotes[nelem][9]
   cg10:= alotes[nelem][10]
   cg11:= alotes[nelem][11]
   cg12:= alotes[nelem][12]
   cg13:= alotes[nelem][13]
   cg14:= alotes[nelem][14]
   cg15:= alotes[nelem][15]
   cg16:= alotes[nelem][16]
   cg17:= alotes[nelem][17]
   cg18:= alotes[nelem][18]
   cg19:= alotes[nelem][19]
   cg20:= alotes[nelem][20]
   setcursor(1)
   do while (.T.)
      set color to N/W
      @ 19,  2 say "<F10>=finalizar carga"
      @ 20,  2 say "< B >=borra ¡tem     "
      set color to R/W*
      @ 24,  0 say ;
         "                                                                                "
      set color to B/W
      if (nelem = totlen)
         set key K_UP to vuelvo
         set key K_F10 to cierro
      endif
      cargatecla()
      if (Len(alltrim(cg2)) > 0)
         putoart:= SubStr("X" + cg2 + Space(20), 1, 20)
      else
         putoart:= SubStr(cg2 + Space(20), 1, 20)
      endif
      @ h,  4 get putoart picture "@KS8"
      read
      descatecla()
      SetKey(K_UP, Nil)
      SetKey(K_F10, Nil)
      set color to N/W
      @ 19,  2 say "                     "
      @ 20,  2 say "                     "
      set color to B/W
      if (LastKey() == K_ESC)
         set color to N/W
         @ 19,  2 say "<F10>=finalizar carga"
         @ 20,  2 say "< B >=borra ¡tem     "
         set color to B/W
         setcursor(0)
         return ""
      endif
      if (Len(alltrim(putoart)) > 0)
         select 2
         if (SubStr(putoart, 1, 1) = "X")
            opbassha("BASE003", "BASE003A")
            putoart:= SubStr(putoart, 2, 8)
            zcz:= 8
         else
            opbassha("BASE003", "BASE003X")
            zcz:= 9
         endif
         seek putoart
         if (Found() .AND. Len(alltrim(putoart)) >= 8)
            fun0005()
            @ h,  4 say cg2
            @ h, 15 say cg3
            @ h, 36 say cg1 picture "999999.99"
            @ h, 46 say SubStr(cg4, 1, 4)
            do case
            case dato5 = 1
               @ h, 51 say cg7 picture "999999.99"
               @ h, 68 say Round(cg7 * cg1 * (1 - cg18 / 100), 2) ;
                  picture "9999999.99"
            case dato5 = 2
               @ h, 51 say cg8 picture "999999.99"
               @ h, 68 say Round(cg8 * cg1 * (1 - cg18 / 100), 2) ;
                  picture "9999999.99"
            case dato5 = 3
               @ h, 51 say cg9 picture "999999.99"
               @ h, 68 say Round(cg9 * cg1 * (1 - cg18 / 100), 2) ;
                  picture "9999999.99"
            case dato5 = 4
               @ h, 51 say cg10 picture "999999.99"
               @ h, 68 say Round(cg10 * cg1 * (1 - cg18 / 100), 2) ;
                  picture "9999999.99"
            case dato5 = 5
               @ h, 51 say cg11 picture "999999.99"
               @ h, 68 say Round(cg11 * cg1 * (1 - cg18 / 100), 2) ;
                  picture "9999999.99"
            endcase
            set color to R/W*
            @ 24,  5 say cg20
            set color to B/W
            @ h, 62 say cg18 picture "99.99"
            close
            select 1
         else
            seek alltrim(putoart)
            if (!Found())
               goto top
            endif
            zcv:= "precio" + Str(dato5, 1)
            if (zcz == 8)
               campy:= ;
                  "SUBSTR(COD+' '+NOMBRECOM+' '+str(&zcv,10,2),1,60)"
            else
               campy:= ;
                  "SUBSTR(CODBARRA+' '+NOMBRECOM+' '+str(&zcv,10,2),1,72)"
            endif
            cuanhay:= LastRec()
            save screen to p13_2
            brow03(campy, 8, 5, "N/BG", "N/BG,W+/R", "NOMBRECOM", 2)
            restore screen from p13_2
            if (LastKey() != K_ESC)
               cg2:= cod
               keyboard "X" + cg2 + Chr(13)
            endif
            close
            select 1
            loop
         endif
         close
         select 1
      else
         @ h, 15 get cg3 picture "@K"
         read
         if (LastKey() == K_ESC)
            loop
         endif
         select 2
         opbassha("BASE003", "BASE003B")
         seek cg3
         if (Found())
            cg2:= cod
            keyboard "X" + cg2 + Chr(13)
            loop
         else
            seek alltrim(cg3)
            if (!Found())
               goto top
            endif
            zcv:= "precio" + Str(dato5, 1)
            campy:= ;
               "SUBSTR(COD+' '+NOMBRECOM+' '+str(&zcv,10,2),1,60)"
            cuanhay:= LastRec()
            save screen to p13_2
            brow03(campy, 8, 5, "N/BG", "N/BG,W+/R", "NOMBRECOM", 2)
            restore screen from p13_2
            if (LastKey() != K_ESC)
               cg2:= cod
               keyboard "X" + cg2 + Chr(13)
            endif
            close
            select 1
            loop
         endif
         close
         select 1
      endif
      if (cg19 == 0)
         if (aperfil[queperfi][22] = "S")
            keyboard Chr(6)
            save screen to pnom
            @ h, 15 get cg20 picture "@!" valid Len(alltrim(cg20)) > 0
            read
            restore screen from pnom
            if (LastKey() == K_ESC)
               loop
            endif
            cg3:= SubStr(cg20, 1, 20)
            @ h, 15 say cg3
         endif
         if (aperfil[queperfi][18] = "E")
            @ h, 39 get cg1 picture "999.99"
            read
         elseif (aperfil[queperfi][18] = "M")
            @ h, 36 say cg1 picture "999999.99"
         elseif (aperfil[queperfi][18] = "O")
            @ h, 36 say "         "
         endif
         if (LastKey() = K_ESC .OR. cg1 = 0)
            loop
         endif
         if (aperfil[queperfi][20] = "E")
            do case
            case dato5 = 1
               @ h, 51 get cg7 picture "999999.99"
            case dato5 = 2
               @ h, 51 get cg8 picture "999999.99"
            case dato5 = 3
               @ h, 51 get cg9 picture "999999.99"
            case dato5 = 4
               @ h, 51 get cg10 picture "999999.99"
            case dato5 = 5
               @ h, 51 get cg11 picture "999999.99"
            endcase
            read
         elseif (aperfil[queperfi][20] = "O")
            @ h, 51 say "         "
         endif
         if (LastKey() = K_ESC .OR. cg7 = 0)
            loop
         endif
         do case
         case dato5 = 1
            @ h, 68 say Round(cg7 * cg1 * (1 - cg18 / 100), 2) ;
               picture "9999999.99"
         case dato5 = 2
            @ h, 68 say Round(cg8 * cg1 * (1 - cg18 / 100), 2) ;
               picture "9999999.99"
         case dato5 = 3
            @ h, 68 say Round(cg9 * cg1 * (1 - cg18 / 100), 2) ;
               picture "9999999.99"
         case dato5 = 4
            @ h, 68 say Round(cg10 * cg1 * (1 - cg18 / 100), 2) ;
               picture "9999999.99"
         case dato5 = 5
            @ h, 68 say Round(cg11 * cg1 * (1 - cg18 / 100), 2) ;
               picture "9999999.99"
         endcase
         if (aperfil[queperfi][21] = "E")
            @ h, 62 get cg18 picture "99.99"
            read
         elseif (aperfil[queperfi][21] = "M")
            @ h, 62 say cg18 picture "99.99"
         elseif (aperfil[queperfi][21] = "O")
            @ h, 62 say "     "
         endif
         if (LastKey() == K_ESC)
            loop
         endif
         do case
         case dato5 = 1
            @ h, 68 say Round(cg7 * cg1 * (1 - cg18 / 100), 2) ;
               picture "9999999.99"
         case dato5 = 2
            @ h, 68 say Round(cg8 * cg1 * (1 - cg18 / 100), 2) ;
               picture "9999999.99"
         case dato5 = 3
            @ h, 68 say Round(cg9 * cg1 * (1 - cg18 / 100), 2) ;
               picture "9999999.99"
         case dato5 = 4
            @ h, 68 say Round(cg10 * cg1 * (1 - cg18 / 100), 2) ;
               picture "9999999.99"
         case dato5 = 5
            @ h, 68 say Round(cg11 * cg1 * (1 - cg18 / 100), 2) ;
               picture "9999999.99"
         endcase
      else
         if (aperfil[queperfi][18] = "E")
            @ h, 39 get cg1 picture "999.99"
            read
         elseif (aperfil[queperfi][18] = "M")
            @ h, 36 say cg1 picture "999999.99"
         elseif (aperfil[queperfi][18] = "O")
            @ h, 36 say "         "
         endif
         if (LastKey() = K_ESC .OR. cg1 = 0)
            loop
         endif
         qimporte:= 0
         do case
         case dato5 = 1
            qimporte:= Round(cg7 * cg1 * (1 - cg18 / 100), 2)
         case dato5 = 2
            qimporte:= Round(cg8 * cg1 * (1 - cg18 / 100), 2)
         case dato5 = 3
            qimporte:= Round(cg9 * cg1 * (1 - cg18 / 100), 2)
         case dato5 = 4
            qimporte:= Round(cg10 * cg1 * (1 - cg18 / 100), 2)
         case dato5 = 5
            qimporte:= Round(cg11 * cg1 * (1 - cg18 / 100), 2)
         endcase
         @ h, 68 get qimporte picture "9999999.99" valid qimporte > 0
         read
         if (LastKey() == K_ESC)
            loop
         endif
         do case
         case dato5 = 1
            cg1:= qimporte / cg7
            @ h, 51 say cg7 picture "999999.99"
         case dato5 = 2
            cg1:= qimporte / cg8
            @ h, 51 say cg8 picture "999999.99"
         case dato5 = 3
            cg1:= qimporte / cg9
            @ h, 51 say cg9 picture "999999.99"
         case dato5 = 4
            cg1:= qimporte / cg10
            @ h, 51 say cg10 picture "999999.99"
         case dato5 = 5
            cg1:= qimporte / cg11
            @ h, 51 say cg11 picture "999999.99"
         endcase
         @ h, 36 say cg1 picture "999999.99"
      endif
      fun0002()
      y:= 1
      dato8:= 0
      for y:= 1 to totlen
         do case
         case dato5 = 1
            dato8:= dato8 + alotes[y][7] * alotes[y][1] * (1 - ;
               alotes[y][18] / 100)
         case dato5 = 2
            dato8:= dato8 + alotes[y][8] * alotes[y][1] * (1 - ;
               alotes[y][18] / 100)
         case dato5 = 3
            dato8:= dato8 + alotes[y][9] * alotes[y][1] * (1 - ;
               alotes[y][18] / 100)
         case dato5 = 4
            dato8:= dato8 + alotes[y][10] * alotes[y][1] * (1 - ;
               alotes[y][18] / 100)
         case dato5 = 5
            dato8:= dato8 + alotes[y][11] * alotes[y][1] * (1 - ;
               alotes[y][18] / 100)
         endcase
      next
      @ 18, 68 say dato8 picture "9999999.99"
      @ 22, 68 say dato8 picture "9999999.99"
      if (LastKey() == K_ENTER)
         keyboard Chr(24)
      endif
      exit
   enddo
   setcursor(0)
   return

********************************
procedure VUELVO

   SetKey(K_ENTER, Nil)
   SetKey(K_F10, Nil)
   keyboard Chr(27)
   return

********************************
procedure CIERRO

   SetKey(K_ENTER, Nil)
   SetKey(K_F10, Nil)
   sal:= 4
   keyboard Chr(27)
   return

********************************
function FUN0012

   SetKey(K_ENTER, Nil)
   parameters nalic
   campy:= "SUBSTR(STR(NRO_CLIENT,5)+' '+EMPRESA,1,35)"
   cuanhay:= LastRec()
   save screen to p13_2
   boxshadow(2, 0, 2, 7)
   brow03(campy, 1, 16, "N/BG", "N/BG,W+/R", "EMPRESA", 2)
   restore screen from p13_2
   if (LastKey() != K_ESC)
      dato6a:= nro_client
      nalic:= SubStr(empresa, 1, 25)
      dato6b:= SubStr(empresa, 1, 25)
   endif
   set color to R/W*
   set key K_ENTER to fun0010
   return nalic

********************************
procedure ORD99_9

   h:= Row()
   f:= Col()
   tecl:= ""
   do case
   case h >= l1 .AND. h < l13
      keyboard Chr(24)
   case h = l13 .AND. f < fiz + ancho1 + 25
      if (dito12a > 0 .AND. dito12a <= 7)
         @ l13, fiz + ancho1 + 6 say adocum[dito12a][3]
      else
         bus99_9b()
      endif
      if (LastKey() != K_ESC)
         keyboard Chr(24)
      endif
   case h = l13 .AND. f > fiz + ancho1 + 25
      keyboard Chr(24)
   case h = l14
      if (dito13 > 0 .AND. dito13 <= 7)
         @ l14, fiz + ancho1 + 6 say respiva[dito13][3]
      else
         bus99_9c()
      endif
      if (LastKey() != K_ESC)
         SetKey(K_ENTER, Nil)
         keyboard Chr(13)
      endif
   endcase
   return

********************************
procedure F10_99_9

   h:= Row()
   f:= Col()
   tecl:= ""
   if (h = l13 .AND. f < fiz + ancho1 + 25)
      bus99_9b()
      if (LastKey() != K_ESC)
         keyboard Chr(24)
      endif
   elseif (h = l13 .AND. f > fiz + ancho1 + 25)
   elseif (h = l14)
      bus99_9c()
      if (LastKey() != K_ESC)
         keyboard Chr(24)
      endif
      keyboard Chr(24)
   endif
   return

********************************
procedure BUS99_9B

   SetKey(K_ENTER, Nil)
   SetKey(K_F10, Nil)
   save screen to p99_9
   nelem:= 0
   totlen:= Len(adocu)
   wa:= Len(adocu)
   hh:= l13
   if (h + wa > 23)
      hh:= 23 - wa
   endif
   boxshadow(l13 - 1, fiz, l13 - 1, fiz + ancho1)
   achoi02("Adocu", hh - 1, fiz + ancho1 + 3, hh + wa, f + 27, ;
      "N/BG,W+/R", 1)
   restore screen from p99_9
   if (LastKey() != K_ESC)
      dito12a:= nelem
      @ l13, fiz + ancho1 + 6 say adocum[dito12a][3]
   endif
   set key K_ENTER to ord99_9
   set key K_F10 to f10_99_9
   return

********************************
procedure BUS99_9C

   SetKey(K_ENTER, Nil)
   SetKey(K_F10, Nil)
   save screen to p99_9
   nelem:= 0
   totlen:= Len(respiv)
   wa:= Len(respiv)
   hh:= l14
   if (h + wa > 23)
      hh:= 23 - wa
   endif
   boxshadow(l14 - 1, fiz, l14 - 1, fiz + ancho1)
   achoi02("Respiv", hh - 1, fiz + ancho1 + 3, hh + wa, f + 27, ;
      "N/BG,W+/R", 1)
   restore screen from p99_9
   if (LastKey() != K_ESC)
      dito13:= nelem
      @ l14, fiz + ancho1 + 6 say respiva[dito13][3]
   endif
   set key K_ENTER to ord99_9
   set key K_F10 to f10_99_9
   return

* EOF
