program ejercicio3;

type { Declara un tipo de registro llamado “nodo”
     con dos campos: un entero y un puntero a “nodo”.}
  nodo= record
    num: Integer;
    puntero: ^nodo;
  end;

var {Declara una variable de tipo puntero a nodo}
  p : ^nodo;

begin
  {Crea un nodo en memoria dinámica (heap)}
  new(p);
  {Dale valor 100 al campo entero de este nodo}
  p^.num := 100;
  {Pon a nil el campo puntero del nodo}
  p^.puntero:= nil;
  {Pon ahora el puntero del nodo a apuntar al propio nodo}
  p^.puntero := p;
  {liberar la memoria dinámica creada}
  Dispose(p);
end.

