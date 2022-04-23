.AUTODEPEND

INCLUDE = ../include
CC = bcc -v -mc -DDOS -I$(INCLUDE) 
TASM = tasm
CFLAGS = -c -r- -w-rvl -v-
AFLAGS =
ASFLAGS = /zi /mx

all: rtcom.lib

.c.obj:
	$(CC) -c {$< }

rtcom.lib : rtcom.obj buffer.obj
	tlib rtcom.lib +-rtcom.obj +-buffer.obj

