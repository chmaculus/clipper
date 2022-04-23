(*
	Interface with the TSR. 
	The TSR must be loaded before the program, with the following parameters:
	
	TSRFisc -sn

	where 'n' is the serial port number.
	If necessary, there are two additional parameters (-b and -q) that
	set I/O base address and IRQ of the serial port, respectively.
	After the program's termination, the TSR may be uninstalled with 
	the -d option, or via this unit with the UninstallDriver function, 
	perhaps using ExitProc().

	Author: Leandro Fanzone - HASAR SAIC - 25/8/98
*)

unit HASAR;

{$X+}

interface

Function SendPacket(const Command: String; Var Answer: String): Boolean;
Function CheckDriver: Boolean;
Function UninstallDriver: Boolean;

Implementation

Uses Dos, Strings;

Const
	DRIVER_PRINT_BYTE	= $0;
	DRIVER_INIT_PRINTER	= $1;
	DRIVER_STATUS		= $2;
	DRIVER_UNINSTALL	= $3;
	DRIVER_GETANSWER	= $5;

	TSR_SEND_OK			= $10;

Var
	Initialized : Boolean;
	IntNumber	: Integer;


(*
	Checks if the driver is loaded, and if there is a printer 
	out there. Returns True if so, and False if not.
*)

Function CheckDriver: Boolean;
Var
	Regs    		: Registers;
	Segment 		: Integer;
	Offset			: Integer;
	Found			: Boolean;
    Signature		: PChar;
    Len				: Integer;
	VectorOffset	: Integer;

Begin

	(*	Checks if driver is present. *)

	Signature := 'HASAR';
	Len := StrLen(Signature);
	Found := False;
		
	(* 
		Seeks through possible interrupts where
		the TSR is installed.
		Just before the main entry point is
		a signature ('HASAR').
	*)

	for IntNumber := $60 to $70 do
	Begin

		(*
			Gets one by one the address of
			the each interrupt handler.
		*)

		VectorOffset := IntNumber * 4;
		Offset	:= MemW [0:VectorOffset];
		Segment	:= MemW [0:VectorOffset + 2];
		if (StrLComp(Ptr(Segment, Offset-Len), Signature, Len) = 0) then
		Begin
			Found := True;
			break;
		end;
	end;

	(* No interrupt handler has the signature. *)

	if Not Found then
	Begin
		CheckDriver := False;
		exit;
	end;

	(*
		This service makes sure that a printer is
		at the specified serial port.
		It also sinchronizes possible packet mismatch
		by sending two status requests.
	*)

	Regs.AH := DRIVER_INIT_PRINTER;
	Intr (IntNumber, Regs);
	CheckDriver := Regs.AH = TSR_SEND_OK;
end;

(*
	If first time, checks for the printer and the
	driver. Returns True if success.
*)

Function Initialize: Boolean;
Begin
	(*	Initializes if first time. *)

	if Not Initialized then
	Begin
		if Not CheckDriver then
		Begin
			Initialize := False;
			exit;
		end;
		Initialized := True;
	end;
	Initialize := True;	
end;


(*
	Function that interacts with the TSR. 
*)

Function SendPacket(const Command: String; Var Answer: String): Boolean;
Var
	Regs    : Registers;
	i       : Integer;
	Buffer	: Array[1..512] of Byte;
Const
	MAXSTRING = 255;
Begin
	
	(* Are driver and printer present? *)
	
	if Initialize = False then 
	Begin
		SendPacket := False;
		exit;
	end;

	i := 1;
	while (i <> Length(Command)+1) do
	Begin
		Regs.AH := DRIVER_PRINT_BYTE;
		Regs.AL := Ord(Command[i]);
		Intr (IntNumber, Regs);
		i := i + 1;
	end;
	
	(* End of Transmission: *)

	Regs.AH := DRIVER_PRINT_BYTE;
	Regs.AL := $D;
	Intr (IntNumber, Regs);
	
	(* Check for Errors:  *)

	if Regs.AH <> TSR_SEND_OK then
	Begin
		SendPacket := False;
		exit;
	end;

	(*
		If needed, the statuses are here, as integers:

		FiscalStatus := Regs.DX;
		PrinterStatus := Regs.BX;
	
		To check errors faster than now, you could
		take these two integers and perform binary
		arithmetic operations over them, looking for
		masks, like

			if (FiscalStatus and MASK_MEMORY_FULL) <> 0 then
			Begin
			    TextOut('Fiscal memory full');
			    SetFiscalError(gcErrMemoryFull);
				...
			end;

		or for global fatal errors:

			if (FiscalStatus and MASK_FATAL_ERRORS) <> 0 then 
			Begin
				... { Something for handling general fatal errors }
			end;

	*)

	(*	Now, get the answer: *)
	
	Regs.BX := Seg(Buffer);
	Regs.DX := Ofs(Buffer);
	Regs.AH := DRIVER_GETANSWER;
	Intr(IntNumber, Regs);

	(* 
		The answer may be longer than a Pascal string of maximum size,
		so we receive it in a temporary buffer, and then we translate it
		up to the maximum length to the caller's string.
		Note that if the answer is too long, a portion may be lost
		in the translation.
		Currently, the maximum expected size of the answer is about
		200 bytes, but this may change in the future.
	*)

	for i := 1 to MAXSTRING do
	Begin
		(* The answer is ASCIIZ *)
		if Buffer[i] = $0 then break;
		Answer[i] := Chr(Buffer[i]);
	end;

	Answer[0] := Chr(i-1); { Strip the zero }
	SendPacket := True;
end;

Function UninstallDriver: Boolean;
Var
	Regs    : Registers;
Begin
	Regs.AH := DRIVER_UNINSTALL;
	Intr (IntNumber, Regs);
	UninstallDriver := Regs.AX = 0;
end;

end.
