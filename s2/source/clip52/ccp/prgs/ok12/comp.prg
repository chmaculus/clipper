#INCLUDE "PFISCAL.CH"
? "Cierre de factura"
   * Armado y env¡o del comando de Cierre de Tique
      do PF_IniciarSalida
      nada = PF_AgregaCampoSalida( "F" )
      nada = PF_AgregaCampoSalida( "A" )
      nada = PF_AgregaCampoSalida("FINAL")
      * El comando PF_AgregaCampoSalida da error si se sobrepasan los 20 elementos
      if PF_EnviarComando( PF_FCCerrar )
         Continuar = .T.
         ? "Factura cerrada "+ str( val(PF_DatoRecibido[3]) )
      else
         Continuar = .F.
         ? PF_MensajeEstado( PF_ModuloImpresor )
         ? PF_MensajeEstado( PF_ModuloFiscal )
         * La aplicaci¢n aca debe analizar por que se produjo el error del comando
         * y tomar la decisi¢n si cancela el comprobante, o avisa que no hay papel
         * o el importe del comprobante es cero
      endif
