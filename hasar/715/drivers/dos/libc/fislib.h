typedef void (*PFV)(int Reason, int Port);

int MandaPaqueteFiscal (int PortDescriptor, char *Command, 
					unsigned short *FiscalStatus, 
					unsigned short *PrinterStatus,
					char *AnswerBuffer);

int  OpenCommFiscal 		 (int PortNumber);
int  CloseCommFiscal 		 (int PortDescriptor);
int  SetKeepAliveHandler	 (PFV Handler);

// Funciones Nuevas.
int  SetBaudios 			 (int PortNumber, long Baudios);
int  SetCommandRetries 		 (int Retries);
int  SetNewProtocol      	 (int Value);
void ObtenerNumeroDePaquetes (int *Enviado, int *Recibido, int *CmdRecibido);

int  ObtenerStatusImpresor (int PortNumber, unsigned short *FiscalStatus, 
	unsigned short *PrinterStatus, 	char *AnswerBuffer);

int  SearchPrn 					(int PortDesc, long *Baud);
