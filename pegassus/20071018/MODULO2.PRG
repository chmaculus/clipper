#include "common.ch"
#include "inkey.ch"

********************************
procedure CUALES

   parameters xa, ya, xe, ye, nro_area
   do while (.T.)
      select (nro_area)
      @ xa, ya get elnom picture "@!"
      read
      if (LastKey() == K_ESC)
         elnum:= 0
         elnom:= " "
         exit
      endif
      elno:= alltrim(elnom)
      copy to SELEC
      select 9
      use SELEC
      if (EOF())
         alert(alltrim(afrases[44]))
         close
         loop
      endif
      cuanhay:= LastRec()
      if (cuanhay == 1)
         elnum:= &rfcampy1
         elnom:= &rfcampy2
         exit
      else
         save screen to panty
         brow03(campy, xe, ye, "N/BG", "N/BG,W+/R", &rfcampy2, 2)
         if (LastKey() == K_ESC)
            elnum:= 0
            elnom:= " "
            exit
         endif
         elnum:= &rfcampy1
         elnom:= &rfcampy2
         restore screen from panty
         exit
      endif
   enddo
   select 9
   close
   select (nro_area)
   return

********************************
*procedure MODULO2


********************************
procedure FUN_22_1

   set confirm on
   opbassha("BASE011", "BASE011A")
   private alic[80]
   y:= 1
   for y:= 1 to 80
      seek y
      if (Found())
         alic[y]:= nombre
      else
         alic[y]:= "<ÄÄ No reconocido ! "
      endif
   next
   goto top
   d:= LastRec()
   private alic1[d]
   private alic2[d]
   y:= 1
   for y:= 1 to d
      alic1[y]:= numero
      alic2[y]:= Str(numero, 3) + " " + nombre + " %" + Str(porcent, ;
         9, 4)
      skip 
   next
   opbassha("BASE005", "BASE005C")
   d:= LastRec()
   private family[d, 2]
   private famil[d]
   goto top
   y:= 1
   for y:= 1 to d
      family[y][1]:= nro_grupo
      family[y][2]:= nro_rubro
      famil[y]:= nom_grupo + "ÄÄ>" + nom_rubro
      skip 
   next
   close
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
   l17:= far + 18
   set color to N/W
   jcbox(far, fiz, fab, fde, "N/W", 20, 1, .T., .F., .T., "W+/B", ;
      alltrim(&bas[opcj3][2]))
   jjbox(fab, fiz, fab, fde, "W/B", 20, 5, .F.)
   jjbox(far + 1, fiz + ancho1 + 2, far + 8, fiz + ancho1 + ancho2 + ;
      3, "N/W", 20, 4, .F.)
   jjbox(far + 8, fiz + ancho1 + 2, far + 12, fiz + ancho1 + ancho2 ;
      + 3, "N/W", 20, 7, .F.)
   jjbox(far + 12, fiz + ancho1 + 2, far + 19, fiz + ancho1 + ancho2 ;
      + 3, "N/W", 20, 6, .F.)
   select 1
   opbasexc("BASE003")
   set index to BASE003A, BASE003B, BASE003X
   refy:= 1
   set order to 1
   goto top
   opc27:= 1
   do while (opc27 != 0)
      setblink(.F.)
      ver_22_1()
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
         aca:= cod
         dat1:= 0
         dato1b:= Space(20)
         dat2:= 0
         dat3:= 0
         dato1:= "        "
         dato2:= Space(40)
         dato3:= Space(20)
         dato4:= Space(20)
         dato5:= Space(20)
         dato6:= 0
         dato7:= "     "
         dato8:= " "
         dato9:= " "
         dato10:= 0
         dato11:= 0
         dato12:= 0
         dato13:= 1
         dato14:= 11
         dato15:= 21
         dato16:= 0
         dato17:= 41
         dato18:= "S"
         dato19:= 51
         dato20:= 0
         mtr22_1()
         do while (.T.)
            save screen to p22_1
            nelem:= 0
            totlen:= Len(famil)
            wa:= Len(famil)
            hh:= l2
            if (hh + wa > 22)
               hh:= 22
            else
               hh:= hh + wa
            endif
            achoi02("Famil", l2 - 1, fiz + ancho1 + 3, hh, fiz + ;
               ancho1 + 3 + 44, "N/BG,W+/R", 1)
            restore screen from p22_1
            if (LastKey() == K_ESC)
               alert(alltrim(afrases[35]))
               exit
            endif
            dat1:= family[nelem][1]
            dat2:= family[nelem][2]
            dato4:= SubStr(famil[nelem], 1, 20)
            dato5:= SubStr(famil[nelem], 24, 20)
            set color to N/W*
            @ l3, fiz + ancho1 + 3 say strzero(dat1, 2) + ;
               strzero(dat2, 2)
            set color to R/W*,R/W*
            @ l1, fiz + ancho1 + 3 say dato4
            @ l2, fiz + ancho1 + 3 say dato5
            @ l3, fiz + ancho1 + 7 get dat3 picture "9999" valid ;
               dat3 > 0
            read
            if (LastKey() = K_ESC .OR. dat3 = 0)
               alert(alltrim(afrases[35]))
               exit
            endif
            dato1:= strzero(dat1, 2) + strzero(dat2, 2) + ;
               strzero(dat3, 4)
            seek dato1
            if (Found())
               alert(alltrim(afrases[36]))
               dato1:= "        "
               dat1:= 0
               loop
            endif
            @ l3, fiz + ancho1 + 3 say dato1
            do while (.T.)
               set key K_F10 to f10_22_1
               set key K_ENTER to ord22_1
               get22_1()
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
               save screen to pannet
               opbcol:= SetColor()
               set color to W+/R
               do while (.T.)
                  if (RLock())
                     rpl22_1()
                     unlock
                     exit
                  else
                     jjbox(9, 12, 11, 70, "W+/R", 20, 1, .F.)
                     @ 10, 15 say ;
                        "ATENCION: Registro ocupado en red, espere por favor.."
                     InKey(1)
                  endif
               enddo
               set color to (opbcol)
               restore screen from pannet
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
            save screen to pannet
            opbcol:= SetColor()
            set color to W+/R
            do while (.T.)
               if (FLock())
                  delete
                  pack
                  goto top
                  unlock
                  exit
               else
                  jjbox(9, 12, 11, 70, "W+/R", 20, 1, .F.)
                  @ 10, 15 say ;
                     "ATENCION: Registro ocupado en red, espere por favor.."
                  InKey(1)
               endif
            enddo
            set color to (opbcol)
            restore screen from pannet
         endif
         restore screen from pantabm
      case opc27 = 3
         set color to R/W*,R/W*
         save screen to pantabm
         aca:= cod
         dat1:= 0
         dat2:= 0
         dat3:= Val(SubStr(cod, 5, 4))
         dato1:= cod
         dato1b:= codbarra
         dato2:= nombrecom
         dato3:= nombrered
         dato4:= grupo
         dato5:= familia
         dato6:= precio1
         dato7:= unidad
         dato8:= llevastk
         dato9:= stkasoc
         dato10:= stkmax
         dato11:= stkmin
         dato12:= stkped
         dato13:= numiva
         dato14:= sosutaiva
         dato15:= nimpint
         dato16:= impintfij
         dato17:= sosutai_i
         dato18:= ret_a_rni
         dato19:= per_i_bru
         dato20:= bonific
         mtr22_1()
         do while (.T.)
            save screen to p22_1
            nelem:= 0
            nj:= ascan(famil, dato4 + "ÄÄ>" + dato5)
            ky:= ""
            y:= 1
            for y:= 1 to nj - 1
               ky:= ky + ""
            next
            keyboard ky
            totlen:= Len(famil)
            wa:= Len(famil)
            hh:= l2
            if (hh + wa > 22)
               hh:= 22
            else
               hh:= hh + wa
            endif
            achoi02("Famil", l2 - 1, fiz + ancho1 + 3, hh, fiz + ;
               ancho1 + 3 + 44, "N/BG,W+/R", 1)
            restore screen from p22_1
            if (LastKey() == K_ESC)
               alert(alltrim(afrases[35]))
               exit
            endif
            dat1:= family[nelem][1]
            dat2:= family[nelem][2]
            dato4:= SubStr(famil[nelem], 1, 20)
            dato5:= SubStr(famil[nelem], 24, 20)
            set color to N/W*
            @ l3, fiz + ancho1 + 3 say strzero(dat1, 2) + ;
               strzero(dat2, 2)
            set color to R/W*,R/W*
            @ l1, fiz + ancho1 + 3 say dato4
            @ l2, fiz + ancho1 + 3 say dato5
            @ l3, fiz + ancho1 + 7 get dat3 picture "9999" valid ;
               dat3 > 0
            read
            if (LastKey() = K_ESC .OR. dat3 = 0)
               alert(alltrim(afrases[35]))
               exit
            endif
            dato1:= strzero(dat1, 2) + strzero(dat2, 2) + ;
               strzero(dat3, 4)
            estees:= RecNo()
            seek dato1
            if (Found() .AND. RecNo() != estees)
               alert(alltrim(afrases[36]))
               dato1:= "        "
               seek aca
               loop
            endif
            seek aca
            @ l3, fiz + ancho1 + 3 say dato1
            do while (.T.)
               set key K_F10 to f10_22_1
               set key K_ENTER to ord22_1
               get22_1()
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
               if (cod = aca)
                  save screen to pannet
                  opbcol:= SetColor()
                  set color to W+/R
                  do while (.T.)
                     if (RLock())
                        rpl22_1()
                        unlock
                        exit
                     else
                        jjbox(9, 12, 11, 70, "W+/R", 20, 1, .F.)
                        @ 10, 15 say ;
                           "ATENCION: Registro ocupado en red, espere por favor.."
                        InKey(1)
                     endif
                  enddo
                  set color to (opbcol)
                  restore screen from pannet
               else
                  alert("No encuentro el archivo a modificar...")
               endif
            else
               seek aca
            endif
            exit
         enddo
         restore screen from pantabm
      case opc27 = 4
         set color to R/W*,R/W*
         save screen to pantabm
         aca:= cod
         dat1:= 0
         dat2:= 0
         dat3:= Val(SubStr(cod, 5, 4)) + 1
         dato1:= cod
         dato1b:= codbarra
         dato2:= nombrecom
         dato3:= nombrered
         dato4:= grupo
         dato5:= familia
         dato6:= precio1
         dato7:= unidad
         dato8:= llevastk
         dato9:= stkasoc
         dato10:= stkmax
         dato11:= stkmin
         dato12:= stkped
         dato13:= numiva
         dato14:= sosutaiva
         dato15:= nimpint
         dato16:= impintfij
         dato17:= sosutai_i
         dato18:= ret_a_rni
         dato19:= per_i_bru
         dato20:= bonific
         mtr22_1()
         do while (.T.)
            save screen to p22_1
            nelem:= 0
            nj:= ascan(famil, dato4 + "ÄÄ>" + dato5)
            ky:= ""
            y:= 1
            for y:= 1 to nj - 1
               ky:= ky + ""
            next
            keyboard ky
            totlen:= Len(famil)
            wa:= Len(famil)
            hh:= l2
            if (hh + wa > 22)
               hh:= 22
            else
               hh:= hh + wa
            endif
            achoi02("Famil", l2 - 1, fiz + ancho1 + 3, hh, fiz + ;
               ancho1 + 3 + 44, "N/BG,W+/R", 1)
            restore screen from p22_1
            if (LastKey() == K_ESC)
               alert(alltrim(afrases[35]))
               exit
            endif
            dat1:= family[nelem][1]
            dat2:= family[nelem][2]
            dato4:= SubStr(famil[nelem], 1, 20)
            dato5:= SubStr(famil[nelem], 24, 20)
            set color to N/W*
            @ l3, fiz + ancho1 + 3 say strzero(dat1, 2) + ;
               strzero(dat2, 2)
            set color to R/W*,R/W*
            @ l1, fiz + ancho1 + 3 say dato4
            @ l2, fiz + ancho1 + 3 say dato5
            @ l3, fiz + ancho1 + 7 get dat3 picture "9999" valid ;
               dat3 > 0
            read
            if (LastKey() = K_ESC .OR. dat3 = 0)
               alert(alltrim(afrases[35]))
               exit
            endif
            dato1:= strzero(dat1, 2) + strzero(dat2, 2) + ;
               strzero(dat3, 4)
            seek dato1
            if (Found())
               alert(alltrim(afrases[36]))
               dato1:= "        "
               seek aca
               loop
            endif
            seek aca
            @ l3, fiz + ancho1 + 3 say dato1
            do while (.T.)
               set key K_F10 to f10_22_1
               set key K_ENTER to ord22_1
               get22_1()
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
               save screen to pannet
               opbcol:= SetColor()
               set color to W+/R
               do while (.T.)
                  if (RLock())
                     rpl22_1()
                     unlock
                     exit
                  else
                     jjbox(9, 12, 11, 70, "W+/R", 20, 1, .F.)
                     @ 10, 15 say ;
                        "ATENCION: Registro ocupado en red, espere por favor.."
                     InKey(1)
                  endif
               enddo
               set color to (opbcol)
               restore screen from pannet
            else
               seek aca
            endif
            exit
         enddo
         restore screen from pantabm
      case opc27 = 5
         save screen to pantabm
         campos:= "SUBSTR(COD+' '+NOMBRECOM,1,55)"
         acata:= RecNo()
         set order to 2
         brow02(campos, 10, 3, "N/BG+", "N/W*,W+/R", "NOMBRECOM", 2)
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
            prn22_1()
         endif
         restore screen from pantabm
      endcase
   enddo
   return

********************************
procedure VER_22_1

   set color to N/W
   @ l1, fiz + 2 say "Grupo            :"
   @ l2, fiz + 2 say "Familia          :"
   @ l3, fiz + 2 say "C¢digo art¡culo  :"
   @ l3, fiz + 32 say "C¢d.barra:"
   @ l4, fiz + 2 say "Nombre completo  :"
   @ l5, fiz + 2 say "Nombre reducido  :"
   @ l6, fiz + 2 say "Precio (Lista1)  :"
   @ l6, fiz + 37 say "% Bonificaci¢n:"
   @ l7, fiz + 2 say "                  "
   @ l8, fiz + 2 say "Unidad           :"
   @ l9, fiz + 2 say "Lleva stock   s/n:"
   @ l10, fiz + 2 say "Lleva f¢rmula s/n:"
   @ l8, fiz + 37 say "Stock m ximo  :"
   @ l9, fiz + 37 say "Stock m¡nimo  :"
   @ l10, fiz + 37 say "Stock p.pedido:"
   @ l11, fiz + 2 say "                 :"
   @ l12, fiz + 2 say "Al¡cuota IVA     :"
   @ l13, fiz + 2 say "+- Tasa IVA      :"
   @ l14, fiz + 2 say "Impuesto Interno.:"
   @ l14, fiz + 46 say "Monto:"
   @ l15, fiz + 2 say "+- Tasa Imp.Int. :"
   @ l16, fiz + 2 say "Aplicar ret a RNI:"
   @ l17, fiz + 2 say "Percep. I.Brutos :"
   set color to B/W
   @ l1, fiz + ancho1 + 3 say grupo
   @ l2, fiz + ancho1 + 3 say familia
   @ l3, fiz + ancho1 + 3 say cod
   @ l3, fiz + ancho1 + 25 say codbarra
   @ l4, fiz + ancho1 + 3 say nombrecom
   @ l5, fiz + ancho1 + 3 say nombrered
   @ l6, fiz + ancho1 + 3 say precio1 picture "99999.9999"
   @ l6, fiz + ancho1 + 35 say bonific picture "999.9"
   @ l8, fiz + ancho1 + 3 say unidad
   @ l9, fiz + ancho1 + 3 say llevastk
   @ l10, fiz + ancho1 + 3 say stkasoc
   @ l8, fiz + ancho1 + 35 say stkmax picture "999999.999"
   @ l9, fiz + ancho1 + 35 say stkmin picture "999999.999"
   @ l10, fiz + ancho1 + 35 say stkped picture "999999.999"
   @ l12, fiz + ancho1 + 3 say numiva picture "99"
   @ l13, fiz + ancho1 + 3 say sosutaiva picture "99"
   @ l14, fiz + ancho1 + 3 say nimpint picture "99"
   @ l14, fiz + ancho1 + 35 say impintfij picture "99999.9999"
   @ l15, fiz + ancho1 + 3 say sosutai_i picture "99"
   @ l16, fiz + ancho1 + 3 say ret_a_rni
   @ l17, fiz + ancho1 + 3 say per_i_bru picture "99"
   if (numiva > 0)
      @ l12, fiz + ancho1 + 6 say alic[numiva]
   else
      @ l12, fiz + ancho1 + 6 say "                    "
   endif
   if (sosutaiva > 0)
      @ l13, fiz + ancho1 + 6 say alic[sosutaiva]
   else
      @ l13, fiz + ancho1 + 6 say "                    "
   endif
   if (nimpint > 0)
      @ l14, fiz + ancho1 + 6 say alic[nimpint]
   else
      @ l14, fiz + ancho1 + 6 say "                    "
   endif
   if (sosutai_i > 0)
      @ l15, fiz + ancho1 + 6 say alic[sosutai_i]
   else
      @ l15, fiz + ancho1 + 6 say "                    "
   endif
   if (per_i_bru > 0)
      @ l17, fiz + ancho1 + 6 say alic[per_i_bru]
   else
      @ l17, fiz + ancho1 + 6 say "                    "
   endif
   return

********************************
procedure RPL22_1

   replace cod with dato1
   replace codbarra with dato1b
   replace nombrecom with dato2
   replace nombrered with dato3
   replace grupo with dato4
   replace familia with dato5
   replace precio1 with dato6
   replace bonific with dato20
   replace unidad with dato7
   replace llevastk with dato8
   replace stkasoc with dato9
   replace stkmax with dato10
   replace stkmin with dato11
   replace stkped with dato12
   replace numiva with dato13
   replace sosutaiva with dato14
   replace nimpint with dato15
   replace impintfij with dato16
   replace sosutai_i with dato17
   replace ret_a_rni with dato18
   replace per_i_bru with dato19
   return

********************************
procedure MTR22_1

   @ l1, fiz + ancho1 + 3 say dato4
   @ l2, fiz + ancho1 + 3 say dato5
   @ l3, fiz + ancho1 + 3 say dato1
   @ l3, fiz + ancho1 + 25 say dato1b
   @ l4, fiz + ancho1 + 3 say dato2
   @ l5, fiz + ancho1 + 3 say dato3
   @ l6, fiz + ancho1 + 3 say dato6 picture "99999.9999"
   @ l6, fiz + ancho1 + 35 say dato20 picture "999.9"
   @ l8, fiz + ancho1 + 3 say dato7
   @ l9, fiz + ancho1 + 3 say dato8
   @ l10, fiz + ancho1 + 3 say dato9
   @ l8, fiz + ancho1 + 35 say dato10 picture "999999.999"
   @ l9, fiz + ancho1 + 35 say dato11 picture "999999.999"
   @ l10, fiz + ancho1 + 35 say dato12 picture "999999.999"
   @ l12, fiz + ancho1 + 3 say dato13 picture "99"
   @ l13, fiz + ancho1 + 3 say dato14 picture "99"
   @ l14, fiz + ancho1 + 3 say dato15 picture "99"
   @ l14, fiz + ancho1 + 35 say dato16 picture "99999.9999"
   @ l15, fiz + ancho1 + 3 say dato17 picture "99"
   @ l16, fiz + ancho1 + 3 say dato18
   @ l17, fiz + ancho1 + 3 say dato19 picture "99"
   if (dato13 > 0)
      @ l12, fiz + ancho1 + 6 say alic[dato13]
   else
      @ l12, fiz + ancho1 + 6 say "                    "
   endif
   if (dato14 > 0)
      @ l13, fiz + ancho1 + 6 say alic[dato14]
   else
      @ l13, fiz + ancho1 + 6 say "                    "
   endif
   if (dato15 > 0)
      @ l14, fiz + ancho1 + 6 say alic[dato15]
   else
      @ l14, fiz + ancho1 + 6 say "                    "
   endif
   if (dato17 > 0)
      @ l15, fiz + ancho1 + 6 say alic[dato17]
   else
      @ l15, fiz + ancho1 + 6 say "                    "
   endif
   if (dato19 > 0)
      @ l17, fiz + ancho1 + 6 say alic[dato19]
   else
      @ l17, fiz + ancho1 + 6 say "                    "
   endif
   return

********************************
procedure GET22_1

   @ 24,  0 say ;
      "  F10=Opciones                                                                 "
   @ l3, fiz + ancho1 + 25 get dato1b
   @ l4, fiz + ancho1 + 3 get dato2 valid Len(alltrim(dato2)) > 0
   @ l5, fiz + ancho1 + 3 get dato3 valid Len(alltrim(dato3)) > 0
   @ l6, fiz + ancho1 + 3 get dato6 picture "99999.9999" valid dato6 ;
      > 0
   @ l6, fiz + ancho1 + 35 get dato20 picture "999.9"
   @ l8, fiz + ancho1 + 3 get dato7 valid Len(alltrim(dato7)) > 0
   @ l9, fiz + ancho1 + 3 get dato8 picture "@!" valid dato8 = "S" ;
      .OR. dato8 = "N"
   @ l10, fiz + ancho1 + 3 get dato9 picture "@!" valid dato9 = "S" ;
      .OR. dato9 = "N"
   @ l8, fiz + ancho1 + 35 get dato10 picture "999999.999" when ;
      dato8 = "S"
   @ l9, fiz + ancho1 + 35 get dato11 picture "999999.999" when ;
      dato8 = "S"
   @ l10, fiz + ancho1 + 35 get dato12 picture "999999.999" when ;
      dato8 = "S"
   @ l12, fiz + ancho1 + 3 get dato13 picture "99" valid dato13 > 0
   @ l13, fiz + ancho1 + 3 get dato14 picture "99" valid dato14 > 0
   @ l14, fiz + ancho1 + 3 get dato15 picture "99" valid dato15 > 0
   @ l14, fiz + ancho1 + 35 get dato16 picture "99999.9999" when ;
      dato15 = 40
   @ l15, fiz + ancho1 + 3 get dato17 picture "99" valid dato17 > 0
   @ l16, fiz + ancho1 + 3 get dato18 picture "@!" valid dato18 = ;
      "S" .OR. dato18 = "N"
   @ l17, fiz + ancho1 + 3 get dato19 picture "99" valid dato19 > 0
   return

********************************
procedure PRN22_1

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
procedure ORD22_1

   h:= Row()
   f:= Col()
   tecl:= ""
   queali:= 0
   do case
   case h >= l1 .AND. h <= l11
      keyboard Chr(24)
   case h = l12
      queali:= 1
      if (dato13 > 0 .AND. dato13 <= 10)
         if (alic[dato13] != "<ÄÄ No reconocido ! ")
            @ l12, fiz + ancho1 + 6 say alic[dato13]
            keyboard Chr(24)
         else
            datou:= bus22_1a(dato13)
            dato13:= datou
         endif
      else
         ojo(1)
         dato13:= 0
         @ l12, fiz + ancho1 + 6 say "                    "
         keyboard Chr(7) + Chr(7) + Chr(19)
      endif
   case h = l13
      queali:= 2
      if (dato14 >= 11 .AND. dato14 <= 20)
         if (alic[dato14] != "<ÄÄ No reconocido ! ")
            @ l13, fiz + ancho1 + 6 say alic[dato14]
            keyboard Chr(24)
         else
            datou:= bus22_1a(dato14)
            dato14:= datou
         endif
      else
         ojo(1)
         dato14:= 0
         @ l13, fiz + ancho1 + 6 say "                    "
         keyboard Chr(7) + Chr(7) + Chr(19)
      endif
   case h = l14 .AND. f < 40
      queali:= 3
      if (dato15 >= 21 .AND. dato15 <= 40)
         if (alic[dato15] != "<ÄÄ No reconocido ! ")
            @ l14, fiz + ancho1 + 6 say alic[dato15]
            keyboard Chr(24)
         else
            datou:= bus22_1a(dato15)
            dato15:= datou
         endif
      else
         ojo(1)
         dato15:= 0
         @ l14, fiz + ancho1 + 6 say "                    "
         keyboard Chr(7) + Chr(7) + Chr(19)
      endif
   case h = l14 .AND. f > 40
      keyboard Chr(24)
   case h = l15
      queali:= 4
      if (dato17 >= 41 .AND. dato17 <= 50)
         if (alic[dato17] != "<ÄÄ No reconocido ! ")
            @ l15, fiz + ancho1 + 6 say alic[dato17]
            keyboard Chr(24)
         else
            datou:= bus22_1a(dato17)
            dato17:= datou
         endif
      else
         ojo(1)
         dato17:= 0
         @ l15, fiz + ancho1 + 6 say "                    "
         keyboard Chr(7) + Chr(7) + Chr(19)
      endif
   case h = l16
      keyboard Chr(24)
   case h = l17
      queali:= 5
      if (dato19 >= 51 .AND. dato19 <= 60)
         if (alic[dato19] != "<ÄÄ No reconocido ! ")
            @ l17, fiz + ancho1 + 6 say alic[dato19]
            SetKey(K_ENTER, Nil)
            keyboard Chr(13)
         else
            datou:= bus22_1a(dato19)
            dato19:= datou
         endif
      else
         ojo(1)
         dato19:= 0
         @ l17, fiz + ancho1 + 6 say "                    "
         keyboard Chr(7) + Chr(7) + Chr(19)
      endif
   endcase
   select 1
   return

********************************
procedure F10_22_1

   h:= Row()
   f:= Col()
   tecl:= ""
   do case
   case h = l12
      datou:= bus22_1a(dato13)
      dato13:= datou
   case h = l13
      datou:= bus22_1a(dato14)
      dato14:= datou
   case h = l14 .AND. f < 40
      datou:= bus22_1a(dato15)
      dato15:= datou
   case h = l15
      datou:= bus22_1a(dato17)
      dato17:= datou
   case h = l17
      datou:= bus22_1a(dato19)
      dato19:= datou
   endcase
   select 1
   return

********************************
function BUS22_1A

   parameters nalic
   SetKey(K_ENTER, Nil)
   SetKey(K_F10, Nil)
   save screen to p22_1
   nelem:= 0
   totlen:= Len(alic2)
   wa:= Len(alic2)
   hh:= h
   if (h + wa > 23)
      hh:= 23 - wa
   endif
   boxshadow(h - 1, fiz, h - 1, fiz + ancho1)
   achoi02("Alic2", hh - 1, fiz + ancho1 + 3, hh + wa, fiz + ancho1 ;
      + 3 + 36, "N/BG,W+/R", 1)
   restore screen from p22_1
   if (LastKey() != K_ESC)
      nalic:= alic1[nelem]
      @ h, fiz + ancho1 + 6 say alic[nalic]
   endif
   set key K_ENTER to ord22_1
   set key K_F10 to f10_22_1
   return nalic

********************************
procedure OJO

   quecol:= SetColor()
   save screen to pojo
   do case
   case queali = 1
      lin_1:= "Al¡cuota de IVA     "
      lin_2:= "debe ser del 1 al 10 "
   case queali = 2
      lin_1:= "Sobre/Subtasa IVA   "
      lin_2:= "debe ser del 11 al 20"
   case queali = 3
      lin_1:= "Impuesto interno    "
      lin_2:= "debe ser del 21 al 40"
   case queali = 4
      lin_1:= "Sob/Subtasa Imp.Int."
      lin_2:= "debe ser del 41 al 50"
   case queali = 5
      lin_1:= "Percepci¢n I.Brutos "
      lin_2:= "debe ser del 51 al 60"
   endcase
   do while (.T.)
      set color to N/BG
      x7:= 10
      y7:= 25
      jjbox(x7, y7, x7 + 6, y7 + 24, "N/BG", 20, 1, .T.)
      @ x7 + 1, y7 + 2 say "El c¢digo para"
      @ x7 + 2, y7 + 2 say lin_1
      @ x7 + 3, y7 + 2 say lin_2
      set color to W/R
      setcursor(0)
      @ x7 + 5, y7 + 10 say " OK "
      InKey(0)
      setcursor(1)
      if (LastKey() = K_ESC .OR. LastKey() = K_ENTER)
         exit
      endif
   enddo
   restore screen from pojo
   set color to (quecol)
   return

********************************
procedure FUN_22_5

   @ 24,  0
   far:= 7
   fiz:= 1
   fab:= 21
   fde:= 70
   ancho1:= 16
   ancho2:= 20
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
   opbasexc("BASE004")
   set index to BASE004A, BASE004B
   set order to 1
   goto bottom
   ultnum:= nro_rubro
   goto top
   opc27:= 1
   do while (opc27 != 0)
      setblink(.F.)
      ver_22_5()
      set message to 24 center
      set color to W+/B,B/W*
      abm_prom(fab, fiz)
      set wrap on
      menu to opc27
      do case
      case opc27 = 1
         set color to R/W*,R/W*
         save screen to pantabm
         aca:= nro_rubro
         dato1:= ultnum + 1
         dato2:= "                    "
         mtr22_5()
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
               get22_5()
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
               rpl22_5()
               ultnum:= nro_rubro
               seek dato1
            else
               seek aca
            endif
            exit
         enddo
         restore screen from pantabm
      case opc27 = 2
         save screen to pantabm
         dato1:= nro_rubro
         select 2
         opbassha("BASE005", "BASE005A")
         locate for nro_grupo = dato1
         if (Found())
            alert("NO BORRAR: Existen familias en este grupo")
            close
            select 1
            restore screen from pantabm
            loop
         endif
         close
         select 1
         resp:= " "
         confirm0(15, 35)
         if (resp = "S")
            delete
            pack
            goto bottom
            ultnum:= nro_rubro
         endif
         restore screen from pantabm
      case opc27 = 3
         set color to R/W*,R/W*
         save screen to pantabm
         aca:= nro_rubro
         dato1:= nro_rubro
         dato2:= nom_rubro
         mtr22_5()
         do while (.T.)
            set color to R/W*,R/W*
            get22_5()
            read
            if (LastKey() == K_ESC)
               alert(alltrim(afrases[35]))
               seek aca
               exit
            endif
            resp:= " "
            confirm0(15, 30)
            if (resp = "S")
               rpl22_5()
               mensaje("Actualizando en Art¡culos...", "N/BG")
               select 2
               opbasexc("BASE003")
               DBEval({|| field->grupo:= dato2}, {|| Val(SubStr(cod, ;
                  1, 2)) = dato1}, Nil, Nil, Nil, .F.)
               close
               select 1
            else
               seek aca
            endif
            exit
         enddo
         restore screen from pantabm
      case opc27 = 4
         set color to R/W*,R/W*
         save screen to pantabm
         aca:= nro_rubro
         dato1:= ultnum + 1
         dato2:= nom_rubro
         mtr22_5()
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
               get22_5()
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
               rpl22_5()
               goto bottom
               ultnum:= nro_rubro
               seek dato1
            else
               seek aca
            endif
            exit
         enddo
         restore screen from pantabm
      case opc27 = 5
         save screen to pantabm
         campos:= "SUBSTR(STR(NRO_RUBRO,3)+' '+NOM_RUBRO,1,24)"
         acata:= RecNo()
         set order to 2
         brow02(campos, 10, 3, "N/BG+", "N/W*,W+/R", "NOM_RUBRO", 2)
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
            prn22_5()
         endif
         restore screen from pantabm
      endcase
   enddo
   return

********************************
procedure VER_22_5

   set color to N/W
   @ l1, fiz + 2 say alltrim(afrases[20])
   @ l2, fiz + 2 say alltrim(afrases[21])
   set color to B/W
   @ l1, fiz + ancho1 + 3 say nro_rubro picture "99"
   @ l2, fiz + ancho1 + 3 say nom_rubro
   return

********************************
procedure RPL22_5

   replace nro_rubro with dato1
   replace nom_rubro with dato2
   return

********************************
procedure MTR22_5

   @ l1, fiz + ancho1 + 3 say dato1 picture "99"
   @ l2, fiz + ancho1 + 3 say dato2
   return

********************************
procedure GET22_5

   @ l2, fiz + ancho1 + 3 get dato2 picture "@!" valid ;
      Len(alltrim(dato2)) > 0
   return

********************************
procedure PRN22_5

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
      ? "       ", alltrim(afrases[41]), alltrim(afrases[42]), ":"
      ? "       ", Replicate("Í", 70)
      ? "       ", SubStr(afrases[20], 1, 5), SubStr(afrases[21], 1, ;
         20)
      ? "       ", Replicate("Ä", 70)
      filas:= 1
      locate for RecNo() = desdereg
      do while (filas < 40 .AND. !EOF())
         ? "       ", Str(nro_rubro, 5), nom_rubro
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
   return

********************************
procedure FUN_22_6

   @ 24,  0
   far:= 7
   fiz:= 1
   fab:= 21
   fde:= 70
   ancho1:= 16
   ancho2:= 20
   l1:= far + 2
   l2:= far + 4
   l3:= far + 6
   set color to N/W
   jcbox(far, fiz, fab, fde, "N/W", 20, 1, .T., .F., .T., "W+/B", ;
      alltrim(&bas[opcj3][2]))
   jjbox(fab, fiz, fab, fde, "W/B", 20, 5, .F.)
   jjbox(far + 1, fiz + ancho1 + 2, far + 3, fiz + ancho1 + ancho2 + ;
      3, "N/W", 20, 4, .F.)
   jjbox(far + 3, fiz + ancho1 + 2, far + 5, fiz + ancho1 + ancho2 + ;
      3, "N/W", 20, 7, .F.)
   jjbox(far + 5, fiz + ancho1 + 2, far + 7, fiz + ancho1 + ancho2 + ;
      3, "N/W", 20, 7, .F.)
   select 2
   opbasexc("BASE004", "BASE004B")
   select 1
   opbasexc("BASE005")
   set index to BASE005A, BASE005B, BASE005C
   set order to 3
   goto top
   opc27:= 1
   do while (opc27 != 0)
      setblink(.F.)
      ver_22_6()
      set message to 24 center
      set color to W+/B,B/W*
      abm_prom(fab, fiz)
      set wrap on
      menu to opc27
      do case
      case opc27 = 1
         set color to R/W*,R/W*
         save screen to pantabm
         aca:= Str(nro_grupo, 2) + Str(nro_rubro, 2)
         dato1:= 0
         dato2:= "                    "
         dato3:= "                    "
         dato4:= 0
         mtr22_6()
         do while (.T.)
            set color to R/W*,R/W*
            campy:= "SUBSTR(STR(NRO_RUBRO,2)+' '+NOM_RUBRO,1,24)"
            rfcampy1:= "NRO_RUBRO"
            rfcampy2:= "NOM_RUBRO"
            elnom:= dato3
            elnum:= dato4
            cuales(l1, fiz + ancho1 + 3, l1 - 3, fiz + ancho1 + 3, 2)
            select 1
            if (LastKey() == K_ESC)
               alert(alltrim(afrases[35]))
               seek aca
               exit
            endif
            dato3:= SubStr(elnom, 1, 20)
            dato4:= elnum
            @ l1, fiz + ancho1 + 3 say elnom
            @ l2, fiz + ancho1 + 3 get dato1 picture "99"
            read
            if (LastKey() = K_ESC .OR. dato1 = 0)
               alert(alltrim(afrases[35]))
               exit
            endif
            dref:= Str(dato4, 2) + Str(dato1, 2)
            seek dref
            if (Found())
               alert(alltrim(afrases[36]))
               dato1:= 0
               loop
            endif
            get22_6()
            read
            if (LastKey() == K_ESC)
               alert(alltrim(afrases[35]))
               seek aca
               exit
            endif
            resp:= " "
            confirm0(15, 35)
            if (resp = "S")
               append blank
               rpl22_6()
            else
               seek aca
            endif
            exit
         enddo
         restore screen from pantabm
      case opc27 = 2
         save screen to pantabm
         dato1:= strzero(nro_grupo, 2) + strzero(nro_rubro, 2)
         select 2
         opbassha("BASE003")
         locate for SubStr(cod, 1, 4) == dato1
         if (Found())
            alert("NO BORRAR: Existen art¡culos en esta familia")
            close
            select 1
            restore screen from pantabm
            loop
         endif
         close
         select 1
         resp:= " "
         confirm0(15, 35)
         if (resp = "S")
            delete
            pack
            goto top
         endif
         restore screen from pantabm
      case opc27 = 3
         set color to R/W*,R/W*
         save screen to pantabm
         esteno:= RecNo()
         aca:= Str(nro_grupo, 2) + Str(nro_rubro, 2)
         dato1:= nro_rubro
         dato2:= nom_rubro
         dato3:= nom_grupo
         dato4:= nro_grupo
         mtr22_6()
         do while (.T.)
            get22_6()
            read
            if (LastKey() == K_ESC)
               alert(alltrim(afrases[35]))
               seek aca
               exit
            endif
            goto top
            locate for RecNo() = esteno
            resp:= " "
            confirm0(15, 35)
            if (resp = "S")
               rpl22_6()
               mensaje("Actualizando en Art¡culos...", "N/BG")
               select 2
               opbasexc("BASE003", "BASE003A")
               reficod:= strzero(dato4, 2) + strzero(dato1, 2)
               DBEval({|| field->familia:= dato2}, {|| SubStr(cod, ;
                  1, 4) = reficod}, Nil, Nil, Nil, .F.)
               close
               select 1
            else
               seek aca
            endif
            exit
         enddo
         restore screen from pantabm
      case opc27 = 4
      case opc27 = 5
         save screen to pantabm
         aca:= Str(nro_grupo, 2) + Str(nro_rubro, 2)
         campos:= ;
            "SUBSTR(STR(NRO_GRUPO,2)+' '+NOM_GRUPO+'Ä>'+STR(NRO_RUBRO,2)+' '+NOM_RUBRO,1,55)"
         brow02(campos, 10, 3, "N/BG+", "N/W*,W+/R", "NOM_RUBRO", 2)
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
            prn22_6()
         endif
         restore screen from pantabm
      endcase
   enddo
   return

********************************
procedure VER_22_6

   set color to N/W
   @ l1, fiz + 2 say "Grupo corresp. :"
   @ l2, fiz + 2 say "C¢digo         :"
   @ l3, fiz + 2 say "Nombre         :"
   set color to B/W
   @ l1, fiz + ancho1 + 3 say nom_grupo
   @ l2, fiz + ancho1 + 3 say nro_rubro picture "99"
   @ l3, fiz + ancho1 + 3 say nom_rubro
   return

********************************
procedure RPL22_6

   replace nro_rubro with dato1
   replace nom_rubro with dato2
   replace nro_grupo with dato4
   replace nom_grupo with dato3
   return

********************************
procedure MTR22_6

   @ l3, fiz + ancho1 + 3 say dato2
   return

********************************
procedure GET22_6

   @ l3, fiz + ancho1 + 3 get dato2 picture "@!" valid ;
      Len(alltrim(dato2)) > 0
   return

********************************
procedure PRN22_6

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
         ? "       ", Str(nro_rubro, 5), nom_rubro
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
   set order to 3
   return

********************************
procedure FUN_22_2

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
   opbasexc("BASE007")
   set index to BASE007A, BASE007B
   set order to 1
   goto bottom
   ultnum:= nro_concep
   goto top
   opc27:= 1
   do while (opc27 != 0)
      setblink(.F.)
      ver_22_2()
      set message to 24 center
      set color to W+/B,B/W*
      abm_prom(fab, fiz)
      set wrap on
      menu to opc27
      do case
      case opc27 = 1
         set color to R/W*,R/W*
         save screen to pantabm
         aca:= nro_concep
         dato1:= ultnum + 1
         dato2:= "                    "
         mtr22_2()
         do while (.T.)
            set color to R/W*,R/W*
            @ l1, fiz + ancho1 + 3 get dato1 picture "999"
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
               get22_2()
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
               rpl22_2()
               ultnum:= nro_concep
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
            ultnum:= nro_concep
         endif
         restore screen from pantabm
      case opc27 = 3
         set color to R/W*,R/W*
         save screen to pantabm
         aca:= nro_concep
         dato1:= nro_concep
         dato2:= nom_concep
         mtr22_2()
         do while (.T.)
            set color to R/W*,R/W*
            get22_2()
            read
            if (LastKey() == K_ESC)
               alert(alltrim(afrases[35]))
               seek aca
               exit
            endif
            resp:= " "
            confirm0(15, 30)
            if (resp = "S")
               rpl22_2()
            else
               seek aca
            endif
            exit
         enddo
         restore screen from pantabm
      case opc27 = 4
         set color to R/W*,R/W*
         save screen to pantabm
         aca:= nro_concep
         dato1:= ultnum + 1
         dato2:= nom_concep
         mtr22_2()
         do while (.T.)
            set color to R/W*,R/W*
            @ l1, fiz + ancho1 + 3 get dato1 picture "999"
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
               get22_2()
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
               rpl22_2()
               goto top
               ultnum:= nro_concep
               seek dato1
            else
               seek aca
            endif
            exit
         enddo
         restore screen from pantabm
      case opc27 = 5
         save screen to pantabm
         campos:= "SUBSTR(STR(NRO_CONCEP,3)+' '+NOM_CONCEP,1,34)"
         acata:= RecNo()
         set order to 2
         brow02(campos, 10, 3, "N/BG+", "N/W*,W+/R", "NOM_CONCEP", 2)
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
            prn22_2()
         endif
         restore screen from pantabm
      endcase
   enddo
   return

********************************
procedure VER_22_2

   set color to N/W
   @ l1, fiz + 2 say alltrim(afrases[20])
   @ l2, fiz + 2 say alltrim(afrases[21])
   set color to B/W
   @ l1, fiz + ancho1 + 3 say nro_concep picture "999"
   @ l2, fiz + ancho1 + 3 say nom_concep
   return

********************************
procedure RPL22_2

   replace nro_concep with dato1
   replace nom_concep with dato2
   return

********************************
procedure MTR22_2

   @ l1, fiz + ancho1 + 3 say dato1 picture "999"
   @ l2, fiz + ancho1 + 3 say dato2
   return

********************************
procedure GET22_2

   @ l2, fiz + ancho1 + 3 get dato2 picture "@!" valid ;
      Len(alltrim(dato2)) > 0
   return

********************************
procedure PRN22_2

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
      ? "       ", alltrim(afrases[41]), alltrim(afrases[46]), ":"
      ? "       ", Replicate("Í", 70)
      ? "       ", SubStr(afrases[20], 1, 5), SubStr(afrases[21], 1, ;
         30)
      ? "       ", Replicate("Ä", 70)
      filas:= 1
      locate for RecNo() = desdereg
      do while (filas < 40 .AND. !EOF())
         ? "       ", Str(nro_concep, 5), nom_concep
         filas:= 1 + filas
         tcant:= 1 + tcant
         skip 
      enddo
      if (EOF())
         ? "       ", Replicate("Ä", 70)
         ? "       ", "TOTALES.......", alltrim(Str(tcant, 3)), ;
            "CONCEPS."
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
procedure FUN_22_3

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
   opbasexc("BASE012", "BASE012A")
   goto bottom
   ultnum:= numero
   goto top
   opc27:= 1
   do while (opc27 != 0)
      setblink(.F.)
      ver_22_3()
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
         dato2:= Space(30)
         mtr22_3()
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
               get22_3()
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
               rpl22_3()
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
         mtr22_3()
         do while (.T.)
            set color to R/W*,R/W*
            get22_3()
            read
            if (LastKey() == K_ESC)
               alert(alltrim(afrases[35]))
               seek aca
               exit
            endif
            resp:= " "
            confirm0(15, 30)
            if (resp = "S")
               rpl22_3()
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
         mtr22_3()
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
               get22_3()
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
               rpl22_3()
               goto top
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
         aca:= numero
         brow02(campos, 10, 3, "N/BG+", "N/W*,W+/R", "NOMBRE", 2)
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
            prn22_3()
         endif
         restore screen from pantabm
      endcase
   enddo
   return

********************************
procedure VER_22_3

   set color to N/W
   @ l1, fiz + 2 say alltrim(afrases[20])
   @ l2, fiz + 2 say alltrim(afrases[21])
   set color to B/W
   @ l1, fiz + ancho1 + 3 say numero picture "99"
   @ l2, fiz + ancho1 + 3 say nombre
   return

********************************
procedure RPL22_3

   replace numero with dato1
   replace nombre with dato2
   return

********************************
procedure MTR22_3

   @ l1, fiz + ancho1 + 3 say dato1 picture "99"
   @ l2, fiz + ancho1 + 3 say dato2
   return

********************************
procedure GET22_3

   @ l2, fiz + ancho1 + 3 get dato2 picture "@!" valid ;
      Len(alltrim(dato2)) > 0
   return

********************************
procedure PRN22_3

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
      ? "       ", alltrim(afrases[41]), alltrim(afrases[46]), ":"
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
            "CONCEPS."
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
procedure FUN_21_1

   alert("Disculpe, esta funci¢n est  siendo modificada.")
   return

********************************
procedure FUN_21_2

   alert("Disculpe, esta funci¢n est  siendo modificada.")
   return

********************************
procedure FUN_21_3

   alert("Disculpe, esta funci¢n est  siendo modificada.")
   return

********************************
procedure FUN_21_4

   alert("Disculpe, esta funci¢n est  siendo modificada.")
   return

********************************
procedure FUN_21_5

   alert("Disculpe, esta funci¢n est  siendo modificada.")
   return

********************************
procedure FUN_22_4

   alert("Disculpe, esta funci¢n est  siendo modificada.")
   return

********************************
procedure FUN_23_1

   alert("No existen registros.")
   return

* EOF
