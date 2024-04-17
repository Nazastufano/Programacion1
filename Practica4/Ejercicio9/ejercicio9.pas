program Ejercicio9;

(*Ej 9) Dado un archivo que contiene en cada línea 4 números (N1, D1, N2, D2) numerador y denominador
de dos fracciones. Se pide leer los pares de fracciones y por cada uno de ellos informe:
a) La suma como fracción.
b) El producto como fracción.*)

function SumaFraccion(n1,d1,n2,d2: integer):real;
    var
        resultado: real;

    begin
        resultado := ((n1/d1) + (n2/d2));
        SumaFraccion := resultado;
    end;

function ProducFraccion(n1,d1,n2,d2: integer):real;
    var
        resultado: real;

    begin
        resultado := ((n1/d1)*(n2/d2));
        ProducFraccion := resultado;
    end;

var
    arch:text;
    n1,n2,d1,d2: integer;
    resultado: real;

begin
    assign(arch, 'datos.TXT');
    reset(arch);
    read(arch, n1, d1, n2, d2);
    
    while not eof(arch) do
        begin
            resultado := SumaFraccion(n1, d1, n2, d2);
            writeln('La suma como fraccion es: ', resultado:0:2);

            resultado := ProducFraccion(n1, d1, n2, d2);
            writeln('El producto como fraccion es: ', resultado:0:2);

            read(arch, n1, d1, n2, d2);
        end;
    close(arch);
end.