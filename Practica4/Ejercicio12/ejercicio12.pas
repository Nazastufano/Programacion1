program Ejercicio12;

(*Ej 12) Los dos primeros términos de la sucesión de Fibonacci valen 1, y los demás se hallan sumando los
dos anteriores: 1, 1, 2, 3, 5, 8,13, 21…
Desarrolle un programa que lea N cotas enteras positivas, y para cada una de ellas genere y muestre los
términos de la sucesión hasta superar la cota dada.*)

uses
    SysUtils;

function Fibonacci(cota:integer): string;
    var
        a, b, c:integer;
        resultado: string;

    begin
        a:=1;
        b:=1;
        resultado := '';

        while c <= cota do
            begin
                a := b;
                b := c;
                c := a + b;
                if c <= cota then
                    resultado := resultado + IntToStr(c) + ', '
                else
                    begin
                        resultado := resultado + IntToStr(c) + '.';
                    end;
            end;
        Fibonacci := resultado;
    end;

var
    i, cotas, cota: integer;

begin
    repeat
        writeln('Cuantas cotas desea ingresar? ');
        readln(cotas);    
    until (cotas>0);

    for i := 1 to cotas do
        begin
            repeat
                writeln('Ingrese el numero a alcanzar: ');
                readln(cota);
            until (cota>0);
            
            writeln(Fibonacci(cota));
        end;    
end.