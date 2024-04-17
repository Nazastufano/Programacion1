program Ejercicio6;

(*Ej 6) Desarrollar una función que devuelva un número aleatorio en un rango [A, B] con A<B ingresados
por teclado. 
Nota: usar la función Random y Randomize. *)

uses
    SysUtils;

function NumAleatorio(a,b:integer):integer;
    begin
        Randomize;
        NumAleatorio := Random(b - a + 1) + a; 
    end;

var
    num1, num2: integer;

begin
    repeat
        writeln('Ingrese el primer numero: ');
        readln(num1);

        writeln('Ingrese el segundo numero (mayor que el primero): ');
        readln(num2);
    until (num1<num2);
        
    writeln('Numero aleatorio en el rango [', num1, ', ', num2, ']: ', NumAleatorio(num1, num2));
end.