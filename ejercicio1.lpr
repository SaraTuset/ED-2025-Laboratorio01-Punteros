program ejercicio1;

type
  Puntero=^Integer;

var {Declara variable entera (x) y  de tipo puntero a entero (p_ent)}
  x:Integer;
  p_ent: Puntero;

begin
   {Da el valor 100 a x}
   x := 100;
   { Crea un entero dinámicamente con p_ent y dale el valor que tiene actualmente x}
   new(p_ent);
   p_ent^ := x;
   {Imprime por pantalla el valor contenido en el entero al que apunta p_ent}
   WriteLn(p_ent^);

   dispose(p_ent);
   new(p_ent);

   WriteLn(p_ent^);
   dispose(p_ent);
   p_ent := @x;
   p_ent^ += 100;

   WriteLn(x, p_ent^);
   p_ent := nil;
   dispose(p_ent);



end.

