{$define noDEBUG}
{$ifdef DEBUG}
   {$R+,S+}
{$else}
   {$R-,S-}
{$endif}
{$M 2048,0,655360}

PROGRAM NGZ;    { Disassemble Norton Guide database files  }
                {                                          }
                { Usage: NGZ ngfile.ng [/?][/R|/Poffs[/Q]] }
                {                                          }
                { Contains detailed description of the NG  }
                { v1.0 database file format.               }
                {                                          }
                { Morten Elling - May, 1993                }
USES Dos;

{$I ngz.glo }   { Global definitions }
{$I ngz.inc }   { Support routines   }
{   ngz.doc }   { Documentation file }
{ Compile with Turbo Pascal 4.0+     }

{ -------------------------------------------------------------------------- }


PROCEDURE list_pointers(VAR f : TEXT); FORWARD;

PROCEDURE exZit(rc : BYTE);
   PROCEDURE write_usage;
   BEGIN  WRITELN('Usage: NGZ ngfile.ng [/?][/R | /Poffset[/Q]]');  END;
BEGIN
   IF (rc = 0) OR (rc >=5) THEN BEGIN
      CLOSE(NGf);
      CLOSE(screen);
   END;
   IF NOT is_partial AND (rc IN [8,12]) THEN BEGIN
      list_pointers(reptf);
      CLOSE(reptf);
   END;

   CASE rc OF
      0 : WRITELN('Done.');
      1 : BEGIN
          WRITELN('NGZ 1.0 þ Disassemble NG database files þ /Me 1993');
          write_usage;
          WRITELN('  /?  This text');
          WRITELN('  /R  Report only (',dot_RPT,')');
          WRITELN('  /Poffset  Partial disassembly at _hex_ file offset.');
          WRITELN('      Run a report first to get the offset.');
          WRITELN('      Don''t use this on menu or short-to-short strucs.');
          WRITELN('  /Q  Suppress screen output (Note: disables Ctrl-C)');
          WRITELN;
          rc := 0;
          END;
      2 : write_usage;
      4 : WRITELN('Error on input.');
      5 : WRITELN('Not a valid NG database file.');
      8 : WRITELN('Unexpected Eof.');
      9 : WRITELN('Bad menu structure.');
     12 : WRITELN('Unknown structure ID (',last_ID,').');
     13 : WRITELN('Bad seek.');
   END;
   IF rc > 2 THEN WRITELN('Aborted.');

   HALT(rc);    { Exit to DOS setting errorlevel }
END;


FUNCTION GetNGstr(i : WORD; VAR sz : WORD) : str100;
{ Get NG-compressed ASCIIZ string, starting at buf[i],
  expanding spaces, and returning (compressed) length
  (less trailing zero) in var sz }
VAR
   j, k, z : WORD;  st : str100;
BEGIN
   j := 0;  z := i;
   WHILE (buf[i] > 0) AND (j < one_hundred) DO BEGIN
      Inc(j);
      IF (buf[i] = 255) AND (buf[i+1] > 0) THEN BEGIN
         FOR k := 1 TO buf[i+1] DO
            IF j < one_hundred THEN BEGIN    { prevent overflow }
               st[j] := #32;
               Inc(j);
            END;
         Dec(j);  Inc(i);
      END
      ELSE st[j] := Chr(buf[i]);
      Inc(i);
   END;
   st[0] := Chr(j);
   sz := i - z;
   GetNGstr := st;
END;


FUNCTION GetNGstr_s(i : WORD; VAR sz : WORD) : str100;
{ Get NG-compressed ASCIIZ string, starting at sbuf[i],
  expanding spaces, and returning (compressed) length
  (less trailing zero) in var sz }
VAR
   j, k, z : WORD;  st : str100;
BEGIN
   j := 0;  z := i;
   WHILE (sbuf[i] > 0) AND (j < one_hundred) DO BEGIN
      Inc(j);
      IF (sbuf[i] = 255) AND (sbuf[i+1] > 0) THEN BEGIN
         FOR k := 1 TO sbuf[i+1] DO
            IF j < one_hundred THEN BEGIN
               st[j] := #32;
               Inc(j);
            END;
         Dec(j);  Inc(i);
      END
      ELSE st[j] := Chr(sbuf[i]);
      Inc(i);
   END;
   st[0] := Chr(j);
   sz := i - z;
   GetNGstr_s := st;
END;


PROCEDURE read_n_verify_header;
{ Read NG database file header, and get database name and credits text }
VAR i : WORD;  st : str2;
BEGIN
   buf[0] := Ord('N') XOR Ord('G');             { so no false match }
   BlockRead(NGf, buf, header_size);
   Move(buf[0], st[1], 2);
   st[0] := #2;
   IF st <> NG_file_signature THEN exZit(5);    { bad signature }

   no_of_menus := getW(6);
   NG_name := getstr(8);
   FOR i := 0 TO Pred(credits_num) DO
      credits[i] := getstr(48 + i * Succ(credits_str_len));
END;


PROCEDURE read_n_decrypt_struc(VAR ID : WORD; varia_too : BOOLEAN);
{ Read structure at current file pos. into var buf and decrypt it;
  file ptr is advanced to start of next structure or to Eof.
  NOTE: Some NGs are zero-filled at eof to a 128 byte boundary; in this case,
        the procedure does not abort but returns (at Eof) with an ID of 99
        Note2: Zome wize guyz remove the last two bytes of the .NG to
               prevent a disassembly; ngz can handle this }
VAR i,j,k : WORD;

   FUNCTION just_zeros(a,z:WORD) : BOOLEAN;
   BEGIN WHILE (buf[a] = 0) AND (a < z) DO Inc(a);
         IF buf[a] <> 0 THEN just_zeros := FALSE
         ELSE BEGIN Seek(NGf,FileSize(NGf)); just_zeros := TRUE; END;
   END;
BEGIN
   IF Eof(NGf) THEN EXIT;
   last_read_pos := FilePos(NGf);
   BlockRead(NGf, buf[0], fixed_struc_size, j);
   FOR i := 0 TO Pred(j) DO
      buf[i] := buf[i] XOR crypto;              { decrypt }
   IF (j <> fixed_struc_size) OR (getW(2)=0) THEN { read less than requested }
      IF NOT just_zeros(0, Pred(j))
         THEN exZit(8)                          { unexpected Eof }
         ELSE BEGIN ID := 99; EXIT; END;        { expected Eof }
   ID := getW(0);
   IF ID > menu_ID THEN EXIT;                   { unknown ID }
   varia_struc_size := getW(2);
   IF NOT varia_too THEN BEGIN
      Seek(NGf,last_read_pos + $1A + varia_struc_size);
      EXIT;           { no need to read more during initial indexing }
   END;
   BlockRead(NGf, buf[fixed_struc_size], varia_struc_size, j);
   k := Pred(fixed_struc_size + j);
   FOR i := fixed_struc_size TO k DO
      buf[i] := buf[i] XOR crypto;              { decrypt }
   IF (j <> varia_struc_size) THEN
      IF just_zeros(fixed_struc_size, k)
         THEN BEGIN ID := 99; EXIT; END         { expected Eof }
         ELSE IF varia_struc_size - j <= 2      { make asciiz if 2 bytes miss}
         THEN BEGIN buf[$1A+j] := 0; EXIT; END
         ELSE exZit(8);                         { unexpected Eof }
END;


PROCEDURE get_menu_struc;
{ Get info for one menu struc from var buf }
VAR i,j,it,len : WORD;
BEGIN
   it := getW(4);    { no. of items includes menu title }
   menu[curr_menu].items := it - 1;
   menu[curr_menu].toptxt := getNGstr($1A + 4 * Pred(it) + 8 * it, len);

   { get file pointers and text for each menu item }
   FOR i := 0 TO Pred(it) -1 DO
      BEGIN
         menu[curr_menu].drop[i].fptr := getDW($1A + 4 * i);
         { get pointer to menu item string }
         j := getW($1A + 4 * Pred(it) + 8 * i);
         menu[curr_menu].drop[i].txt := getNGstr($1A + j, len);
      END;
END;


PROCEDURE register_strucs;
{ Read NG file sequentially to build pointer list of all short strucs
  and long strucs off menu, in order to resolve S/A and !File references }
VAR i,cnt : WORD;  par_dw : DWORD;
BEGIN
   {$I-}  Seek(NGf, menu[0].drop[0].fptr);  {$I+}      { start after menus }
   IF IOresult <> 0 THEN exZit(13);     { bad seek }
   WRITELN(screen,'Indexing');
   cnt := 0;
   REPEAT
      read_n_decrypt_struc(last_ID, False);  { False= read fixed part only }
      CASE last_ID of                   { statistics }
         short_ID: Inc(no_of_shorts);
         long_ID : Inc(no_of_longs);
      END;
      IF last_ID = 99 THEN EXIT         { Eof: see note at read_n_decrypt }
      ELSE IF last_ID = menu_ID         { in trouble, if menu reached here }
         THEN exZit(9)
      ELSE IF NOT (last_ID IN [short_ID, long_ID])
         THEN exZit(12);                { abort if unknown ID }

      par_dw := getDW($0A);
      IF (last_ID=short_ID) OR ((last_ID=long_ID) AND (par_dw = -1)) THEN
      BEGIN
         { register short strucs and no-parent longs in pointer list;
           these go in separate files }
         Inc(out_files_num);
         src^.ID        := last_ID;
         src^.file_offs := last_read_pos;
         src^.par_ptr   := par_dw;
         IF last_ID = long_ID
            THEN src^.first_ptr := last_read_pos
            ELSE src^.first_ptr := -1;  { don't know yet }
         src^.last_ptr  := src^.first_ptr;
         src^.tgt_file  := out_files_num;
         src^.next      := NIL;   { assume end of list }
         { }
         IF src <> sr1 THEN
            srp^.next   := src;   { link previous rec to this }
         srp            := src;   { "Remember this" }
         New(src);                { allocate mem. for a new rec }
      END
      ELSE { process a has-parent long; never goes in separate file }
      BEGIN
         { locate parent in list }
         sra := sr1;
         WHILE (sra^.file_offs <> par_dw) AND (sra <> NIL) DO
            sra := sra^.next;
         IF sra^.file_offs = par_dw THEN
         BEGIN               { change ptrs }
            IF sra^.first_ptr = -1 THEN
               BEGIN
                  sra^.first_ptr := last_read_pos;
                  sra^.last_ptr  := last_read_pos;
               END
            ELSE BEGIN            { it's safe to assume an interval }
               IF sra^.first_ptr > last_read_pos
                  THEN sra^.first_ptr := last_read_pos;
               IF sra^.last_ptr < last_read_pos
                  THEN sra^.last_ptr := last_read_pos;
            END;
         END
         ELSE
            WRITELN(reptf,'WARNING: Parent not found ',hexDW(last_read_pos));
            { linker must have caught this (?) }
      END; { if }
      Inc(cnt);
      IF cnt MOD  10 = 0 THEN WRITE(screen,'.');       { simple odometer }
      IF cnt MOD 500 = 0 THEN WRITELN(screen);
   UNTIL Eof(NGf);
   WRITELN(screen);
END;  { register_strucs }


PROCEDURE list_statistics(VAR f : TEXT);
BEGIN
   WRITELN(f, in_name);
   WRITELN(f, NG_name);
   WRITELN(f);
   WRITELN(f, 'File size: ',hexDW(file_size),'  (',file_size,'d)');
   WRITELN(f,no_of_menus : 8, ' menus');
   WRITELN(f,no_of_shorts: 8, ' short strucs');
   WRITELN(f,no_of_longs : 8, ' long strucs');
   WRITELN(f,' --> ',out_files_num : 3,' files.');
   WRITELN(f);
END;


PROCEDURE list_pointers(VAR f : TEXT);
{ Display list of pointers }
VAR sra : struc_rec_ptr;
BEGIN
   sra := sr1;
   WRITELN(f);
   WRITELN(f,'Numbers in hex, except target file #');
   WRITELN(f);
   WRITELN(f,'ID    FileOffs  1stptr    Lastptr   Tgt  Parent');
   WHILE sra <> NIL DO BEGIN
      WRITE(f,hexw(sra^.ID),'  ',hexdw(sra^.file_offs),'  ');
      WRITE(f,hexdw(sra^.first_ptr),'  ',hexdw(sra^.last_ptr),'  ');
      WRITELN(f,zeropad(sra^.tgt_file),'  ',hexdw(sra^.par_ptr));
      sra := sra^.next;
   END;
   WRITELN(f);
END;


FUNCTION lookup_file_no(fp : DWORD) : WORD;
{ Look up struc offset in pointer table,
  and return the corresponding output file number }
VAR sra : struc_rec_ptr;
BEGIN
   sra := sr1;
   WHILE (sra^.file_offs <> fp) AND (sra <> NIL) DO
      sra := sra^.next;
   IF sra^.file_offs = fp
      THEN lookup_file_no := sra^.tgt_file
      ELSE lookup_file_no := 999;   
END;


FUNCTION lookup_sa_ref(fp : DWORD) : WORD;
{ Look up seealso reference in pointer table,
  and return the corresponding output file number,
  returns 999 if not found }
VAR sra : struc_rec_ptr; found : BOOLEAN;
BEGIN
   sra := sr1;  found := False;
   WHILE NOT found AND (sra <> NIL) DO
      IF (fp >= sra^.first_ptr) AND (fp <= sra^.last_ptr)
         THEN found := True
      ELSE sra := sra^.next;
   IF found THEN lookup_sa_ref := sra^.tgt_file
   ELSE lookup_sa_ref := 999;       { not found; NGML only warns about this }
END;


PROCEDURE process_long_struc(VAR f : TEXT; curr_file:WORD; lookup:BOOLEAN);
{ Process long in var buf }
VAR lines,ix,j,k,len,sa_offs,sa_no : WORD;
BEGIN
   ix := fixed_struc_size;
   lines := getW(4);
   FOR j := 0 TO Pred(lines) DO                 { no. of lines }
      BEGIN
         WRITELN(f, getNGstr(ix,len));
         ix := ix + Succ(len);                  { bump trailing zero }
      END;

   { process SeeAlso data, if appropriate }
   IF NOT lookup OR (getW(6) = 0) THEN EXIT;
   sa_offs := fixed_struc_size + getW(6);
   sa_no := getW(sa_offs);
   IF sa_no = 0 THEN EXIT;
   WRITE(f,'!Seealso:');
   ix := sa_offs + 2 + sa_no * 4;               { index of 1st string }
   FOR j := 0 TO Pred(sa_no) DO
      BEGIN
         k := lookup_sa_ref(getDW(sa_offs + 2 + j * 4));
         IF k <> curr_file THEN                 { put file ref. in }
            BEGIN
               WRITE(f, fprefix + zeropad(k) + dot_NGO + ':');
               IF k = 999 THEN                  { put warning in report }
                  WRITELN(reptf,'Unresolved S/A (file: '
                          + zeropad(curr_file) + ')');
            END;
         WRITE(f, '"' + getNGstr(ix, len)  + '"  ');
         ix := ix + Succ(len);
      END;
   WRITELN(f);
END;  { process_long_struc }


PROCEDURE process_struc(VAR datf:TEXT;
          fpos:DWORD; file_no:WORD; lookup:BOOLEAN);
{ Process long OR short struc incl. longs/shorts in next level,
  and display a simple odometer }
VAR it,i,len,num,itc : WORD;  srt : struc_rec_ptr;
    caption : str100; entry_pos : DWORD;
BEGIN
   WRITELN(screen,'File : '+ fprefix + zeropad(file_no) + dot_ASC);
   Seek(NGf, fpos);
   read_n_decrypt_struc(last_ID, True);
   IF last_ID > menu_ID THEN exZit(12);         { unknown ID }
   {}
   IF last_ID = long_ID THEN                    { long off menu }
      BEGIN
         WRITELN(screen,'l');
         process_long_struc(datf, file_no, lookup);
         EXIT;  { done here }
      END;

   { beyond this point: current struc is short }
   it := getW(4);                               { no. of items to process }
   Move(buf, sbuf, fixed_struc_size + getW(2)); { copy to VAR sbuf while
                                                  processing next level }

   FOR itc := 0 TO Pred(it) DO
      BEGIN
         caption := getNGstr_s($1A + getW_s($1A + itc * 6), len);
         entry_pos := getDW_s($1A + 2 + itc * 6);
         WRITELN(datf, '!Short:' + caption);
         IF entry_pos = -1 THEN    { done here:  no entry, just a caption }
         ELSE IF lookup_file_no(entry_pos) = 999 THEN
            BEGIN       { expands into long }
              IF itc = 0 THEN WRITE(screen,'s');
              WRITE(screen,'l');
              Seek(NGf, entry_pos);
              read_n_decrypt_struc(last_ID, True);
              process_long_struc(datf, file_no, lookup)
            END
         ELSE           { expands into short }
            BEGIN
               srt := sr1;        { register caption in struc record }
               WHILE (srt^.tgt_file <> lookup_file_no(entry_pos))
                  AND (srt <> NIL) DO srt := srt^.next;
               IF srt^.tgt_file = lookup_file_no(entry_pos)
                  THEN srt^.txt := caption
                  ELSE srt^.txt := '';
               WRITE(screen,'f');
               WRITELN(datf, '!File:'
                 + fprefix + zeropad(lookup_file_no(entry_pos)) + dot_NGO);
            END;
      END;  { FOR }

      WRITELN(screen);
END;  { process_struc }


{ MAIN -------------------------------------------------------------------- }

VAR
   { general purpose vars }
   i,j      : WORD;
   this_num : WORD;
   this_pos : DWORD;

BEGIN
   { Get args from command line }
   parse_command(rc, in_name);
   IF is_info_req THEN exZit(1);
   IF rc > 0 THEN exZit(2);
   IF is_rept_only THEN is_partial := False;

   ASSIGN(NGf, in_name);
   FileMode := 0;                    { open as read-only }
   {$I-}  RESET(NGf, 1);  {$I+}
   IF IOresult <> 0 THEN exZit(4);   { error on input }
   file_size := FileSize(NGf);


   { Init vars }
   no_of_shorts  := 0;
   no_of_longs   := 0;
   out_files_num := 0;               { count is one-based }

   fprefix       := '____';
   i := Length(in_name);  j := 1;
   WHILE (i > 1) AND NOT (in_name[Pred(i)] IN [':','\']) DO
      Dec(i);
   WHILE (in_name[i] <> '.') AND (j <= 4) DO
      BEGIN fprefix[j] := in_name[i]; Inc(i); Inc(j); END;


   ASSIGN(screen,'CON');
   IF is_quiet THEN ASSIGN(screen,'NUL');
   REWRITE(screen);


   { Process /P switch bypassing all indexing }
   IF is_partial THEN BEGIN
      sr1 := NIL;
      ASSIGN(datf, fprefix + zeropad(_112) + dot_ASC);
      SetTextBuf(datf, textbuffer);
      REWRITE(datf);
      process_struc(datf, partial_offs, _112, False);
      CLOSE(datf);
      exZit(0);                                 { ------------- }
   END;


   FindFirst(fprefix + '*.*', Archive, dir_info);
   IF (DosError = 0) AND (Pos(dot_NG,dir_info.Name) = 0) THEN BEGIN
      WRITELN(screen,'* WARNING *');
      WRITELN(screen,'Current directory has files matching ',fprefix + '*.*');
      WRITELN(screen,'Press Break (Ctrl-C) NOW to avoid overwriting files.');
      WRITELN(screen);
   END;


   IF is_rept_only THEN
      WRITELN(screen,'Report only');
   ASSIGN(reptf, fprefix + dot_RPT);
   REWRITE(reptf);                              { open report file }

   read_n_verify_header;                        { first read the header }
   curr_menu := 0;
   REPEAT                                       { then the menus }
      read_n_decrypt_struc(last_ID, True);
      IF last_ID = menu_ID THEN BEGIN
         get_menu_struc;
         Inc(curr_menu);
      END;
   UNTIL (curr_menu = no_of_menus)
         OR (last_ID <> menu_ID) OR Eof(NGf);
   IF curr_menu <> no_of_menus THEN exZit(9);   { menu number mismatch }
   IF last_ID > menu_ID THEN exZit(12);         { abort if unknown ID }


   { Register strucs in single-linked pointer list }
   src := NIL;
   Mark(srm);                 { record the heap state }
   New(src);
   sr1 := src;                { pointer to 1st rec }
   register_strucs;           { read rest of file }
   { at this point, sr1 points to 1st rec,
     srp points to last rec (srp^.next = NIL) }


   { Show list of pointers/statistics }
   list_statistics(screen);
   (*   list_pointers(screen); *)


   { Write the data files }
   sra := sr1;
   WHILE sra <> NIL DO
      BEGIN
         ASSIGN(datf, fprefix + zeropad(sra^.tgt_file) + dot_ASC);
         IF is_rept_only THEN ASSIGN(datf,'NUL');
         SetTextBuf(datf, textbuffer);      { 8 K buffer for fast writes }
         REWRITE(datf);
         process_struc(datf, sra^.file_offs, sra^.tgt_file, True);
         CLOSE(datf);
         sra := sra^.next;
      END;


   { Synchronize menu info and pointer list (file no. and texts) }
   FOR curr_menu := 0 TO Pred(no_of_menus) DO
      FOR curr_item := 0 TO Pred(menu[curr_menu].items) DO
         BEGIN
            this_pos := menu[curr_menu].drop[curr_item].fptr;
            this_num := lookup_file_no(this_pos);
            menu[curr_menu].drop[curr_item].datn := this_num;
            sra := sr1;
            WHILE (sra^.tgt_file <> this_num) AND (sra <> NIL) DO
               sra := sra^.next;
            IF sra^.tgt_file = this_num THEN
               sra^.txt := Copy(menu[curr_menu].toptxt,1,8) + ': '
                           + menu[curr_menu].drop[curr_item].txt;
         END;


   WRITELN(screen,'Writing report file');
   list_statistics(reptf);
   list_pointers(reptf);
   sra := sr1;
   WHILE sra <> NIL DO                          { list menus/captions }
      BEGIN
         WRITELN(reptf,
            fprefix+zeropad(sra^.tgt_file) + dot_ASC + ': ', sra^.txt);
         sra := sra^.next;
      END;
   CLOSE(reptf);
   IF NOT is_rept_only THEN BEGIN
      WRITELN(screen,'Writing link and make files');
      write_link_file;
      write_make_file;
   END;


   Release(srm);        { return heap to previous state }
   exZit(0);            { all termination is routed through proc. exZit }
END.

