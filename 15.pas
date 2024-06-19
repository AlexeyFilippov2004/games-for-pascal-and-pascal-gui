uses crt;//,sysutils;

var
  a, a1, am, an, b, c, x, y, x1, y1, nom, nx, ny: integer;
  i, i1: array [1..100, 1..100] of smallint;
  s, ss: string;
  n: array of string;

begin
  repeat
    randomize;
    TextBackground(2);
    TextColor(4);
    ClrScr;
    write('Введите ширину и высоту - ');
    readln(ny, nx);
    clrscr;
    a := 1;
    for c := 1 to ny do 
      for b := 1 to nx do
      begin
        i[b, c] := a;   
        i1[c, b] := a;   
        a := a + 1;
      end;  
      am:=a;
    for c := ny downto 1 do
      for b := nx downto 1 do
      begin
        a := random(3) + 1;
        a1 := random(3) + 1;
        x := i[b, c];
        i[b, c] := i[a, a1];
        i[a, a1] := x;
      end;
    a1 := 0;    
    nom := 0;
    writeln('Количество ходов - ', a1);
    for x := 1 to nx * 4 do write('-');
    writeln();
    for x := 1 to nx do
    begin
      write('|');
      for y := 1 to ny do 
      begin
        if i[x, y] = nx * ny then 
        begin
          TextBackground(0);
          write('  ');
          x1 := x;
          y1 := y;
          TextBackground(2);
          write('|');
        end
        else if i[x, y] < 10 then 
          write(i[x, y], ' |')
        else 
          write(i[x, y], '|');
      end;
      writeln();
      for a := 1 to nx * 4 do write('-');
      writeln();
    end;
    repeat
      readln(s);
      b := -1;
      SetLength(n, 0);
      while s <> '' do
      begin
        a := pos(' ', s);
        if a = 0 then
          a := Length(s) + 1;
        b := b + 1;
        a1 := a1 + 1;
        SetLength(n, Length(n) + 1);
        n[b] := copy(s, 1, a - 1);
        delete(s, 1, a);
      end;
      
      for nom := 0 to b do
      begin
        for x := 1 to nx do
          for y := 1 to ny do
          begin
            if i[x, y] = nx * ny then 
            begin
              x1 := x;
              y1 := y;
            end;
          end;
        for x := 1 to nx do
          for y := 1 to ny do
          begin
            str(i[x, y], ss);
            if ss = n[nom] then 
            begin
              i[x, y] := nx * ny;
              i[x1, y1] := StrToInt(n[nom]);
            end;
          end;
        Delay(500);
        ClrScr;
        writeln('Количество ходов - ', a1);
        for x := 1 to nx * 4 do write('-');
        writeln();
        for x := 1 to nx do
        begin
          write('|');
          for y := 1 to ny do 
          begin
            if i[x, y] = nx * ny then
            begin
              TextBackground(0);
              write('  ');
              x1 := x;
              y1 := y;
              TextBackground(2);
              write('|');
            end
            else begin
              if i[x, y] = i1[x, y] then begin
                TextBackground(3);
                if i[x, y] < 10 then begin
                  write(i[x, y]);
                  TextBackground(2);
                  write(' |');
                end else begin
                  write(i[x, y]);
                  TextBackground(2);
                  write('|');
                end;
              end else begin
                TextBackground(2);
                if i[x, y] < 10 then
                  write(i[x, y], ' |')
                else 
                  write(i[x, y], '|');
              end;
            end;
          end;
          writeln();    
          for a := 1 to nx * 4 do write('-');
          writeln();
        end;
      end;
      for a:=1 to am do
      begin
//        if comparemem(@i[a],@i1[a],sizeof(i[a])) then an:=an+1;
        if an=nx*ny then 
      begin
        write('Вы победили!');
        Delay(10000);
        s := '0';
      end;
      end;
    until s = '0';  
  until s = ' ';
end.