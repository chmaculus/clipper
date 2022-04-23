; Driver Fiscal de enlace para MicoFocus Cobol 3.00 o + (DOS)
; Intercambio de parametros directo desde WORKING.
; (C) Daniel Ales 12/11/2000 ver 1.00 revision 4.1 OK (11/12/2000)
; Driver para TSRFISC.EXE o LPTFIS
;      
;       Desarrollado por:
;                                Carlos Daniel Al‚s
;                                Juan Carlos Al‚s
;                                  Alberdi 430
;                                  (B 7000 ACJ) TANDIL
;                                  Pcia. de Buenos Aires
;                                  TE (02293) 425748
;                                  mailto <jcales@infovia.com.ar>
;
.model huge, c
.286

.data
buffer  db      512d dup(00)
cont    equ     512d
cr      EQU     0Dh                     
lf      EQU     0Ah                     
eom     EQU     '$'                    
fis_int EQU     17H              ; 17h para LPTFIS.EXE 
                                 ; 60h para TSRFIS.EXE
ori_si  dw      ?
ori_es  dw      ?

.code
FISDRV PROC C                    ; Procedimiento (void) igual al C
inicia:
 int 03h                         ; Break point para debugger
 jmp inspector                   ; llama al inspector
r_inspector:
 mov ori_si,si
 mov dx,0001h                    ;\
 mov ah,01h                      ; > Init printer
 int fis_int                     ;/ 
 jmp manda_paq  

manda_paq:
 xor cx,cx                       ; contador en cero
 mov cx,cont                     ; ------> cantidad de bytes a enviar
c_mand_paq:
 mov dx,0001h                    ; Comando de putcmd
 xor ax,ax                       ; ax en cero
 mov al,es:[si]                  ; es:[si] = byte a enviar
 int fis_int                     ; interrupcion de impresora
 cmp al,0dh                      ; if al = 0D go to salir_paq
 je salir_paq
 cmp al,0ah                      ; if al = 0A go to salir_paq
 je salir_paq
 inc si                          ; pasa al siguiente byte
 loop c_mand_paq                 ; cicla hasta cl = 0
salir_paq:
 jmp resp_fis
resp_fis: 
 mov bx,offset buffer 
 mov dx,es                       ;\
 mov ah,05h                      ; > Get answer
 int fis_int                     ;/ 
 mov ori_es,es
 mov si,ori_si
 mov di,si
 mov es,bx                       ;posiciones originales bx:dx 
 mov si,dx                       ;
 xor bx,bx
 mov es,bx
c_resp_fis:
 xor ax,ax                       ; ax en cero
 mov al,es:[si]                  ; es:[si] = byte de respuesta
 mov es,ori_es                   ; reestablece ES original   
 mov es:[di],al                  ; mueve byte a COBOL 
 mov es,bx
 inc si                          ; incrementa contador origen
 inc di                          ; incrementa contador destino
 cmp al,00h
 je sale_resp
 cmp al,0dh
 je sale_resp
 cmp al,0ah
 je sale_resp
 loop c_resp_fis                 ; 
sale_resp:
 mov es,ori_es                   ; original ES
 mov si,ori_si                   ; original SI
 ret                             ; return del call

inspector:
 push si
 mov cx,200h
a_inspector:
 mov al,es:[si]                  ; es:[si] = byte a examinar
 cmp al,00h
 je a_cambia
 cmp al,0dh
 je f_inspector
 cmp al,0ah
 je f_inspector
b_inspector:
 inc si 
 loop a_inspector 
a_cambia:
 mov al,20h
 mov es:[si],al
 jmp b_inspector
f_inspector:
 pop si
 jmp r_inspector
FISDRV ENDP
end 
