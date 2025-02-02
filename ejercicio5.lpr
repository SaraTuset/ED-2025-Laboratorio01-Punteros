program ejercicio5;

const
  MAX = 3;

type {Declara un tipo coordenada_3D para puntos con coordenadas x,y,z}
  Coordenada_3D = record
    x:Integer;
    y:Integer;
    z:Integer;
  end;

  TPCoord = ^Coordenada_3D;

var {Declara un array de MAX punteros a coordenadas_3D}
  mi_array : array [0..MAX] of TPCoord;

{Implementa un subprograma que permita añadir una coordenada en la primera
 posición libre del array}
 procedure annadir_coordenada(var mi_array: array of TPCoord; cord: Coordenada_3D);
 var
   encontrada_posicion : boolean;
   i: Integer;
 begin
   encontrada_posicion:=False;
   i := 0;
   while not encontrada_posicion do
     if mi_array[i] = nil then
       begin
         encontrada_posicion:= True;
         new(mi_array[i]);
         mi_array[i]^ := cord;
       end
     else
       i += 1;
 end;

function coordenada_al_azar(): Coordenada_3D;
begin
  Randomize();
  coordenada_al_azar.x := Random(100);
  coordenada_al_azar.y := Random(100);
  coordenada_al_azar.z := Random(100);
end;

{Implementa un subprograma que libere la memoria asignada a una posición}
procedure liberar_memoria(var mi_array: array of TPCoord; i: Integer);
begin
  if mi_array[i] > nil then
    begin
        Dispose(mi_array[i]);
        mi_array[i] := nil
    end;
end;

{Implementa una función que sume todas las x}
function suma_las_x(mi_array: array of TPCoord): Integer;
var
  acc: Integer;
  i: Integer;
begin
  acc := 0;
  for i:= 0 to MAX do
     if mi_array[i] > nil then
       acc += mi_array[i]^.x;
  suma_las_x := acc;
end;

{Implementa un subprograma que calcule la máxima coordenada y (debes comprobar
antes,pues puede que alguna posición no tenga coordenada y esté a NIL)}
function mayor_y(mi_array: array of TPCoord): Integer;
var
  mayor: Integer;
  i: Integer;
begin
  mayor := 0;
  for i := 0 to MAX do
     if mi_array[i] > nil then
       if mi_array[i]^.y > mayor then
         mayor := i;
  mayor_y := mayor;
end;

begin
  {Crea una coordenada_3D en cada una de las posiciones inicializado
  todas las coordenadas con números aleatorios}
  annadir_coordenada(mi_array, coordenada_al_azar());
  annadir_coordenada(mi_array, coordenada_al_azar());
  annadir_coordenada(mi_array, coordenada_al_azar());
  liberar_memoria(mi_array,1);
  WriteLn(suma_las_x(mi_array));
  WriteLn(mayor_y(mi_array));
  liberar_memoria(mi_array, 0);
end.

