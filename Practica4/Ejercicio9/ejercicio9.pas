program Ejercicio9;

(*Dado un archivo que contiene en cada línea 4 números (N1, D1, N2, D2) numerador y denominador
de dos fracciones. Se pide leer los pares de fracciones y por cada uno de ellos informe:
a) La suma como fracción. 
b) El producto como fracción.*)

function SumaFraccion(n1,d1,n2,d2:integer):real;
begin
    SumaFraccion:= (n1*d2+n2*d1)/(d1*d2);
end;

function ProducFraccion(n1,d1,n2,d2:integer): real;
begin
    ProducFraccion:= (n1*n2)/(d1*d2);
end;

var
    arch: Text;
    num1, div1, num2, div2: integer;

begin
    Assign(arch, 'datos.txt');
    Reset(arch);
    
    while not eof(arch) do
        begin
            readln(arch, num1, div1, num2, div2);
            WriteLn('La suma como fraccion de: ', num1,'/', div1, ' + ', num2, '/', div2, ' es: ', SumaFraccion(num1, div1, num2, div2):0:2);
            WriteLn('El producto como fraccion de: ', num1,'/', div1,' x ', num2,'/', div2, ' es: ', ProducFraccion(num1, div1, num2, div2):0:2);
        end;
    close(arch);
end.