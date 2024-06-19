
program SnakeGame;
uses CRT;

const
  Width = 30; // ширина поля
  Height = 15; // высота поля

var
  Field: array[1..Width, 1..Height] of string;
  Snake: array[1..Width*Height, 1..Width*Height] of integer;
  SnakeLength,num,i: integer;
  X, Y, DX, DY: integer;
  FruitX, FruitY,n: integer;
  GameOver: boolean;
  st:string;
  GamePaused: boolean;

procedure Init;
begin
  ClrScr;
  Randomize;
  SnakeLength := 1;
  Snake[1, 1] := Width div 2;
  Snake[1, 2] := Height div 2;
  X := Snake[1, 1]; Y := Snake[1, 2];
  DX := 1; DY := 0;
  FruitX := Random(Width - 2) + 2;
  FruitY := Random(Height - 2) + 2;
  GameOver := False;
  GamePaused := False;
end;

procedure Draw;
var
  I, J: integer;
begin
  ClrScr;
  writeln('Чтобы начать, приостановить, продолжить нажмите пробел');
  writeln('Управление a,s,d,w.');
  writeln('Счет - ', num);
  for J := 1 to Height do
  begin
    for I := 1 to Width do
    begin
      if (I = Snake[1, 1]) and (J = Snake[1, 2]) then
        begin
        Write('*') // рисуем голову змеи
        end
      else if (I = FruitX) and (J = FruitY) then
        begin
            TextBackground(4);
            Write('O') // рисуем фрукт
        end
      else if (I = Width) or (I = 1) then 
      begin
        TextBackground(14);
        Write('|') // рисуем границу поля
        end
      else if (J = Height) or (J = 1) then 
        begin
        TextBackground(14);
        Write('-')
        end
      else if Field[I, J] = '*' then
      begin
        TextBackground(3);
        Write('+') // рисуем тело змеи
        end
      else
      begin
        TextBackground(0);
        Write(' '); // рисуем пустую ячейку поля
        end;
        TextBackground(2);
      Field[I, J] := ' ';
    end;
    Writeln;
  end;

  for I := 1 to SnakeLength do
  begin
    Field[Snake[I, 1], Snake[I, 2]] := '*';
  end;
end;

procedure MoveSnake;
var
  I: integer;
begin
  if GamePaused then Exit;

  X := X + DX;
  Y := Y + DY;

  if (X = FruitX) and (Y = FruitY) then
  begin
    num := num + 1;
    Inc(SnakeLength);
    FruitX := Random(Width - 2) + 2;
    FruitY := Random(Height - 2) + 2;
  end;

  if (X < 2) or (X > Width - 1) or (Y < 2) or (Y > Height - 1) or (Field[X, Y] = '*') then
  begin
    GameOver := True;
        if GameOver and (n<>1) then
    begin
      repeat
        ClrScr;
        Draw;
      st:=readkey;
      if (st = ' ') then 
      begin
        Init; // Перезапуск игры
        num:=0;
        GameOver := False;
        GamePaused := False;
        st:='';
        end;
        until GameOver = False;
    end;
end;

  for I := SnakeLength downto 2 do
  begin
    Snake[I, 1] := Snake[I - 1, 1];
    Snake[I, 2] := Snake[I - 1, 2];
  end;

  Snake[1, 1] := X;
  Snake[1, 2] := Y;

  Field[X, Y] := ' ';
end;


procedure HandleInput;
var
  Ch: char;
begin
  if KeyPressed then
  begin
    Ch := ReadKey;
    if GameOver and (n <> 1) then 
    begin
      if (ch = 'y') or (ch = 'н') then 
        GameOver := false
      else 
        n := 1;
    end
    else 
    begin
      if GameOver = false then 
      begin
        if (Ch = 'w') or (Ch = 'ц') then 
        begin 
          DX := 0; 
          DY := -1; 
        end
        else if (Ch = 's') or (Ch = 'ы') then 
        begin 
          DX := 0; 
          DY := 1; 
        end
        else if (Ch = 'a') or (Ch = 'ф') then 
        begin 
          DX := -1; 
          DY := 0; 
        end
        else if (Ch = 'd') or (Ch = 'в') then 
        begin 
          DX := 1; 
          DY := 0; 
        end;
        if Ch = ' ' then
          GamePaused := not GamePaused;
      end
      else if Ch = #27 then
      begin
        GameOver := True;
        GamePaused := False;
      end;
    end;
  end;
  
end;

procedure GameLoop;
var
  st: string;
  i,time:integer;
  td:boolean;
begin
  td:=false;
  time:=10;
  GamePaused:=true;
repeat
    Draw;
    HandleInput;
    MoveSnake;
    if (num mod 2=0) and not td then
      begin
      time:=time-1;
      td:=true;
      end;
    Delay(time*50);
  until GameOver;
end;

begin
  Init;
  GameLoop;
end.
