/*
	fisdebug.h
*/

#ifdef NODEBUG
#define FISdebug
#else
void FISdebug (int Level, char *fmt, ...);
#endif

