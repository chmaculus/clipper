#include "common.ch"
#include "inkey.ch"

********************************
   clear screen
   clear gets
   save screen to pinicio
   run CUBO.EXE
   set date british
   if (iscolor())
      set color to "N/B*,N/W,,B,BG+/B"
   endif
   set century on
   set scoreboard off
   setcursor(0)
   set confirm on
   set fixed on
   set decimals to 6
   setblink(.F.)
   nivel:= 0
   idioma:= 1
   ? "a"
   opbassha("EST00")
   idirec:= alltrim(directorio)
   fispool:= alltrim(dirspool)
   quespool:= alltrim(slogin)
   close
   set default to (idirec)
   opbassha("EST01")
   iusuar:= usuarios
   iresgu:= resguardo
   ititul:= titulo
   ititular:= titulo2
   mapa:= mapacarac
   inoacc:= col_acces
   qwncaja:= qncaja
   qwfecha:= qfecha
   mpconon:= ""
   mpconoff:= ""
   titulon:= "W"
   tituloff:= "W" + Chr(0)
   close
   com:= "1"
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
   opbassha("BASE002")
   titular:= alltrim(comercio)
   resptitu:= 1
   private adocum[7, 3]
   y:= 1
   for y:= 1 to 7
      adocum[y][1]:= y
   next
   adocum[1][2]:= "C"
   adocum[2][2]:= "0"
   adocum[3][2]:= "1"
   adocum[4][2]:= "2"
   adocum[5][2]:= "3"
   adocum[6][2]:= "4"
   adocum[7][2]:= " "
   adocum[1][3]:= "C.U.I.T.            "
   adocum[2][3]:= "Libreta Enrolamiento"
   adocum[3][3]:= "Libreta C¡vica      "
   adocum[4][3]:= "Doc.Nac.de Identid. "
   adocum[5][3]:= "Pasaporte           "
   adocum[6][3]:= "C‚dula de Identidad "
   adocum[7][3]:= "Sin Calificar       "
   private respiva[7, 3]
   y:= 1
   for y:= 1 to 7
      respiva[y][1]:= y
   next
   respiva[1][2]:= "I"
   respiva[2][2]:= "N"
   respiva[3][2]:= "E"
   respiva[4][2]:= "A"
   respiva[5][2]:= "C"
   respiva[6][2]:= "M"
   respiva[7][2]:= "C"
   respiva[1][3]:= "Resp. Inscripto     "
   respiva[2][3]:= "Resp. No Inscripto  "
   respiva[3][3]:= "Exento              "
   respiva[4][3]:= "No Responsable      "
   respiva[5][3]:= "Consumidor Final    "
   respiva[6][3]:= "Resp. Monotributo   "
   respiva[7][3]:= "No Categorizado     "
   opbassha("BASE010")
   private alistas[5, 4]
   y:= 1
   for y:= 1 to 5
      alistas[y][1]:= numero
      alistas[y][2]:= nombre
      alistas[y][3]:= formcalc
      alistas[y][4]:= habilit
      skip 
   next
   icolora:= "N/W*,N/W,,B,BG+/B"
   icolorb:= "W/B*,N/W"
   jtop:= 1
   jleft:= 3
   jbott:= 18
   jright:= 65
   jnivop:= 0
   idireca:= idirec + "ESTADO\"
   idirecb:= idirec + "RESPALDO\"
   set default to (idireca)
   opbassha("TERMINOS")
   y:= LastRec()
   private afrases[y]
   goto top
   o:= 1
   for o:= 1 to y
      if (idioma == 1)
         afrases[o]:= frase1
      else
         afrases[o]:= frase2
      endif
      skip 
   next
   close databases
   select 1
   opbasexc("EST02")
   jt1:= jleft + 1
   jtm:= LastRec()
   private aestad[jtm, 6]
   y:= 1
   for i:= 1 to jtm
      aestad[i][1]:= nro_modulo
      if (idioma == 1)
         aestad[i][2]:= nom_modulo
         aestad[i][5]:= mensaje
      else
         aestad[i][2]:= ext_modulo
         aestad[i][5]:= mensaje2
      endif
      aestad[i][3]:= instalado
      aestad[i][4]:= jt1
      aestad[i][6]:= niv_acceso
      jt1:= jt1 + 2 + Len(alltrim(aestad[i][2]))
      skip 
   next
   select 2
   opbasexc("EST04", "NUMMOD4")
   select 1
   opbasexc("EST03", "NUMMOD3")
   totreg:= 0
   DBEval({|| totreg:= totreg + 1}, {|| nro_modulo = 1}, Nil, Nil, ;
      Nil, .F.)
   private asmenu1[totreg, 7]
   totreg:= 0
   DBEval({|| totreg:= totreg + 1}, {|| nro_modulo = 2}, Nil, Nil, ;
      Nil, .F.)
   private asmenu2[totreg, 7]
   totreg:= 0
   DBEval({|| totreg:= totreg + 1}, {|| nro_modulo = 3}, Nil, Nil, ;
      Nil, .F.)
   private asmenu3[totreg, 7]
   totreg:= 0
   DBEval({|| totreg:= totreg + 1}, {|| nro_modulo = 4}, Nil, Nil, ;
      Nil, .F.)
   private asmenu4[totreg, 7]
   totreg:= 0
   DBEval({|| totreg:= totreg + 1}, {|| nro_modulo = 5}, Nil, Nil, ;
      Nil, .F.)
   private asmenu5[totreg, 7]
   totreg:= 0
   DBEval({|| totreg:= totreg + 1}, {|| nro_modulo = 6}, Nil, Nil, ;
      Nil, .F.)
   private asmenu6[totreg, 7]
   goto top
   jeg:= 1
   jref:= 0
   janch1:= 1
   janch2:= 1
   janch3:= 1
   janch4:= 1
   janch5:= 1
   janch6:= 1
   do while (!EOF())
      if (nro_modulo != jref)
         jref:= nro_modulo
         jeg:= 1
      endif
      do case
      case nro_modulo = 1 .AND. aestad[1][3]
         asmenu1[jeg][1]:= nro_rutina
         if (idioma == 1)
            asmenu1[jeg][2]:= nom_rutina
            asmenu1[jeg][3]:= mensaje
         else
            asmenu1[jeg][2]:= ext_rutina
            asmenu1[jeg][3]:= mensaje2
         endif
         asmenu1[jeg][4]:= niv_acceso
         asmenu1[jeg][5]:= ejecuta
         asmenu1[jeg][6]:= nro_modulo
         asmenu1[jeg][7]:= ejecutor
         if (Len(alltrim(asmenu1[jeg][2])) > janch1)
            janch1:= Len(alltrim(asmenu1[jeg][2]))
         endif
         if (!asmenu1[jeg][7])
            select 2
            totreg:= 0
            DBEval({|| totreg:= totreg + 1}, {|| nro_rutina = jeg ;
               .AND. nro_modulo = 1}, Nil, Nil, Nil, .F.)
            newbase:= alltrim(asmenu1[jeg][5])
            private &newbase[totreg, 4]
            goto top
            locate for nro_rutina = jeg .AND. nro_modulo = 1
            jug:= 1
            do while (nro_rutina = jeg .AND. nro_modulo = 1)
               &newbase[jug][1]:= nro_submen
               if (idioma == 1)
                  &newbase[jug][2]:= nom_submen
                  &newbase[jug][3]:= mensaje
               else
                  &newbase[jug][2]:= ext_submen
                  &newbase[jug][3]:= mensaje2
               endif
               &newbase[jug][4]:= ejecuta
               skip 
               jug:= jug + 1
            enddo
            select 1
         endif
      case nro_modulo = 2 .AND. aestad[2][3]
         asmenu2[jeg][1]:= nro_rutina
         if (idioma == 1)
            asmenu2[jeg][2]:= nom_rutina
            asmenu2[jeg][3]:= mensaje
         else
            asmenu2[jeg][2]:= ext_rutina
            asmenu2[jeg][3]:= mensaje2
         endif
         asmenu2[jeg][4]:= niv_acceso
         asmenu2[jeg][5]:= ejecuta
         asmenu2[jeg][6]:= nro_modulo
         asmenu2[jeg][7]:= ejecutor
         if (Len(alltrim(asmenu2[jeg][2])) > janch2)
            janch2:= Len(alltrim(asmenu2[jeg][2]))
         endif
         if (!asmenu2[jeg][7])
            select 2
            totreg:= 0
            DBEval({|| totreg:= totreg + 1}, {|| nro_rutina = jeg ;
               .AND. nro_modulo = 2}, Nil, Nil, Nil, .F.)
            newbase:= alltrim(asmenu2[jeg][5])
            private &newbase[totreg, 4]
            goto top
            locate for nro_rutina = jeg .AND. nro_modulo = 2
            jug:= 1
            do while (nro_rutina = jeg .AND. nro_modulo = 2)
               &newbase[jug][1]:= nro_submen
               if (idioma == 1)
                  &newbase[jug][2]:= nom_submen
                  &newbase[jug][3]:= mensaje
               else
                  &newbase[jug][2]:= ext_submen
                  &newbase[jug][3]:= mensaje2
               endif
               &newbase[jug][4]:= ejecuta
               skip 
               jug:= jug + 1
            enddo
            select 1
         endif
      case nro_modulo = 3 .AND. aestad[3][3]
         asmenu3[jeg][1]:= nro_rutina
         if (idioma == 1)
            asmenu3[jeg][2]:= nom_rutina
            asmenu3[jeg][3]:= mensaje
         else
            asmenu3[jeg][2]:= ext_rutina
            asmenu3[jeg][3]:= mensaje2
         endif
         asmenu3[jeg][4]:= niv_acceso
         asmenu3[jeg][5]:= ejecuta
         asmenu3[jeg][6]:= nro_modulo
         asmenu3[jeg][7]:= ejecutor
         if (Len(alltrim(asmenu3[jeg][2])) > janch3)
            janch3:= Len(alltrim(asmenu3[jeg][2]))
         endif
         if (!asmenu3[jeg][7])
            select 2
            totreg:= 0
            DBEval({|| totreg:= totreg + 1}, {|| nro_rutina = jeg ;
               .AND. nro_modulo = 3}, Nil, Nil, Nil, .F.)
            newbase:= alltrim(asmenu3[jeg][5])
            private &newbase[totreg, 4]
            goto top
            locate for nro_rutina = jeg .AND. nro_modulo = 3
            jug:= 1
            do while (nro_rutina = jeg .AND. nro_modulo = 3)
               &newbase[jug][1]:= nro_submen
               if (idioma == 1)
                  &newbase[jug][2]:= nom_submen
                  &newbase[jug][3]:= mensaje
               else
                  &newbase[jug][2]:= ext_submen
                  &newbase[jug][3]:= mensaje2
               endif
               &newbase[jug][4]:= ejecuta
               skip 
               jug:= jug + 1
            enddo
            select 1
         endif
      case nro_modulo = 4 .AND. aestad[4][3]
         asmenu4[jeg][1]:= nro_rutina
         if (idioma == 1)
            asmenu4[jeg][2]:= nom_rutina
            asmenu4[jeg][3]:= mensaje
         else
            asmenu4[jeg][2]:= ext_rutina
            asmenu4[jeg][3]:= mensaje2
         endif
         asmenu4[jeg][4]:= niv_acceso
         asmenu4[jeg][5]:= ejecuta
         asmenu4[jeg][6]:= nro_modulo
         asmenu4[jeg][7]:= ejecutor
         if (Len(alltrim(asmenu4[jeg][2])) > janch4)
            janch4:= Len(alltrim(asmenu4[jeg][2]))
         endif
         if (!asmenu4[jeg][7])
            select 2
            totreg:= 0
            DBEval({|| totreg:= totreg + 1}, {|| nro_rutina = jeg ;
               .AND. nro_modulo = 4}, Nil, Nil, Nil, .F.)
            newbase:= alltrim(asmenu4[jeg][5])
            private &newbase[totreg, 4]
            goto top
            locate for nro_rutina = jeg .AND. nro_modulo = 4
            jug:= 1
            do while (nro_rutina = jeg .AND. nro_modulo = 4)
               &newbase[jug][1]:= nro_submen
               if (idioma == 1)
                  &newbase[jug][2]:= nom_submen
                  &newbase[jug][3]:= mensaje
               else
                  &newbase[jug][2]:= ext_submen
                  &newbase[jug][3]:= mensaje2
               endif
               &newbase[jug][4]:= ejecuta
               skip 
               jug:= jug + 1
            enddo
            select 1
         endif
      case nro_modulo = 5 .AND. aestad[5][3]
         asmenu5[jeg][1]:= nro_rutina
         if (idioma == 1)
            asmenu5[jeg][2]:= nom_rutina
            asmenu5[jeg][3]:= mensaje
         else
            asmenu5[jeg][2]:= ext_rutina
            asmenu5[jeg][3]:= mensaje2
         endif
         asmenu5[jeg][4]:= niv_acceso
         asmenu5[jeg][5]:= ejecuta
         asmenu5[jeg][6]:= nro_modulo
         asmenu5[jeg][7]:= ejecutor
         if (Len(alltrim(asmenu5[jeg][2])) > janch5)
            janch5:= Len(alltrim(asmenu5[jeg][2]))
         endif
         if (!asmenu5[jeg][7])
            select 2
            totreg:= 0
            DBEval({|| totreg:= totreg + 1}, {|| nro_rutina = jeg ;
               .AND. nro_modulo = 5}, Nil, Nil, Nil, .F.)
            newbase:= alltrim(asmenu5[jeg][5])
            private &newbase[totreg, 4]
            goto top
            locate for nro_rutina = jeg .AND. nro_modulo = 5
            jug:= 1
            do while (nro_rutina = jeg .AND. nro_modulo = 5)
               &newbase[jug][1]:= nro_submen
               if (idioma == 1)
                  &newbase[jug][2]:= nom_submen
                  &newbase[jug][3]:= mensaje
               else
                  &newbase[jug][2]:= ext_submen
                  &newbase[jug][3]:= mensaje2
               endif
               &newbase[jug][4]:= ejecuta
               skip 
               jug:= jug + 1
            enddo
            select 1
         endif
      case nro_modulo = 6 .AND. aestad[6][3]
         asmenu6[jeg][1]:= nro_rutina
         if (idioma == 1)
            asmenu6[jeg][2]:= nom_rutina
            asmenu6[jeg][3]:= mensaje
         else
            asmenu6[jeg][2]:= ext_rutina
            asmenu6[jeg][3]:= mensaje2
         endif
         asmenu6[jeg][4]:= niv_acceso
         asmenu6[jeg][5]:= ejecuta
         asmenu6[jeg][6]:= nro_modulo
         asmenu6[jeg][7]:= ejecutor
         if (Len(alltrim(asmenu6[jeg][2])) > janch6)
            janch6:= Len(alltrim(asmenu6[jeg][2]))
         endif
         if (!asmenu6[jeg][7])
            select 2
            totreg:= 0
            DBEval({|| totreg:= totreg + 1}, {|| nro_rutina = jeg ;
               .AND. nro_modulo = 6}, Nil, Nil, Nil, .F.)
            newbase:= alltrim(asmenu6[jeg][5])
            private &newbase[totreg, 4]
            goto top
            locate for nro_rutina = jeg .AND. nro_modulo = 6
            jug:= 1
            do while (nro_rutina = jeg .AND. nro_modulo = 6)
               &newbase[jug][1]:= nro_submen
               if (idioma == 1)
                  &newbase[jug][2]:= nom_submen
                  &newbase[jug][3]:= mensaje
               else
                  &newbase[jug][2]:= ext_submen
                  &newbase[jug][3]:= mensaje2
               endif
               &newbase[jug][4]:= ejecuta
               skip 
               jug:= jug + 1
            enddo
            select 1
         endif
      endcase
      jeg:= jeg + 1
      skip 
   enddo
   close databases
   select 1
   numoper:= 0
   nomoper:= "                              "
   if (iusuar)
      set default to (idirec)
      clear screen
      clear gets
      opbassha("BASE001")
      pass:= 0
      y:= 1
      for y:= 1 to 3
         numoper:= 0
         nomoper:= "                              "
         claoper:= "        "
         jjbox(10, 16, 12, 60, "N/W*", 20, 1, .T.)
         set color to R/W*,R/W*
         flogo(11, 17, "R/W*", "N/W*", "B/W*", .F., "N/B*")
         @ 11, 21 say SubStr(afrases[1], 1, 8)
         @ 11, 30 get Nomoper picture "@!" valid ;
            Len(alltrim(nomoper)) > 0
         read
         if (LastKey() == K_ESC)
            close databases
            set color to W/N
            clear screen
            clear gets
            run STAN.EXE
            restore screen from pinicio
            return
         endif
         goto top
         locate for usuario == nomoper
         if (Found())
            numoper:= RecNo()
            jnivop:= niv_acceso
            refclave:= clave
            set color to R/W*
            @ 11, 21 say SubStr(afrases[3], 1, 8)
            set color to W*/W*,W+/W*
            @ 11, 30 get ClaOper valid Len(alltrim(claoper)) > 0
            read
            if (LastKey() == K_ESC)
               close databases
               set color to W/N
               clear screen
               clear gets
               run STAN.EXE
               restore screen from pinicio
               return
            endif
            if (claoper == refclave)
               pass:= 1
               exit
            endif
         endif
      next
      if (pass == 0)
         close databases
         select 1
         restore screen from pinicio
         return
      endif
      close
   endif
   set color to N/B*
   close databases
   clear screen
   clear gets
   @ 23,  0 say Replicate("Ï", 80)
   setcursor(0)
   flogo(22, 67, "R/B*", "N/B*", "B/B*", .F., "N/B*")
   set color to W/B*
   @ 22, 70 say "Pegassus"
   if (iscolor())
      set color to (icolora)
   endif
   set default to (idirec)
   @ 24,  0
   opc:= 1
   jcbox(jtop, jleft, jbott, jright, "N/W*", 20, 1, .T., .T., .F., ;
      "W+/B", ititul)
   qw1:= 1
   qw2:= 1
   qw3:= 1
   qw4:= 1
   qw5:= 1
   qw6:= 1
   do while (opc != 0)
      set message to 24 center
      if (aestad[1][3])
         qw1:= 0
         if (aestad[1][6] < jnivop .AND. inoacc)
            @ jtop + 1, aestad[1][4] prompt " " + Replicate(".", ;
               Len(alltrim(aestad[1][2]))) + " "
         else
            @ jtop + 1, aestad[1][4] prompt " " + ;
               alltrim(aestad[1][2]) + " " message ;
               alltrim(aestad[1][5])
         endif
      else
         if (iscolor())
            set color to W/W*
         endif
         @ jtop + 1, aestad[1][4] say " " + alltrim(aestad[1][2]) + ;
            " "
         if (iscolor())
            set color to (icolora)
         endif
      endif
      if (Len(aestad) > 1)
         if (aestad[2][3])
            qw2:= 0
            if (aestad[2][6] < jnivop .AND. inoacc)
               @ jtop + 1, aestad[2][4] prompt " " + Replicate(".", ;
                  Len(alltrim(aestad[2][2]))) + " "
            else
               @ jtop + 1, aestad[2][4] prompt " " + ;
                  alltrim(aestad[2][2]) + " " message ;
                  alltrim(aestad[2][5])
            endif
         else
            if (iscolor())
               set color to W/W*
            endif
            @ jtop + 1, aestad[2][4] say " " + alltrim(aestad[2][2]) ;
               + " "
            if (iscolor())
               set color to (icolora)
            endif
         endif
      endif
      if (Len(aestad) > 2)
         if (aestad[3][3])
            qw3:= 0
            if (aestad[3][6] < jnivop .AND. inoacc)
               @ jtop + 1, aestad[3][4] prompt " " + Replicate(".", ;
                  Len(alltrim(aestad[3][2]))) + " "
            else
               @ jtop + 1, aestad[3][4] prompt " " + ;
                  alltrim(aestad[3][2]) + " " message ;
                  alltrim(aestad[3][5])
            endif
         else
            if (iscolor())
               set color to W/W*
            endif
            @ jtop + 1, aestad[3][4] say " " + alltrim(aestad[3][2]) ;
               + " "
            if (iscolor())
               set color to (icolora)
            endif
         endif
      endif
      if (Len(aestad) > 3)
         if (aestad[4][3])
            qw4:= 0
            if (aestad[4][6] < jnivop .AND. inoacc)
               @ jtop + 1, aestad[4][4] prompt " " + Replicate(".", ;
                  Len(alltrim(aestad[4][2]))) + " "
            else
               @ jtop + 1, aestad[4][4] prompt " " + ;
                  alltrim(aestad[4][2]) + " " message ;
                  alltrim(aestad[4][5])
            endif
         else
            if (iscolor())
               set color to W/W*
            endif
            @ jtop + 1, aestad[4][4] say " " + alltrim(aestad[4][2]) ;
               + " "
            if (iscolor())
               set color to N/W*
            endif
         endif
      endif
      if (Len(aestad) > 4)
         if (aestad[5][3])
            qw5:= 0
            if (aestad[5][6] < jnivop .AND. inoacc)
               @ jtop + 1, aestad[5][4] prompt " " + Replicate(".", ;
                  Len(alltrim(aestad[5][2]))) + " "
            else
               @ jtop + 1, aestad[5][4] prompt " " + ;
                  alltrim(aestad[5][2]) + " " message ;
                  alltrim(aestad[5][5])
            endif
         else
            if (iscolor())
               set color to W/W*
            endif
            @ jtop + 1, aestad[5][4] say " " + alltrim(aestad[5][2]) ;
               + " "
            if (iscolor())
               set color to N/W*
            endif
         endif
      endif
      if (Len(aestad) > 5)
         if (aestad[6][3])
            qw6:= 0
            if (aestad[6][6] < jnivop .AND. inoacc)
               @ jtop + 1, aestad[6][4] prompt " " + Replicate(".", ;
                  Len(alltrim(aestad[6][2]))) + " "
            else
               @ jtop + 1, aestad[6][4] prompt " " + ;
                  alltrim(aestad[6][2]) + " " message ;
                  alltrim(aestad[6][5])
            endif
         else
            if (iscolor())
               set color to W/W*
            endif
            @ jtop + 1, aestad[6][4] say " " + alltrim(aestad[6][2]) ;
               + " "
            if (iscolor())
               set color to N/W*
            endif
         endif
      endif
      @ 24,  0
      set wrap on
      menu to opc
      do case
      case opc = 1
         save screen to popc
         oldcolo:= SetColor()
         qopc:= 1
         cuan:= Len(asmenu1)
         if (cuan > 0 .AND. aestad[qopc][6] >= jnivop)
            submen()
         endif
         t_ho_off()
         set color to (oldcolo)
         restore screen from popc
      case opc = 2
         save screen to popc
         oldcolo:= SetColor()
         qopc:= 2
         cuan:= Len(asmenu2)
         if (cuan > 0 .AND. aestad[qopc][6] >= jnivop)
            submen()
         endif
         t_ho_off()
         set color to (oldcolo)
         restore screen from popc
      case opc = 3
         save screen to popc
         oldcolo:= SetColor()
         do case
         case qw1 + qw2 + qw3 = 0
            qopc:= 3
            cuan:= Len(asmenu3)
         case qw1 + qw2 + qw3 + qw4 + qw5 = 3
            qopc:= 6
            cuan:= Len(asmenu6)
         case qw1 + qw2 + qw3 + qw4 = 2
            qopc:= 5
            cuan:= Len(asmenu5)
         case qw1 + qw2 + qw3 + qw4 = 1
            qopc:= 4
            cuan:= Len(asmenu4)
         endcase
         if (cuan > 0 .AND. aestad[qopc][6] >= jnivop)
            submen()
         endif
         t_ho_off()
         set color to (oldcolo)
         restore screen from popc
      case opc = 4
         save screen to popc
         oldcolo:= SetColor()
         if (qw1 + qw2 + qw3 + qw4 = 0)
            qopc:= 4
            cuan:= Len(asmenu4)
         elseif (qw1 + qw2 + qw3 + qw4 + qw5 = 2)
            qopc:= 6
            cuan:= Len(asmenu6)
         elseif (qw1 + qw2 + qw3 + qw4 = 1)
            qopc:= 5
            cuan:= Len(asmenu5)
         endif
         if (cuan > 0 .AND. aestad[qopc][6] >= jnivop)
            submen()
         endif
         t_ho_off()
         set color to (oldcolo)
         restore screen from popc
      case opc = 5
         save screen to popc
         oldcolo:= SetColor()
         if (qw1 + qw2 + qw3 + qw4 + qw5 = 0)
            qopc:= 5
            cuan:= Len(asmenu5)
         elseif (qw1 + qw2 + qw3 + qw4 + qw5 = 1)
            qopc:= 6
            cuan:= Len(asmenu6)
         endif
         if (cuan > 0 .AND. aestad[qopc][6] >= jnivop)
            submen()
         endif
         t_ho_off()
         set color to (oldcolo)
         restore screen from popc
      case opc = 6
         save screen to popc
         oldcolo:= SetColor()
         qopc:= 6
         cuan:= Len(asmenu6)
         if (cuan > 0 .AND. aestad[qopc][6] >= jnivop)
            submen()
         endif
         t_ho_off()
         set color to (oldcolo)
         restore screen from popc
      endcase
   enddo
   set color to W/N
   clear screen
   clear gets
   run STAN.EXE
   restore screen from pinicio
   return

********************************
procedure SUBMEN

   ci1:= 4
   ci2:= 12
   ci3:= 19
   ci4:= 27
   ci5:= 36
   ci6:= 39
   do case
   case qopc = 1
      cix:= ci1
   case qopc = 2
      cix:= ci2
   case qopc = 3
      cix:= ci3
   case qopc = 4
      cix:= ci4
   case qopc = 5
      cix:= ci5
   case qopc = 6
      cix:= ci6
   endcase
   janch:= "janch" + Str(qopc, 1)
   janch:= &janch
   t_ho_on()
   jjbox(jtop + 2, cix, jtop + 3 + cuan, cix + janch + 3, "N/W*", ;
      20, 1, .T., .T., .T.)
   opcj1:= 1
   do while (opcj1 != 0)
      set message to 24 center
      i:= 1
      for i:= 1 to 10
         arra1:= "ASMENU" + Str(qopc, 1) + "[" + alltrim(Str(i, 1)) ;
            + ",1]"
         arra2:= "ASMENU" + Str(qopc, 1) + "[" + alltrim(Str(i, 1)) ;
            + ",2]"
         arra3:= "ASMENU" + Str(qopc, 1) + "[" + alltrim(Str(i, 1)) ;
            + ",3]"
         arra4:= "ASMENU" + Str(qopc, 1) + "[" + alltrim(Str(i, 1)) ;
            + ",4]"
         arra5:= "ASMENU" + Str(qopc, 1) + "[" + alltrim(Str(i, 1)) ;
            + ",5]"
         arra7:= "ASMENU" + Str(qopc, 1) + "[" + alltrim(Str(i, 1)) ;
            + ",7]"
         janch:= "janch" + Str(qopc, 1)
         janch:= &janch
         if (&arra4 < jnivop .AND. inoacc)
            @ jtop + 2 + i, cix + 1 prompt " " + Replicate(".", ;
               janch) + " "
         else
            @ jtop + 2 + i, cix + 1 prompt " " + SubStr(&arra2, 1, ;
               janch) + " " message alltrim(&arra3)
         endif
         if (i = cuan)
            exit
         endif
      next
      @ 24,  0
      set wrap on
      menu to opcj1
      do case
      case opcj1 = 1
         refsmen1()
      case opcj1 = 2
         refsmen1()
      case opcj1 = 3
         refsmen1()
      case opcj1 = 4
         refsmen1()
      case opcj1 = 5
         refsmen1()
      case opcj1 = 6
         refsmen1()
      case opcj1 = 7
         refsmen1()
      case opcj1 = 8
         refsmen1()
      case opcj1 = 9
         refsmen1()
      case opcj1 = 10
         refsmen1()
      endcase
   enddo
   SetKey(K_RIGHT, Nil)
   SetKey(K_LEFT, Nil)
   return

********************************
procedure T_HO_ON

   set key K_RIGHT to pupod
   set key K_LEFT to pupoi
   return

********************************
procedure T_HO_OFF

   SetKey(K_RIGHT, Nil)
   SetKey(K_LEFT, Nil)

********************************
procedure PUPOD

   keyboard Chr(27) + Chr(4) + Chr(13)
   return

********************************
procedure PUPOI

   keyboard Chr(27) + Chr(19) + Chr(13)
   return

********************************
procedure REFSMEN1

   save screen to popcj1
   oldcol:= SetColor()
   t_ho_off()
   sarra1:= "ASMENU" + Str(qopc, 1) + "[" + alltrim(Str(opcj1, 1)) + ;
      ",1]"
   sarra2:= "ASMENU" + Str(qopc, 1) + "[" + alltrim(Str(opcj1, 1)) + ;
      ",2]"
   sarra3:= "ASMENU" + Str(qopc, 1) + "[" + alltrim(Str(opcj1, 1)) + ;
      ",3]"
   sarra4:= "ASMENU" + Str(qopc, 1) + "[" + alltrim(Str(opcj1, 1)) + ;
      ",4]"
   sarra5:= "ASMENU" + Str(qopc, 1) + "[" + alltrim(Str(opcj1, 1)) + ;
      ",5]"
   sarra7:= "ASMENU" + Str(qopc, 1) + "[" + alltrim(Str(opcj1, 1)) + ;
      ",7]"
   if (&sarra4 >= jnivop)
      if (&sarra7)
         opcj3:= opcj1
         bas:= "ASMENU" + Str(qopc, 1)
         ejec:= &sarra5
         &ejec()
      else
         submen1()
      endif
   endif
   t_ho_on()
   set color to (oldcol)
   restore screen from popcj1
   close databases
   select 1
   set default to (idirec)
   return

********************************
procedure SUBMEN1

   bas:= alltrim(&sarra5)
   cuan3:= Len(&bas)
   kl:= 1
   juanch3:= 1
   do while (kl <= Len(&bas))
      if (Len(alltrim(&bas[kl][2])) > juanch3)
         juanch3:= Len(alltrim(&bas[kl][2]))
      endif
      kl:= kl + 1
   enddo
   arrib:= jtop + 3 + opcj1
   izqui:= cix + Len(alltrim(&sarra2)) - 5
   if (izqui > 50)
      izqui:= izqui - Len(alltrim(&sarra2))
   endif
   abajo:= arrib + 1 + cuan3
   derec:= izqui + 3 + juanch3
   jjbox(arrib, izqui, abajo, derec, "N/W*", 20, 1, .T., .T., .T.)
   opcj3:= 1
   do while (opcj3 != 0)
      set message to 24 center
      ik:= 1
      for ik:= 1 to cuan3
         @ arrib + ik, izqui + 1 prompt " " + SubStr(&bas[ik][2], 1, ;
            juanch3) + " " message alltrim(&bas[ik][3])
      next
      @ 24,  0
      set wrap on
      menu to opcj3
      do case
      case opcj3 = 1
         refsmen2()
      case opcj3 = 2
         refsmen2()
      case opcj3 = 3
         refsmen2()
      case opcj3 = 4
         refsmen2()
      case opcj3 = 5
         refsmen2()
      case opcj3 = 6
         refsmen2()
      case opcj3 = 7
         refsmen2()
      case opcj3 = 8
         refsmen2()
      case opcj3 = 9
         refsmen2()
      case opcj3 = 10
         refsmen2()
      endcase
   enddo
   return

********************************
procedure REFSMEN2

   save screen to popcj2
   oldcol:= SetColor()
   ejec3:= &bas[opcj3][4]
   &ejec3()
   set color to (oldcol)
   restore screen from popcj2
   close databases
   select 1
   set default to (idirec)
   return

* EOF
