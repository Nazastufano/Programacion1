program Ejercicio3;

(*Ej 3) Dado un número natural N, calcular
y mostrar la suma de los N primeros números naturales. *)

Function Suma(n: word): word;
     var
          i, res: word;

     begin
          res:= 0;
          begin
               for i:=n downto 1 do
                    begin
                         res:= res + i;
                    end;
               Suma := res;
          end;
     end;

var
     numero: word;

begin
     writeln('Ingrese un numero positivo para sumar');
     readln(numero);
     
     writeln('La suma de los numeros es: ', Suma(numero));
     readln();
end.

