

{ NGZ.INC  ---  Support routines for NGZ.PAS }


FUNCTION HexB(B : Byte) : str2;
CONST
   HexDigits : ARRAY[0..15] OF CHAR = '0123456789ABCDEF';
BEGIN
   HexB := HexDigits[B SHR 4]+HexDigits[B AND $0F];
END;

FUNCTION HexW(W : WORD) : str4;
BEGIN
   HexW := HexB(Hi(W)) + HexB(Lo(W));
END;

FUNCTION HexDW(DW : LONGINT) : str8;
BEGIN
   HexDW := HexW((DW AND $FFFF0000) SHR 16)
         + HexW(DW AND $0000FFFF);
END;


FUNCTION GetW(i : WORD) : WORD;
{ Get word from var buf starting at buf[i] }
VAR w : WORD;
BEGIN
   Move(buf[i],w,2);
   GetW := w;
END;

FUNCTION GetDW(i : WORD) : DWORD;
{ Get dword from var buf }
VAR dw : DWORD;
BEGIN
   Move(buf[i],dw,4);
   GetDW := dw;
END;


FUNCTION GetW_s(i : WORD) : WORD;
{ Get word from var sbuf starting at sbuf[i] }
VAR w : WORD;
BEGIN
   Move(sbuf[i],w,2);
   GetW_s := w;
END;

FUNCTION GetDW_s(i : WORD) : DWORD;
{ Get dword from var sbuf }
VAR dw : DWORD;
BEGIN
   Move(sbuf[i],dw,4);
   GetDW_s := dw;
END;


FUNCTION GetStr(i : WORD) : str65;
{ Get (plain) asciiz string starting at buf[i],
  only used for non-compressed strings in
  file header }
VAR
   s : str65;
   j : WORD;
BEGIN
   j := 0;
   WHILE buf[i] > 0 DO BEGIN
      Inc(j);
      s[j] := Chr(buf[i]);
      Inc(i);
   END;
   s[0] := Chr(j);
   GetStr := s;
END;


FUNCTION rpad(s : str100; len : WORD) : str100;
{ pad string on right with blanks }
BEGIN
   WHILE Length(s) < len DO
      s := s + #32;
   rpad := s;
END;

FUNCTION zeropad(n : WORD) : str3;
{ return number as zero-padded digit string }
VAR s : str3; i : WORD;
BEGIN
   Str(n : 3, s);
   FOR i := 1 TO 2 DO
      IF s[i] = #32 THEN s[i] := '0';
   zeropad := s;
END;


FUNCTION cap(s : str100) : str100;
{ convert to uppercase }
VAR i : WORD;
BEGIN
   FOR i := 1 TO Length(s) DO
     IF s[i] IN ['a'..'z'] THEN Dec(s[i],$20);
   cap := s;
END;


PROCEDURE parse_command(VAR r_c : BYTE;  VAR sce : str79);
{ Get args on command line
  Exit: r_c = 0: no errors (sce = input file),
        r_c > 0: no args or bad number }
VAR
   i,j  : WORD;
   test : INTEGER;
BEGIN
   sce := cap(ParamStr(1));             { uppercase }
   cmd := '';
   FOR i := 1 TO ParamCount DO
      cmd := cmd + cap(ParamStr(i)) + ' ';
   is_info_req  := Pos('?',cmd) > 0;
   is_quiet     := Pos('/Q',cmd) > 0;
   is_rept_only := Pos('/R',cmd) > 0;
   is_partial   := Pos('/P',cmd) > 0;

   r_c := 0;
   IF is_info_req THEN EXIT;            { info request: skip rest }

   r_c := 1;
   IF cmd = '' THEN EXIT;
   IF sce = '' THEN EXIT;

   IF is_partial THEN BEGIN
      i := Pos('/P',cmd) + 2;
      j := i;
      WHILE cmd[j] IN ['0'..'9','A'..'F'] DO Inc(j);
      {$IFDEF DEBUG}
         {$R-}
      {$ENDIF}
      Val('$'+Copy(cmd,i,j-i), partial_offs, test);
      {$IFDEF DEBUG}
         {$R+}
      {$ENDIF}
      IF (test > 0) OR (partial_offs < 0) THEN
         EXIT;
   END;

   r_c := 0;
END;


PROCEDURE write_link_file;
{ Output file to use with NGML - the menu linker }
VAR i,j : WORD;
    st : str100;
BEGIN
   ASSIGN(linkf, fprefix + dot_LCF);
   REWRITE(linkf);
   WRITELN(linkf, crlf + rpad('!Name:',12) + NG_name + crlf);
   WRITELN(linkf,'!Credits:');

   st := '';
   FOR i := 0 TO Pred(credits_num) DO           { suppress empty credits }
      st := st + credits[0];
   IF NOT (st = '') THEN
      FOR i := 0 TO Pred(credits_num) DO
         WRITELN(linkf, credits[i]);
   WRITELN(linkf);

   FOR i := 0 TO Pred(no_of_menus) DO BEGIN     { print menus & .NGOs }
      WRITE(linkf, rpad('!Menu:',12));
      WRITELN(linkf, menu[i].toptxt);
      FOR j := 0 TO Pred(menu[i].items) DO BEGIN
         st := menu[i].drop[j].txt;
         WRITELN(linkf, rpad('',12) + rpad(st, Succ(name_len))
           + fprefix + zeropad(menu[i].drop[j].datn) + dot_NGO);
      END;
      WRITELN(linkf);
   END;
   CLOSE(linkf);
END;


PROCEDURE write_make_file;
{ Output file to use with the MAKE utility }
VAR i,j,k : WORD;
    st : str100;
BEGIN
   ASSIGN(makef, fprefix + dot_MAK);
   REWRITE(makef);
   WRITELN(makef, '# Type:  MAKE -f' + fprefix + dot_MAK + crlf);
   WRITELN(makef, dot_ASC + dot_NGO + ':');
   WRITELN(makef, rpad('',12) + 'NGC $<' + crlf);
   WRITE(makef, 'OBJECTS= ');
   k := 9;
   FOR i := 1 TO out_files_num DO
      BEGIN
         WRITE(makef, rpad( fprefix + zeropad(i) + dot_NGO, 14) );
         k := k + 14;
         IF k >= 65 THEN BEGIN
            WRITE(makef,'\' + crlf + rpad('',9));
            k := 9;
         END;
      END;
   WRITELN(makef,crlf+crlf+ 'NEWNG.NG:   $(OBJECTS)');
   WRITELN(makef, rpad('',9) + 'NGML ' + fprefix + dot_LCF);
   CLOSE(makef);
END;





{ ------- Procedures beyond this point are not normally used by NGZ ------- }

{         For a verbose, raw, sequential dump of an NG file, edit
          the first 2 lines of NGZ.PAS's main procedure to:
             dump_NG_file('c:\ng\filename.ng','outfile.$$$');
             Halt(0);
          and recompile (TPC ngz).
}


FUNCTION getNGstr(i:WORD; VAR sz:WORD) : str100; FORWARD;
PROCEDURE read_n_verify_header; FORWARD;
PROCEDURE read_n_decrypt_struc(VAR ID : WORD; varia_too : BOOLEAN); FORWARD;

PROCEDURE dump_NG_file(infs,outfs:str100);
VAR outf:TEXT; this_ID:WORD;

PROCEDURE dump_menu_struc(VAR f:TEXT);
VAR i,j,it,len : WORD;
BEGIN
   it := getw(4);
   WRITELN(f, crlf,'Menu struc at file offset: ',hexDW(last_read_pos));
   WRITELN(f, 'ID    VarSz Items (4x)  ??');
   WRITE(f, hexW(getW(0)),'  ',hexW(getW(2)),'  ',hexW(it),'  ',
         hexW(getW(6)),'  ');
   FOR i := 8 TO Pred($1A) DO WRITE(f, hexB(buf[i]));
   WRITELN(f);
   WRITELN(f,'Menu title: ' + getNGstr($1A + 4 * Pred(it) + 8 * it, len)  );
   WRITELN(f,'Struc offs, and menu_string:');
   FOR i := 1 TO Pred(it) DO
      BEGIN
         WRITELN(f, hexDW(getDW($1A + 4 * Pred(i)) ) + '   ' +
            getNGstr($1A + getW($1A + 4 * Pred(it) + 8 * Pred(i)),len) );
      END;
   WRITELN(f);
END;  { dump_menu_struc }


PROCEDURE dump_short_struc(VAR f:TEXT);
VAR i,it,len : WORD;
BEGIN
   it := getw(4);
   WRITELN(f,crlf,'Short struc at file offset: ', hexDW(last_read_pos));
   WRITELN(f,
   'ID    VarSz Items ??    Par#  Parent    Mnu#  Itm#  0         0');
   WRITE(f, hexW(getW(0)),'  ',hexW(getW(2)),'  ',hexW(it),'  ');
   WRITE(f, hexW(getW(6)),'  ',hexW(getW(8)),'  ',hexDW(getDW($0a)),'  ');
   WRITE(f, hexW(getW($0e)),'  ',hexW(getW($10)),'  ');
   WRITELN(f, hexDW(getDW($12)),'  ',hexDW(getDW($16)));
   IF it > 0 THEN BEGIN
      { print 1st short string }
      WRITELN(f, '1st text:'+getNGstr($1A + getW($1A),len) );
      { print pointers }
      WRITELN(f,'Pointers:');
      FOR i := 1 TO it DO
         BEGIN
            WRITE(f, hexDW(getDW($1A + 2 + 6 * Pred(i))),' ');
            IF i MOD 8 = 0 THEN WRITELN(f);
         END;
      WRITELN(f,crlf);
   END;
END;  { dump_short_struc }


PROCEDURE dump_long_struc(VAR f:TEXT);
VAR i,it,len : WORD;
BEGIN
   it := getW(4);
   WRITELN(f, 'Long struc at file offset: ',hexDW(last_read_pos));
   WRITELN(f,
   'ID    VarSz Lines SAof  Par#  Parent    Mnu#  Itm#  PrevPtr   NextPtr');
   WRITE(f, hexW(getW(0)),'  ',hexW(getW(2)),'  ',hexW(it),'  ');
   WRITE(f, hexW(getW(6)),'  ',hexW(getW(8)),'  ',hexDW(getDW($0a)),'  ');
   WRITE(f, hexW(getW($0e)),'  ',hexW(getW($10)),'  ');
   WRITELN(f, hexDW(getDW($12)),'  ',hexDW(getDW($16)));
   { display 1st 2 strings }
   WRITELN(f, getNGstr($1A,len));
   IF it > 1 THEN
      WRITELN(f, getNGstr($1A+Succ(len),len));
   WRITELN(f);
END;  { dump_long_struc }


BEGIN  { dump_NG_file }
   ASSIGN(NGf,infs);
   FileMode := 0;
   RESET(NGf,1);

   ASSIGN(outf,outfs);
   SetTextBuf(outf, textbuffer);
   REWRITE(outf);

   read_n_verify_header;
   WRITELN(outf,infs + crlf + getstr(8));
   REPEAT
      read_n_decrypt_struc(this_ID,True);
      CASE this_ID OF
         0 : dump_short_struc(outf);
         1 : dump_long_struc(outf);
         2 : dump_menu_struc(outf);
        99 : { at Eof: see note at read_n_decrypt } ;
      END;
      WRITE('.');
   UNTIL Eof(NGf);
   CLOSE(NGf); CLOSE(outf);
   WRITELN;
END;

{ eof }
