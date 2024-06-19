program game2048;
uses Crt;
const
    num2=2;
    num4=num2*num2;
    SIZE_MAP = 4;
    SIZETOPBOT = SIZE_MAP*6+6;
    NOTHING = 0;
    UP = 'w';
    RIGHT = 'd';
    LEFT = 'a';
    DOWN = 's';
type 
    type_vector = array [0..SIZE_MAP] of integer;
    type_game = record 
 lin,col:integer;
 map: array [1..SIZE_MAP,0..SIZE_MAP] of integer;
 score:integer;
    end;
    type_coord = record
 lin,col:integer;
    end;

var 
    game:type_game;
    end_game,movement:boolean;

procedure Create_Number(var game:type_game);
var 
    number:integer;
    RanP:type_coord;
begin
    randomize;
    if random(9) = 1 then
 number:=num4
    else
 number:=num2;
    RanP.lin:=random(game.lin)+1;
    RanP.col:=random(game.col)+1;
    while game.map[RanP.lin,RanP.col] <> NOTHING do 
 begin
     RanP.lin:=random(game.lin)+1;
     RanP.col:=random(game.col)+1;
 end;
    game.map[RanP.lin,Ranp.Col]:=number;
end;

procedure initializing_game(var game:type_game);
var i,j:integer;
begin
    game.lin:=SIZE_MAP;
    game.col:=SIZE_MAP;
    game.score:=0;
    for i:=1 to game.lin do
 for j:=1 to game.col do
     game.map[i,j]:=NOTHING;

    Create_Number(game);
    Create_Number(game);
end;

function CountDigit(number:integer): integer;
var
  CountDigit1: integer;
begin
  if number <> 0 then
  begin
    CountDigit1 := 0;
    while number <> 0 do
    begin
      CountDigit1 := CountDigit1 + 1;
      number := number div 10;
    end;
    CountDigit := CountDigit1;
  end
  else
    CountDigit := 1;
end;

procedure print_number(number: integer);
var
  k, cl, hwdigit: integer;
begin
  if number > 0 then
  begin
    cl := Trunc(LogN(2, number));
    cl := cl mod 20;
  end
  else
    cl := 0;
  
  hwdigit := CountDigit(number);
  for k := 1 to 5 - hwdigit do
  begin
    TextBackground(cl);
    write(' ');
  end;
  TextBackground(0);
  write(number);
  TextBackground(cl);
  write(' ');
end;
procedure print_line(lengthL:integer; ch:string);
var i:integer;
begin
 TextBackground(3); 
    write('+');
 TextBackground(0); 
    for i:=1 to (lengthL-2) do
 begin
    TextBackground(3); 

     if i mod 7 = 0 then
  write('+')
     else
     begin
        TextBackground(3); 
        write(ch);
        TextBackground(0); 

    end;
    end;
     TextBackground(0); 

    writeln;
end;

procedure print_map(var game:type_game);
var i,j:integer;
begin
    print_line(SIZETOPBOT,'-');
    for i:=1 to game.lin do
 begin
      TextBackground(3);
     write('|');
        TextBackground(0);
     for j:=1 to game.col do
  if game.map[i,j] >= 0 then
      begin
   print_number(game.map[i,j]);
        TextBackground(3);
        write('|');
      
        TextBackground(0);
        end;
     writeln;
     print_line(SIZETOPBOT,'-');
 end;
 
        TextBackground(0);
end;

function CanMove(var v_lin:type_vector; i:integer):integer;
begin
    if v_lin[i-1] = NOTHING then
        CanMove:=1
    else if v_lin[i] = v_lin[i-1] then
        CanMove:=2
    else
        CanMove:=0;
end;

function MoveAndSum(var game:type_game; var v_lin:type_vector; size:integer):boolean;
var
    i,e,ResultM:integer;
    v:type_vector;
begin
    MoveAndSum:=FALSE;
    for i:=1 to size do
        v[i]:=0;

    for i:=2 to size do
        begin
     if v_lin[i] <> 0 then
  begin
      e:=i;
      ResultM:=CanMove(v_lin,e);
      while (ResultM <> 0)and(e>1) do
   begin
       case ResultM of
    1:begin
        v_lin[e-1]:=v_lin[e];
        v_lin[e]:=NOTHING;
    end;
    2:begin
        if v[e] = 0 then 
     begin
         v_lin[e-1]:=v_lin[e-1]*num2;
         game.score:=game.score+v_lin[e-1];
         v_lin[e]:=NOTHING;
         v[e-1]:=1;
     end;
    end;
       end;
       e:=e-1;
       ResultM:=CanMove(v_lin,e);
   end;
      if e <> i then
   MoveAndSum:=TRUE;
      v[e-1]:=1;
  end;
        end;
end;

function move_left(var game:type_game):boolean;
var 
    i,j:integer;
    v:type_vector;
begin
    move_left:=FALSE;
    for i:=1 to game.lin do
 begin
     for j:=1 to game.col do
  v[j]:=game.map[i,j];

     if MoveAndSum(game,v,game.lin) then
  move_left:=TRUE;

     for j:=1 to game.col do
  game.map[i,j]:=v[j];
 end;
end;

function move_right(var game:type_game):boolean;
var 
    i,j,k:integer;
    v:type_vector;
begin
    move_right:=FALSE;
    for i:=1 to game.lin do
 begin
     k:=1;
     for j:=game.col downto 1 do
  begin
      v[k]:=game.map[i,j];
      k:=k+1;
  end;
     if MoveAndSum(game,v,game.lin) then
  move_right:=TRUE;
     k:=1;
     for j:=game.col downto 1 do
  begin
      game.map[i,k]:=v[j];
      k:=k+1;
  end;
 end;
end;

function move_down(var game:type_game):boolean;
var 
    i,j,k:integer;
    v:type_vector;
begin
    move_down:=FALSE;
    for j:=1 to game.col do
 begin
     k:=1;
     for i:=game.lin downto 1 do
  begin
      v[k]:=game.map[i,j];
      k:=k+1;
  end;
     if MoveAndSum(game,v,game.lin) then
  move_down:=TRUE;
     k:=1;
     for i:=game.lin downto 1 do
  begin
      game.map[k,j]:=v[i];
      k:=k+1;
  end;
 end;
end;

function move_up(var game:type_game):boolean;
var 
    i,j,k:integer;
    v:type_vector;
begin
    move_up:=FALSE;
    for j:=1 to game.col do
    begin
        k:=1;
        for i:=1 to game.lin do
        begin
            v[k]:=game.map[i,j];
            k:=k+1;
        end;
        if MoveAndSum(game,v,game.lin) then
        begin
            move_up:=TRUE;
            k:=1;
            for i:=1 to game.lin do
            begin
                game.map[i,j]:=v[k];
                k:=k+1;
            end;
        end;
    end;
end;

function CheckWinLose(var game: type_game): integer;
var i, j, CheckWinLose1: integer;
begin
  with game do
  begin
    CheckWinLose1 := 1;
    i := 1;
    while (i <= game.lin) and (CheckWinLose1 <> 2) do
    begin
      j := 1;
      while (j <= game.col) and (CheckWinLose1 <> 2) do
      begin
        if map[i, j] = 1111111111 then
          CheckWinLose1 := 2
        else if map[i, j] = NOTHING then
          CheckWinLose1 := 0
        else
        begin
          if (j < game.col) and (map[i, j] = map[i, j + 1]) then
            CheckWinLose1 := 0
          else if (j > 1) and (map[i, j] = map[i, j - 1]) then
            CheckWinLose1 := 0
          else if (i < game.lin) and (map[i, j] = map[i + 1, j]) then
            CheckWinLose1 := 0
          else if (i > 1) and (map[i, j] = map[i - 1, j]) then
            CheckWinLose1 := 0;
        end;
        j := j + 1;
      end;
      i := i + 1;
    end;
  end;
  CheckWinLose := CheckWinLose1;
end;

begin
    movement:=false;
    end_game:=false;
    initializing_game(game);
    repeat 
 ClrScr;
 if movement then
     Create_Number(game);
 movement:=false;

 writeln('Очки: ',game.score);
 writeln('Управление wasd');
 print_map(game);

 case CheckWinLose(game) of
     1:begin
  print_line(SIZETOPBOT,'-');
  writeln('|         Game Over!        |');
  print_line(SIZETOPBOT,'-');
  end_game:=TRUE;
     end;
     2:begin
  print_line(SIZETOPBOT,'-');
  writeln('|          You Win!         |');
  print_line(SIZETOPBOT,'-');
  end_game:=TRUE;
     end;
 end;

 repeat 
 until KeyPressed;
 case ReadKey of
     'w':movement:=move_up(game);
      'd':movement:=move_right(game); 
      'a':movement:=move_left(game);
      's':movement:=move_down(game);
   #27:end_game:=true;
 end;
    until end_game;
end.
