#include "common.ch"
#include "inkey.ch"

********************************
procedure ABM_PROM

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
      + 2 prompt " " + alltrim(afrases[32]) + " "
   @ abmlin, abmcol + 1 + Len(alltrim(afrases[25])) + 2 + ;
      Len(alltrim(afrases[26])) + 2 + Len(alltrim(afrases[27])) + 2 ;
      + Len(alltrim(afrases[28])) + 2 + Len(alltrim(afrases[29])) + ;
      2 + Len(alltrim(afrases[30])) + 2 + Len(alltrim(afrases[31])) ;
      + 2 + Len(alltrim(afrases[32])) + 2 prompt " " + ;
      alltrim(afrases[33]) + " "
   @ abmlin, abmcol + 1 + Len(alltrim(afrases[25])) + 2 + ;
      Len(alltrim(afrases[26])) + 2 + Len(alltrim(afrases[27])) + 2 ;
      + Len(alltrim(afrases[28])) + 2 + Len(alltrim(afrases[29])) + ;
      2 + Len(alltrim(afrases[30])) + 2 + Len(alltrim(afrases[31])) ;
      + 2 + Len(alltrim(afrases[32])) + 2 + ;
      Len(alltrim(afrases[33])) + 2 prompt " " + ;
      alltrim(afrases[34]) + " "
   return

********************************
procedure PRINTSN

   parameters par, piz
   confcol:= SetColor()
   confir:= 1
   loncf1:= Len(alltrim(afrases[18]))
   loncf2:= Len(alltrim(afrases[19]))
   loncf3:= Len(alltrim(afrases[40]))
   if (loncf1 + loncf2 + 6 > loncf3)
      loncf:= loncf1 + loncf2 + 6
   else
      loncf:= loncf3
   endif
   do while (confir != 0)
      jjbox(par, piz, par + 4, piz + loncf + 1, "W+/R", 20, 5, .T.)
      set color to W+/R,W+/B
      @ par + 1, piz + 2 say alltrim(afrases[40])
      @ par + 3, piz + 2 prompt " " + alltrim(afrases[18]) + " "
      @ par + 3, piz + 2 + loncf1 + 2 prompt " " + ;
         alltrim(afrases[19]) + " "
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
   return

********************************
procedure ACHOI01

   colbrow:= SetColor()
   parameters bloke, barr1, bizq1, baba1, bder1, talon, bcol1, ;
      bcol2, bcol3, titu
   jcbox(barr1, bizq1, baba1 + talon, bder1, bcol1, 20, 1, .T., .F., ;
      .F., "W+/B", titu)
   jjbox(barr1 + 1, bizq1 + 1, baba1 - 1, bder1 - 1, bcol2, 20, 4, ;
      .F.)
   set color to (bcol1)
   @ baba1, bizq1 + 3 say SubStr(afrases[6], 1, 14)
   set color to (bcol3)
   achoice(barr1 + 2, bizq1 + 2, baba1 - 2, bder1 - 2, &bloke, .T., ;
      "UserFunc")
   set color to (colbrow)
   return

procedure FUN_12_1

   nelem:= 0
   totlen:= Len(alistas)
   col131:= "N/W*,W+/B"
   set key K_ENTER to modif121
   keyboard Chr(24)
   private alista[totlen]
   y:= 1
   for y:= 1 to totlen
      alista[y]:= alistas[y][2]
   next
   achoi01("ALISTA", 9, 25, 21, 60, 1, "N/W", "N/W", col131, ;
      "Nombres de listas")
   SetKey(K_ENTER, Nil)
   if (nelem > 0)
      opbasexc("BASE010")
      y:= 1
      for y:= 1 to totlen
         replace nombre with alistas[y][2]
         skip 
      next
      close
   endif
   select 1
   return

********************************
procedure MODIF121

   SetKey(K_ENTER, Nil)
   h:= Row()
   save screen to pmod_acc
   set color to N/W,R/W*
   qniv:= alistas[nelem][2]
   setcursor(1)
   @ baba1, bizq1 + 2 say "                "
   @ baba1, bizq1 + 2 say "Descrip.:" get qNiv valid ;
      Len(alltrim(qniv)) > 0
   read
   setcursor(0)
   if (LastKey() != K_ESC)
      alistas[nelem][2]:= qniv
      alista[nelem]:= qniv
      if (nelem == 1)
         keyboard Chr(24) + Chr(5)
      else
         keyboard Chr(5) + Chr(24)
      endif
   endif
   restore screen from pmod_acc
   set color to (col131)
   set key K_ENTER to modif121
   return

********************************
procedure FUN_12_2

   nelem:= 0
   totlen:= Len(alistas)
   col131:= "N/W*,W+/B"
   set key K_ENTER to modif122
   keyboard Chr(24)
   private alista[totlen]
   y:= 1
   for y:= 1 to totlen
      if (alistas[y][4] = "S")
         alista[y]:= alistas[y][2] + "->Activa"
      else
         alista[y]:= alistas[y][2] + "        "
      endif
   next
   achoi01("ALISTA", 9, 25, 21, 60, 1, "N/W", "N/W", col131, ;
      "Activar listas   ")
   SetKey(K_ENTER, Nil)
   if (nelem > 0)
      opbasexc("BASE010")
      y:= 1
      for y:= 1 to totlen
         replace habilit with alistas[y][4]
         skip 
      next
      close
   endif
   select 1
   return

********************************
procedure MODIF122

   SetKey(K_ENTER, Nil)
   h:= Row()
   save screen to pmod_acc
   set color to N/W,R/W*
   qniv:= alistas[nelem][4]
   if (qniv = "S")
      alistas[nelem][4]:= "N"
      alista[nelem]:= alistas[nelem][2] + "        "
   else
      alistas[nelem][4]:= "S"
      alista[nelem]:= alistas[nelem][2] + "->Activa"
   endif
   if (nelem == 1)
      keyboard Chr(24) + Chr(5)
   else
      keyboard Chr(5) + Chr(24)
   endif
   restore screen from pmod_acc
   set color to (col131)
   set key K_ENTER to modif122
   return

********************************
procedure FUN_13_1

   @ 24,  0
   far:= 7
   fiz:= 1
   fab:= 21
   fde:= 70
   ancho1:= 16
   ancho2:= 30
   l1:= far + 2
   l2:= far + 4
   l3:= far + 6
   l4:= far + 8
   l5:= far + 10
   set color to N/W
   jcbox(far, fiz, fab, fde, "N/W", 20, 1, .T., .F., .T., "W+/B", ;
      alltrim(&bas[opcj3][2]))
   jjbox(fab, fiz, fab, fde, "W/B", 20, 5, .F.)
   jjbox(far + 1, fiz + ancho1 + 2, far + 3, fiz + ancho1 + ancho2 + ;
      3, "N/W", 20, 4, .F.)
   jjbox(far + 3, fiz + ancho1 + 2, far + 5, fiz + ancho1 + ancho2 + ;
      3, "N/W", 20, 7, .F.)
   opbasexc("BASE008")
   set index to BASE008A, BASE008B
   set order to 1
   goto bottom
   ultnum:= numero
   goto top
   opc27:= 1
   do while (opc27 != 0)
      setblink(.F.)
      ver_13_1()
      set message to 24 center
      set color to W+/B,B/W*
      abm_prom(fab, fiz)
      set wrap on
      menu to opc27
      do case
      case opc27 = 1
         set color to R/W*,R/W*
         save screen to pantabm
         aca:= numero
         dato1:= ultnum + 1
         dato2:= "                    "
         mtr13_1()
         do while (.T.)
            set color to R/W*,R/W*
            @ l1, fiz + ancho1 + 3 get dato1 picture "99"
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
               get13_1()
               read
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
               rpl13_1()
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
         confirm0(15, 35)
         if (resp = "S")
            delete
            pack
            goto bottom
            ultnum:= numero
         endif
         restore screen from pantabm
      case opc27 = 3
         set color to R/W*,R/W*
         save screen to pantabm
         aca:= numero
         dato1:= numero
         dato2:= nombre
         mtr13_1()
         do while (.T.)
            set color to R/W*,R/W*
            get13_1()
            read
            if (LastKey() == K_ESC)
               alert(alltrim(afrases[35]))
               seek aca
               exit
            endif
            resp:= " "
            confirm0(15, 30)
            if (resp = "S")
               rpl13_1()
            else
               seek aca
            endif
            exit
         enddo
         restore screen from pantabm
      case opc27 = 4
         set color to R/W*,R/W*
         save screen to pantabm
         aca:= numero
         dato1:= ultnum + 1
         dato2:= nombre
         mtr13_1()
         do while (.T.)
            set color to R/W*,R/W*
            @ l1, fiz + ancho1 + 3 get dato1 picture "99"
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
               get13_1()
               read
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
               rpl13_1()
               ultnum:= numero
               seek dato1
            else
               seek aca
            endif
            exit
         enddo
         restore screen from pantabm
      case opc27 = 5
         save screen to pantabm
         campos:= "SUBSTR(STR(NUMERO,3)+' '+NOMBRE,1,34)"
         acata:= RecNo()
         set order to 2
         brow02(campos, 10, 3, "N/BG+", "N/W*,W+/R", "NOMBRE", 2)
         set order to 1
         goto top
         locate for RecNo() = acata
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
         goto top
         restore screen from pantabm
      case opc27 = 9
         save screen to pantabm
         goto bottom
         restore screen from pantabm
      case opc27 = 10
         save screen to pantabm
         prinsn:= " "
         printsn(12, 30)
         if (prinsn = "S")
            prn13_1()
         endif
         restore screen from pantabm
      endcase
   enddo
   set color to (icolora)
   return

********************************
procedure VER_13_1

   set color to N/W
   @ l1, fiz + 2 say alltrim(afrases[20])
   @ l2, fiz + 2 say alltrim(afrases[21])
   set color to B/W
   @ l1, fiz + ancho1 + 3 say numero picture "99"
   @ l2, fiz + ancho1 + 3 say nombre
   return

********************************
procedure RPL13_1

   replace numero with dato1
   replace nombre with dato2
   return

********************************
procedure MTR13_1

   @ l1, fiz + ancho1 + 3 say dato1 picture "99"
   @ l2, fiz + ancho1 + 3 say dato2
   return

********************************
procedure GET13_1

   @ l2, fiz + ancho1 + 3 get dato2 picture "@!" valid ;
      Len(alltrim(dato2)) > 0
   return

********************************
procedure PRN13_1

   set console off
   ttotal:= 0
   tcant:= 0
   pag:= 1
   set printer on
   goto top
   desdereg:= RecNo()
   do while (.T.)
      ? "       ", Space(35), "     Pag.", Str(pag, 4, 0), "   ", ;
         "      ", Date()
      ? "       ", titulon, titular, tituloff
      ? 
      ? "       ", alltrim(afrases[41]), "Vendedores", ":"
      ? "       ", Replicate("Í", 70)
      ? "       ", SubStr(afrases[20], 1, 5), SubStr(afrases[21], 1, ;
         30)
      ? "       ", Replicate("Ä", 70)
      filas:= 1
      locate for RecNo() = desdereg
      do while (filas < 40 .AND. !EOF())
         ? "       ", Str(numero, 5), nombre
         filas:= 1 + filas
         tcant:= 1 + tcant
         skip 
      enddo
      if (EOF())
         ? "       ", Replicate("Ä", 70)
         ? "       ", "TOTALES.......", alltrim(Str(tcant, 3)), ;
            "Registros."
         ? "       ", Replicate("Ä", 70)
      endif
      eject
      if (EOF())
         exit
      endif
      desdereg:= RecNo()
      pag:= 1 + pag
   enddo
   set printer off
   set console on
   goto bottom
   return

********************************
procedure FUN_13_2

   set confirm on
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
   far:= 1
   fiz:= 1
   fab:= 21
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
   l9:= far + 10
   l10:= far + 11
   l11:= far + 12
   l12:= far + 13
   l13:= far + 14
   l14:= far + 15
   l15:= far + 16
   l16:= far + 17
   set color to N/W
   jcbox(far, fiz, fab, fde, "N/W", 20, 1, .T., .F., .T., "W+/B", ;
      alltrim(&bas[opcj3][2]))
   jjbox(fab, fiz, fab, fde, "W/B", 20, 5, .F.)
   jjbox(far + 1, fiz + ancho1 + 2, far + 9, fiz + ancho1 + ancho2 + ;
      3, "N/W", 20, 4, .F.)
   jjbox(far + 9, fiz + ancho1 + 2, far + 18, fiz + ancho1 + ancho2 ;
      + 3, "N/W", 20, 7, .F.)
   select 1
   opbasexc("BASE009")
   set index to BASE009A, BASE009B, BASE009C
   set order to 1
   goto bottom
   ultnum:= nro_client
   goto top
   opc27:= 1
   do while (opc27 != 0)
      setblink(.F.)
      ver_13_2()
      set message to 24 center
      set color to (icolora)
      @ 24,  0 say ;
         "                                                                               "
      set color to W+/B,B/W*
      abm_prom(fab, fiz)
      set wrap on
      menu to opc27
      do case
      case opc27 = 1
         set color to R/W*,R/W*
         save screen to pantabm
         aca:= nro_client
         dato1:= ultnum + 1
         dato2:= Space(30)
         dato3:= Space(30)
         dato4:= "GRAL ALVEAR         "
         dato5:= 5620
         dato6:= "MENDOZA        "
         dato7:= Space(40)
         dato8:= Space(30)
         dato9:= 0
         dato10:= 0
         dato11:= 0
         dato12a:= 0
         dato12b:= Space(14)
         dato13:= 0
         dato14:= 0
         dato15a:= 0
         dato15b:= Space(30)
         dato16:= 0
         mtr13_2()
         do while (.T.)
            set color to R/W*,R/W*
            @ l1, fiz + ancho1 + 3 get dato1 picture "99999"
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
               set key K_F10 to f10_13_2
               set key K_ENTER to ord13_2
               get13_2()
               read
               SetKey(K_F10, Nil)
               SetKey(K_ENTER, Nil)
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
               rpl13_2()
               goto bottom
               ultnum:= nro_client
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
         confirm0(15, 35)
         if (resp = "S")
            delete
            pack
            goto bottom
            ultnum:= nro_client
         endif
         restore screen from pantabm
      case opc27 = 3
         set color to R/W*,R/W*
         save screen to pantabm
         aca:= nro_client
         dato1:= nro_client
         dato2:= empresa
         dato3:= direccion
         dato4:= localidad
         dato5:= cpostal
         dato6:= provincia
         dato7:= telefonos
         dato8:= contacto
         dato9:= credito
         dato10:= porbonif
         dato11:= lista
         dato12a:= tipodoc
         dato12b:= nrodoc
         dato13:= respon
         dato14:= saldo
         dato15a:= nuec
         dato15b:= noec
         dato16:= condvent
         mtr13_2()
         do while (.T.)
            set color to R/W*,R/W*
            set key K_F10 to f10_13_2
            set key K_ENTER to ord13_2
            get13_2()
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
               rpl13_2()
            else
               seek aca
            endif
            exit
         enddo
         restore screen from pantabm
      case opc27 = 4
         set color to R/W*,R/W*
         save screen to pantabm
         aca:= nro_client
         dato1:= ultnum + 1
         dato2:= empresa
         dato3:= direccion
         dato4:= localidad
         dato5:= cpostal
         dato6:= provincia
         dato7:= telefonos
         dato8:= contacto
         dato9:= credito
         dato10:= porbonif
         dato11:= lista
         dato12a:= tipodoc
         dato12b:= nrodoc
         dato13:= respon
         dato14:= saldo
         dato15a:= nuec
         dato15b:= noec
         dato16:= condvent
         mtr13_2()
         do while (.T.)
            set color to R/W*,R/W*
            @ l1, fiz + ancho1 + 3 get dato1 picture "99999"
            read
            if (LastKey() = K_ESC .OR. dato1 = 0)
               alert(alltrim(afrases[35]))
               exit
            endif
            seek dato1
            if (Found())
               alert(alltrim(afrases[36]))
               dato1:= Space(14)
               loop
            endif
            do while (.T.)
               set key K_F10 to f10_13_2
               set key K_ENTER to ord13_2
               get13_2()
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
               rpl13_2()
               goto bottom
               ultnum:= nro_client
               seek dato1
            else
               seek aca
            endif
            exit
         enddo
         restore screen from pantabm
      case opc27 = 5
         save screen to pantabm
         campos:= "SUBSTR(STR(NRO_CLIENT,5)+' '+EMPRESA,1,55)"
         acata:= RecNo()
         set order to 2
         brow02(campos, 10, 3, "N/BG+", "N/W*,W+/R", "EMPRESA", 2)
         set order to 1
         goto top
         locate for RecNo() = acata
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
         goto top
         restore screen from pantabm
      case opc27 = 9
         save screen to pantabm
         goto bottom
         restore screen from pantabm
      case opc27 = 10
         save screen to pantabm
         prinsn:= " "
         printsn(12, 30)
         if (prinsn = "S")
            prn13_2()
         endif
         restore screen from pantabm
      endcase
   enddo
   return

********************************
procedure VER_13_2

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
   @ l9, fiz + 2 say "Cond. de venta   :"
   @ l10, fiz + 2 say "L¡mite Cta.Cte   :"
   @ l11, fiz + 2 say "% Bonificaci¢n   :"
   @ l12, fiz + 2 say "L. Precios habit.:"
   @ l13, fiz + 2 say "Tipo de Documento:"
   @ l13, fiz + 45 say "N§"
   @ l14, fiz + 2 say "Responsab. I.V.A.:"
   @ l15, fiz + 2 say "Saldo            :"
   @ l16, fiz + 2 say "Vendedor         :"
   set color to B/W
   @ l1, fiz + ancho1 + 3 say nro_client picture "99999"
   @ l2, fiz + ancho1 + 3 say empresa
   @ l3, fiz + ancho1 + 3 say direccion
   @ l4, fiz + ancho1 + 3 say localidad
   @ l4, fiz + ancho1 + 32 say cpostal picture "99999"
   @ l5, fiz + ancho1 + 3 say provincia
   @ l6, fiz + ancho1 + 3 say telefonos
   @ l7, fiz + ancho1 + 3 say contacto
   @ l9, fiz + ancho1 + 3 say condvent picture "9"
   @ l10, fiz + ancho1 + 3 say credito picture "9999999.99"
   @ l11, fiz + ancho1 + 3 say porbonif picture "99.99"
   @ l12, fiz + ancho1 + 3 say lista picture "99"
   if (condvent > 0)
      if (condvent == 1)
         @ l9, fiz + ancho1 + 5 say "Contado."
      else
         @ l9, fiz + ancho1 + 5 say "Cta.Cte."
      endif
   else
      @ l9, fiz + ancho1 + 5 say "        "
   endif
   if (lista > 0)
      @ l12, fiz + ancho1 + 6 say alistas[lista][2]
   else
      @ l12, fiz + ancho1 + 6 say "                    "
   endif
   @ l13, fiz + ancho1 + 3 say tipodoc picture "99"
   if (tipodoc == 0)
      @ l13, fiz + ancho1 + 6 say "                    "
   else
      @ l13, fiz + ancho1 + 6 say adocum[tipodoc][3]
   endif
   @ l13, fiz + ancho1 + 30 say nrodoc
   @ l14, fiz + ancho1 + 3 say respon picture "99"
   if (respon > 0)
      @ l14, fiz + ancho1 + 6 say respiva[respon][3]
   else
      @ l14, fiz + ancho1 + 6 say "                    "
   endif
   @ l15, fiz + ancho1 + 3 say saldo picture "9999999.99"
   @ l16, fiz + ancho1 + 3 say nuec picture "99"
   @ l16, fiz + ancho1 + 6 say noec
   return

********************************
procedure RPL13_2

   replace nro_client with dato1
   replace empresa with dato2
   replace direccion with dato3
   replace localidad with dato4
   replace cpostal with dato5
   replace provincia with dato6
   replace telefonos with dato7
   replace contacto with dato8
   replace credito with dato9
   replace porbonif with dato10
   replace lista with dato11
   replace tipodoc with dato12a
   replace nrodoc with dato12b
   replace respon with dato13
   replace saldo with dato14
   replace nuec with dato15a
   replace noec with dato15b
   replace condvent with dato16
   return

********************************
procedure MTR13_2

   @ l1, fiz + ancho1 + 3 say dato1 picture "99999"
   @ l2, fiz + ancho1 + 3 say dato2
   @ l3, fiz + ancho1 + 3 say dato3
   @ l4, fiz + ancho1 + 3 say dato4
   @ l4, fiz + ancho1 + 32 say dato5 picture "99999"
   @ l5, fiz + ancho1 + 3 say dato6
   @ l6, fiz + ancho1 + 3 say dato7
   @ l7, fiz + ancho1 + 3 say dato8
   @ l9, fiz + ancho1 + 3 say dato16 picture "9"
   @ l10, fiz + ancho1 + 3 say dato9 picture "9999999.99"
   @ l11, fiz + ancho1 + 3 say dato10 picture "99.99"
   @ l12, fiz + ancho1 + 3 say dato11 picture "99"
   if (dato16 > 0)
      if (dato16 == 1)
         @ l9, fiz + ancho1 + 5 say "Contado."
      else
         @ l9, fiz + ancho1 + 5 say "Cta.Cte."
      endif
   else
      @ l9, fiz + ancho1 + 5 say "        "
   endif
   if (dato11 > 0)
      @ l12, fiz + ancho1 + 6 say alistas[dato11][2]
   else
      @ l12, fiz + ancho1 + 6 say "                    "
   endif
   @ l13, fiz + ancho1 + 3 say dato12a picture "99"
   if (dato12a == 0)
      @ l13, fiz + ancho1 + 6 say "                    "
   else
      @ l13, fiz + ancho1 + 6 say adocum[dato12a][3]
   endif
   @ l13, fiz + ancho1 + 30 say dato12b
   @ l14, fiz + ancho1 + 3 say dato13 picture "99"
   if (dato12a == 1)
      @ l14, fiz + ancho1 + 6 say respiva[dato13][3]
   else
      @ l14, fiz + ancho1 + 6 say "                    "
   endif
   @ l15, fiz + ancho1 + 3 say dato14 picture "9999999.99"
   @ l16, fiz + ancho1 + 3 say dato15a picture "99"
   @ l16, fiz + ancho1 + 6 say dato15b
   return

********************************
procedure GET13_2

   @ 24,  0 say ;
      "  F10=Opciones                                                                 "
   @ l2, fiz + ancho1 + 3 get dato2 picture "@!" valid ;
      Len(alltrim(dato2)) > 0
   @ l3, fiz + ancho1 + 3 get dato3 picture "@!" valid ;
      Len(alltrim(dato3)) > 0
   @ l4, fiz + ancho1 + 3 get dato4 picture "@!"
   @ l4, fiz + ancho1 + 32 get dato5 picture "99999"
   @ l5, fiz + ancho1 + 3 get dato6
   @ l6, fiz + ancho1 + 3 get dato7
   @ l7, fiz + ancho1 + 3 get dato8 picture "@!"
   @ l9, fiz + ancho1 + 3 get dato16 picture "9" valid dato16 = 1 ;
      .OR. dato16 = 2 .OR. dato16 = 0
   @ l10, fiz + ancho1 + 3 get dato9 picture "9999999.99"
   @ l11, fiz + ancho1 + 3 get dato10 picture "99.99"
   @ l12, fiz + ancho1 + 3 get dato11 picture "99" valid dato11 <= 5
   @ l13, fiz + ancho1 + 3 get dato12a picture "99" valid dato12a > ;
      0 .AND. dato12a <= 7
   @ l13, fiz + ancho1 + 30 get dato12b picture "99999999999999" ;
      valid Len(alltrim(dato12b)) > 0 when dato12a < 7 .AND. dato12a ;
      > 0
   @ l14, fiz + ancho1 + 3 get dato13 picture "99" valid dato13 > 0 ;
      .AND. dato13 <= 7
   @ l16, fiz + ancho1 + 3 get dato15a picture "99"
   return

********************************
procedure PRN13_2

   set console off
   ttotal:= 0
   tcant:= 0
   pag:= 1
   set order to 3
   set printer on
   goto top
   refgrup:= 0
   desdereg:= RecNo()
   do while (.T.)
      ? "       ", Space(35), "     Pag.", Str(pag, 4, 0), "   ", ;
         "      ", Date()
      ? "       ", titulon, titular, tituloff
      ? 
      ? "       ", alltrim(afrases[41]), alltrim(afrases[45]), ":"
      ? "       ", Replicate("Í", 70)
      ? "       ", SubStr(afrases[20], 1, 5), SubStr(afrases[21], 1, ;
         20)
      filas:= 1
      locate for RecNo() = desdereg
      do while (filas < 40 .AND. !EOF())
         if (nro_grupo != refgrup)
            ? "       ", Replicate("Ä", 70)
            ? "      ", mpboldon, nom_grupo, mpconoff
            refgrup:= nro_grupo
            filas:= 2 + filas
         endif
         ? "       ", Str(nro_client, 5), nom_rubro
         filas:= 1 + filas
         tcant:= 1 + tcant
         skip 
      enddo
      if (EOF())
         ? "       ", Replicate("Ä", 70)
         ? "       ", "TOTALES.......", alltrim(Str(tcant, 3)), ;
            "RUBROS."
         ? "       ", Replicate("Ä", 70)
      endif
      eject
      if (EOF())
         exit
      endif
      desdereg:= RecNo()
      pag:= 1 + pag
   enddo
   set printer off
   set console on
   goto bottom
   set order to 1
   return

********************************
procedure ORD13_2

   h:= Row()
   f:= Col()
   tecl:= ""
   do case
   case h >= l1 .AND. h <= l8
      keyboard Chr(24)
   case h = l9
      if (dato16 > 0)
         if (dato16 == 1)
            @ l9, fiz + ancho1 + 5 say "Contado."
         else
            @ l9, fiz + ancho1 + 5 say "Cta.Cte."
         endif
      else
         @ l9, fiz + ancho1 + 5 say "        "
      endif
      if (LastKey() != K_ESC)
         keyboard Chr(24)
      endif
   case h >= l10 .AND. h <= l11
      keyboard Chr(24)
   case h = l12
      if (dato11 > 0)
         if (dato11 <= 5)
            @ l12, fiz + ancho1 + 6 say alistas[dato11][2]
         else
            bus13_2a()
         endif
      else
         dato11:= 0
         @ l12, fiz + ancho1 + 6 say "                    "
      endif
      if (LastKey() != K_ESC)
         keyboard Chr(24)
      endif
   case h = l13 .AND. f < fiz + ancho1 + 25
      if (dato12a > 0 .AND. dato12a <= 7)
         @ l13, fiz + ancho1 + 6 say adocum[dato12a][3]
      else
         bus13_2b()
      endif
      if (LastKey() != K_ESC)
         keyboard Chr(24)
      endif
   case h = l13 .AND. f > fiz + ancho1 + 25
      keyboard Chr(24)
   case h = l14
      if (dato13 > 0 .AND. dato13 <= 7)
         @ l14, fiz + ancho1 + 6 say respiva[dato13][3]
      else
         bus13_2c()
      endif
      if (LastKey() != K_ESC)
         keyboard Chr(24)
      endif
   case h = l15
      keyboard Chr(24)
   case h = l16
      if (dato15a > 0)
         select 2
         opbassha("BASE008", "BASE008A")
         seek dato15a
         if (Found())
            dato15a:= numero
            dato15b:= nombre
            @ l16, fiz + ancho1 + 3 say dato15a picture "99"
            @ l16, fiz + ancho1 + 6 say dato15b
         else
            close
            bus13_2d()
         endif
         select 1
      endif
      SetKey(K_ENTER, Nil)
      keyboard Chr(13)
   endcase
   select 1
   return

********************************
procedure F10_13_2

   h:= Row()
   f:= Col()
   tecl:= ""
   do case
   case h = l12
      bus13_2a()
      if (LastKey() != K_ESC)
         keyboard Chr(24)
      endif
   case h = l13 .AND. f < fiz + ancho1 + 25
      bus13_2b()
      if (LastKey() != K_ESC)
         keyboard Chr(24)
      endif
   case h = l13 .AND. f > fiz + ancho1 + 25
   case h = l14
      bus13_2c()
      if (LastKey() != K_ESC)
         keyboard Chr(24)
      endif
      keyboard Chr(24)
   case h = l16
      bus13_2d()
   endcase
   select 1
   return

********************************
procedure BUS13_2A

   SetKey(K_ENTER, Nil)
   SetKey(K_F10, Nil)
   save screen to p13_2
   nelem:= 0
   totlen:= Len(alista)
   wa:= Len(alista)
   hh:= l12
   if (h + wa > 23)
      hh:= 23 - wa
   endif
   boxshadow(l12 - 1, fiz, l12 - 1, fiz + ancho1)
   achoi02("Alista", hh - 1, fiz + ancho1 + 3, hh + wa, f + 27, ;
      "N/BG,W+/R", 1)
   restore screen from p13_2
   if (LastKey() != K_ESC)
      dato11:= nelem
      @ l12, fiz + ancho1 + 6 say alistas[dato11][2]
   endif
   set key K_ENTER to ord13_2
   set key K_F10 to f10_13_2
   return

********************************
procedure BUS13_2B

   SetKey(K_ENTER, Nil)
   SetKey(K_F10, Nil)
   save screen to p13_2
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
   restore screen from p13_2
   if (LastKey() != K_ESC)
      dato12a:= nelem
      @ l13, fiz + ancho1 + 6 say adocum[dato12a][3]
   endif
   set key K_ENTER to ord13_2
   set key K_F10 to f10_13_2
   return

********************************
procedure BUS13_2C

   SetKey(K_ENTER, Nil)
   SetKey(K_F10, Nil)
   save screen to p13_2
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
   restore screen from p13_2
   if (LastKey() != K_ESC)
      dato13:= nelem
      @ l14, fiz + ancho1 + 6 say respiva[dato13][3]
   endif
   set key K_ENTER to ord13_2
   set key K_F10 to f10_13_2
   return

********************************
procedure BUS13_2D

   select 2
   opbassha("BASE008", "BASE008B")
   if (dato15a > 0)
      locate for numero = dato15a
      if (EOF())
         goto top
      endif
   endif
   campy:= "SUBSTR(STR(NUMERO,3)+' '+NOMBRE,1,24)"
   cuanhay:= LastRec()
   SetKey(K_ENTER, Nil)
   SetKey(K_F10, Nil)
   save screen to p13_2
   boxshadow(l16 - 1, fiz, l16 - 1, fiz + ancho1)
   brow03(campy, l16 - 3, fiz + ancho1 + 3, "N/BG", "N/BG,W+/R", ;
      "NOMBRE", 2)
   restore screen from p13_2
   set key K_ENTER to ord13_2
   set key K_F10 to f10_13_2
   if (LastKey() == K_ESC)
      close
      select 1
   else
      dato15a:= numero
      dato15b:= nombre
      @ l16, fiz + ancho1 + 3 say dato15a picture "99"
      @ l16, fiz + ancho1 + 6 say dato15b
      close
      select 1
      return
   endif

********************************
procedure FUN_13_3

   @ 24,  0
   far:= 4
   fiz:= 1
   fab:= 21
   fde:= 70
   ancho1:= 16
   ancho2:= 30
   l1:= far + 2
   l2:= far + 3
   l3:= far + 4
   l4:= far + 5
   l5:= far + 6
   l6:= far + 7
   l7:= far + 8
   l8:= far + 9
   l9:= far + 10
   l10:= far + 11
   l11:= far + 12
   l12:= far + 13
   l13:= far + 14
   l14:= far + 15
   set color to N/W
   jcbox(far, fiz, fab, fde, "N/W", 20, 1, .T., .F., .T., "W+/B", ;
      alltrim(&bas[opcj3][2]))
   jjbox(fab, fiz, fab, fde, "W/B", 20, 5, .F.)
   jjbox(far + 1, fiz + ancho1 + 2, far + 6, fiz + ancho1 + ancho2 + ;
      3, "N/W", 20, 4, .F.)
   opbasexc("BASE011")
   set index to BASE011A
   goto bottom
   ultnum:= 0
   goto top
   opc27:= 1
   do while (opc27 != 0)
      setblink(.F.)
      ver_13_3()
      set message to 24 center
      set color to W+/B,B/W*
      abm_prom(fab, fiz)
      set wrap on
      menu to opc27
      do case
      case opc27 = 1
         set color to R/W*,R/W*
         save screen to pantabm
         aca:= numero
         dato1:= 0
         dato2:= Space(20)
         dato3:= 0
         dato4:= 0
         mtr13_3()
         do while (.T.)
            set color to R/W*,R/W*
            @ l1, fiz + ancho1 + 3 get dato1 picture "99" valid ;
               dato1 > 0
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
               get13_3()
               read
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
               rpl13_3()
               seek dato1
            else
               seek aca
            endif
            exit
         enddo
         restore screen from pantabm
      case opc27 = 2
         save screen to pantabm
         if (numero = 1 .OR. numero = 11 .OR. numero = 21 .OR. ;
               numero = 40 .OR. numero = 41 .OR. numero = 51 .OR. ;
               numero = 70 .OR. numero = 80)
            alert("Esta Al¡cuota no debe ser borrada.")
         else
            resp:= " "
            confirm0(15, 35)
            if (resp = "S")
               delete
               pack
               goto top
            endif
         endif
         restore screen from pantabm
      case opc27 = 3
         set color to R/W*,R/W*
         save screen to pantabm
         aca:= numero
         dato1:= numero
         dato2:= nombre
         dato3:= porcent
         dato4:= impormin
         mtr13_3()
         do while (.T.)
            set color to R/W*,R/W*
            get13_3()
            read
            if (LastKey() == K_ESC)
               alert(alltrim(afrases[35]))
               seek aca
               exit
            endif
            resp:= " "
            confirm0(15, 30)
            if (resp = "S")
               rpl13_3()
            else
               seek aca
            endif
            exit
         enddo
         restore screen from pantabm
      case opc27 = 4
      case opc27 = 5
         save screen to pantabm
         campos:= ;
            "SUBSTR(STR(NUMERO,2)+' '+NOMBRE+' '+STR(PORCENT,9,4),1,55)+' '+STR(IMPORMIN,10,2)"
         acata:= RecNo()
         brow02(campos, 10, 3, "N/BG+", "N/W*,W+/R", "NUMERO", 1)
         goto top
         locate for RecNo() = acata
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
         goto top
         restore screen from pantabm
      case opc27 = 9
         save screen to pantabm
         goto bottom
         restore screen from pantabm
      case opc27 = 10
         save screen to pantabm
         prinsn:= " "
         printsn(12, 30)
         if (prinsn = "S")
            prn13_3()
         endif
         restore screen from pantabm
      endcase
   enddo
   set color to (icolora)
   return

********************************
procedure VER_13_3

   set color to N/W
   @ l1, fiz + 2 say "Cod. Al¡cuota  :"
   @ l2, fiz + 2 say "Descripci¢n    :"
   @ l3, fiz + 2 say "Porcentaje     :"
   @ l4, fiz + 2 say "Importe m¡n.apl:"
   @ l6, fiz + 10 say ;
      "  Valores permitidos para c¢digos de Al¡cuotas     "
   @ l7, fiz + 10 say ;
      " 1 al 10  ÄÄ> Tasas de IVA para art¡culos.         "
   @ l8, fiz + 10 say ;
      "11 al 20  ÄÄ> Sobre/Subtasas de IVA.               "
   @ l9, fiz + 10 say ;
      "21 al 39  ÄÄ> Tasas de impuestos internos.         "
   @ l10, fiz + 10 say ;
      "      40  ÄÄ> Impuestos internos por importe fijo. "
   @ l11, fiz + 10 say ;
      "41 al 50  ÄÄ> Sobre/Subtasas de impuestos internos."
   @ l12, fiz + 10 say ;
      "51 al 60  ÄÄ> Percepciones de ingresos brutos      "
   @ l13, fiz + 10 say ;
      "      70  ÄÄ> Tasa de retenci¢n para R.N.I.        "
   @ l14, fiz + 10 say ;
      "      80  ÄÄ> IVA liberado.                        "
   set color to B/W
   @ l1, fiz + ancho1 + 3 say numero picture "99"
   @ l2, fiz + ancho1 + 3 say nombre
   @ l3, fiz + ancho1 + 3 say porcent picture "9999.9999"
   @ l4, fiz + ancho1 + 3 say impormin picture "999999999.99"
   return

********************************
procedure RPL13_3

   replace numero with dato1
   replace nombre with dato2
   replace porcent with dato3
   replace impormin with dato4
   return

********************************
procedure MTR13_3

   @ l1, fiz + ancho1 + 3 say dato1 picture "99"
   @ l2, fiz + ancho1 + 3 say dato2
   @ l3, fiz + ancho1 + 3 say dato3 picture "9999.9999"
   @ l4, fiz + ancho1 + 3 say dato4 picture "999999999.99"
   return

********************************
procedure GET13_3

   @ l2, fiz + ancho1 + 3 get dato2 valid Len(alltrim(dato2)) > 0
   if (dato1 = 1 .OR. dato1 = 70)
      @ l3, fiz + ancho1 + 3 get dato3 picture "9999.9999" valid ;
         dato3 > 0 when dato1 != 40
   else
      @ l3, fiz + ancho1 + 3 get dato3 picture "9999.9999" when ;
         dato1 != 40
   endif
   @ l4, fiz + ancho1 + 3 get dato4 picture "999999999.99"
   return

********************************
procedure PRN13_3

   set console off
   ttotal:= 0
   tcant:= 0
   pag:= 1
   set printer on
   goto top
   desdereg:= RecNo()
   do while (.T.)
      ? "       ", Space(35), "     Pag.", Str(pag, 4, 0), "   ", ;
         "      ", Date()
      ? "       ", titulon, titular, tituloff
      ? 
      ? "       ", alltrim(afrases[41]), "Vendedores", ":"
      ? "       ", Replicate("Í", 70)
      ? "       ", SubStr(afrases[20], 1, 5), SubStr(afrases[21], 1, ;
         30)
      ? "       ", Replicate("Ä", 70)
      filas:= 1
      locate for RecNo() = desdereg
      do while (filas < 40 .AND. !EOF())
         ? "       ", Str(numero, 5), nombre
         filas:= 1 + filas
         tcant:= 1 + tcant
         skip 
      enddo
      if (EOF())
         ? "       ", Replicate("Ä", 70)
         ? "       ", "TOTALES.......", alltrim(Str(tcant, 3)), ;
            "Registros."
         ? "       ", Replicate("Ä", 70)
      endif
      eject
      if (EOF())
         exit
      endif
      desdereg:= RecNo()
      pag:= 1 + pag
   enddo
   set printer off
   set console on
   goto bottom
   return

********************************
procedure FUN_13_4

   @ 24,  0
   far:= 7
   fiz:= 1
   fab:= 21
   fde:= 70
   ancho1:= 16
   ancho2:= 30
   l1:= far + 2
   l2:= far + 4
   l3:= far + 6
   l4:= far + 8
   l5:= far + 10
   set color to N/W
   jcbox(far, fiz, fab, fde, "N/W", 20, 1, .T., .F., .T., "W+/B", ;
      alltrim(&bas[opcj3][2]))
   jjbox(fab, fiz, fab, fde, "W/B", 20, 5, .F.)
   jjbox(far + 1, fiz + ancho1 + 2, far + 3, fiz + ancho1 + ancho2 + ;
      3, "N/W", 20, 4, .F.)
   jjbox(far + 3, fiz + ancho1 + 2, far + 5, fiz + ancho1 + ancho2 + ;
      3, "N/W", 20, 7, .F.)
   opbasexc("BASE015", "BASE015A")
   goto bottom
   ultnum:= numero
   goto top
   opc27:= 1
   do while (opc27 != 0)
      setblink(.F.)
      ver_13_4()
      set message to 24 center
      set color to W+/B,B/W*
      abm_prom(fab, fiz)
      set wrap on
      menu to opc27
      do case
      case opc27 = 1
         set color to R/W*,R/W*
         save screen to pantabm
         aca:= numero
         dato1:= ultnum + 1
         dato2:= "                    "
         mtr13_4()
         do while (.T.)
            set color to R/W*,R/W*
            @ l1, fiz + ancho1 + 3 get dato1 picture "99"
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
               get13_4()
               read
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
               rpl13_4()
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
         if (numero <= 2)
            alert("Este registro no puede ser borrado")
         else
            resp:= " "
            confirm0(15, 35)
            if (resp = "S")
               delete
               pack
               goto bottom
               ultnum:= numero
            endif
         endif
         restore screen from pantabm
      case opc27 = 3
         if (numero <= 2)
            alert("Este registro no puede ser modificado")
            loop
         endif
         set color to R/W*,R/W*
         save screen to pantabm
         aca:= numero
         dato1:= numero
         dato2:= nombre
         mtr13_4()
         do while (.T.)
            set color to R/W*,R/W*
            get13_4()
            read
            if (LastKey() == K_ESC)
               alert(alltrim(afrases[35]))
               seek aca
               exit
            endif
            resp:= " "
            confirm0(15, 30)
            if (resp = "S")
               rpl13_4()
            else
               seek aca
            endif
            exit
         enddo
         restore screen from pantabm
      case opc27 = 4
         set color to R/W*,R/W*
         save screen to pantabm
         aca:= numero
         dato1:= ultnum + 1
         dato2:= nombre
         mtr13_4()
         do while (.T.)
            set color to R/W*,R/W*
            @ l1, fiz + ancho1 + 3 get dato1 picture "99"
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
               get13_4()
               read
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
               rpl13_4()
               ultnum:= numero
               seek dato1
            else
               seek aca
            endif
            exit
         enddo
         restore screen from pantabm
      case opc27 = 5
         aca:= numero
         save screen to pantabm
         campos:= "SUBSTR(STR(NUMERO,3)+' '+NOMBRE,1,34)"
         brow02(campos, 10, 3, "N/BG+", "N/W*,W+/R", "NUMERO", 1)
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
         goto top
         restore screen from pantabm
      case opc27 = 9
         save screen to pantabm
         goto bottom
         restore screen from pantabm
      case opc27 = 10
         save screen to pantabm
         prinsn:= " "
         printsn(12, 30)
         if (prinsn = "S")
            prn13_4()
         endif
         restore screen from pantabm
      endcase
   enddo
   set color to (icolora)
   return

********************************
procedure VER_13_4

   set color to N/W
   @ l1, fiz + 2 say alltrim(afrases[20])
   @ l2, fiz + 2 say alltrim(afrases[21])
   set color to B/W
   @ l1, fiz + ancho1 + 3 say numero picture "99"
   @ l2, fiz + ancho1 + 3 say nombre
   return

********************************
procedure RPL13_4

   replace numero with dato1
   replace nombre with dato2
   return

********************************
procedure MTR13_4

   @ l1, fiz + ancho1 + 3 say dato1 picture "99"
   @ l2, fiz + ancho1 + 3 say dato2
   return

********************************
procedure GET13_4

   @ l2, fiz + ancho1 + 3 get dato2 picture "@!" valid ;
      Len(alltrim(dato2)) > 0
   return

********************************
procedure PRN13_4

   set console off
   ttotal:= 0
   tcant:= 0
   pag:= 1
   set printer on
   goto top
   desdereg:= RecNo()
   do while (.T.)
      ? "       ", Space(35), "     Pag.", Str(pag, 4, 0), "   ", ;
         "      ", Date()
      ? "       ", titulon, titular, tituloff
      ? 
      ? "       ", alltrim(afrases[41]), "Vendedores", ":"
      ? "       ", Replicate("Í", 70)
      ? "       ", SubStr(afrases[20], 1, 5), SubStr(afrases[21], 1, ;
         30)
      ? "       ", Replicate("Ä", 70)
      filas:= 1
      locate for RecNo() = desdereg
      do while (filas < 40 .AND. !EOF())
         ? "       ", Str(numero, 5), nombre
         filas:= 1 + filas
         tcant:= 1 + tcant
         skip 
      enddo
      if (EOF())
         ? "       ", Replicate("Ä", 70)
         ? "       ", "TOTALES.......", alltrim(Str(tcant, 3)), ;
            "Registros."
         ? "       ", Replicate("Ä", 70)
      endif
      eject
      if (EOF())
         exit
      endif
      desdereg:= RecNo()
      pag:= 1 + pag
   enddo
   set printer off
   set console on
   goto bottom
   return

********************************
procedure FUN_15_2

   @ 24,  0
   far:= 3
   fiz:= 1
   fab:= 21
   fde:= 70
   ancho1:= 18
   ancho2:= 30
   l1:= far + 2
   l2:= far + 3
   l3:= far + 4
   l4:= far + 5
   l5:= far + 6
   l6:= far + 7
   l7:= far + 8
   l8:= far + 9
   l9:= far + 10
   l10:= far + 11
   l11:= far + 12
   l12:= far + 13
   l13:= far + 14
   l14:= far + 15
   set color to N/W
   jcbox(far, fiz, fab, fde, "N/W", 20, 1, .T., .F., .T., "W+/B", ;
      alltrim(&bas[opcj3][2]))
   jjbox(fab, fiz, fab, fde, "W/B", 20, 5, .F.)
   jjbox(far + 1, fiz + ancho1 + 2, far + 4, fiz + ancho1 + ancho2 + ;
      3, "N/W", 20, 4, .F.)
   jjbox(far + 4, fiz + ancho1 + 2, far + 10, fiz + ancho1 + ancho2 ;
      + 3, "N/W", 20, 7, .F.)
   jjbox(far + 10, fiz + ancho1 + 2, far + 14, fiz + ancho1 + ancho2 ;
      + 3, "N/W", 20, 7, .F.)
   jjbox(far + 14, fiz + ancho1 + 2, far + 16, fiz + ancho1 + ancho2 ;
      + 3, "N/W", 20, 7, .F.)
   opbasexc("BASE014", "BASE014A")
   goto bottom
   ultnum:= numero
   goto top
   opc27:= 1
   do while (opc27 != 0)
      setblink(.F.)
      ver_15_2()
      set message to 24 center
      set color to W+/B,B/W*
      abm_prom(fab, fiz)
      set wrap on
      menu to opc27
      do case
      case opc27 = 1
         set color to R/W*,R/W*
         save screen to pantabm
         aca:= numero
         dato1:= ultnum + 1
         dato2:= Space(20)
         dato3:= " "
         dato4:= 0
         dato5:= " "
         dato6:= " "
         dato7:= " "
         dato8:= 0
         dato9:= 0
         dato10:= 0
         dato11:= 0
         dato12:= Space(30)
         mtr15_2()
         do while (.T.)
            set color to R/W*,R/W*
            @ l1, fiz + ancho1 + 3 get dato1 picture "99"
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
               get15_2()
               read
               if (LastKey() == K_ESC)
                  alert(alltrim(afrases[35]))
                  seek aca
                  exit
               endif
               est15_2()
               if (LastKey() == K_ESC)
                  dato11:= 0
                  dato12:= Space(30)
                  loop
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
               rpl15_2()
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
         confirm0(15, 35)
         if (resp = "S")
            delete
            pack
            goto bottom
            ultnum:= numero
         endif
         restore screen from pantabm
      case opc27 = 3
         set color to R/W*,R/W*
         save screen to pantabm
         aca:= numero
         dato1:= numero
         dato2:= nombre
         dato3:= letra
         dato4:= sucursal
         dato5:= tipocomp
         dato6:= ventas
         dato7:= stock
         dato8:= desde
         dato9:= hasta
         dato10:= ultnumero
         dato11:= nroestac
         dato12:= nomestac
         mtr15_2()
         do while (.T.)
            set color to R/W*,R/W*
            get15_2()
            read
            if (LastKey() == K_ESC)
               alert(alltrim(afrases[35]))
               seek aca
               exit
            endif
            est15_2()
            if (LastKey() == K_ESC)
               dato11:= 0
               dato12:= Space(30)
               loop
            endif
            resp:= " "
            confirm0(15, 30)
            if (resp = "S")
               rpl15_2()
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
         goto top
         restore screen from pantabm
      case opc27 = 9
         save screen to pantabm
         goto bottom
         restore screen from pantabm
      case opc27 = 10
         save screen to pantabm
         prinsn:= " "
         printsn(12, 30)
         if (prinsn = "S")
            prn15_2()
         endif
         restore screen from pantabm
      endcase
   enddo
   set color to (icolora)
   return

********************************
procedure VER_15_2

   set color to N/W
   @ l1, fiz + 2 say "C¢digo           :"
   @ l2, fiz + 2 say "Descripci¢n      :"
   @ l4, fiz + 2 say "Letra identific. :"
   @ l5, fiz + 2 say "Puesto de venta  :"
   @ l6, fiz + 2 say "Tipo comprobante :"
   @ l6, fiz + ancho1 + 6 say "(D‚bito, Cr‚dito, Nada)"
   @ l7, fiz + 2 say "Afecta IVA Ventas:"
   @ l8, fiz + 2 say "Afecta stock     :"
   @ l10, fiz + 2 say "1er N§ habilitado:"
   @ l11, fiz + 2 say "Ultimo N§ habilit:"
   @ l12, fiz + 2 say "Ultimo N§ emitido:"
   @ l14, fiz + 2 say "Est. de impresi¢n:"
   set color to B/W
   @ l1, fiz + ancho1 + 3 say numero picture "99"
   @ l2, fiz + ancho1 + 3 say nombre
   @ l4, fiz + ancho1 + 3 say letra
   @ l5, fiz + ancho1 + 3 say strzero(sucursal, 4)
   @ l6, fiz + ancho1 + 3 say tipocomp
   @ l7, fiz + ancho1 + 3 say ventas
   @ l8, fiz + ancho1 + 3 say stock
   @ l10, fiz + ancho1 + 3 say desde picture "99999999"
   @ l11, fiz + ancho1 + 3 say hasta picture "99999999"
   @ l12, fiz + ancho1 + 3 say ultnumero picture "99999999"
   @ l14, fiz + ancho1 + 3 say nomestac
   return

********************************
procedure RPL15_2

   replace numero with dato1
   replace nombre with dato2
   replace letra with dato3
   replace sucursal with dato4
   replace tipocomp with dato5
   replace ventas with dato6
   replace stock with dato7
   replace desde with dato8
   replace hasta with dato9
   replace ultnumero with dato10
   replace nroestac with dato11
   replace nomestac with dato12
   return

********************************
procedure MTR15_2

   @ l2, fiz + ancho1 + 3 say dato2
   @ l4, fiz + ancho1 + 3 say dato3
   @ l5, fiz + ancho1 + 3 say strzero(dato4, 4)
   @ l6, fiz + ancho1 + 3 say dato5
   @ l7, fiz + ancho1 + 3 say dato6
   @ l8, fiz + ancho1 + 3 say dato7
   @ l10, fiz + ancho1 + 3 say dato8 picture "99999999"
   @ l11, fiz + ancho1 + 3 say dato9 picture "99999999"
   @ l12, fiz + ancho1 + 3 say dato10 picture "99999999"
   @ l14, fiz + ancho1 + 3 say dato12
   return

********************************
procedure GET15_2

   @ l2, fiz + ancho1 + 3 get dato2 valid Len(alltrim(dato2)) > 0
   @ l4, fiz + ancho1 + 3 get dato3 valid dato3 = "A" .OR. dato3 = ;
      "B" .OR. dato3 = "a" .OR. dato3 = "b" .OR. dato3 = "D" .OR. ;
      dato3 = "E" .OR. dato3 = "R" .OR. dato3 = "S" .OR. dato3 = "r" ;
      .OR. dato3 = "u" .OR. dato3 = "T" .OR. dato3 = "O"
   @ l5, fiz + ancho1 + 3 get dato4 picture "9999"
   @ l6, fiz + ancho1 + 3 get dato5 picture "!" valid dato5 = "D" ;
      .OR. dato5 = "C" .OR. dato5 = "N"
   @ l7, fiz + ancho1 + 3 get dato6 picture "!" valid dato6 = "S" ;
      .OR. dato6 = "N"
   @ l8, fiz + ancho1 + 3 get dato7 picture "!" valid dato7 = "S" ;
      .OR. dato7 = "N"
   @ l10, fiz + ancho1 + 3 get dato8 picture "99999999"
   @ l11, fiz + ancho1 + 3 get dato9 picture "99999999"
   @ l12, fiz + ancho1 + 3 get dato10 picture "99999999"
   return

********************************
procedure PRN15_2

   set console off
   ttotal:= 0
   tcant:= 0
   pag:= 1
   set printer on
   goto top
   desdereg:= RecNo()
   do while (.T.)
      ? "       ", Space(35), "     Pag.", Str(pag, 4, 0), "   ", ;
         "      ", Date()
      ? "       ", titulon, titular, tituloff
      ? 
      ? "       ", alltrim(afrases[41]), "Vendedores", ":"
      ? "       ", Replicate("Í", 70)
      ? "       ", SubStr(afrases[20], 1, 5), SubStr(afrases[21], 1, ;
         30)
      ? "       ", Replicate("Ä", 70)
      filas:= 1
      locate for RecNo() = desdereg
      do while (filas < 40 .AND. !EOF())
         ? "       ", Str(numero, 5), nombre
         filas:= 1 + filas
         tcant:= 1 + tcant
         skip 
      enddo
      if (EOF())
         ? "       ", Replicate("Ä", 70)
         ? "       ", "TOTALES.......", alltrim(Str(tcant, 3)), ;
            "Registros."
         ? "       ", Replicate("Ä", 70)
      endif
      eject
      if (EOF())
         exit
      endif
      desdereg:= RecNo()
      pag:= 1 + pag
   enddo
   set printer off
   set console on
   goto bottom
   return

********************************
procedure EST15_2

   select 2
   opbassha("BASE013", "BASE013A")
   if (dato11 > 0)
      seek dato11
      if (!Found())
         goto top
      endif
   endif
   campy:= "SUBSTR(STR(NUMERO,3)+' '+PUERTO+'ÄÄ>'+NOMBRE,1,35)"
   cuanhay:= LastRec()
   save screen to p13_2
   boxshadow(l14 - 1, fiz - 1, l14 - 1, fiz + ancho1 + 2)
   brow03(campy, l14 - 3, fiz + ancho1 + 3, "N/BG", "N/BG,W+/R", ;
      "NUMERO", 1)
   restore screen from p13_2
   dato11:= numero
   dato12:= puerto + "ÄÄ>" + nombre
   set color to R/W*
   @ l14, fiz + ancho1 + 3 say dato12
   close
   select 1
   return

********************************
procedure FUN_11_2

   nelem:= 1
   opbasexc("BASE017")
   private ateclas[8]
   y:= 1
   goto top
   for y:= 1 to 8
      ateclas[y]:= tecla + "-->" + SubStr(codigo, 1, 8) + " " + ;
         articulo
      skip 
   next
   close
   totlen:= 8
   col131:= "N/W*,W+/B"
   set key K_ENTER to modif112
   achoi07("aTeclas", 7, 10, 18, 68, 1, "N/W", "N/W", col131, ;
      "Teclas programadas")
   SetKey(K_ENTER, Nil)
   opbasexc("BASE017")
   y:= 1
   for y:= 1 to 8
      replace codigo with SubStr(ateclas[y], 6, 8)
      replace articulo with SubStr(ateclas[y], 15, 40)
      skip 
   next
   close
   select 1
   return

********************************
procedure MODIF112

   SetKey(K_ENTER, Nil)
   h:= Row()
   save screen to pmod_acc
   set color to N/W,R/W*
   select 2
   opbassha("BASE003", "BASE003B")
   goto top
   campy:= "SUBSTR(COD+' '+NOMBRECOM,1,50)"
   cuanhay:= LastRec()
   save screen to p13_2
   brow03(campy, 8, 20, "N/BG", "N/BG,W+/R", "NOMBRECOM", 2)
   restore screen from p13_2
   if (LastKey() == K_ENTER)
      oldtec:= ateclas[nelem]
      ateclas[nelem]:= SubStr(oldtec, 1, 2) + "-->" + SubStr(cod, 1, ;
         8) + " " + nombrecom
      keyboard Chr(19)
   endif
   close
   select 1
   restore screen from pmod_acc
   set color to (col131)
   setcursor(0)
   set key K_ENTER to modif112
   return

********************************
procedure ACHOI07

   colbrow:= SetColor()
   parameters bloke, barr1, bizq1, baba1, bder1, talon, bcol1, ;
      bcol2, bcol3, titu
   jcbox(barr1, bizq1, baba1 + talon, bder1, bcol1, 20, 1, .T., .F., ;
      .F., "W+/B", titu)
   jjbox(barr1 + 1, bizq1 + 1, baba1 - 1, bder1 - 1, bcol2, 20, 4, ;
      .F.)
   set color to (bcol1)
   @ baba1, bizq1 + 3 say "Enter=carga/modifica     B=limpia"
   set color to (bcol3)
   achoice(barr1 + 2, bizq1 + 2, baba1 - 2, bder1 - 2, &bloke, .T., ;
      "UserFun7")
   set color to (colbrow)
   return

********************************
function USERFUN7(Arg1, Arg2, Arg3)

   local Local1
   Local1:= 2
   if (LastKey() == K_ESC)
      return 0
   else
      k:= 1
      for k:= 1 to totlen
         if (Arg2 == k)
            nelem:= k
            if (LastKey() = 98 .OR. LastKey() = 66)
               oldtec:= ateclas[nelem]
               ateclas[nelem]:= SubStr(oldtec, 1, 2) + "-->" + ;
                  Space(49)
            endif
         endif
      next
   endif
   return Local1

********************************
procedure FUN_14_3

   alert("No existen registros...")
   return

********************************
procedure FUN_14_4

   alert("No existen registros...")
   return

********************************
procedure FUN_16_2

   alert("Disculpe, esta funci¢n est  siendo modificada.")
   return

********************************
procedure FUN_16_3

   alert("Disculpe, esta funci¢n est  siendo modificada.")
   return

* EOF
