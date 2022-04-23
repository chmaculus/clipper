#ifndef _ACERTO_DEFINED

#ifndef NDEBUG

#command ACERTO( <exp> [, <msg>] )                                      ;
                                                                        ;
      => IF ( !(<exp>) )                                                ;
       ;   OUTSTD(                                                      ;
                   CHR(13) + CHR(10) +                                  ;
                   "Esa no es la tecla pedida" +                        ;
                   CHR(13) + CHR(10)                                    ;
                 )                                                      ;
       ;   QUIT                                                         ;
       ; ENDIF

#else  // If NDEBUG is definded, ignore all occurences of ACERTO()

#command ACERTO( <exp> [, <msg>] )      =>

#endif // NDEBUG

#define _ACERTO_DEFINED

#endif // _ACERTO_DEFINED
