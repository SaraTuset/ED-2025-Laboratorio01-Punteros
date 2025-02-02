program ejercicio2;

type
  TArray = Array [1..3] of Integer;
  TPEntero = ^Integer;

var
  V: TArray;
  p: TPEntero;
  i: Integer;

begin
  {Crea un array de 3 enteros V e inicialízalo con números aleatorios.}
  Randomize;
  for i:= 1 to 3 do
     V[i] := Random(100) + 1;
  {Muestra sus valores por pantalla}
  for i:= 1 to 3 do
     WriteLn(V[i]);
  {Declara un puntero a entero p y ponlo a apuntar a la primera posición del array}
  new(p);
  p := @V[1];

  {Pon el valor 100 en el entero apuntado por p}
  p^ := 100;

  {Muestra los valores del array “V” por pantalla}
  for i:= 1 to 3 do
     WriteLn(V[i]);

  {Recorre con p todas las posiciones del array para ponerlas todas a cero}
  for i:= 1 to 3 do
  begin
     p^ := 0;
     Inc(p); //Para pasar al siguiente puntero
  end;
end.

