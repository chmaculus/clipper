use prueba
go top
c=reccount()
d=descripcio
e=codart
do while .t.
    b=recno()
    if b=c
        exit
    endif
    a=descripcio
    if a="CRE"
        replace descripcio with d
        replace codart with e
    endif
    e=codart
    d=descripcio
    skip
    loop
enddo
