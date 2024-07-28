program Minesweeper;
uses crt;
const
  GRID_SIZE = 10;
  NUM_MINES = 10;

type
  TCell = record
    isMine: boolean;
    mineCount: integer;
    isRevealed: boolean;
  end;

var
  grid: array[0..GRID_SIZE-1, 0..GRID_SIZE-1] of TCell;
  revealedCells: set of 0..GRID_SIZE*GRID_SIZE-1;


procedure InitializeGrid;
var
  i, j, newX, newY, dx, dy, mineCount: integer;
begin
  Randomize;
  for i := 0 to GRID_SIZE-1 do
    for j := 0 to GRID_SIZE-1 do
    begin
      grid[i, j].isMine := false;
      grid[i, j].mineCount := 0;
      grid[i, j].isRevealed := false;
    end;

  mineCount := 0;
  while mineCount < NUM_MINES do
  begin
    i := Random(GRID_SIZE);
    j := Random(GRID_SIZE);
    if not grid[i, j].isMine then
    begin
      grid[i, j].isMine := true;
      inc(mineCount);
    end;
  end;

  for i := 0 to GRID_SIZE-1 do
    for j := 0 to GRID_SIZE-1 do
      if not grid[i, j].isMine then
        for dy := -1 to 1 do
          for dx := -1 to 1 do
          begin
            newX := i + dx;
            newY := j + dy;
            if (newX >= 0) and (newX < GRID_SIZE) and (newY >= 0) and (newY < GRID_SIZE) and grid[newX, newY].isMine then
              inc(grid[i, j].mineCount);
          end;
end;
procedure RevealCell(x, y: integer);
var
  i, j, newX, newY: integer;
begin
  if (x >= 0) and (x < GRID_SIZE) and (y >= 0) and (y < GRID_SIZE) and not grid[x, y].isRevealed then
  begin
    grid[x, y].isRevealed := true;
    Include(revealedCells, x + y * GRID_SIZE);
    if grid[x, y].isMine then
    begin
      Writeln('Game Over!');
      Exit;
    end
    else if grid[x, y].mineCount = 0 then
    begin
      for i := -1 to 1 do
        for j := -1 to 1 do
        begin
          newX := x + i;
          newY := y + j;
          if (newX >= 0) and (newX < GRID_SIZE) and (newY >= 0) and (newY < GRID_SIZE) and not grid[newX, newY].isRevealed then
            RevealCell(newX, newY);
        end;
    end;
  end;
end;

procedure DrawGrid;
var
  i, j: integer;
begin
  ClrScr;
  // Вывод верхней границы
  Write('  ');
  for i := 0 to GRID_SIZE-1 do
    Write(i, ' ');
  Writeln;
  Write('+');
  for i := 0 to GRID_SIZE * 2 do
    Write('-');
  Writeln('+');

  // Вывод сетки
  for j := 0 to GRID_SIZE-1 do
  begin
    // Вывод номера строки
    Write(j, '|');

    // Вывод клеток
    for i := 0 to GRID_SIZE-1 do
    begin
      if grid[i, j].isRevealed then
      begin
        if grid[i, j].isMine then
          Write('*')
        else if grid[i, j].mineCount = 0 then
          Write(' ')
        else
          Write(grid[i, j].mineCount);
      end
      else
        Write('.');
      Write('|');
    end;

    Writeln;

    // Вывод нижней границы
    if j < GRID_SIZE-1 then
    begin
      Write('+');
      for i := 0 to GRID_SIZE * 2 do
        Write('-');
      Writeln('+');
    end;
  end;

  // Вывод нижней границы
  Write('+');
  for i := 0 to GRID_SIZE * 2 do
    Write('-');
  Writeln('+');
end;

function IsGameWon: boolean;
var
  i, j: integer;
  allRevealed: boolean;
begin
  allRevealed := true;
  for i := 0 to GRID_SIZE-1 do
    for j := 0 to GRID_SIZE-1 do
      if not grid[i, j].isMine and not grid[i, j].isRevealed then
      begin
        allRevealed := false;
        break;
      end;
  IsGameWon := allRevealed;
end;

var
  x, y: integer;
  input: string;
  valid: boolean;
  pos: integer;
begin
  InitializeGrid;
  repeat
    DrawGrid;
    Writeln('Enter cell (e.g. 88):');
    ReadLn(input);
    valid := (Length(input) = 2) and (input[1] in ['0'..'9']) and (input[2] in ['0'..'9']);
    if valid then
    begin
      val(input, pos, x);
      y := pos div GRID_SIZE;
      x := pos mod GRID_SIZE;
      if (x >= 0) and (x < GRID_SIZE) and (y >= 0) and (y < GRID_SIZE) then
        RevealCell(x, y)
      else
        Writeln('Invalid cell coordinates. Try again.');
    end
    else
      Writeln('Invalid input. Try again.');
  until (x < 0) or (y < 0) or (grid[x, y].isMine) or IsGameWon;

  if IsGameWon then
    Writeln('Congratulations! You won the game.')
  else
    Writeln('Game Over!');
end.