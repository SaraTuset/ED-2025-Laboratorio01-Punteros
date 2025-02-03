{Isla de las tentaciones zodiacal}
program ejercicio6;

const
  NUM_PAREJAS = 5; //Cambia crear_perfil si lo aumentas
  NUM_PARTICIPANTES = 2 * NUM_PAREJAS + NUM_PAREJAS div 2;

type
  TipoParticipante = (tentador, pareja);
  TPParticipante = ^Participante;
  {crear un registro Participante}
  Participante = record
    nombre: String;
    edad: Integer;
    rol: TipoParticipante;
    otroParticipante: TPParticipante;
  end;

  TAParticipantes= array[1..NUM_PARTICIPANTES] of TPParticipante;
  TADe3 = array[0..2] of TPParticipante;

var
  participantes: TAParticipantes ;
  ronda: Integer;
  opt: String;

{Implementa un procedimiento para crear un participante}
procedure crear_participante(nombre: String; edad: Integer; rol: TipoParticipante; i:Integer);
begin
if participantes[i] = nil then
  begin
    new(participantes[i]);
    participantes[i]^.nombre:= nombre;
    participantes[i]^.edad:= edad;
    participantes[i]^.rol:= rol;
    participantes[i]^.otroParticipante:= nil;
  end
else
    WriteLn('Se ha producido un error.');
end;

{Implementa un procedimiento para establecer la pareja de un participante}
procedure establecer_pareja(var persona1: Participante; var persona2: Participante);
begin
   persona1.otroParticipante:= @persona2;
   persona2.otroParticipante:= @persona1;
end;

{Implementa un procedimiento que muestre el estado actual de la isla, incluyendo
para cada participante}
procedure estado_de_la_isla();
var
  i: Integer;
begin
   WriteLn('Estado de la isla en la ', ronda, ' ronda:');
   for i:= 1 to NUM_PARTICIPANTES do
       begin
            WriteLn(participantes[i]^.nombre);
            if participantes[i]^.rol = pareja then
               if participantes[i]^.otroParticipante = nil then
                  WriteLn('Sin pareja')
               else if participantes[i]^.otroParticipante^.rol = pareja then
                  WriteLn('Esta con ', participantes[i]^.otroParticipante^.nombre)
               else
                 WriteLn('Infiel')
            else if participantes[i]^.otroParticipante > nil then
               WriteLn('Tento a ', participantes[i]^.otroParticipante^.nombre);
            WriteLn();
       end;
end;

{Selección aleatoria de una pareja para ser tentada y un tentador}
function seleccion_aleatoria_tentacion(): TADe3;
var
  azar_tentadores: Integer;
  azar_parejas: Integer;
  i: Integer;
begin
   Randomize();
   i:= 1;
   azar_tentadores := Random(NUM_PAREJAS div 2) + 1;
   azar_parejas := Random(NUM_PAREJAS) + 1;
   while (azar_parejas > 0) or (azar_tentadores > 0) do
         begin
           if participantes[i]^.rol = pareja then
                begin
                     azar_parejas -= 1;
                     seleccion_aleatoria_tentacion[0] := participantes[i];
                end
           else
               begin
                 azar_tentadores -= 1;
                 seleccion_aleatoria_tentacion[2] := participantes[i];
               end;
           i += 1;
         end;
    seleccion_aleatoria_tentacion[1] := seleccion_aleatoria_tentacion[0]^.otroParticipante;
end;

{se forma una nueva pareja con el tentador}
procedure tentado(tentados: TADe3);
begin
    if tentados[0] = nil then
       begin
            tentados[1]^.otroParticipante^.otroParticipante:= nil;
            tentados[1]^.otroParticipante := tentados[2];
            tentados[2]^.otroParticipante := tentados[1];
            WriteLn(tentados[1]^.nombre, ' cayo en la tentacion.');
       end
    else
        begin
            tentados[0]^.otroParticipante^.otroParticipante:= nil;
            tentados[0]^.otroParticipante := tentados[2];
            tentados[2]^.otroParticipante := tentados[0];
            WriteLn(tentados[0]^.nombre, ' cayo en la tentacion.');
       end;
    WriteLn(tentados[2]^.nombre, ' consiguio su objetivo.');
end;

{Implementa un procedimiento para simular una ronda de tentación}
procedure ronda_de_tentacion();
var
  azar_tentadores: Integer;
  azar_parejas: Integer;
  tentados: TADe3;
begin
   Randomize();
   tentados := seleccion_aleatoria_tentacion();

   {Tentación}
   azar_parejas := Random(2);
   WriteLn(tentados[2]^.nombre ,' no quita los ojos de encima de ', tentados[azar_parejas]^.nombre);
   tentados[(azar_parejas+1) mod 2] := nil;

   azar_tentadores:= Random(4);
   if azar_tentadores = 0 then
      tentado(tentados)
   else
      WriteLn(tentados[2]^.nombre, ' ha sido insultado y humillado.');
end;

procedure crear_perfil(i:Integer; rol:TipoParticipante);
begin
    case i of
        1: crear_participante('Aries', 19, rol, i);
        2: crear_participante('Tauro', 24, rol, i);
        3: crear_participante('Geminis', 20, rol, i);
        4: crear_participante('Cancer', 26, rol, i);
        5: crear_participante('Leo', 22, rol, i);
        6: crear_participante('Virgo', 30, rol, i);
        7: crear_participante('Libra', 21, rol, i);
        8: crear_participante('Escorpio', 28, rol, i);
        9: crear_participante('Sagitario', 25, rol, i);
        10: crear_participante('Capricornio', 32, rol, i);
        11: crear_participante('Acuario', 23, rol, i);
        12: crear_participante('Piscis', 27, rol, i);
    end;
end;

procedure crear_pareja(i:Integer);
var
  su_pareja: Integer;
begin
   Randomize();
   crear_perfil(i, pareja);
   su_pareja := i;
   while participantes[su_pareja] <> nil do
         su_pareja := Random(NUM_PARTICIPANTES +1 - i) + i;
   crear_perfil(su_pareja, pareja);
   establecer_pareja(participantes[i]^, participantes[su_pareja]^);
end;

{Crea un procedimiento para inicializar la isla}
procedure init();
var
  i: Integer;
  cant_parejas:Integer;
  cant_tentadores:Integer;
begin
   i:=1;
   cant_parejas:= 0;
   cant_tentadores := 0;
   Randomize();
   while i<NUM_PARTICIPANTES + 1 do
         begin
           if participantes[i] = nil then   //crea solo si no se a creado
             if Random(2) = 0 then
               if cant_parejas < NUM_PAREJAS then
                 begin
                      crear_pareja(i);
                      cant_parejas += 1;
                 end
               else
                crear_perfil(i, tentador)
             else
               begin
                 if cant_tentadores < (NUM_PAREJAS div 2) then
                   begin
                     crear_perfil(i, tentador);
                     cant_tentadores += 1;
                   end
                 else
                   crear_pareja(i);
               end;
           i += 1;
         end;
end;

begin
  ronda:= 0;
  opt := 'si';
  init();
  WriteLn('Bienvenid@ a las islas de las tentaciones del zodiaco.');
  WriteLn('Estos son los 12 concursantes: ');
  estado_de_la_isla();
  while opt <> 'no' do
        begin
          if opt = 'si' then
            begin
                ronda += 1;
                WriteLn('Estamos en la ', ronda, 'a ronda.');
                ronda_de_tentacion();
                WriteLn();
                estado_de_la_isla();
            end;
          WriteLn('Inserta *si* si deseas seguir otra ronda y *no* si deseas salir.');
          ReadLn(opt);
        end;

end.

{Extras por hacer:
-Hacer compatibilidades (afinidad).
-Hacer dialogos graciosos.
-Hacer estadisticas de infidelidad.
-Hacer eventos especiales.
-Permitir seleccion manual tentación.}
