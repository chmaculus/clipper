#include <stdio.h>
#include <stdarg.h>
#include <conio.h>
#include <time.h>
#include <string.h>
#include <io.h>
#include <fcntl.h>
#include <stdlib.h>

#include "fisdebug.h"

#if defined (DEBUG) || !defined (DOS) 
static char *FileLog;
static char BufLog [500];
#endif

void WINFISdebug (int Nivel, char *buffer);

void
FISdebug (int Nivel, char *fmt, ...)
{
	va_list argptr;

#ifdef DOS 

	#ifndef DEBUG 
		return;

    #else

    	int Level = 3;
    	char *LevelVar;
    	
    	if ( (LevelVar = getenv("DEBUGLEVEL")) != NULL )
    		Level = atoi(LevelVar);

    	if (Nivel > Level)
    		return;

        va_start(argptr, fmt);
        vsprintf (BufLog, fmt, argptr);

        cputs (BufLog);
        putch ('\n');
        putch ('\r');

        va_end (argptr);

    #endif

#else

    if ( (FileLog = getenv("FILELOG")) == NULL ) 
		return;

	va_start(argptr, fmt);
    vsprintf (BufLog, fmt, argptr);
   WINFISdebug (Nivel, BufLog);

	va_end (argptr);

#endif

}

#ifndef DOS

int
debopen (char *file)
{
	int fd;
	char FileBackUp[100];

	if (!file)
		return -1;

	if ((fd = open (file, O_WRONLY | O_CREAT | O_APPEND, 0666)) < 0)
		return fd;

	/* --- Obtiene informacion acerca del archivo --- */

	if ( lseek(fd, 0L, 2) >= 500000L )
	{
		close (fd);

		strcpy (FileBackUp, file);
		FileBackUp[strlen(file)-2] = '_';

		unlink (FileBackUp);		
		rename (file, FileBackUp);

		/* --- Lo abre nuevamente --- */
		fd = open(file, O_CREAT | O_TRUNC | O_APPEND | O_WRONLY, 0666) ;
	}

	return fd;
}

void
DoDebug (char *msg)
{
	static char buf [500];
	time_t ct;
	struct tm *ptm;
	int fd;

	if ((fd = debopen (FileLog)) < 0 )
		return;

	time (&ct);
	ptm = localtime(&ct);
	sprintf(buf,"%02d/%02d-%02d:%02d:%02d: %s\n",
			ptm->tm_mday,
			ptm->tm_mon+1,
			ptm->tm_hour,
			ptm->tm_min,
			ptm->tm_sec,
			msg);

	write (fd, buf, strlen (buf));

	close (fd);
}

void
WINFISdebug (int Nivel, char *buffer)
{
	int Level = 3;
	char *LevelVar;
	
	if ( (LevelVar = getenv("DEBUGLEVEL")) != NULL )
		Level = atoi(LevelVar);

	if (Nivel > Level)
		return;

	DoDebug (buffer);
}

#endif

