/*
comm.h
*/

int  start_comm     (int Port);

#ifdef WIN32
int GetComHandle(int n);
#endif

void end_comm       (int PortNumber);
int  GetByte        (int PortNumber, int *Byte);
int  GetByteTimed   (int PortNumber);
int  send_packet    (int PortNumber, char *data);
int  SendByte       (int PortNumber, int Byte);
int  SendCommand    (int PortNumber, char *Com);
int  BufferEmpty 	(int PortNumber);
void SetPortIOBase	(int PortNumber, unsigned int IOBase);
void SetIRQNumber	(int PortNumber, int IRQNumber);
int  SetBaudRate    (int PortNumber, long Baudios);

#ifdef __CLIPPER 
int SpaceUsedInBuffer (int PortNumber);
#endif 
