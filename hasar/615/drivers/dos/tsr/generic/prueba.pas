(*
  Programa para probar el nuevo controlador fiscal (cf386) con sus
  nuevas funcionalidades.
*)

program prueba;

{$X+}

uses hasar, Strings;

const
     FS                         = '';
     CMD_SET_CUSTOMER_DATA      = 'b';
     CMD_OPEN_DOC               = '@';
     CMD_SELL                   = 'B';
     CMD_CLOSE_DOC              = 'E';
     CMD_STATUS                 = '*';
     CMD_STATPRN                = '¡';

function	IsSTATPRN( ans: string ): boolean;
var
	pans:	array[0..255] of Char;
begin
	StrPCopy( pans, ans );

	if( strpos( pans, '~STATPRN~' ) <> nil )
    	then IsSTATPRN := true
		else IsSTATPRN := false;
end;

procedure	InitPrinter;
begin

end;

procedure	SendCommand( cmd: string );
var
	ans: 	string;
begin

	Writeln( 'Send command: ', cmd );

	if( not SendPacket( cmd, ans ) )
    	then Writeln( 'Error!!!' );

	while( IsSTATPRN( ans ) ) do
	begin
		Writeln( 'STATPRN - Answer: ', ans );
    	if( not SendPacket( cmd, ans ) )
        	then Writeln( 'Error!!! (STATPRN)' );
	end;

	Writeln( 'Answer: ', ans );
	Writeln( '' );
end;

procedure	SendStatus;
var
	str: 	string;
begin
	str := CMD_STATUS;

	SendCommand( str );
end;

procedure	SetCustomerData( Name: string; CustomerDocNum: string; IVAResp: char;
                           	 CustomerDocType: char; Address: string  );
var
	str: 	string;
begin
	str := CMD_SET_CUSTOMER_DATA + FS + Name + FS + CustomerDocNum + FS +
    		IVAResp + FS + CustomerDocType + FS + Address;

	SendCommand( str );
end;

procedure 	OpenDocument( DocType: char );
var
	str: 	string;
begin
	str := CMD_OPEN_DOC + FS + DocType + FS + 'S';

	SendCommand( str );
end;

procedure 	Sell( Desc: string; Cant: string; Price: string; IVA: string;
                	Sign: string; K: string; TotalBase: string );
var
	str: 	string;
begin
	str := CMD_SELL + FS + Desc + FS + Cant + FS + Price + FS + IVA + FS +
            Sign + FS + K + FS + FS + TotalBase;

	SendCommand( str );
end;

procedure	CloseDocument;
var
	str: 	string;
begin
	str := CMD_CLOSE_DOC;

	SendCommand( str );
end;

(*
  Bloque principal.
*)
begin
	InitPrinter;

	SendStatus;

    SetCustomerData( 'Pascu', '20183697308', 'I', 'C', 'Direccion' );

    OpenDocument( 'A' );
    Sell( 'Item1', '1', '10', '21', 'M', '0', 'T' );
    Sell( 'Item2', '1', '20', '21', 'M', '0', 'T' );
    Sell( 'Item3', '1', '30', '21', 'M', '0', 'T' );
    Sell( 'Item4', '1', '40', '21', 'M', '0', 'T' );
    Sell( 'Item5', '1', '50', '21', 'M', '0', 'T' );
    Sell( 'Item6', '1', '60', '21', 'M', '0', 'T' );
    Sell( 'Item7', '1', '70', '21', 'M', '0', 'T' );
    Sell( 'Item8', '1', '80', '21', 'M', '0', 'T' );
    Sell( 'Item9', '1', '90', '21', 'M', '0', 'T' );
    Sell( 'Item10', '1', '100', '21', 'M', '0', 'T' );
    CloseDocument;

{    UninstallDriver;}
end.