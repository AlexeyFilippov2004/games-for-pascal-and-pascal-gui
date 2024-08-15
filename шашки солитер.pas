program ChineseCheckers;

uses crt;

const
  BOARD_SIZE = 7;
  BOARD_EMPTY = ' ';
  BOARD_CHECKER = '*';

type
  TBoard = array[1..BOARD_SIZE, 1..BOARD_SIZE] of char;
  TPos = record
    x, y: integer;
  end;

var
  Board: TBoard;
  Player: TPos;
  MoveCount: integer;
  fromX, fromY, toX, toY, a: integer;
 
procedure InitializeBoard;
var
  i, j: integer;
begin
  for i := 1 to BOARD_SIZE do
    for j := 1 to BOARD_SIZE do
      if ((i >= 3) and (i <= 5)) or ((j >= 3) and (j <= 5)) then
        Board[i, j] := BOARD_CHECKER
      else
        Board[i, j] := BOARD_EMPTY;
  
  Player.x := 4;
  Player.y := 4;
  MoveCount := 0;
end;

procedure DrawBoard;
var
  i, j: integer;
begin
  writeln(' 1234567y');
  for i := 1 to BOARD_SIZE do
  begin
    write(i);
    for j := 1 to BOARD_SIZE do
    begin
      if (i = Player.x) and (j = Player.y) then
        Write(' ')
      else
        Write(Board[i, j]);
    end;
    WriteLn;
  end;
  Writeln('x');
end;

procedure MakeMove(fromX, fromY, toX, toY: integer);
var
  dx, dy, jumpX, jumpY: integer;
begin
  if (fromX < 1) or (fromX > BOARD_SIZE) or (fromY < 1) or (fromY > BOARD_SIZE) or
     (toX < 1) or (toX > BOARD_SIZE) or (toY < 1) or (toY > BOARD_SIZE) then
  begin
    WriteLn('Invalid move. Please try again.');
    Exit;
  end;
  
  if Board[fromX, fromY] <> BOARD_CHECKER then
  begin
    WriteLn('There is no checker at the specified position. Please try again.');
    Exit;
  end;
  
  dx := toX - fromX;
  dy := toY - fromY;
  
  if ((dx = 0) and (dy = 1)) or ((dx = 0) and (dy = -1)) or ((dx = 1) and (dy = 0)) or ((dx = -1) and (dy = 0)) then 
  begin
    Board[fromX, fromY] := BOARD_EMPTY;
    Board[toX, toY] := BOARD_CHECKER;
    Player.x := toX;
    Player.y := toY;
    Inc(MoveCount);
  end
  else if ((dx = 0) and (dy = 2)) or ((dx = 0) and (dy = -2)) or ((dx = 2) and (dy = 0)) or ((dx = -2) and (dy = 0)) then 
  begin
    jumpX := (fromX + toX) div 2;
    jumpY := (fromY + toY) div 2;
    
    if Board[jumpX, jumpY] = BOARD_CHECKER then
    begin
      Board[fromX, fromY] := BOARD_EMPTY;
      Board[jumpX, jumpY] := BOARD_EMPTY; 
      Board[toX, toY] := BOARD_CHECKER;
      Player.x := fromX;
      Player.y := fromY;
      Inc(MoveCount);
    end
    else
    begin
      WriteLn('Invalid move. Please try again.');
      Exit;
    end;
  end
  else
  begin
    WriteLn('Invalid move. Please try again.');
    Exit;
  end;
end;


begin
  InitializeBoard;
  repeat
    DrawBoard;
    WriteLn('Your move (fromX fromY toX toY) (4244):');
    Read(a);
    toY := a mod 10;
    a := a div 10;
    toX := a mod 10;
    a := a div 10;
    fromY := a mod 10;
    a := a div 10;
    fromX := a mod 10;
    writeln(fromX,',', fromY,',', toX,',', toY);
    MakeMove(fromX, fromY, toX, toY);
    clrscr;
  until false;
end.