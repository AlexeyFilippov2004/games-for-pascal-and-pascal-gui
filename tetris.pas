program tetris;

uses crt;

const
  RandMassSize = 10000;

var
  ss, nn, x, y, pus, a, b, c, d, lin, rlin: integer;
  st: array[1..12, 1..22] of integer;
  randmas: array[0..RandMassSize] of integer;
  CounterFigure: integer;
  CurrFigure, NextFigure: integer;
  Score: integer;
  i: integer;

procedure k(x, y: integer);
begin
  gotoxy(x * 2 + 20, 23 - y);
  if ss = 0 Then write('  ');
  if ss = 1 Then write('[]');
  if ss = 2 Then
  begin
    textcolor(LightCyan);
    write(chr(124), chr(124));
    textcolor(white);
  end;
  if (ss = 3) and (st[x, y] > 0) Then pus := 1;
  if ss = 4 Then st[x, y] := 1;
end;

procedure fig(x, y, n, s: integer);
begin
  if s = 3 Then pus := 0;
  ss := s;
  k(x, y);
  if n = 1 Then
  begin
    k(x + 1, y);
    k(x, y - 1);
    k(x + 1, y - 1)
  end;
  if n = 2 Then
  begin
    k(x - 1, y);
    k(x + 1, y);
    k(x + 2, y)
  end;
  if n = 3 Then
  begin
    k(x, y + 1);
    k(x, y - 1);
    k(x, y - 2)
  end;
  if n = 4 Then
  begin
    k(x + 1, y);
    k(x - 1, y);
    k(x - 1, y + 1)
  end;
  if n = 5 Then
  begin
    k(x, y + 1);
    k(x + 1, y + 1);
    k(x, y - 1)
  end;
  if n = 6 Then
  begin
    k(x - 1, y);
    k(x + 1, y);
    k(x + 1, y - 1)
  end;
  if n = 7 Then
  begin
    k(x, y + 1);
    k(x, y - 1);
    k(x - 1, y - 1)
  end;
  if n = 8 Then
  begin
    k(x - 1, y);
    k(x + 1, y);
    k(x + 1, y + 1)
  end;
  if n = 9 Then
  begin
    k(x, y + 1);
    k(x, y - 1);
    k(x + 1, y - 1)
  end;
  if n = 10 Then
  begin
    k(x + 1, y);
    k(x - 1, y);
    k(x - 1, y - 1)
  end;
  if n = 11 Then
  begin
    k(x, y + 1);
    k(x, y - 1);
    k(x - 1, y + 1)
  end;
  if n = 12 Then
  begin
    k(x - 1, y);
    k(x, y - 1);
    k(x + 1, y - 1)
  end;
  if n = 13 Then
  begin
    k(x, y + 1);
    k(x - 1, y);
    k(x - 1, y - 1)
  end;
  if n = 14 Then
  begin
    k(x + 1, y);
    k(x - 1, y - 1);
    k(x, y - 1)
  end;
  if n = 15 Then
  begin
    k(x - 1, y);
    k(x, y - 1);
    k(x - 1, y + 1)
  end;
  if n = 16 Then
  begin
    k(x + 1, y);
    k(x - 1, y);
    k(x, y + 1)
  end;
  if n = 17 Then
  begin
    k(x + 1, y);
    k(x, y + 1);
    k(x, y - 1)
  end;
  if n = 18 Then
  begin
    k(x, y - 1);
    k(x - 1, y);
    k(x + 1, y)
  end;
  if n = 19 Then
  begin
    k(x - 1, y);
    k(x, y + 1);
    k(x, y - 1)
  end;
end;

procedure pov;
begin
  nn := nn - 1;
  if nn = 15 Then nn := 19;
  if nn = 13 Then nn := 15;
  if nn = 11 Then nn := 13;
  if nn = 7 Then nn := 11;
  if nn = 3 Then nn := 7;
  if nn = 1 Then nn := 3;
  if nn = 0 Then nn := 1;
end;

procedure clrst;
var
  y, x: integer;
begin
  for x := 1 to 12 do
    for y := 1 to 22 do
      if (x = 1) or (x = 12) or (y = 1) Then st[x, y] := 2
      else st[x, y] := 0;
end;

procedure risvesst;
var
  y, x: integer;
begin
  for x := 1 to 12 do
    for y := 1 to 22 do
    begin
      ss := st[x, y];
      k(x, y)
    end;
end;

procedure dvig;
var
  i: integer;
  key: char;
begin
  for i := 1 to 10 do
  begin
    delay(d);
    key := ' ';
    if keypressed Then key := readkey;
    if (key = 'a') or (key = 'ф') Then
    begin
      fig(x - 1, y, nn, 3);
      if pus = 0 Then
      begin
        fig(x, y, nn, 0);
        x := x - 1;
        fig(x, y, nn, 1);
      end;
    end;
    if (key = 'd') or (key = 'в') Then
    begin
      fig(x + 1, y, nn, 3);
      if pus = 0 Then
      begin
        fig(x, y, nn, 0);
        x := x + 1;
        fig(x, y, nn, 1);
      end;
    end;
    if (key ='w') or (key = 'ц') Then
    begin
      pov;
      fig(x, y, nn, 3);
      pov;
      pov;
      pov;
      if pus = 0 Then
      begin
        fig(x, y, nn, 0);
        pov;
        fig(x, y, nn, 1);
      end;
    end;
    if (key = 's') or (key = 'ы') Then d := 1;
  end;
end;

procedure newfigure;
var i: integer;
begin
  CurrFigure := randmas[CounterFigure + 1];
  if (CounterFigure + 2) > RandMassSize then begin
    for i := 0 to RandMassSize do
      randmas[i] := 1 + random(18);
    CounterFigure := 1
  end;
  NextFigure := randmas[CounterFigure + 2];
  gotoxy(50, 10);
  writeln('               ');
  gotoxy(50, 10);
  writeln('Очки: ', Score);
  gotoxy(50, 3);
  writeln('Следующая ');
  gotoxy(50, 4);
  writeln('               ');
  gotoxy(50, 5);
  writeln('               ');
  gotoxy(50, 6);
  writeln('               ');
  gotoxy(50, 7);
  writeln('               ');
  gotoxy(50, 8);
  writeln('               ');
  gotoxy(50, 9);
  writeln('               ');
  fig(16, 17, NextFigure, 1);
  nn := CurrFigure;
end;

begin
  TextBackground(Blue);
  TextBackGround(Blue);
  TextColor(White);
  ClrScr();
  write('Нажмите любую клавишу для старта');
  ReadKey;
  randomize;
  for i := 0 to RandMassSize do
    randmas[i] := (1 + random(18));
  TextBackground(Blue);
  TextBackGround(Blue);
  TextColor(White);
  clrscr;
  textcolor(Yellow);
  gotoxy(01, 10);
  Writeln(' Как играть?');
  Writeln('');
  Writeln(' <A,Ф> влево');
  Writeln(' <D,В> вправо');
  Writeln(' <S,Ы> сбросить вниз');
  Writeln(' <W,Ц> поворот фигуры');
  TextColor(White);
  clrst;
  risvesst;
  lin := 0;
  Score := 0;
  repeat
    newfigure;
    x := 6;
    y := 21;
    fig(x, y, nn, 3);
    d := 80 - (lin * 3);
    if pus = 0 Then
    begin
      repeat
        fig(x, y, nn, 1);
        dvig;
        fig(x, y - 1, nn, 3);
        if pus = 0 Then
        begin
          fig(x, y, nn, 0);
          y := y - 1;
        end;
      until pus = 1;
      fig(x, y, nn, 4);
      CounterFigure := CounterFigure + 1;
      Score := Score + 100;
      for y := 22 downto 2 do
      begin
        a := 0;
        for x := 2 to 11 do
          a := a + st[x, y];
        if a = 10 Then
        begin
          for b := y to 21 do
            for c := 2 to 11 do
              st[c, b] := st[c, b + 1];
          lin := lin + 1;
          gotoxy(50, 12);
          writeln('Линии: ', lin);
          Score := Score + 1000;
        end;
      end;
      risvesst;
      pus := 0;
    end;
  until pus = 1;
  gotoxy(4, 2);
  writeln('Игра окончена!');
end.
