#ifdef DEBUG
#include <stdio.h>
#include <stdarg.h>
#include <stdlib.h>
#include <string.h>	
#include "fiscal.h"

#ifdef __CLIPPER
#include "extend.h"
#endif

#include "fisdebug.h"
#include "rtcomplr.h"

#define MAXBUF 250
static char buf[MAXBUF];

char *
mystrlwr (char *s)
{
	char *p = s;
	
	while (*s)
	{
		if ( *s >= 'A' && *s <= 'Z' )
			*s = 'a' + ( *s - 'A' );
		s++;
	}
	
	return p;
}

/*
 * Arma un puntero huge tomando como parametros el segmento y
 * el offset. Identico que MK_FP en borland.
 *
 */

void huge *
MakeFp (unsigned seg, unsigned off)
{
	unsigned long d = (((unsigned long)seg) << 16) + (unsigned long)off;
	return (void huge *)d;
}

/*
 * Retorna el contenido de una variable de ambiente.
 * Si no la encuentra retorna NULL.
 *
 * Compilar en modelo LARGE dado que sino hay que usar las funciones
 * far de strlen, strlwr, sprintf ... 
 *
 */

char *
MyGetenv (char *Str)
{
    char *Entorno;
	unsigned int huge *q;
	unsigned my_bx;
	int len, i;
    
	_asm mov ah, 62h
	_asm int 21h
	_asm mov my_bx, bx

    /*
     * En bx se encuentra la direccion del psp. En psp:0x2c se
     * encuentra la direccion del buffer en donde estan las variables
     * del entorno.
     *
     */

	q = MakeFp (my_bx, 0x2c);
	Entorno = MakeFp (*q, 0);

	/*
	 * El puntero Entorno apunta a un buffer en donde se encuentra
	 * el ambiente. Cada linea del entorno termina con un NULL.
	 * El buffer termina con doble NULL.
	 *
	 */

    for ( i = 0; (i < MAXBUF - 2) && *Str; i ++, Str++ )
        buf[i] = *Str;

    buf[i++] = '=';
    buf[i]   = 0;
	
	len = strlen (buf);
	mystrlwr (buf);
	
	while ( *Entorno )
	{
		if ( !strncmp (mystrlwr(Entorno), buf, len) )
			return Entorno + len;
		Entorno += strlen(Entorno) + 1;
	}

	return NULL;
}

int 
mystrlen (char *s)
{
	int i = 0;

	while (*s++)
		++i;
	return i;
}

char *
copy(char *dst, char *src, int maxbytes)
{
	while ( --maxbytes && ((*dst++ = *src++) != 0) )
		;
	*dst = 0;

	return dst;
}

void
mostrar (char *m)
{
	strcat (m, "\r\n$");
	ASM mov ah, 9
	ASM push ds
	ASM lds dx, m
	ASM int 21h
	ASM pop ds
}

void
FISdebug (int Nivel, char *fmt, ...)
{
    int Level = 3;
    char *LevelVar;
	va_list argptr;
	int c, Indice, n;
	char buftmp[50];
	
    // if ( (LevelVar = getenv("DEBUGLEVEL")) == NULL )
    if ( (LevelVar = MyGetenv("DEBUGLEVEL")) == NULL )
		return;
   	Level = atoi(LevelVar);

    if (Nivel > Level)
    	return;

	va_start (argptr, fmt);

	memset (buf, 0, sizeof (buf));

	for ( Indice = 0; Indice < MAXBUF - 1 ; )
	{
		if ( (c = *fmt++) == 0) 
			break;

		if ( c == '%' )
		{
			if ( (c = *fmt++) == 0 )	
				break;	// Fin del string.

			switch ( c )	// Leo el siguiente caracter
			{
				case 's':
					copy (buftmp, va_arg (argptr, char *), sizeof (buftmp));
					n = mystrlen (buftmp);
					if ( Indice + n >= MAXBUF )
						n = MAXBUF - Indice - 1;
					strncat (buf, buftmp, n);
					Indice += n;
					break;
				case 'd':
					itoa (va_arg (argptr, int), buftmp, 10);
					n = mystrlen (buftmp);
					if ( Indice + n >= MAXBUF )
						n = MAXBUF - Indice - 1;
					strncat (buf, buftmp, n);
					Indice += n;
					break;
				default:
					buf[Indice++] = c;
					break;
			}
		}

		else buf[Indice++] = c;
	}
	
	if ( Indice >= MAXBUF - 4 )
		buf [MAXBUF - 4] = 0;

	mostrar (buf);

	va_end (argptr);

	return;
}
#endif

