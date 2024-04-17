program Ejercicio4;

(*Ej 4) Desarrollar una función que calcule la potencia n-ésima de un número X (X^n). *)

uses
    math;

function Potencias(x,n: real):real;
    var
        resultado: real;
    begin
        resultado := power(x,n);
        Potencias := resultado;
    end;

var
    base, exponenete: real;

begin
    writeln('Ingrese un numero base: ');
    readln(base);

    writeln('Ingrese un exponente: ');
    readln(exponenete);

    writeln(Potencias(base,exponenete):0:2);
end.