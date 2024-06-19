uses crt;
var 
  k, i, j, numk, p, c: integer;
  t: string;
  num: array[1..10] of integer;
  num1: array[1..10] of integer;
  num2: array[1..10] of integer;
  tt: array of string;
  
begin
  Write('Количество значений (до 10) - ');
  ReadLn(k);
clrscr;
  for i := 1 to k do
  begin
    num[i] := i;
    num1[i] := 0 ;
    num2[i] := 0 ;
  end;

  for i := 1 to k do
  begin
    Write(num[i], ' ', num1[i], ' ', num2[i]);
    WriteLn;
  end;

  while t <> '00' do
  begin
  
    if (Length(t) mod 2 = 0) and (p = 1) then
    begin
      SetLength(tt, Length(t) div 2);  // Установка длины массива tt
      for i := 0 to Length(tt) - 1 do
      begin
        tt[i] := Copy(t, i * 2 + 1, 2);  // Добавление пары символов в массив tt
      end;

      p := 0;
      
      for i := 0 to Length(tt) - 1 do
      begin
        c:=c+1;
        if tt[i] = '12' then
        begin
          numk := 0 ;
          for j := 1 to k do
          begin
            if num[j] <> 0  then
            begin
              numk := num[j];
              num[j] := 0 ;
              break;
            end;
          end;

          for j := k downto 1 do
          begin
            if num1[j] = 0  then
            begin
              num1[j] := numk;
              break;
            end;
          end;
        end
        else if tt[i] = '13' then
        begin
          numk := 0 ;
          for j := 1 to k do
          begin
            if num[j] <> 0  then
            begin
              numk := num[j];
              num[j] := 0 ;
              break;
            end;
          end;

          for j := k downto 1 do
          begin
            if num2[j] = 0  then
            begin
              num2[j] := numk;
              break;
            end;
          end;
        end
        else if tt[i] = '21' then
        begin
          numk := 0 ;
          for j := 1 to k do
          begin
            if num1[j] <> 0  then
            begin
              numk := num1[j];
              num1[j] := 0 ;
              break;
            end;
          end;

          for j := k downto 1 do
          begin
            if num[j] = 0  then
            begin
              num[j] := numk;
              break;
            end;
          end;
        end
        else if tt[i] = '23' then
        begin
          numk := 0 ;
          for j := 1 to k do
          begin
            if num1[j] <> 0  then
            begin
              numk := num1[j];
              num1[j] := 0 ;
              break;
            end;
          end;

          for j := k downto 1 do
          begin
            if num2[j] = 0  then
            begin
              num2[j] := numk;
              break;
            end;
          end;
        end
        else if tt[i] = '31' then
        begin
          numk := 0 ;
          for j := 1 to k do
          begin
            if num2[j] <> 0  then
            begin
              numk := num2[j];
              num2[j] := 0 ;
              break;
            end;
          end;

          for j := k downto 1 do
          begin
            if num[j] = 0  then
            begin
              num[j] := numk;
              break;
            end;
          end;
        end
        else if tt[i] = '32' then
        begin
          numk := 0 ;
          for j := 1 to k do
          begin
            if num2[j] <> 0  then
            begin
              numk := num2[j];
              num2[j] := 0 ;
              break;
            end;
          end;

          for j := k downto 1 do
          begin
            if num1[j] = 0  then
            begin
              num1[j] := numk;
              break;
            end;
          end;
        end;
      end;
clrscr;
writeln('Количество шагов - ',c);
      for i := 1 to k do
      begin
        Write(num[i], ' ', num1[i], ' ', num2[i]);
        WriteLn;
      end;
    end;

    p := 1;
    ReadLn(t);
  end;
  
end.
