program Ejercicio3;

(*Ej 3) Dado un número natural N, calcular
y mostrar la suma de los N primeros números naturales. *)
(*VALIDAR EL INGRESO, repeat until, if n > 0 then*)

Function Suma(n: integer): integer;
          var
               i, res: integer;

          begin
               res:= 0;
               begin
                    for i:=1 to n do
                         begin
                              res:= res + (i-1);
                         end;
                    Suma := res;
               end;
         end;

var
     numero: integer;

begin
     repeat
          writeln('Ingrese un numero positivo para sumar');
          readln(numero);
     until numero>0;
     writeln('La suma de los numeros es: ', Suma(numero));
     readln();
end.

