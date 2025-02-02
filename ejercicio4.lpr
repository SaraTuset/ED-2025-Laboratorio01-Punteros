program ejercicio4;

{$mode objfpc}{$H+}

const
  MAX = 3;

type
  TPEntero = ^Integer;

var   {Declarar un array de MAX punteros a enteros}
   mi_array : array [0..MAX] of TPEntero;
   i : Integer;

{ Implementa un procedimiento que muestre por pantalla el contenido de cada posición}
procedure ver_array(mi_array: array of  TPEntero);
begin
  for i := 0 to MAX do
      WriteLn(mi_array[i]^);
end;

{Implementa un procedimiento que ponga a cero todos los números}
procedure todo_a_cero(var mi_array: array of  TPEntero);
begin
    for i:= 0 to MAX do
        mi_array[i]^ := 0;
end;

{ Implementa un subprograma que ponga todos los punteros que no lo estén, a NIL}
procedure vaciar_array(var mi_array: array of  TPEntero);
begin
    for i := 0 to MAX do
        if mi_array[i] > nil then
        begin
             dispose(mi_array[i]);
             mi_array[i] := nil
        end;
end;

{Implementa una función que calcule el máximo número del array (debes comprobar antes, pues
 puede que alguna posición no tenga un número y esté a NIL)}
function maximo(mi_array: array of  TPEntero):Integer;
var max: Integer;
begin
    max := 0;
    for i:= 0 to MAX do
        begin//Solo se recorre una vez y no sé por qué
          if mi_array[i] > nil then
             if mi_array[i]^ > max then
                max := mi_array[i]^;
        end;
    maximo := max;
end;

{ Implementa una función que compute la suma de todos los enteros (de nuevo
 asegúrate de no intentar sumar los que estén a NIL)}
function suma(mi_array: array of  TPEntero):Integer;
var
   acc : Integer;
begin
    acc := 0;
    for i:=0 to MAX do
       if mi_array[i] > nil then
          acc +=  mi_array[i]^;
    suma := acc;
end;

begin
  {Crea un entero en cada una de las posiciones inicializado
  a un número aleatorio}
  Randomize();
  for i:= 0 to MAX do
      new(mi_array[i]);
      mi_array[i]^ := Random(100);

  //Probando
  ver_array(mi_array);
  WriteLn(maximo(mi_array));
  WriteLn(suma(mi_array));
  todo_a_cero(mi_array);     //Este punto de interrupción me permite ver si todo se ha escrito correctamente
  ver_array(mi_array);
  vaciar_array(mi_array);
end.

