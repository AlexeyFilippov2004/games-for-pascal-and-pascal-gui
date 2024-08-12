program SudokuGame;
uses {sysutils,}crt;
const
  GRID_SIZE = 9;
  BLOCK_SIZE = 3;

type
  TGrid = array[1..GRID_SIZE, 1..GRID_SIZE] of 0..GRID_SIZE;
  TUsedInRow = array[1..GRID_SIZE, 1..GRID_SIZE] of boolean;
  TUsedInCol = array[1..GRID_SIZE, 1..GRID_SIZE] of boolean;
  TUsedInBlock = array[1..GRID_SIZE, 1..GRID_SIZE] of boolean;

var
  Grid: TGrid;
  UsedInRow:TUsedInRow;
  UsedInCol:TUsedInCol;
  UsedInBlock:TUsedInBlock;


function IsCellValid(row, col, value: Integer): boolean;
begin
  if UsedInRow[row, value] or UsedInCol[col, value] or UsedInBlock[((row - 1) div BLOCK_SIZE) * BLOCK_SIZE + ((col - 1) div BLOCK_SIZE) + 1, value] then
    IsCellValid := false
  else
    IsCellValid := true;
end;

procedure InitializeGrid;
var
  i, j: Integer;
begin
  for i := 1 to GRID_SIZE do
    for j := 1 to GRID_SIZE do
    begin
      Grid[i, j] := 0;
      UsedInRow[i, j] := false;
      UsedInCol[i, j] := false;
      UsedInBlock[i, j] := false;
    end;
end;

procedure GenerateGrid;
var
  i, j, k, value, lastValidIndex: Integer;
begin
  InitializeGrid;

  for i := 1 to GRID_SIZE do
  begin
    for j := 1 to GRID_SIZE do
    begin
      lastValidIndex := 0;
      for k := 1 to GRID_SIZE do
      begin
        value := k;
        if IsCellValid(i, j, value) then
        begin
          Grid[i, j] := value;
          UsedInRow[i, value] := true;
          UsedInCol[j, value] := true;
          UsedInBlock[((i - 1) div BLOCK_SIZE) * BLOCK_SIZE + ((j - 1) div BLOCK_SIZE) + 1, value] := true;
          lastValidIndex := k;
          break;
        end;
      end;

      if lastValidIndex = 0 then
        Grid[i, j] := 0;
    end;
  end;
end;

procedure RemoveDigits;
var
  i, j, k, count: Integer;
begin
  count := 0;
  while count < 40 do
  begin
    i := Random(GRID_SIZE) + 1;
    j := Random(GRID_SIZE) + 1;
    if Grid[i, j] <> 0 then
    begin
      Grid[i, j] := 0;
      count := count + 1;
    end;
  end;
end;



procedure PrintGrid;
var
  i, j: Integer;
begin
  Writeln('   123 456 789');
  for i := 1 to GRID_SIZE do
  begin
    if (i - 1) mod BLOCK_SIZE = 0 then
      Writeln('  +---+---+---+');
    Write(i, ' ');

    for j := 1 to GRID_SIZE do
    begin
      if (j - 1) mod BLOCK_SIZE = 0 then
        Write('|');

      if Grid[i, j] = 0 then
        Write('_')
      else
        Write(Grid[i, j]);
    end;
        Write('|');
    Writeln;
  end;
  Writeln('  +---+---+---+');
end;

procedure FillCell;
var
  input: string;
  x, y, val: Integer;
begin
  Write('Enter a 3-digit number (column, row, value): ');
  ReadLn(input);

  if Length(input) <> 3 then
  begin
    Writeln('Invalid input. Please enter a 3-digit number.');
  end;

  x := StrToInt(input[1]);
  y := StrToInt(input[2]);
  val := StrToInt(input[3]);

  if (x < 1) or (x > GRID_SIZE) or (y < 1) or (y > GRID_SIZE) or (val < 1) or (val > GRID_SIZE) then
  begin
    Writeln('Invalid input. Please enter valid values.');
  end;

  if Grid[y, x] <> 0 then
  begin
    Writeln('The cell is already filled. Please try again.');
  end;
  if IsCellValid(y, x, val)=false then
  begin
    Grid[y, x] := val;
  end
  else
  begin
    Writeln('The value is not valid for the given cell. Please try again.');
  end;
end;

begin
  Randomize;
  GenerateGrid;
  RemoveDigits;
  while true do 
  begin
  PrintGrid;  
  FillCell;
  clrscr;
  end;  
end.
