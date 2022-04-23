#include "common.ch"
#include "inkey.ch"

********************************
procedure OPEVAR

   SetKey(K_F1, Nil)
   set key K_F2 to playlotes
   set key K_F3 to verfact
   set key K_F4 to equis
   set key K_F5 to cierre
   set key K_F6 to quevendi
   return

********************************
procedure CLOVAR

   SetKey(K_F1, Nil)
   SetKey(K_F2, Nil)
   SetKey(K_F3, Nil)
   SetKey(K_F4, Nil)
   SetKey(K_F5, Nil)
   return

********************************
function BOXSHADOW

   parameters top, left, bottom, right
   private stop, sleft, sbottom, sright
   grey_on_bl:= "X"
   stop:= bottom + 1
   sbottom:= stop
   sleft:= left + 1
   sright:= right + 1
   if (bottom < 24 .AND. right < 79)
      RestScreen(sbottom, sleft, sbottom, sright, ;
         Transform(SaveScreen(stop, sleft, sbottom, sright), ;
         Replicate(grey_on_bl, sright - sleft + 1)))
      stop:= top + 1
      sleft:= right + 1
      sright:= sleft
      sbottom:= bottom + 1
      RestScreen(stop, sleft, sbottom, sright, ;
         Transform(SaveScreen(stop, sleft, sbottom, sright), ;
         Replicate(grey_on_bl, sbottom - stop + 1)))
   elseif (bottom = 24 .AND. right < 79)
      stop:= top + 1
      sleft:= right + 1
      sright:= sleft
      sbottom:= bottom
      RestScreen(stop, sleft, sbottom, sright, ;
         Transform(SaveScreen(stop, sleft, sbottom, sright), ;
         Replicate(grey_on_bl, sbottom - stop + 1)))
   elseif (bottom < 24 .AND. right = 79)
      sright:= right
      RestScreen(sbottom, sleft, sbottom, sright, ;
         Transform(SaveScreen(stop, sleft, sbottom, sright), ;
         Replicate(grey_on_bl, sright - sleft + 1)))
   endif
   return .T.

********************************
procedure ACHOI03

   colbrow:= SetColor()
   parameters bloke, barr1, bizq1, baba1, bder1, bcol, shad, leyenda
   if (shad == 0)
      jjbox(barr1 - 2, bizq1, baba1, bder1, bcol, 20, 1, .F.)
   else
      jjbox(barr1 - 2, bizq1, baba1, bder1, bcol, 20, 1, .T.)
   endif
   set color to (bcol)
   @ barr1 - 1, bizq1 + 2 say leyenda
   set color to (bcol)
   achoice(barr1 + 1, bizq1 + 1, baba1 - 1, bder1 - 1, &bloke, .T., ;
      "UserFun2")
   set color to (colbrow)
   return

********************************
function ENVIAR

   parameters string
   private result, statprn
   do while (.T.)
      save screen to penvia
      statprn:= mandapaq(handler, string)
      if (statprn < 0)
         do while (statprn = -9)
            mensaje("Impresora ocupada...     (Esc=aborta)", "W*/R")
            caden:= "¡"
            statprn:= mandapaq(handler, caden)
            if (LastKey() == K_ESC)
               return -9
            endif
            InKey(1)
         enddo
         restore screen from penvia
         if (statprn >= 0)
            loop
         endif
         qqq:= okcancel("Error en comunicaci¢n con impresor.")
         if (qqq = "N")
            return -1
         else
            loop
         endif
      endif
      result:= respuesta(handler)
      fiserr:= ""
      qfst:= geterrors(result)
      if (qfst < 0)
         qqq:= okcancel("Error en comunicaci¢n con impresor.")
         if (qqq = "N")
            return -1
         else
            loop
         endif
      endif
      if (Len(alltrim(fiserr)) > 0)
         qqq:= okcancel(fiserr)
         if (qqq = "N")
            return -1
         else
            loop
         endif
      endif
      restore screen from penvia
      exit
   enddo
   return 0

********************************
procedure FUN0001

   set color to W+/B
   @  0,  0 say Space(80)
   flogo(0, 0, "R/B", "N/B", "BG/B", .F., "W/B")
   set color to W/B
   @  0,  3 say "Pegassus"
   @  0, 58 say ititular
   set color to G+/B
   @  0, 33 say "FACTURACION"
   set color to N/W*
   @ 24,  0 say Space(80)
   set color to N/W
   jjbox(1, 0, 23, 79, "N/W", 20, 1, .F.)
   jjbox(1, 0, 6, 79, "N/W", 20, 1, .F.)
   jjbox(17, 0, 23, 79, "N/W", 20, 1, .F.)
   jjbox(17, 0, 23, 25, "N/W", 20, 1, .F.)
   jjbox(17, 57, 23, 79, "N/W", 20, 1, .F.)
   @  2,  1 say ;
      "N§ Lote:                                   Vendedor  :                        "
   @  3,  1 say ;
      "Cliente:                                   Cond.Venta:                        "
   @  4,  1 say ;
      "CUIT   :                                   Dep¢sito  :                        "
   @  5,  1 say ;
      "Bonific:      %                            L.Precios :                        "
   @  7,  1 say ;
      "  C¢digo          Descripci¢n       Cantid.  Unid  P.Unit    %Bon.   Importe "
   @ 18,  1 say "F1=consulta prec/exist. "
   @ 19,  1 say "F2=ver lotes abiertos   "
   @ 20,  1 say "F3=ver comprob.emitidos "
   @ 21,  1 say "F4=cambio de turno      "
   @ 22,  1 say "F5=CIERRE DE JORNADA    "
   @ 18, 27 say "IVA                 :        "
   @ 19, 27 say "Impuesto interno    :        "
   @ 20, 27 say "Resp. No inscripto  :        "
   @ 21, 27 say "                             "
   @ 22, 27 say "                             "
   @ 18, 58 say "Subtotal :          "
   @ 19, 58 say "Bonific. :          "
   @ 20, 58 say "Impuestos:          "
   @ 21, 58 say "         ÄÄÄÄÄÄÄÄÄÄÄ"
   @ 22, 58 say "TOTAL    :          "
   set color to B/W
   @  7, 14 say "³"
   @  7, 35 say "³"
   @  7, 45 say "³"
   @  7, 50 say "³"
   @  7, 61 say "³"
   @  7, 67 say "³"
   y:= 8
   for y:= 8 to 16
      @ y,  1 say ;
         "             ³                    ³         ³    ³          ³     ³          "
   next
   @  2, 30 say Date()
   return

********************************
procedure FUN0003

   goto top
   y:= 1
   for y:= 1 to w
      if (numero = y)
         aperfil[y][1]:= numero
         aperfil[y][2]:= nombre
         aperfil[y][3]:= var3a
         aperfil[y][4]:= var3b
         aperfil[y][5]:= var4a
         aperfil[y][6]:= var4b
         aperfil[y][7]:= var5a
         aperfil[y][8]:= var6a
         aperfil[y][9]:= var6b
         aperfil[y][10]:= var7a
         aperfil[y][11]:= var7b
         aperfil[y][12]:= var8a
         aperfil[y][13]:= var8b
         aperfil[y][14]:= var10a
         aperfil[y][15]:= var10b
         aperfil[y][16]:= var11a
         aperfil[y][17]:= var12a
         aperfil[y][18]:= var13a
         aperfil[y][19]:= var13b
         aperfil[y][20]:= var14a
         aperfil[y][21]:= var15a
         aperfil[y][22]:= var16a
         aperfil[y][23]:= var18a
      endif
      skip 
   next
   return

********************************
procedure FUN0008

   set key K_ENTER to fun0004
   if (aperfil[queperfi][10] = "E" .AND. qexist = 0)
      @  2, 56 get dato2a picture "99" valid dato2a > 0
   elseif (aperfil[queperfi][10] = "M" .OR. qexist = 1)
      set color to B/W
      @  2, 56 say dato2a picture "99"
      @  2, 59 say SubStr(codvend[ascan(codvend, Str(dato2a, 2))], ;
         4, 20)
      set color to N/W
   else
      @  2, 56 say "                       "
   endif
   if (aperfil[queperfi][8] = "E" .AND. qexist = 0)
      @  3, 56 get dato3 picture "99" valid dato3 > 0
   elseif (aperfil[queperfi][8] = "M" .OR. qexist = 1)
      set color to B/W
      @  3, 56 say dato3 picture "99"
      @  3, 59 say SubStr(condven[ascan(condven, Str(dato3, 2))], 4, ;
         20)
      set color to N/W
   else
      @  3, 56 say "                       "
   endif
   if (aperfil[queperfi][12] = "E" .AND. qexist = 0)
      @  4, 56 get dato4 picture "99" valid dato4 > 0
   elseif (aperfil[queperfi][12] = "M" .OR. qexist = 1)
      set color to B/W
      @  4, 56 say dato4 picture "99"
      @  4, 59 say SubStr(coddepo[ascan(coddepo, Str(dato4, 2))], 4, ;
         20)
      set color to N/W
   else
      @  4, 56 say "                       "
   endif
   if (dato3 > 1)
      dato5:= 2
   endif
   if (aperfil[queperfi][14] = "E" .AND. qexist = 0)
      @  5, 56 get dato5 picture "99" valid dato5 > 0
   elseif (aperfil[queperfi][14] = "M" .OR. qexist = 1)
      set color to B/W
      @  5, 56 say dato5 picture "99"
      @  5, 59 say SubStr(lista[ascan(lista, Str(dato5, 2))], 4, 20)
      set color to N/W
   else
      @  5, 56 say "                       "
   endif
   read
   SetKey(K_ENTER, Nil)
   return

********************************
procedure FUN0010

   SetKey(K_CTRL_K, Nil)
   h:= Row()
   f:= Col()
   qpn:= SubStr(SaveScreen(h, f, h, f), 1, 1)
   tecl:= ""
   queali:= 0
   olcol:= SetColor()
   set color to R/W*
   @ 24,  0 say ;
      "                                                                                "
   set color to b/w
   if (h = 3 .AND. f < 16)
      set order to 1
      if (dato6a > 0)
         seek dato6a
         if (Found())
            dato6a:= nro_client
            dato6b:= SubStr(empresa, 1, 25)
            dato6c:= tipodoc
            dato6d:= nrodoc
            dato6e:= respon
            dato6f:= direccion
            dato6g:= credito
            dato7:= porbonif
            dato3:= condvent
            if (lista > 0)
               dato5:= lista
            endif
            @  3, 10 say dato6a picture "99999"
            @  3, 16 say SubStr(dato6b, 1, 25)
            @  4, 10 say dato6d
            @  4, 24 say respiva[dato6e][3]
            SetKey(K_ENTER, Nil)
            keyboard Chr(13) + Chr(13)
         else
            dato6a:= 0
            keyboard Chr(24)
         endif
      else
         keyboard Chr(24)
      endif
   elseif (h = 3 .AND. f >= 16)
      set order to 2
      if (Len(alltrim(dato6b)) > 0)
         seek SubStr(dato6b, 1, 25)
         if (Found())
            dato6a:= nro_client
            dato6b:= SubStr(empresa, 1, 25)
            dato6c:= tipodoc
            dato6d:= nrodoc
            dato6e:= respon
            dato6f:= direccion
            dato6g:= credito
            dato7:= porbonif
            dato3:= condvent
            if (lista > 0)
               dato5:= lista
            endif
            @  3, 10 say dato6a picture "99999"
            @  3, 16 say SubStr(dato6b, 1, 25)
            @  4, 10 say dato6d
            @  4, 24 say respiva[dato6e][3]
            SetKey(K_ENTER, Nil)
            keyboard Chr(13)
         else
            rpn:= " "
            seek alltrim(dato6b)
            if (!Found())
               goto top
            endif
            datou:= fun0012(dato6b)
            if (LastKey() != K_ESC)
               datou:= Replicate("", 24) + SubStr(datou, 1, 25) + ;
                  Chr(13)
               set color to b/w
               keyboard datou
            endif
         endif
      else
         goto top
         rpn:= " "
         datou:= fun0012(dato6b)
         if (LastKey() != K_ESC)
            datou:= SubStr(datou, 1, 25) + Chr(13)
            set color to b/w
            keyboard datou
         endif
      endif
   else
      keyboard Chr(24)
   endif
   set color to R/W*
   @ 24,  0 say ;
      "      <F10>=Agregar nuevo cliente                                               "
   set color to (olcol)
   set key K_CTRL_K to fun0011
   return

********************************
procedure FUN0011

   clear gets
   SetKey(K_ENTER, Nil)
   SetKey(K_F10, Nil)
   save screen to pabmcli
   abmcol:= SetColor()
   private alista[5]
   y:= 1
   for y:= 1 to 5
      alista[y]:= Str(alistas[y][1], 2) + " " + alistas[y][2]
   next
   private respiv[7]
   private adocu[7]
   y:= 1
   for y:= 1 to 7
      respiv[y]:= Str(respiva[y][1], 2) + " " + respiva[y][3]
      adocu[y]:= Str(adocum[y][1], 2) + " " + adocum[y][3]
   next
   far:= 3
   fiz:= 1
   fab:= 17
   fde:= 70
   ancho1:= 18
   ancho2:= 43
   l1:= far + 2
   l2:= far + 3
   l3:= far + 4
   l4:= far + 5
   l5:= far + 6
   l6:= far + 7
   l7:= far + 8
   l8:= far + 9
   l13:= far + 10
   l14:= far + 11
   set color to N/W
   jcbox(far, fiz, fab, fde, "N/W", 20, 1, .T., .F., .T., "W+/B", ;
      alltrim(&bas[opcj3][2]))
   jjbox(fab, fiz, fab, fde, "W/B", 20, 5, .F.)
   jjbox(far + 1, fiz + ancho1 + 2, far + 9, fiz + ancho1 + ancho2 + ;
      3, "N/W", 20, 4, .F.)
   jjbox(far + 9, fiz + ancho1 + 2, far + 12, fiz + ancho1 + ancho2 ;
      + 3, "N/W", 20, 7, .F.)
   set order to 1
   goto bottom
   ultnum:= nro_client
   set color to N/W
   @ l1, fiz + 2 say "C¢digo de Cliente:"
   @ l2, fiz + 2 say "Raz¢n Social     :"
   @ l3, fiz + 2 say "Direcci¢n        :"
   @ l4, fiz + 2 say "Localidad        :"
   @ l4, fiz + 44 say "C.P.:"
   @ l5, fiz + 2 say "Provincia        :"
   @ l6, fiz + 2 say "Telefonos        :"
   @ l7, fiz + 2 say "Contacto         :"
   @ l8, fiz + 2 say "                  "
   @ l13, fiz + 2 say "Tipo de Documento:"
   @ l13, fiz + 45 say "N§"
   @ l14, fiz + 2 say "Responsab. I.V.A.:"
   set color to (icolora)
   @ 24,  0 say ;
      "                                                                               "
   set color to R/W*,R/W*
   save screen to pantabm
   dito1:= ultnum + 1
   dito2:= Space(30)
   dito3:= Space(30)
   dito4:= "GRAL ALVEAR         "
   dito5:= 5600
   dito6:= "MENDOZA        "
   dito7:= Space(40)
   dito8:= Space(30)
   dito9:= 0
   dito10:= 0
   dito11:= 0
   dito12a:= 0
   dito12b:= Space(14)
   dito13:= 0
   dito14:= 0
   dito15a:= 0
   dito15b:= Space(30)
   @ l1, fiz + ancho1 + 3 say dito1 picture "99999"
   @ l2, fiz + ancho1 + 3 say dito2
   @ l3, fiz + ancho1 + 3 say dito3
   @ l4, fiz + ancho1 + 3 say dito4
   @ l4, fiz + ancho1 + 32 say dito5 picture "99999"
   @ l5, fiz + ancho1 + 3 say dito6
   @ l6, fiz + ancho1 + 3 say dito7
   @ l7, fiz + ancho1 + 3 say dito8
   @ l13, fiz + ancho1 + 3 say dito12a picture "99"
   if (dito12a == 0)
      @ l13, fiz + ancho1 + 6 say "                    "
   else
      @ l13, fiz + ancho1 + 6 say adocum[dito12a][3]
   endif
   @ l13, fiz + ancho1 + 30 say dito12b
   @ l14, fiz + ancho1 + 3 say dito13 picture "99"
   if (dito12a == 1)
      @ l14, fiz + ancho1 + 6 say respiva[dito13][3]
   else
      @ l14, fiz + ancho1 + 6 say "                    "
   endif
   do while (.T.)
      set color to R/W*,R/W*
      @ l1, fiz + ancho1 + 3 get dito1 picture "99999"
      read
      if (LastKey() = K_ESC .OR. dito1 = 0)
         alert(alltrim(afrases[35]))
         exit
      endif
      seek dito1
      if (Found())
         alert(alltrim(afrases[36]))
         dito1:= 0
         loop
      endif
      do while (.T.)
         set key K_F10 to f10_99_9
         set key K_ENTER to ord99_9
         @ 24,  0 say ;
            "  F10=Opciones                                                                 "
         @ l2, fiz + ancho1 + 3 get dito2 picture "@!" valid ;
            Len(alltrim(dito2)) > 0
         @ l3, fiz + ancho1 + 3 get dito3 picture "@!" valid ;
            Len(alltrim(dito3)) > 0
         @ l4, fiz + ancho1 + 3 get dito4 picture "@!"
         @ l4, fiz + ancho1 + 32 get dito5 picture "99999"
         @ l5, fiz + ancho1 + 3 get dito6
         @ l6, fiz + ancho1 + 3 get dito7
         @ l7, fiz + ancho1 + 3 get dito8 picture "@!"
         @ l13, fiz + ancho1 + 3 get dito12a picture "99" valid ;
            dito12a > 0 .AND. dito12a <= 7
         @ l13, fiz + ancho1 + 30 get dito12b picture ;
            "99999999999999" valid Len(alltrim(dito12b)) > 0 when ;
            dito12a < 7 .AND. dito12a > 0
         @ l14, fiz + ancho1 + 3 get dito13 picture "99" valid ;
            dito13 > 0 .AND. dito13 <= 7
         read
         SetKey(K_F10, Nil)
         SetKey(K_ENTER, Nil)
         if (LastKey() == K_ESC)
            alert(alltrim(afrases[35]))
            exit
         endif
         exit
      enddo
      if (LastKey() == K_ESC)
         exit
      endif
      resp:= " "
      confirm0(15, 35)
      if (resp = "S")
         append blank
         replace nro_client with dito1
         replace empresa with dito2
         replace direccion with dito3
         replace localidad with dito4
         replace cpostal with dito5
         replace provincia with dito6
         replace telefonos with dito7
         replace contacto with dito8
         replace tipodoc with dito12a
         replace nrodoc with dito12b
         replace respon with dito13
         dato6a:= dito1
         dato6b:= dito2
         dato6c:= dito12a
         dato6d:= dito12b
         dato6e:= dito13
         dato6f:= dito3
         dato6g:= dato8 + 1
      endif
      exit
   enddo
   set color to (abmcol)
   restore screen from pabmcli
   set key K_ENTER to fun0010
   set key K_F10 to fun0011
   return

********************************
*procedure MOD1C


********************************
procedure FUN_11_1

   if (Date() > CToD("20/06/2050"))
      alert("No reconozco el Controlador Fiscal")
   else
      private contenid[0]
      set color to N/W
      mensaje("Inicializando impresor fiscal...", "N/W")
      public handler, port, n, se
      com:= "1"
      se:= ""
      n:= Val(com)
      mensaje("Abro port de comunicaciones......", "N/W")
      handler:= openport(com)
      mensaje("Establezco velocidad de comunic.", "N/W")
      setbaud(handler, 9600)
      mensaje("Inicializo el impresor..........", "N/W")
      initfiscal(handler)
      canceltick()
      closefisca()
      closenofis()
      opbasexc("BASE014", "BASE014A")
      mensaje("Inicializando variables...", "N/W")
      z:= 0
      DBEval({|| z:= z + 1}, {|| nroestac <= 2}, Nil, Nil, Nil, .F.)
      private comprob[z, 11]
      goto top
      y:= 1
      do while (!EOF())
         if (nroestac <= 2)
            comprob[y][1]:= numero
            comprob[y][2]:= nombre
            comprob[y][3]:= letra
            comprob[y][4]:= sucursal
            comprob[y][5]:= tipocomp
            comprob[y][6]:= ventas
            comprob[y][7]:= stock
            comprob[y][8]:= desde
            comprob[y][9]:= hasta
            comprob[y][10]:= ultnumero
            comprob[y][11]:= nroestac
            y:= y + 1
         endif
         skip 
      enddo
      opbassha("BASE020")
      wwpie1:= linea1
      wwpie2:= linea2
      wwpie3:= linea3
      wwpie4:= linea4
      opbasexc("BASE011", "BASE011A")
      z:= LastRec()
      private alicuota[z]
      goto top
      y:= 1
      for y:= 1 to z
         alicuota[y]:= Str(numero, 2) + " " + nombre + " " + ;
            Str(porcent, 9, 4)
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
      opbasexc("BASE017")
      y:= 1
      for y:= 1 to 8
         tefli:= "Tef" + alltrim(Str(y, 1))
         &tefli:= alltrim(codigo)
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
      if (iusuar)
         opbassha("BASE001")
         locate for RecNo() = numoper
         if (!EOF())
            totperf:= perfil1 + perfil2 + perfil3 + perfil4 + ;
               perfil5 + perfil6 + perfil7 + perfil8 + perfil9 + ;
               perfil10
            perfoper:= Str(perfil1, 1) + Str(perfil2, 1) + ;
               Str(perfil3, 1) + Str(perfil4, 1) + Str(perfil5, 1) + ;
               Str(perfil6, 1) + Str(perfil7, 1) + Str(perfil8, 1) + ;
               Str(perfil9, 1) + Str(perfil10, 1)
         endif
      endif
      opbassha("BASE016")
      if (iusuar .AND. totperf = 0)
         alert("El operador no tiene perfil de facturaci¢n asignado.")
         close databases
         select 1
         closeport(handler)
      else
         if (iusuar .AND. totperf > 0)
            private perfil[totperf]
            y:= 1
            q:= 1
            for y:= 1 to 10
               z:= Val(SubStr(perfoper, y, 1))
               if (z > 0)
                  goto top
                  locate for numero = y
                  if (!EOF())
                     perfil[q]:= Str(numero, 2) + " " + nombre
                     q:= q + 1
                  else
                     alert("Problemas en la carga de perfiles asignados...")
                  endif
               endif
            next
         else
            w:= LastRec()
            private perfil[w]
            y:= 1
            goto top
            for y:= 1 to w
               perfil[y]:= Str(numero, 2) + " " + nombre
               skip 
            next
         endif
         goto bottom
         w:= numero
         private aperfil[w, 23]
         fun0003()
         close
         save screen to apert
         nelem:= 0
         totlen:= Len(perfil)
         achoi03("Perfil", 8, 17, 10 + Len(perfil), 59, "N/BG,W+/R", ;
            1, "Seleccione modo de facturaci¢n:")
         if (LastKey() != K_ESC)
            queperfi:= Val(SubStr(perfil[nelem], 1, 2))
         else
            close databases
            select 1
            closeport(handler)
            return
         endif
         restore screen from apert
         close databases
         select 1
         do while (.T.)
            wwantici:= 0
            wwcuota1:= 0
            wwcuota2:= 0
            wwcuota3:= 0
            wwvenci1:= Date() + 30
            wwvenci2:= Date() + 60
            wwvenci3:= Date() + 90
            dato1:= 0
            dato2a:= aperfil[queperfi][11]
            dato2b:= Space(30)
            dato3:= aperfil[queperfi][9]
            dato4:= aperfil[queperfi][13]
            dato5:= aperfil[queperfi][15]
            dato6a:= aperfil[queperfi][5]
            dato6b:= aperfil[queperfi][6]
            dato6c:= "  -        - "
            dato6d:= 0
            dato6e:= Space(30)
            dato6f:= 0
            dato6g:= 0
            dato7:= 0
            dato8:= 0
            private alotes[0, 20]
            private alote[0]
            fun0001()
            opevar()
            mevoy:= 1
            set color to N/W,R/W*,,B,B/W
            save screen to pcabe
            @  2, 10 get dato1 picture "9999" valid dato1 >= 0
            read
            clovar()
            if (LastKey() = K_ESC .AND. mevoy = 1)
               exit
            endif
            if (dato1 == 0)
               loop
            endif
            set color to N/W,R/W*,,B,B/W
            @ 18,  1 clear to 22, 24
            opbasexc("LOTES")
            locate for nlote = dato1
            if (!EOF())
               fun0009()
               close
               qexist:= 1
               fun0008()
               set color to B/W
               @  3, 10 say dato6a picture "99999"
               @  3, 16 say SubStr(dato6b, 1, 25)
               @  4, 10 say dato6d
               @  4, 24 say respiva[dato6e][3]
               @  5, 10 say dato7 picture "99.99"
               set color to N/W
               qavance:= Replicate("", Len(alote))
               keyboard qavance
            else
               close
               dato6a:= aperfil[queperfi][5]
               dato6b:= SubStr(aperfil[queperfi][6], 1, 25)
               dato6c:= 0
               dato6d:= "              "
               dato6e:= 0
               dato6f:= Space(30)
               dato6g:= 0
               set color to N/W
               @  4,  1 say "CUIT   : "
               set color to B/W
               select 2
               opbassha("BASE009")
               set index to BASE009A, BASE009B, BASE009C
               set order to 1
               set color to R/W*
               @ 24,  0 say ;
                  "      <F10>=Agregar nuevo cliente                                               "
               set color to B/W
               set key K_ENTER to fun0010
               set key K_F10 to fun0011
               @  3, 10 get dato6a picture "99999"
               @  3, 16 get dato6b picture "@!"
               read
               SetKey(K_ENTER, Nil)
               SetKey(K_F10, Nil)
               close
               select 1
               if (LastKey() == K_ESC)
                  restore screen from pcabe
                  loop
               endif
               if (Len(alltrim(dato6d)) == 0)
                  dato6d:= "0"
               endif
               if (dato3 == 0)
                  dato3:= aperfil[queperfi][9]
               endif
               @  3, 10 say dato6a picture "99999"
               @  3, 16 say SubStr(dato6b, 1, 25)
               @  4, 10 say dato6d
               @  4, 24 say respiva[dato6e][3]
               @  5, 10 say dato7 picture "99.99"
               qexist:= 0
               fun0008()
               if (LastKey() == K_ESC)
                  restore screen from pcabe
                  loop
               endif
               AAdd(alotes, {0, Space(8), Space(20), "     ", " ", ;
                  " ", 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, " ", 0, 0, ;
                  Space(40)})
               AAdd(alote, ;
                  "-->          ³                    ³         ³    ³          ³     ³          ")
               keyboard Chr(13)
            endif
            salida:= 0
            do while (.T.)
               set color to B/W
               y:= 8
               for y:= 8 to 16
                  @ y,  1 say ;
                     "             ³                    ³         ³    ³          ³     ³          "
               next
               set color to B/W,R/W*,,B,B/W
               qsal5:= 0
               salida:= 0
               totlen:= Len(alote)
               achoice(8, 1, 16, 78, alote, .T., "UserFac")
               do case
               case salida = 1
                  exit
               case salida = 2
                  AAdd(alotes, {0, Space(8), Space(20), "     ", ;
                     " ", " ", 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, " ", 0, ;
                     0, Space(40)})
                  AAdd(alote, ;
                     "-->          ³                    ³         ³    ³          ³     ³          ")
                  qmanda:= Replicate("", totlen) + Chr(13)
                  keyboard qmanda
               case salida = 3
                  qmanda:= Replicate("", totlen - 2)
                  keyboard qmanda
               case salida = 4
                  exit
               case salida = 5
                  qmanda:= Replicate("", qsal5)
                  keyboard qmanda
               endcase
            enddo
            set color to R/W*
            @ 24,  0
            set color to N/W,R/W*,,B,B/W
            if (salida == 1)
               loop
            endif
            close databases
            select 1
            opcion1:= 1
            do while (.T.)
               set message to 24 center
               @ 18,  1 say "                        "
               @ 19,  1 say "                        "
               @ 20,  1 say "                        "
               @ 21,  1 say "                        "
               @ 22,  1 say "                        "
               @ 18,  2 prompt " 1- Guardar lote     "
               @ 19,  2 prompt " 2- Cierre de lote   "
               @ 20,  2 prompt " 3- Modificar datos  "
               @ 21,  2 prompt " 4- Anular carga     "
               menu to opcion1
               do case
               case opcion1 = 1
                  fun0007()
                  exit
               case opcion1 = 2
                  save screen to popc2
                  @ 18,  1 say "                        "
                  @ 19,  1 say "                        "
                  @ 20,  1 say "                        "
                  @ 21,  1 say "                        "
                  @ 22,  1 say "                        "
                  opcion2:= aperfil[queperfi][4]
                  resp:= " "
                  wwtt:= Len(comprob)
                  wwxx:= 21 - wwtt
                  jjbox(wwxx - 1, 4, wwxx + wwtt, 27, "N/W", 20, 1, ;
                     .T.)
                  do while (opcion2 != 0)
                     ok:= 0
                     if (Len(comprob) >= 1)
                        @ wwxx,  5 prompt ;
                           alltrim(Str(comprob[1][1])) + " " + ;
                           comprob[1][2]
                     endif
                     if (Len(comprob) >= 2)
                        @ wwxx + 1,  5 prompt ;
                           alltrim(Str(comprob[2][1])) + " " + ;
                           comprob[2][2]
                     endif
                     if (Len(comprob) >= 3)
                        @ wwxx + 2,  5 prompt ;
                           alltrim(Str(comprob[3][1])) + " " + ;
                           comprob[3][2]
                     endif
                     if (Len(comprob) >= 4)
                        @ wwxx + 3,  5 prompt ;
                           alltrim(Str(comprob[4][1])) + " " + ;
                           comprob[4][2]
                     endif
                     if (Len(comprob) >= 5)
                        @ wwxx + 4,  5 prompt ;
                           alltrim(Str(comprob[5][1])) + " " + ;
                           comprob[5][2]
                     endif
                     if (Len(comprob) >= 6)
                        @ wwxx + 5,  5 prompt ;
                           alltrim(Str(comprob[6][1])) + " " + ;
                           comprob[6][2]
                     endif
                     if (Len(comprob) >= 7)
                        @ wwxx + 6,  5 prompt ;
                           alltrim(Str(comprob[7][1])) + " " + ;
                           comprob[7][2]
                     endif
                     if (Len(comprob) >= 8)
                        @ wwxx + 7,  5 prompt ;
                           alltrim(Str(comprob[8][1])) + " " + ;
                           comprob[8][2]
                     endif
                     if (Len(comprob) >= 9)
                        @ wwxx + 8,  5 prompt ;
                           alltrim(Str(comprob[9][1])) + " " + ;
                           comprob[9][2]
                     endif
                     if (Len(comprob) >= 10)
                        @ wwxx + 9,  5 prompt ;
                           alltrim(Str(comprob[10][1])) + " " + ;
                           comprob[10][2]
                     endif
                     menu to opcion2
                     if (opcion2 > 0)
                        resp:= " "
                        emitir()
                        exit
                     endif
                  enddo
                  restore screen from popc2
                  if (resp = "S")
                     exit
                  endif
                  set color to N/W,R/W*,,B,B/W
               case opcion1 = 3
                  qexist:= 0
                  fun0008()
                  opcion1:= 1
               case opcion1 = 4
                  exit
               endcase
            enddo
         enddo
         close databases
         select 1
         closeport(handler)
         return
      endif
   endif

********************************
procedure FUN0007

   opbasexc("LOTES")
   y:= 1
   for y:= 1 to Len(alotes)
      append blank
      replace nlote with dato1
      replace cod with alotes[y][2]
      replace nombre with alotes[y][3]
      replace unidad with alotes[y][4]
      replace llevastk with alotes[y][5]
      replace stkasoc with alotes[y][6]
      replace precio1 with alotes[y][7]
      replace precio2 with alotes[y][8]
      replace precio3 with alotes[y][9]
      replace precio4 with alotes[y][10]
      replace precio5 with alotes[y][11]
      replace numiva with alotes[y][12]
      replace sosutaiva with alotes[y][13]
      replace nimpint with alotes[y][14]
      replace impintfij with alotes[y][15]
      replace sosutai_i with alotes[y][16]
      replace ret_a_rni with alotes[y][17]
      replace nvend with dato2a
      replace cvend with dato2b
      replace bonific with alotes[y][18]
      replace cantidad with alotes[y][1]
      replace contotal with alotes[y][19]
      replace nombrecom with alotes[y][20]
      replace condventa with dato3
      replace deposito with dato4
      replace lista with dato5
      replace clnumero with dato6a
      replace clnombre with dato6b
      replace cltipdoc with dato6c
      replace clnrodoc with dato6d
      replace clrespon with dato6e
      replace cldirecc with dato6f
      replace clcredit with dato6g
      replace clporbon with dato7
   next
   close
   return

********************************
procedure FUN0009

   y:= 1
   dato8:= 0
   do while (.T.)
      dato1:= nlote
      dato2a:= nvend
      dato2b:= cvend
      dato3:= condventa
      dato4:= deposito
      dato5:= lista
      dato6a:= clnumero
      dato6b:= clnombre
      dato6c:= cltipdoc
      dato6d:= clnrodoc
      dato6e:= clrespon
      dato6f:= cldirecc
      dato6g:= clcredit
      dato7:= clporbon
      do case
      case dato5 = 1
         qpr:= precio1
         qimp:= Round(precio1 * cantidad * (1 - bonific / 100), 2)
         dato8:= dato8 + precio1 * cantidad * (1 - bonific / 100)
      case dato5 = 2
         qpr:= precio2
         qimp:= Round(precio2 * cantidad * (1 - bonific / 100), 2)
         dato8:= dato8 + precio2 * cantidad * (1 - bonific / 100)
      case dato5 = 3
         qpr:= precio3
         qimp:= Round(precio3 * cantidad * (1 - bonific / 100), 2)
         dato8:= dato8 + precio3 * cantidad * (1 - bonific / 100)
      case dato5 = 4
         qpr:= precio4
         qimp:= Round(precio4 * cantidad * (1 - bonific / 100), 2)
         dato8:= dato8 + precio4 * cantidad * (1 - bonific / 100)
      case dato5 = 5
         qpr:= precio5
         qimp:= Round(precio5 * cantidad * (1 - bonific / 100), 2)
         dato8:= dato8 + precio5 * cantidad * (1 - bonific / 100)
      endcase
      AAdd(alote, "   " + cod + "  ³" + nombre + "³" + Str(cantidad, ;
         9, 2) + "³" + SubStr(unidad, 1, 4) + "³" + Str(qpr, 9, 2) + ;
         " ³" + Str(bonific, 5, 2) + "³" + Str(qimp, 10, 2))
      AAdd(alotes, {cantidad, cod, nombre, unidad, llevastk, ;
         stkasoc, precio1, precio2, precio3, precio4, precio5, ;
         numiva, sosutaiva, nimpint, impintfij, sosutai_i, ;
         ret_a_rni, bonific, contotal, nombrecom})
      delete
      skip 
      if (EOF())
         exit
      endif
      if (nlote != dato1)
         exit
      endif
      y:= y + 1
   enddo
   set color to B/W
   @ 18, 68 say dato8 picture "9999999.99"
   @ 22, 68 say dato8 picture "9999999.99"
   set color to N/W
   pack
   return

********************************
function CANCELTICK

   s:= "D" + se + " " + se + "0.00" + se + "C" + se + "0"
   mandapaq(handler, s)
   return 0

********************************
function CLOSEFISCA

   s:= "E"
   mandapaq(handler, s)
   return 0

********************************
function CLOSENOFIS

   s:= ""
   mandapaq(handler, s)
   return 0

********************************
procedure EMITIR

   save screen to pcf
   do while (.T.)
      restore screen from pcf
      wfecha:= Date()
      whora:= Time()
      wwtpf:= comprob[opcion2][3]
      if (dato3 == 2)
         if (aperfil[queperfi][16] = 1 .AND. dato8 > dato6g)
            confcol:= SetColor()
            confir:= 1
            loncf1:= Len(alltrim("Autoriza"))
            loncf2:= Len(alltrim("Cancela"))
            loncf3:= Len(alltrim("El cliente supera cr‚dito m ximo"))
            if (loncf1 + loncf2 + 6 > loncf3)
               loncf:= loncf1 + loncf2 + 6
            else
               loncf:= loncf3
            endif
            set color to W+/R,W+/B
            par:= 10
            piz:= 20
            save screen to pppr
            prinsn:= "N"
            do while (confir != 0)
               jjbox(par, piz, par + 4, piz + loncf + 3, "W+/R", 20, ;
                  5, .T.)
               @ par + 1, piz + 2 say ;
                  alltrim("El cliente supera cr‚dito m ximo")
               @ par + 3, piz + 6 prompt " " + alltrim("Autoriza") + ;
                  " "
               @ par + 3, piz + 6 + loncf1 + 6 prompt " " + ;
                  alltrim("Cancela") + " "
               set wrap on
               menu to confir
               if (confir = 1)
                  prinsn:= "S"
                  exit
               elseif (confir = 2)
                  prinsn:= "N"
                  exit
               endif
            enddo
            set color to (confcol)
            restore screen from pppr
            if (prinsn = "N")
               exit
            endif
         elseif (aperfil[queperfi][16] = 2 .AND. dato8 > dato6g)
            alert("El cliente supera cr‚dito m ximo...")
            exit
         endif
      endif
      if (dato6e <= 4 .OR. dato6e = 6)
         if (dato6c != 1)
            alert("Incoherencia entre Resp.IVA y Tipo de documento")
            exit
         endif
      endif
      if (resptitu == 1)
         if (wwtpf = "A" .AND. dato6e > 2)
            alert("Al comprador no le corresponde un comprobante A.")
            exit
         endif
         if (wwtpf = "D" .AND. dato6e > 2)
            alert("Al comprador no le corresponde un comprobante A.")
            exit
         endif
         if (wwtpf = "R" .AND. dato6e > 2)
            alert("Al comprador no le corresponde un comprobante A.")
            exit
         endif
         if (wwtpf = "B" .AND. dato6e <= 2)
            alert("Al comprador no le corresponde un comprobante B.")
            exit
         endif
         if (wwtpf = "E" .AND. dato6e <= 2)
            alert("Al comprador no le corresponde un comprobante B.")
            exit
         endif
         if (wwtpf = "S" .AND. dato6e <= 2)
            alert("Al comprador no le corresponde un comprobante B.")
            exit
         endif
      endif
      set color to R/W*
      @ 24,  0 say ;
         "                                                                                "
      set color to N/W
      if (aperfil[queperfi][7] = "E")
         @  5, 10 get dato7 picture "99.99"
         read
         if (LastKey() == K_ESC)
            exit
         endif
      elseif (aperfil[queperfi][7] = "M")
         @  5, 10 say dato7 picture "99.99"
      elseif (aperfil[queperfi][7] = "O")
         @  5, 10 say "     "
      endif
      wwnumero:= comprob[opcion2][10] + 1
      wwtpf:= comprob[opcion2][3]
      if (wwtpf = "O")
         dato3:= 2
      endif
      wwncref:= ""
      wwnomcli:= alltrim(dato6b)
      wwtipdoc:= adocum[dato6c][2]
      wwnrodoc:= alltrim(dato6d)
      wwresiva:= respiva[dato6e][2]
      wwdircli:= alltrim(dato6f)
      wwline03:= " "
      wwline04:= " "
      wwline05:= "Condici¢n de venta: " + ;
         alltrim(SubStr(condven[ascan(condven, Str(dato3, 2))], 4, ;
         30))
      wwdescue:= dato7
      wwrenoin:= Val(SubStr(alicuota[ascan(alicuota, "70")], 25, 9))
      mbase:= 0
      miva:= 0
      mimpint:= 0
      mretrni:= 0
      mdescu:= 0
      mtotal:= 0
      set color to B/W
      @ 18, 48 say miva picture "99999.99"
      @ 19, 48 say mimpint picture "99999.99"
      @ 20, 48 say mretrni picture "99999.99"
      @ 18, 68 say dato8 * (1 - dato7 / 100) picture "9999999.99"
      @ 19, 68 say mdescu picture "9999999.99"
      @ 20, 68 say miva + mimpint + mretrni picture "9999999.99"
      @ 22, 68 say mtotal picture "9999999.99"
      set color to N/W
      save screen to pconf
      resp:= " "
      confirm0(17, 30)
      restore screen from pconf
      if (resp = "S")
         mensaje("Imprimiendo comprobante...", "N/W")
         todook:= imprimecom()
         if (todook < 0)
            canceltick()
            closenofis()
            restore screen from pcf
            resp:= " "
            loop
         endif
         opbasexc("BASE014", "BASE014A")
         seek opcion2
         if (Found())
            replace ultnumero with wwnumero
            comprob[opcion2][10]:= wwnumero
         else
            alert("Ojo, no encontr‚ el tipo de Comprobante")
         endif
         close
         fun0015()
         if (dato3 = 2 .AND. comprob[opcion2][5] != "N")
            fun0016()
         endif
         if (comprob[opcion2][7] = "S")
            fun0017()
         endif
         exit
      else
         exit
      endif
      restore screen from pcf
   enddo
   restore screen from pcf
   return

********************************
function IMPRIMECOM

   do while (.T.)
      wwline05:= "Operador: " + alltrim(nomoper)
      wwline06:= "Vendedor: " + alltrim(dato2b)
      wwline11:= "Total Items: " + alltrim(Str(Len(alotes), 5))
      wws:= "]" + se + "5" + se + wwline05
      qerr:= enviar(wws)
      if (qerr < 0)
         return -1
      endif
      wws:= "]" + se + "6" + se + wwline06
      qerr:= enviar(wws)
      if (qerr < 0)
         return -1
      endif
      j:= "ô" + ;
         alltrim(SubStr(condven[ascan(condven, Str(dato3, 2))], 4, ;
         20))
      wws:= "]" + se + "7" + se + j
      qerr:= enviar(wws)
      if (qerr < 0)
         return -1
      endif
      wws:= "]" + se + "11" + se + wwline11
      qerr:= enviar(wws)
      if (qerr < 0)
         return -1
      endif
      if (comprob[opcion2][3] != "T")
         j:= alltrim(dato6f)
         wws:= "]" + se + "9" + se + j
         qerr:= enviar(wws)
         if (qerr < 0)
            return -1
         endif
         wws:= "b" + se + alltrim(dato6b) + se + alltrim(dato6d) + ;
            se + respiva[dato6e][2] + se + adocum[dato6c][2]
         qerr:= enviar(wws)
         if (qerr < 0)
            return -1
         endif
      endif
      wfecha:= Date()
      whora:= Time()
      if (wwtpf = "O")
         wws:= "H"
         qerr:= enviar(wws)
         if (qerr < 0)
            return -1
         endif
         linnofis:= "----------------------------------------"
         wws:= "I" + se + linnofis + se + "0"
         qerr:= enviar(wws)
         if (qerr < 0)
            return -1
         endif
         linnofis:= "ORDEN DE COMPRA Nro " + strzero(wwnumero, 8)
         wws:= "I" + se + linnofis + se + "0"
         qerr:= enviar(wws)
         if (qerr < 0)
            return -1
         endif
         linnofis:= "Autorizo a Aries Comco SRL a debitar el"
         wws:= "I" + se + linnofis + se + "0"
         qerr:= enviar(wws)
         if (qerr < 0)
            return -1
         endif
         linnofis:= "importe de la presente en la Cuenta"
         wws:= "I" + se + linnofis + se + "0"
         qerr:= enviar(wws)
         if (qerr < 0)
            return -1
         endif
         linnofis:= "de: " + dato6b
         wws:= "I" + se + linnofis + se + "0"
         qerr:= enviar(wws)
         if (qerr < 0)
            return -1
         endif
         linnofis:= "----------------------------------------"
         wws:= "I" + se + linnofis + se + "0"
      else
         wws:= "@" + se + wwtpf + se + "T"
      endif
      qerr:= enviar(wws)
      if (qerr < 0)
         return -1
      endif
      y:= 1
      for y:= 1 to Len(alotes)
         do case
         case dato5 = 1
            qpr:= alotes[y][7]
         case dato5 = 2
            qpr:= alotes[y][8]
         case dato5 = 3
            qpr:= alotes[y][9]
         case dato5 = 4
            qpr:= alotes[y][10]
         case dato5 = 5
            qpr:= alotes[y][11]
         endcase
         if (alotes[y][18] != 0)
            qpr:= qpr - qpr * (alotes[y][18] / 100)
         endif
         iminfij:= Val(Str(alotes[y][15], 12, 4))
         qnombr:= alotes[y][3]
         qcanti:= alotes[y][1]
         qiva:= ;
            Val(SubStr(alicuota[ascan(alicuota, Str(alotes[y][12], ;
            2))], 25, 9))
         piva:= alltrim(Str(qiva, 5, 2))
         if (Val(alltrim(Str(qpr, 12, 4))) < Val(alltrim(Str(qpr, ;
               10, 2))))
            iminfij:= Val(Str(alotes[y][15], 12, 4)) * qcanti
            qnombr:= SubStr(alltrim(Str(qcanti, 10, 1)) + ;
               SubStr(alotes[y][4], 1, 2) + "/$" + alltrim(Str(qpr, ;
               12, 4)) + " " + alotes[y][3], 1, 20)
            qpr:= Round(qpr * qcanti, 2)
            qcanti:= 1
         endif
         if (Val(Str(alotes[y][14], 2)) == 40)
            prebase:= (qpr - iminfij) / (1 + qiva / 100)
            porimpu:= iminfij / prebase * 100
            fk:= 1 / (1 + porimpu / 100)
            if (fk == 1)
               kk:= "0.00"
            else
               kk:= "+" + alltrim(Str(fk, 10, 8))
            endif
         else
            porimpu:= ;
               Val(SubStr(alicuota[ascan(alicuota, Str(alotes[y][14], ;
               2))], 25, 9))
            fk:= 1 / (1 + porimpu / 100)
            if (fk == 1)
               kk:= "0.00"
            else
               kk:= alltrim(Str(fk, 10, 8))
            endif
         endif
         miv:= qpr * (1 - 1 / (1 + qiva / 100 * fk)) * qcanti
         mimpi:= (qpr * qcanti - miv) / (100 + porimpu) * porimpu
         mbas:= qpr * qcanti - mimpi - miv
         mtot:= qpr * qcanti
         mbase:= mbase + mbas
         miva:= miva + miv
         mimpint:= mimpint + mimpi
         mtotal:= mtotal + mtot
         if (wwtpf = "O")
            linnofis:= Str(qcanti, 9, 3) + " " + SubStr(qnombr, 1, ;
               19) + " $" + Str(mtot, 9, 2)
            wws:= "I" + se + linnofis + se + "0"
         else
            wws:= "B" + se + alltrim(qnombr) + se + ;
               alltrim(Str(qcanti, 10, 3)) + se + alltrim(Str(qpr, ;
               10, 2)) + se + piva + se + "M" + se + kk + se + "0" + ;
               se + "T"
         endif
         qerr:= enviar(wws)
         if (qerr < 0)
            return -1
         endif
      next
      gdesc:= mtotal * dato7 / 100
      mtotal:= mtotal - gdesc
      if (gdesc != 0)
         if (gdesc > 0)
            if (wwtpf = "O")
               linnofis:= "Bonificaci¢n " + alltrim(Str(dato7, 5, ;
                  1)) + "%" + Space(11) + "$" + Str(gdesc * -1, 9, 2)
               wws:= "I" + se + linnofis + se + "0"
            else
               gdc:= "Bonificaci¢n " + alltrim(Str(dato7, 5, 1)) + "%"
               wws:= "T" + se + gdc + se + alltrim(Str(gdesc, 9, 2)) ;
                  + se + "m" + se + "0" + se + "T"
            endif
         else
            if (wwtpf = "O")
               gde:= gdesc * -1
               linnofis:= "Recargo " + alltrim(Str(dato7, 5, 1)) + ;
                  "%" + Space(16) + "$" + Str(gde, 9, 2)
               wws:= "I" + se + linnofis + se + "0"
            else
               gde:= gdesc * -1
               gdc:= "Recargo " + alltrim(Str(dato7, 5, 2)) + "%"
            endif
            wws:= "T" + se + gdc + se + alltrim(Str(gde, 9, 2)) + se ;
               + "M" + se + "0" + se + "T"
         endif
         qerr:= enviar(wws)
         if (qerr < 0)
            return -1
         endif
         mdescu:= gdesc
         miva:= miva - (gdesc - gdesc / (1 + qiva / 100))
         mbase:= Round(mtotal, 2) - Round(mimpint, 2) - Round(miva, 2)
      endif
      if (dato6e == 2)
         qrni:= Val(SubStr(alicuota[ascan(alicuota, "70")], 25, 9))
         mretrni:= miva * qrni / 100
         mtotal:= mtotal + mretrni
      endif
      if (wwtpf = "O")
         wws:= "P" + se + "4"
         qerr:= enviar(wws)
         if (qerr < 0)
            return -1
         endif
         linnofis:= "Firma:"
         wws:= "I" + se + linnofis + se + "0"
         qerr:= enviar(wws)
         if (qerr < 0)
            return -1
         endif
         linnofis:= "----------------------------------------"
         wws:= "I" + se + linnofis + se + "0"
         qerr:= enviar(wws)
         if (qerr < 0)
            return -1
         endif
         wws:= "J"
      else
         wws:= "E"
      endif
      qerr:= enviar(wws)
      if (qerr < 0)
         return -1
      endif
      numerocomp()
      wws:= "]" + se + "5" + se + ""
      qerr:= enviar(wws)
      if (qerr < 0)
         return -1
      endif
      wws:= "]" + se + "6" + se + ""
      qerr:= enviar(wws)
      if (qerr < 0)
         return -1
      endif
      wws:= "]" + se + "9" + se + ""
      qerr:= enviar(wws)
      if (qerr < 0)
         return -1
      endif
      wws:= "]" + se + "7" + se + ""
      qerr:= enviar(wws)
      if (qerr < 0)
         return -1
      endif
      wws:= "]" + se + "11" + se + ""
      qerr:= enviar(wws)
      if (qerr < 0)
         return -1
      endif
      exit
   enddo
   return 0

********************************
procedure FUN0015

   opbasexc("FACTURAS")
   append blank
   replace fecha with wfecha
   replace hora with whora
   replace ivaventas with comprob[opcion2][6]
   replace nroestac with comprob[opcion2][11]
   replace sucursal with comprob[opcion2][4]
   replace numero with comprob[opcion2][10]
   replace tipocomp with comprob[opcion2][5]
   replace ntipo with comprob[opcion2][1]
   replace letra with comprob[opcion2][3]
   replace lote with dato1
   replace nvend with dato2a
   replace vendedor with dato2b
   replace ncondvent with dato3
   replace condvent with ;
      SubStr(condven[ascan(condven, Str(dato3, 2))], 4, 20)
   replace ndeposito with dato4
   replace deposito with ;
      SubStr(coddepo[ascan(coddepo, Str(dato4, 2))], 4, 20)
   replace nlista with dato5
   replace lista with SubStr(lista[dato5], 4, 20)
   replace ncliente with dato6a
   replace cliente with dato6b
   replace tipodoc with dato6c
   replace nrodoc with dato6d
   replace respon with dato6e
   replace direccion with dato6f
   replace descuento with mdescu
   replace totbase with Round(mbase, 2)
   replace iva with Round(miva, 2)
   replace impint with Round(mimpint, 2)
   replace retrni with Round(mretrni, 2)
   replace total with Round(mtotal, 2)
   if (wwtpf = "O")
      opbasexc("MAYORORD", "NUMAYORD")
   else
      opbasexc("MAYORFAC", "NUMAYFAC")
   endif
   append blank
   replace ncaja with qwncaja
   replace qfecha with qwfecha
   replace fecha with wfecha
   replace hora with whora
   replace ivaventas with comprob[opcion2][6]
   replace nroestac with comprob[opcion2][11]
   replace sucursal with comprob[opcion2][4]
   replace numero with comprob[opcion2][10]
   replace tipocomp with comprob[opcion2][5]
   replace ntipo with comprob[opcion2][1]
   replace letra with comprob[opcion2][3]
   replace lote with dato1
   replace nvend with dato2a
   replace vendedor with dato2b
   replace ncondvent with dato3
   replace condvent with ;
      SubStr(condven[ascan(condven, Str(dato3, 2))], 4, 20)
   replace ndeposito with dato4
   replace deposito with ;
      SubStr(coddepo[ascan(coddepo, Str(dato4, 2))], 4, 20)
   replace nlista with dato5
   replace lista with SubStr(lista[dato5], 4, 20)
   replace ncliente with dato6a
   replace cliente with dato6b
   replace tipodoc with dato6c
   replace nrodoc with dato6d
   replace respon with dato6e
   replace direccion with dato6f
   replace descuento with mdescu
   replace totbase with Round(mbase, 2)
   replace iva with Round(miva, 2)
   replace impint with Round(mimpint, 2)
   replace retrni with Round(mretrni, 2)
   replace total with Round(mtotal, 2)
   close
   return

********************************
procedure FUN0016

   opbasexc("BASE009", "BASE009A")
   seek dato6a
   if (Found())
      wwolsald:= saldo
      replace saldo with wwolsald - mtotal
   else
      alert("Oh, No encuentro el cliente...")
      close
      return
   endif
   opbasexc("BASE018", "BASE018C")
   append blank
   replace fecha with wfecha
   replace nro_compr with strzero(comprob[opcion2][4], 4) + ;
      strzero(comprob[opcion2][10], 8)
   replace tipo with comprob[opcion2][3]
   replace concepto with "Compr." + comprob[opcion2][3] + " N§" + ;
      strzero(comprob[opcion2][4], 4) + ;
      strzero(comprob[opcion2][10], 8)
   replace nro_client with dato6a
   replace cliente with dato6b
   qmfv:= Month(Date()) + 1
   qafv:= Year(Date())
   if (qmfv > 12)
      qmfv:= 1
      qafv:= qafv + 1
   endif
   replace fechavto with CToD("01/" + Str(qmfv, 2) + "/" + Str(qafv, ;
      4))
   replace debito with mtotal
   replace totalfac with mtotal
   close
   return

********************************
procedure FUN0017

   opbasexc("BASE003", "BASE003A")
   y:= 1
   for y:= 1 to Len(alotes)
      seek alotes[y][2]
      if (Found())
         if (llevastk = "S")
            oldexist:= existenc
            replace existenc with oldexist - alotes[y][1]
         endif
      endif
   next
   close
   opbasexc("ARTVENDI")
   goto top
   y:= 1
   for y:= 1 to Len(alotes)
      goto top
      locate for cod == alotes[y][2]
      do case
      case dato5 = 1
         qpr:= alotes[y][7]
      case dato5 = 2
         qpr:= alotes[y][8]
      case dato5 = 3
         qpr:= alotes[y][9]
      case dato5 = 4
         qpr:= alotes[y][10]
      case dato5 = 5
         qpr:= alotes[y][11]
      endcase
      if (!EOF())
         oldcant:= cantidad
         oldtota:= total
         newcant:= oldcant + alotes[y][1]
         newtota:= oldtota + Round(alotes[y][1] * qpr, 2)
         replace total with newtota
         replace cantidad with newcant
      else
         append blank
         replace cod with alotes[y][2]
         replace nombre with alotes[y][3]
         replace cantidad with alotes[y][1]
         replace total with Round(alotes[y][1] * qpr, 2)
         replace nombrecom with alotes[y][20]
      endif
   next
   close
   opbasexc("ITEMVEND")
   y:= 1
   for y:= 1 to Len(alotes)
      do case
      case dato5 = 1
         qpr:= alotes[y][7]
      case dato5 = 2
         qpr:= alotes[y][8]
      case dato5 = 3
         qpr:= alotes[y][9]
      case dato5 = 4
         qpr:= alotes[y][10]
      case dato5 = 5
         qpr:= alotes[y][11]
      endcase
      append blank
      replace comprob with comprob[opcion2][3] + ;
         strzero(comprob[opcion2][4], 4) + ;
         strzero(comprob[opcion2][10], 8)
      replace cod with alotes[y][2]
      replace fecha with wfecha
      replace nombre with alotes[y][3]
      replace nombrecom with alotes[y][20]
      replace unidad with alotes[y][4]
      replace cantidad with alotes[y][1]
      replace lista with dato5
      replace subtotal with Round(alotes[y][1] * qpr, 2)
      replace nvend with dato2a
      replace cvend with dato2b
   next
   close
   return

********************************
procedure FUN_15_3

   jjbox(12, 14, 17, 67, "N/W", 20, 1, .T.)
   set color to B/W,R/W*,,B,B/W
   opbasexc("BASE020")
   wwpie1z:= linea1
   wwpie2z:= linea2
   wwpie3z:= linea3
   wwpie4z:= linea4
   @ 13, 16 get wwpie1z
   @ 14, 16 get wwpie2z
   @ 15, 16 get wwpie3z
   @ 16, 16 get wwpie4z
   read
   if (LastKey() == K_ESC)
      alert("No se modific¢ la leyenda de pie de factura.")
   else
      replace linea1 with wwpie1z
      replace linea2 with wwpie2z
      replace linea3 with wwpie3z
      replace linea4 with wwpie4z
   endif
   close
   return

********************************
function PLANILLA

   clear gets
   save screen to pplani
   olcol:= SetColor()
   opbassha("FACTURAS")
   qwtvent:= 0
   DBEval({|| qwtvent:= qwtvent + total}, {|| control1 = 0}, Nil, ;
      Nil, Nil, .F.)
   opbasexc("LECTURAS")
   goto bottom
   xda1:= surta1
   xda2:= surta2
   xda3:= surta3
   xda4:= surta4
   xda5:= surtb1
   xda6:= surtb2
   xda7:= surtb3
   xda8:= surtb4
   xda9:= surtc1
   xda10:= surtc2
   xda11:= surtc3
   xda12:= surtc4
   xda13:= surtd1
   xda14:= surtd2
   xda15:= surtd3
   xda16:= surtd4
   opbasexc("SURTIDOR")
   y:= 1
   for y:= 1 to 16
      qd:= "xda" + alltrim(Str(y, 2))
      qsurt:= "surti" + alltrim(Str(y, 2))
      replace lec_ant with &qd
      if (lec_act < &qd)
         replace lec_act with &qd
         replace corrida with 0
         replace tot_vol with 0
         replace total with 0
      endif
      &qsurt:= surtid + " " + SubStr(combus, 1, 18) + "³" + jjva1() ;
         + " " + jjva2() + "³" + jjva3() + "³" + jjva4() + "³" + ;
         jjva5() + "³" + jjva6()
      skip 
   next
   jjbox(0, 0, 24, 79, "N/W", 20, 1, .F.)
   set color to G+/B
   @  0,  0 say ;
      "                    PLANILLA RENDICION DIARIA DE TURNO                          "
   set color to R/W*
   @ 24,  0 say ;
      "                                                                                "
   set color to N/W
   @  1,  1 say ;
      "Surtid    Combustible    ³ L.Actual  L.Anter.³Corrid³Tot.lts³V/unit³  Subtotal"
   @  2,  1 say ;
      "                                                                              "
   @  3,  1 say ;
      "                                                                              "
   @  4,  1 say ;
      "                                                                              "
   @  5,  1 say ;
      "                                                                              "
   @  6,  1 say ;
      "ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ    0.0ÄÄÄÄÄÄÄÄ      0.00"
   @  7,  1 say ;
      "                                                                              "
   @  8,  1 say ;
      "                                                                              "
   @  9,  1 say ;
      "                                                                              "
   @ 10,  1 say ;
      "                                                                              "
   @ 11,  1 say ;
      "ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ    0.0ÄÄÄÄÄÄÄÄ      0.00"
   @ 12,  1 say ;
      "                                                                              "
   @ 13,  1 say ;
      "                                                                              "
   @ 14,  1 say ;
      "                                                                              "
   @ 15,  1 say ;
      "                                                                              "
   @ 16,  1 say ;
      "ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ    0.0ÄÄÄÄÄÄÄÄ      0.00"
   @ 17,  1 say ;
      "                                                                              "
   @ 18,  1 say ;
      "                                                                              "
   @ 19,  1 say ;
      "                                                                              "
   @ 20,  1 say ;
      "                                                                              "
   @ 21,  1 say ;
      "ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ    0.0ÄÄÄÄÄÄÄÄ      0.00"
   @ 22,  1 say ;
      "                                                                              "
   @ 23,  1 say ;
      "    COMBUSTIBLES $           + OTROS $           = TOTAL VENTA $              "
   set color to B/W
   @ 23, 66 say qwtvent picture "9999999.99"
   set color to N/W
   opplan:= 1
   set key K_F9 to cambcomb
   set key K_F10 to arqucaja
   qwtla:= qwtta:= 0
   DBEval({|| (qwtla:= qwtla + tot_vol, qwtta:= qwtta + total)}, {|| ;
      bateria = "A"}, Nil, Nil, Nil, .F.)
   qwtlb:= qwttb:= 0
   DBEval({|| (qwtlb:= qwtlb + tot_vol, qwttb:= qwttb + total)}, {|| ;
      bateria = "B"}, Nil, Nil, Nil, .F.)
   qwtlc:= qwttc:= 0
   DBEval({|| (qwtlc:= qwtlc + tot_vol, qwttc:= qwttc + total)}, {|| ;
      bateria = "C"}, Nil, Nil, Nil, .F.)
   qwtld:= qwttd:= 0
   DBEval({|| (qwtld:= qwtld + tot_vol, qwttd:= qwttd + total)}, {|| ;
      bateria = "D"}, Nil, Nil, Nil, .F.)
   qwtcomb:= qwtta + qwttb + qwttc + qwttd
   set color to B/W
   @  6, 54 say qwtla picture "99999.9"
   @ 11, 54 say qwtlb picture "99999.9"
   @ 16, 54 say qwtlc picture "99999.9"
   @ 21, 54 say qwtld picture "99999.9"
   @  6, 69 say qwtta picture "9999999.99"
   @ 11, 69 say qwttb picture "9999999.99"
   @ 16, 69 say qwttc picture "9999999.99"
   @ 21, 69 say qwttd picture "9999999.99"
   @ 23, 19 say qwtcomb picture "9999999.99"
   do while (.T.)
      set color to R/W*
      @ 24,  0 say ;
         "    F9=Cambiar tipo de combust.        F10=Arqueo de caja                       "
      set color to N/W
      qwsal:= 0
      @  2,  1 prompt surti1
      @  3,  1 prompt surti2
      @  4,  1 prompt surti3
      @  5,  1 prompt surti4
      @  7,  1 prompt surti5
      @  8,  1 prompt surti6
      @  9,  1 prompt surti7
      @ 10,  1 prompt surti8
      @ 12,  1 prompt surti9
      @ 13,  1 prompt surti10
      @ 14,  1 prompt surti11
      @ 15,  1 prompt surti12
      @ 17,  1 prompt surti13
      @ 18,  1 prompt surti14
      @ 19,  1 prompt surti15
      @ 20,  1 prompt surti16
      menu to opplan
      if (opplan = 0 .AND. qwsal = 0)
         exit
      elseif (LastKey() = K_ENTER)
         SetKey(K_F9, Nil)
         SetKey(K_F10, Nil)
         do case
         case opplan > 0 .AND. opplan <= 4
            h:= opplan + 1
         case opplan >= 5 .AND. opplan <= 8
            h:= opplan + 2
         case opplan >= 9 .AND. opplan <= 12
            h:= opplan + 3
         case opplan > 12
            h:= opplan + 4
         endcase
         setcursor(1)
         goto top
         locate for RecNo() = opplan
         if (!EOF())
            qsurt:= "surti" + alltrim(Str(opplan, 2))
            @ h,  1 say &qsurt
            qlact:= lec_act
            qcorr:= corrida
            @ h, 27 get qlact picture "9999999.9" valid qlact >= ;
               lec_ant
            @ h, 47 get qcorr picture "9999.9"
            read
            if (LastKey() != K_ESC)
               replace lec_act with qlact
               replace corrida with qcorr
               replace tot_vol with Round(lec_act - lec_ant - ;
                  corrida, 1)
               replace total with Round(tot_vol * p_unitar, 2)
               &qsurt:= surtid + " " + SubStr(combus, 1, 18) + "³" + ;
                  jjva1() + " " + jjva2() + "³" + jjva3() + "³" + ;
                  jjva4() + "³" + jjva5() + "³" + jjva6()
               qwtla:= qwtta:= 0
               DBEval({|| (qwtla:= qwtla + tot_vol, qwtta:= qwtta + ;
                  total)}, {|| bateria = "A"}, Nil, Nil, Nil, .F.)
               qwtlb:= qwttb:= 0
               DBEval({|| (qwtlb:= qwtlb + tot_vol, qwttb:= qwttb + ;
                  total)}, {|| bateria = "B"}, Nil, Nil, Nil, .F.)
               qwtlc:= qwttc:= 0
               DBEval({|| (qwtlc:= qwtlc + tot_vol, qwttc:= qwttc + ;
                  total)}, {|| bateria = "C"}, Nil, Nil, Nil, .F.)
               qwtld:= qwttd:= 0
               DBEval({|| (qwtld:= qwtld + tot_vol, qwttd:= qwttd + ;
                  total)}, {|| bateria = "D"}, Nil, Nil, Nil, .F.)
               qwtcomb:= qwtta + qwttb + qwttc + qwttd
               qwtotro:= qwtvent - qwtcomb
               set color to B/W
               @  6, 54 say qwtla picture "99999.9"
               @ 11, 54 say qwtlb picture "99999.9"
               @ 16, 54 say qwtlc picture "99999.9"
               @ 21, 54 say qwtld picture "99999.9"
               @  6, 69 say qwtta picture "9999999.99"
               @ 11, 69 say qwttb picture "9999999.99"
               @ 16, 69 say qwttc picture "9999999.99"
               @ 21, 69 say qwttd picture "9999999.99"
               @ 23, 19 say qwtcomb picture "9999999.99"
               set color to N/W
            endif
         else
            alert("Oh!! No encuentro el surtidor.")
         endif
         setcursor(0)
         set key K_F9 to cambcomb
         set key K_F10 to arqucaja
      endif
   enddo
   SetKey(K_F9, Nil)
   SetKey(K_F10, Nil)
   set color to (olcol)
   restore screen from pplani
   close
   if (LastKey() == K_ESC)
      mevoy:= 0
   endif
   select 1
   return Nil

********************************
function JJVA1

   if (lec_act > 0)
      jjv:= Str(lec_act, 9, 1)
   else
      jjv:= "         "
   endif
   return jjv

********************************
function JJVA2

   if (lec_ant > 0)
      jjv:= Str(lec_ant, 9, 1)
   else
      jjv:= "         "
   endif
   return jjv

********************************
function JJVA3

   if (corrida > 0)
      jjv:= Str(corrida, 6, 1)
   else
      jjv:= "      "
   endif
   return jjv

********************************
function JJVA4

   if (tot_vol > 0)
      jjv:= Str(tot_vol, 7, 1)
   else
      jjv:= "       "
   endif
   return jjv

********************************
function JJVA5

   if (p_unitar > 0)
      jjv:= Str(p_unitar, 6, 3)
   else
      jjv:= "      "
   endif
   return jjv

********************************
function JJVA6

   if (total > 0)
      jjv:= Str(total, 10, 2)
   else
      jjv:= "          "
   endif
   return jjv

********************************
procedure CAMBCOMB

   olcol:= SetColor()
   h:= Row()
   SetKey(K_F9, Nil)
   SetKey(K_F10, Nil)
   setcursor(1)
   select 2
   opbassha("BASE003", "BASE003A")
   goto top
   campy:= "SUBSTR(COD+' '+NOMBRECOM,1,45)"
   cuanhay:= LastRec()
   save screen to p13_2
   boxshadow(h - 1, 0, h - 1, 5)
   brow03(campy, 10, 20, "N/BG", "N/BG,W+/R", "NOMBRECOM", 2)
   restore screen from p13_2
   if (LastKey() != K_ESC)
      qcod:= cod
      qnom:= nombrered
      qpre:= precio1
      select 1
      goto top
      locate for RecNo() = opplan
      replace codcombus with qcod
      replace combus with qnom
      replace p_unitar with qpre
      qsurt:= "surti" + alltrim(Str(opplan, 2))
      &qsurt:= surtid + " " + SubStr(combus, 1, 18) + "³" + jjva1() ;
         + " " + jjva2() + "³" + jjva3() + "³" + jjva4() + "³" + ;
         jjva5() + "³" + jjva6()
      qwsal:= 1
      keyboard Chr(27)
   endif
   select 2
   close
   select 1
   setcursor(0)
   set key K_F9 to cambcomb
   set key K_F10 to arqucaja
   set color to (olcol)
   return

********************************
procedure ARQUCAJA

   SetKey(K_F9, Nil)
   SetKey(K_F10, Nil)
   save screen to parca
   mensaje("Computando items vendidos           .", "N/W")
   olcol1:= SetColor()
   setcursor(1)
   set color to R/W*
   @ 24,  0 say ;
      "                                                                                "
   set color to N/W
   index on codcombus to qwcod unique
   qwreg:= 0
   y:= 1
   goto top
   do while (!EOF())
      if (Len(alltrim(codcombus)) > 0)
         qwreg:= qwreg + 1
         qwcod:= "qwcod" + alltrim(Str(qwreg))
         &qwcod:= codcombus
      endif
      skip 
   enddo
   set index to 
   y:= 1
   qwatick:= 0
   private alotes[0, 20]
   select 3
   opbassha("BASE003", "BASE003A")
   select 2
   opbassha("ArtVendi")
   select 1
   for y:= 1 to qwreg
      qwtt:= "qwtt" + alltrim(Str(y))
      qwcod:= "qwcod" + alltrim(Str(y))
      qwttic:= "qwttic" + alltrim(Str(y))
      qwtati:= "qwtati" + alltrim(Str(y))
      &qwtt:= 0
      DBEval(&("{|| &qwtt := &qwtt + tot_vol}"), ;
         &("{|| codcombus==&qwcod}"), Nil, Nil, Nil, .F.)
      select 2
      goto top
      locate
      if (!EOF())
         &qwttic:= cantidad
         &qwtati:= &qwtt - &qwttic
      else
         &qwttic:= 0
         &qwtati:= &qwtt - &qwttic
      endif
      if (&qwtati < 0)
         alert("ATENCION: Posible lectura incorrecta en combust." + ;
            &qwcod)
         select 3
         close
         select 2
         close
         select 1
         restore screen from parca
         return
      endif
      select 3
      seek &qwcod
      if (Found())
         qwcantid:= &qwtati * precio1
         qwatick:= qwatick + qwcantid
         AAdd(alotes, {&qwtati, cod, nombrered, unidad, llevastk, ;
            stkasoc, precio1, precio2, precio3, precio4, precio5, ;
            numiva, sosutaiva, nimpint, impintfij, sosutai_i, ;
            ret_a_rni, bonific, 1, nombrecom})
      else
         alert("Oh, no encuentro el c¢digo del combustible")
      endif
      select 1
   next
   select 3
   close
   select 2
   close
   select 1
   opbassha("FACTURAS")
   qwtvent:= 0
   DBEval({|| qwtvent:= qwtvent + total}, {|| control1 = 0}, Nil, ;
      Nil, Nil, .F.)
   qwctacte:= 0
   DBEval({|| qwctacte:= qwctacte + total}, {|| control1 = 0 .AND. ;
      ncondvent = 2}, Nil, Nil, Nil, .F.)
   close
   qwtvent:= qwtvent + qwatick
   qwtotro:= qwtvent - qwtcomb
   qwefecti:= 0
   qwtarjet:= 0
   qwcheque:= 0
   qwretadm:= 0
   qwvale1:= 0
   qwdifer:= qwtvent - qwctacte
   set color to N/W
   jjbox(6, 19, 20, 55, "N/W", 20, 1, .T.)
   @  7, 20 say " Subtotal combustibles $" + Str(qwtcomb, 10, 2) + " "
   @  8, 20 say " Subtotal otros        $" + Str(qwtotro, 10, 2) + " "
   @  9, 20 say "                       ÄÄÄÄÄÄÄÄÄÄÄÄ"
   @ 10, 20 say " Total Vendido         $" + Str(qwtvent, 10, 2) + " "
   @ 11, 20 say "                                   "
   @ 12, 20 say "          Efectivo     $           "
   @ 13, 20 say "          Cuenta Cte.  $           "
   @ 14, 20 say "          Tarjetas     $           "
   @ 15, 20 say "          Cheques      $           "
   @ 16, 20 say "          Ret.Administ $           "
   @ 17, 20 say "          Vales        $           "
   @ 18, 20 say "                       ÄÄÄÄÄÄÄÄÄÄÄÄ"
   @ 19, 20 say "          DIFERENCIA   $" + Str(qwdifer, 10, 2) + " "
   set key K_ENTER to qwsume
   @ 12, 44 get qwefecti picture "9999999.99"
   @ 13, 44 get qwctacte picture "9999999.99"
   @ 14, 44 get qwtarjet picture "9999999.99"
   @ 15, 44 get qwcheque picture "9999999.99"
   @ 16, 44 get qwretadm picture "9999999.99"
   @ 17, 44 get qwvale1 picture "9999999.99"
   read
   SetKey(K_ENTER, Nil)
   if (LastKey() != K_ESC)
      save screen to pconf
      resp:= " "
      confirm0(20, 30)
      restore screen from pconf
      if (resp = "S")
         confplan()
         keyboard Chr(27)
      endif
   endif
   select 1
   opbasexc("SURTIDOR")
   goto top
   setcursor(0)
   set color to (olcol1)
   restore screen from parca
   set key K_F9 to cambcomb
   set key K_F10 to arqucaja
   return

********************************
procedure CONFPLAN

   SetKey(K_F10, Nil)
   setcursor(1)
   save screen to parca
   if (qwatick > 0)
      do while (.T.)
         restore screen from parca
         save screen to pppr
         confcol:= SetColor()
         prinsn:= "N"
         confir:= 1
         loncf1:= Len(alltrim("Continue"))
         loncf2:= Len(alltrim("Cancele"))
         loncf3:= Len(alltrim("Se imprimir  ticket compensador."))
         if (loncf1 + loncf2 + 6 > loncf3)
            loncf:= loncf1 + loncf2 + 6
         else
            loncf:= loncf3
         endif
         set color to W+/R,N/W*
         par:= 10
         piz:= 20
         do while (confir != 0)
            jjbox(par, piz, par + 4, piz + loncf + 3, "W+/R", 20, 5, ;
               .T.)
            @ par + 1, piz + 2 say ;
               alltrim("Se imprimir  ticket compensador.")
            @ par + 3, piz + 6 prompt " " + alltrim("Continue") + " "
            @ par + 3, piz + 6 + loncf1 + 6 prompt " " + ;
               alltrim("Cancele") + " "
            set wrap on
            menu to confir
            if (confir = 1)
               prinsn:= "S"
               exit
            elseif (confir = 2)
               prinsn:= "N"
               exit
            endif
         enddo
         if (prinsn = "N")
            restore screen from parca
            return
         endif
         set color to (confcol)
         restore screen from parca
         mensaje("Imprimiendo ticket compensador...   .", "N/W")
         dato1:= 0
         dato2a:= aperfil[queperfi][11]
         dato3:= aperfil[queperfi][9]
         dato4:= aperfil[queperfi][13]
         dato5:= 1
         dato6a:= 1
         dato6b:= "A CONSUMIDOR FINAL"
         dato6c:= 7
         dato6d:= "  -        - "
         dato6e:= 5
         dato6f:= Space(30)
         dato7:= 0
         dato8:= 0
         dato2b:= "ôT¡cket de ajuste"
         opcion2:= 3
         wwtpf:= "T"
         wfecha:= Date()
         whora:= Time()
         wwncref:= ""
         wwnumero:= comprob[opcion2][10]
         wwnomcli:= alltrim(dato6b)
         wwtipdoc:= adocum[dato6c][2]
         wwnrodoc:= alltrim(dato6d)
         wwresiva:= respiva[dato6e][2]
         wwdircli:= alltrim(dato6f)
         wwline03:= " "
         wwline04:= " "
         wwline05:= "Condici¢n de venta: " + ;
            alltrim(SubStr(condven[ascan(condven, Str(dato3, 2))], ;
            4, 30))
         wwdescue:= dato7
         wwrenoin:= Val(SubStr(alicuota[ascan(alicuota, "70")], 25, ;
            9))
         mbase:= 0
         miva:= 0
         mimpint:= 0
         mretrni:= 0
         mdescu:= 0
         mtotal:= 0
         todook:= imprimecom()
         if (todook < 0)
            canceltick()
            restore screen from parca
            return
         endif
         restore screen from parca
         opbasexc("BASE014", "BASE014A")
         seek opcion2
         if (Found())
            replace ultnumero with wwnumero
            comprob[opcion2][10]:= wwnumero
         else
            alert("Ojo, no encontr‚ el tipo de Comprobante")
         endif
         close
         fun0015()
         fun0017()
         exit
      enddo
   else
      alert("No hay direrencia a tickar")
   endif
   restore screen from parca
   if (qwxz == 0)
      mensaje("Imprimiendo informe fiscal...       .", "N/W")
      todook:= imprimexz()
      if (todook < 0)
         canceltick()
         restore screen from parca
      endif
   else
      mensaje("Imprimiendo cierre de jorn. fiscal...", "N/W")
      todook:= imprimexz()
      if (todook < 0)
         canceltick()
         restore screen from parca
      endif
   endif
   restore screen from parca
   mensaje("Sumando ventas por vendedor...", "N/W")
   opbassha("BASE008", "BASE008A")
   mmm:= LastRec() + 1
   private ventavend[mmm, 3]
   ventavend[1][1]:= 0
   ventavend[1][2]:= "T¡ckets de ajuste             "
   ventavend[1][3]:= 0
   y:= 2
   do while (!EOF())
      ventavend[y][1]:= numero
      ventavend[y][2]:= nombre
      ventavend[y][3]:= 0
      skip 
      y:= y + 1
   enddo
   opbassha("FACTURAS")
   if (!EOF())
      y:= 1
      for y:= 1 to mmm
         ttvveenn:= 0
         DBEval({|| ttvveenn:= ttvveenn + total}, {|| nvend = ;
            ventavend[y][1] .AND. control1 = 0}, Nil, Nil, Nil, .F.)
         ventavend[y][3]:= ttvveenn
      next
   endif
   close
   restore screen from parca
   mensaje("Imprimiendo ¡tems vendidos...       .", "N/W")
   todook:= quevendi()
   if (todook < 0)
      restore screen from parca
   endif
   mensaje("Actualizando registros de lecturas...", "N/W")
   opbasexc("SURTIDOR")
   goto top
   y:= 1
   for y:= 1 to 16
      qd:= "xda" + alltrim(Str(y, 2))
      &qd:= lec_act
      replace lec_ant with &qd
      replace corrida with 0
      replace tot_vol with 0
      replace total with 0
      skip 
   next
   opbasexc("LECTURAS")
   append blank
   replace fecha with Date()
   replace surta1 with xda1
   replace surta2 with xda2
   replace surta3 with xda3
   replace surta4 with xda4
   replace totsurta with qwtta
   replace surtb1 with xda5
   replace surtb2 with xda6
   replace surtb3 with xda7
   replace surtb4 with xda8
   replace totsurtb with qwttb
   replace surtc1 with xda9
   replace surtc2 with xda10
   replace surtc3 with xda11
   replace surtc4 with xda12
   replace totsurtc with qwttc
   replace surtd1 with xda13
   replace surtd2 with xda14
   replace surtd3 with xda15
   replace surtd4 with xda16
   replace totsurtd with qwttd
   replace total with qwtcomb
   close
   opbasexc("mayortur")
   append blank
   replace pncaja with qwncaja
   replace pfecha with qwfecha
   replace ptotal with qwtvent
   replace pefecti with qwefecti
   replace pctacte with qwctacte
   replace ptarjet with qwtarjet
   replace pcheque with qwcheque
   replace pretiro with qwretadm
   replace pvales with qwvale1
   replace pdifer with qwdifer
   close
   rtncaja:= Str(qwncaja, 10)
   if (Val(SubStr(rtncaja, 10, 1)) == 3)
      qwncaja:= qwncaja + 8
   else
      qwncaja:= qwncaja + 1
   endif
   opbasexc("est01")
   replace qncaja with qwncaja
   close
   restore screen from parca
   mensaje("Actualizando registros de comprobantes...", "N/W")
   if (qwxz == 0)
      opbasexc("FACTURAS")
      DBEval({|| field->control1:= 1}, Nil, Nil, Nil, Nil, .F.)
      close
   else
      opbasexc("FACTURAS")
      zap
      opbasexc("est01")
      replace qfecha with Date() + 1
      qwfecha:= Date() + 1
      close
   endif
   opbasexc("ARTVENDI")
   goto top
   if (qwxz == 0)
      do while (!EOF())
         oldcanta:= cantacum
         oldtotac:= totalacum
         replace cantacum with cantidad + oldcanta
         replace totalacum with total + oldtotac
         replace cantidad with 0
         replace total with 0
         skip 
      enddo
   else
      do while (!EOF())
         oldcanta:= cantacum
         oldtotac:= totalacum
         replace cantacum with cantidad + oldcanta
         replace totalacum with total + oldtotac
         replace cantidad with 0
         replace total with 0
         skip 
      enddo
      restore screen from parca
      mensaje("Imprimiendo items vendido en el d¡a...", "N/W")
      todook:= quevendiz()
      if (todook < 0)
         restore screen from parca
      endif
      opbasexc("ARTVENDI")
      zap
   endif
   close
   setcursor(0)
   SetKey(K_F10, Nil)
   return

********************************
procedure QWSUME

   qwh:= Row()
   qwdifer:= qwtvent - qwefecti - qwctacte - qwtarjet - qwcheque - ;
      qwretadm - qwvale1
   @ 19, 44 say qwdifer picture "9999999.99"
   if (qwh == 17)
      SetKey(K_ENTER, Nil)
      keyboard Chr(13)
   else
      keyboard Chr(24)
   endif
   return

********************************
procedure CIERRE

   clovar()
   olcol:= SetColor()
   qwxz:= 1
   planilla()
   set color to (olcol)
   opevar()
   return

********************************
procedure EQUIS

   clovar()
   olcol:= SetColor()
   qwxz:= 0
   planilla()
   set color to (olcol)
   opevar()
   return

********************************
function QUEVENDI

   wws:= "H"
   qerr:= enviar(wws)
   if (qerr < 0)
      return -1
   endif
   linnofis:= "----------------------------------------"
   wws:= "I" + se + linnofis + se + "0"
   qerr:= enviar(wws)
   if (qerr < 0)
      return -1
   endif
   linnofis:= "ôVenta del turno"
   wws:= "I" + se + linnofis + se + "0"
   qerr:= enviar(wws)
   if (qerr < 0)
      return -1
   endif
   linnofis:= " "
   wws:= "I" + se + linnofis + se + "0"
   qerr:= enviar(wws)
   if (qerr < 0)
      return -1
   endif
   linnofis:= "Cantidad    Articulo            Importe"
   wws:= "I" + se + linnofis + se + "0"
   qerr:= enviar(wws)
   if (qerr < 0)
      return -1
   endif
   opbasexc("ARTVENDI")
   index on cod to arvenntx
   otrostot:= 0
   goto top
   do while (!EOF())
      if (cantidad > 0)
         if (Val(SubStr(cod, 1, 2)) < 3)
            linnofis:= Str(cantidad, 8, 2) + " " + nombre + " " + ;
               Str(total, 10, 2)
            wws:= "I" + se + linnofis + se + "0"
            qerr:= enviar(wws)
            if (qerr < 0)
               return -1
            endif
         else
            otrostot:= otrostot + total
         endif
      endif
      skip 
   enddo
   close
   if (otrostot > 0)
      linnofis:= "  Global SERVICOMPRAS........ " + Str(otrostot, ;
         10, 2)
      wws:= "I" + se + linnofis + se + "0"
      qerr:= enviar(wws)
      if (qerr < 0)
         return -1
      endif
   endif
   linnofis:= "----------------------------------------"
   wws:= "I" + se + linnofis + se + "0"
   qerr:= enviar(wws)
   if (qerr < 0)
      return -1
   endif
   linnofis:= "ôVenta por Vendedor"
   wws:= "I" + se + linnofis + se + "0"
   qerr:= enviar(wws)
   if (qerr < 0)
      return -1
   endif
   linnofis:= " "
   wws:= "I" + se + linnofis + se + "0"
   qerr:= enviar(wws)
   if (qerr < 0)
      return -1
   endif
   y:= 1
   for y:= 1 to Len(ventavend)
      if (ventavend[y][3] > 0)
         linnofis:= SubStr(ventavend[y][2], 1, 25) + " " + ;
            Str(ventavend[y][3], 10, 2)
         wws:= "I" + se + linnofis + se + "0"
         qerr:= enviar(wws)
         if (qerr < 0)
            return -1
         endif
      endif
   next
   linnofis:= "----------------------------------------"
   wws:= "I" + se + linnofis + se + "0"
   qerr:= enviar(wws)
   if (qerr < 0)
      return -1
   endif
   linnofis:= "ôArqueo de caja"
   wws:= "I" + se + linnofis + se + "0"
   qerr:= enviar(wws)
   if (qerr < 0)
      return -1
   endif
   linnofis:= " "
   wws:= "I" + se + linnofis + se + "0"
   qerr:= enviar(wws)
   if (qerr < 0)
      return -1
   endif
   if (qwefecti > 0)
      linnofis:= "       Efectivo       $" + Str(qwefecti, 10, 2)
      wws:= "I" + se + linnofis + se + "0"
      qerr:= enviar(wws)
      if (qerr < 0)
         return -1
      endif
   endif
   if (qwctacte > 0)
      linnofis:= "       Cta. Corriente $" + Str(qwctacte, 10, 2)
      wws:= "I" + se + linnofis + se + "0"
      qerr:= enviar(wws)
      if (qerr < 0)
         return -1
      endif
   endif
   if (qwtarjet > 0)
      linnofis:= "       Tarjetas Cred. $" + Str(qwtarjet, 10, 2)
      wws:= "I" + se + linnofis + se + "0"
      qerr:= enviar(wws)
      if (qerr < 0)
         return -1
      endif
   endif
   if (qwcheque > 0)
      linnofis:= "       Cheques        $" + Str(qwcheque, 10, 2)
      wws:= "I" + se + linnofis + se + "0"
      qerr:= enviar(wws)
      if (qerr < 0)
         return -1
      endif
   endif
   if (qwretadm > 0)
      linnofis:= "       Retiro Aminist $" + Str(qwretadm, 10, 2)
      wws:= "I" + se + linnofis + se + "0"
      qerr:= enviar(wws)
      if (qerr < 0)
         return -1
      endif
   endif
   if (qwvale1 > 0)
      linnofis:= "       Vales          $" + Str(qwvale1, 10, 2)
      wws:= "I" + se + linnofis + se + "0"
      qerr:= enviar(wws)
      if (qerr < 0)
         return -1
      endif
   endif
   if (qwdifer != 0)
      linnofis:= "       Diferencia     $" + Str(qwdifer, 10, 2)
      wws:= "I" + se + linnofis + se + "0"
      qerr:= enviar(wws)
      if (qerr < 0)
         return -1
      endif
   endif
   linnofis:= "----------------------------------------"
   wws:= "I" + se + linnofis + se + "0"
   qerr:= enviar(wws)
   if (qerr < 0)
      return -1
   endif
   wws:= "J"
   qerr:= enviar(wws)
   if (qerr < 0)
      return -1
   endif
   return 0

********************************
function QUEVENDIZ

   private contenid[0]
   wws:= "H"
   qerr:= enviar(wws)
   if (qerr < 0)
      return -1
   endif
   linnofis:= "----------------------------------------"
   wws:= "I" + se + linnofis + se + "0"
   qerr:= enviar(wws)
   if (qerr < 0)
      return -1
   endif
   linnofis:= "ôVentas del d¡a"
   wws:= "I" + se + linnofis + se + "0"
   qerr:= enviar(wws)
   if (qerr < 0)
      return -1
   endif
   linnofis:= " "
   wws:= "I" + se + linnofis + se + "0"
   qerr:= enviar(wws)
   if (qerr < 0)
      return -1
   endif
   linnofis:= "Cantidad    Articulo            Importe"
   wws:= "I" + se + linnofis + se + "0"
   qerr:= enviar(wws)
   if (qerr < 0)
      return -1
   endif
   otrostot:= 0
   goto top
   do while (!EOF())
      if (cantacum > 0)
         if (Val(SubStr(cod, 1, 2)) < 3)
            linnofis:= Str(cantacum, 8, 2) + " " + nombre + " " + ;
               Str(totalacum, 10, 2)
            wws:= "I" + se + linnofis + se + "0"
            qerr:= enviar(wws)
            if (qerr < 0)
               return -1
            endif
         else
            otrostot:= otrostot + total
         endif
      endif
      skip 
   enddo
   close
   if (otrostot > 0)
      linnofis:= "  Global SERVICOMPRAS........ " + Str(otrostot, ;
         10, 2)
      wws:= "I" + se + linnofis + se + "0"
      qerr:= enviar(wws)
      if (qerr < 0)
         return -1
      endif
   endif
   linnofis:= "----------------------------------------"
   wws:= "I" + se + linnofis + se + "0"
   qerr:= enviar(wws)
   if (qerr < 0)
      return -1
   endif
   wws:= "J"
   qerr:= enviar(wws)
   if (qerr < 0)
      return -1
   endif
   return 0

********************************
function IMPRIMEXZ

   private contenid[0]
   if (qwxz == 0)
      wws:= "9" + se + "X"
   else
      wws:= "9" + se + "Z"
   endif
   qerr:= enviar(wws)
   if (qerr < 0)
      return -1
   endif
   return 0

********************************
procedure NUMEROCOMP

   mandapaq(handler, "*")
   result:= respuesta(handler)
   if (wwtpf = "A")
      wwnumero:= Val(SubStr(result, 25, 8))
   elseif (wwtpf = "B")
      wwnumero:= Val(SubStr(result, 11, 8))
   elseif (wwtpf = "T")
      wwnumero:= Val(SubStr(result, 11, 8))
   endif
   return

* EOF
