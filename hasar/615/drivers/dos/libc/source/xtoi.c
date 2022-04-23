#include <ctype.h>


/* Convierte un numero hexa ascii de 4 bytes en su equivalente entero */
int
xtoi(char *num)
{
	int n,i;
	
	for (i=0,n=0 ; i < 4 ; i++,num++)
	{
		n <<= 4;
		n |= (isdigit(*num) ? *num - '0' : toupper(*num)-'A'+ 0xa);
	}
	return n;
}
