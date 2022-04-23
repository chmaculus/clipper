if PF_PuertoInit( 1,"3F8", 4)
*if PF_PuertoInit( 2,"2F8", 3)

   do PF_IniciarSalida
   Continuar = PF_AgregaCampoSalida("X")
   Continuar = PF_AgregaCampoSalida("P")
   if Continuar
      if PF_EnviarComando( PF_CierreX )
         Continuar = .T.
      else
         Continuar = .F.
         ? PF_MensajeEstado( PF_ModuloImpresor )
         ? PF_MensajeEstado( PF_ModuloFiscal )
      endif
   endif
   if Continuar
      i=1
      do while PF_DatoRecibido[i] <> NIL .and. i <= 25
         ? PF_DatoRecibido[i]
         i = i + 1
      enddo
   endif

   Continuar =.T.

   if Continuar
      do PF_IniciarSalida
      Nada = PF_AgregaCampoSalida("Z")
      Nada = PF_AgregaCampoSalida("P")
      if PF_EnviarComando( PF_CierreZ )
         Continuar = .T.
         ? "Cierre de D¡a"
      else
         Continuar = .F.
         ? PF_MensajeEstado( PF_ModuloImpresor )
         ? PF_MensajeEstado( PF_ModuloFiscal )
         * La aplicaci¢n aca debe analizar por que se produjo el error del comando
      endif
   endif
endif
RETURN
