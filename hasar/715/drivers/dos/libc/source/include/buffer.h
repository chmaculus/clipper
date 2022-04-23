typedef struct
{
	void *Buffer;
	void *Head;
	void *Tail;
	unsigned int Count;
	unsigned int Size;
} CIRCULAR_BUFFER;

unsigned int PutInBuffer (CIRCULAR_BUFFER far *Buffer, void *Data, unsigned int SizeOfData);
unsigned int GetOfBuffer (CIRCULAR_BUFFER far *Buffer, void *Data, unsigned int SizeOfData);
CIRCULAR_BUFFER *CreateBuffer (unsigned int Size);
void DestroyBuffer (CIRCULAR_BUFFER **Buffer);





