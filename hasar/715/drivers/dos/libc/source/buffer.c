/*
	Implementaci¢n de buffer circular.

	Tiene dos modos: alocando buffers din micamente con malloc() o
	con buffers est ticos. Si no se quiere la versi¢n con malloc() hay
	que #definir DRIVER. De otra forma, hay que customizar la constante
	STATIC_BUFFER_SIZE para el uso que se le va a dar.

	Autor: Leandro Fanzone.				20/6/97
*/

#include <stdlib.h>
#include "rtcomplr.h"
#include "buffer.h"

#define HEAD ((char *) Buffer->Head)
#define EDGE ((char *) Buffer->Buffer + Buffer->Size)
#define TAIL ((char *) Buffer->Tail)
#define BASE Buffer->Buffer

#ifdef NO_MALLOC_IN_BUFFER
	#define malloc mymalloc
	#define free myfree
	#define STATIC_BUFFER_SIZE 3000
	static char StaticBuffer[STATIC_BUFFER_SIZE];
	static char *NextFreeBufferPos = StaticBuffer;

	void *malloc (unsigned Size)
	{
		if (NextFreeBufferPos - StaticBuffer + Size >= STATIC_BUFFER_SIZE)
			return NULL;
		return NextFreeBufferPos += Size;
	}

	#pragma argsused
	void free (void *p)	{}

#endif

/*
	Crea un buffer circular de tama¤o Size 
*/

CIRCULAR_BUFFER *
CreateBuffer (unsigned int Size)
{
	CIRCULAR_BUFFER *New;
	void *Buffer;

	if (!(New = (CIRCULAR_BUFFER *) malloc(sizeof(CIRCULAR_BUFFER))))
		return NULL;

	if (!(Buffer = malloc(Size)))
	{
		free (New);
		return NULL;
	}

	New->Count = 0;
	New->Size = Size;
	New->Head = New->Tail = New->Buffer = Buffer;

	return New;
}

/*
	Destruye un buffer creado con CreateBuffer()
*/

void
DestroyBuffer (CIRCULAR_BUFFER **Buffer)
{
	free ((*Buffer)->Buffer);
	free (*Buffer);
}


/*
	Pone en el buffer n cantidad de bytes. Si excede el tama¤o 
	del buffer, pone todo lo que entre. Devuelve la cantidad
	de bytes escritos.
*/

unsigned int
PutInBuffer (CIRCULAR_BUFFER far *Buffer, void *Data, unsigned int SizeOfData)
{
	int Count = 0;

	if (Buffer->Count == Buffer->Size)
		return 0;
	ASM cli
	do 	
	{
		if (Count == SizeOfData)
			break;
		*TAIL++ = *((char *)Data)++;
		if (TAIL == EDGE)
			TAIL = BASE;
		Count++;
		Buffer->Count++;
	} while ( TAIL != HEAD );
	ASM sti
	return Count;
}

/*
	Saca del buffer n bytes. Si es m s de lo que hay en el buffer,
	saca todo lo que hay. Devuelve la cantidad de bytes le¡dos.
*/

unsigned int
GetOfBuffer (CIRCULAR_BUFFER far *Buffer, void *Data, unsigned int SizeOfData)
{
	int Count = 0;

	ASM cli
	while ( HEAD != TAIL || Buffer->Count == Buffer->Size)
	{
		if (Count == SizeOfData)
			break;
		* ((char *)Data)++ = *HEAD++;
		if (HEAD == EDGE)
			HEAD = BASE;
		Count++;
		Buffer->Count--;
	}
	ASM sti
	return Count;
}


