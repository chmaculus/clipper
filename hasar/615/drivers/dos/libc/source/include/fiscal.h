/********************/
/*    Includes      */
/********************/

#include "fiserr.h"			 // M¢dulo de Errores retornados por la librer¡a ...


/*********************/
/* Estructura de     */
/* respuesta fiscal  */
/*********************/

struct resp_fiscal 
{
	char Stx;
	unsigned char Paquete;
	char Comando;                                              /* Commando */
	char field_sep;                                                /* 0x1c */
	char printer_status[4];             /* Status de printer.En hexa ascii */
	char field_sep1;                                               /* 0x1c */
	char fiscal_status[4];                  /* Status fiscal.En hexa ascii */
	char operandos;                         /* Operandos adicionales.
								Depende del codigo de operacion*/
};

// Estrucura utilizada para el protocolo nuevo, en donde 
// se envia un ESC antes del codigo de operacion del comando

struct resp_fiscal_new
{
	char Stx;
	unsigned char Paquete;
	char Escape;
	char Comando;                                              /* Commando */
	char field_sep;                                                /* 0x1c */
	char printer_status[4];             /* Status de printer.En hexa ascii */
	char field_sep1;                                               /* 0x1c */
	char fiscal_status[4];                  /* Status fiscal.En hexa ascii */
	char operandos;                         /* Operandos adicionales.
								Depende del codigo de operacion*/
};

/*********************/
/*    Prototipos     */
/*********************/

int  xtoi(char *num);
void ArmaPaqueteFiscal(int PortNumber, char far *command);
int  GetAnswer (int PortNumber, char *Buffer, int Max);
int  GetAck (int PortNumber);


/********************/
/*    Defines       */
/********************/

#define MX_FISCAL 			500
#define TRUE 				1
#define FALSE 				0
#define START_PACKET 		0x20
#define END_PACKET 			0x7f
#define DELAY_BEFORE_ACK 	1
#define TIMEOUT 			-2
#define DELTA_TOUT 			4
#define MAX_TRASH 			500 /* Caracteres de basura en comunicaciones */

#define INI_EPROM 			0xb0
#define SET_DATE  			0x58
#define GET_DATE  			0x59

#define ACK_RETRY       	3
#define ANS_RETRY       	3

#define TIMEOUT_FISCAL  	40      // 40 Ticks de Timeout ( 2 seg ).
#define TIMEOUT_FISCAL_MS	2000	// 2 segundos (2000 ms)

// Comando usado para encuestar al printer en caso 
// de estar esperando una respuesta y el mismo estar 
// en estado de error.

#define CMD_STATPRN		   0xa1


typedef struct
{
	char			Buffer_Fiscal [MX_FISCAL];
	char 		Buffer_Recepcion [MX_FISCAL];
	unsigned char	PacketNumber;
#ifdef DOS
	int				Port;
#else
	PORT			*Port;
	int				Mode;
#ifdef WIN32
	HANDLE			Mutex;
	unsigned long	PID;
#else
	int				Atomic;
#endif
#endif
#ifdef WIN32
	int AbortInProgress;
#endif
} PUERTO_FISCAL;

#define MAX_FISCAL_PORTS 4

#ifdef C_LIB
typedef void (*PFV)(int Reason, int Port);
#endif

