Program Ejercicio4;

(*Ej 4) Desarrollar una función que calcule la potencia n-ésima de un número X (X^n). *)

function Potencia(x:integer; n:integer): real;
var
    i: byte;
    res:Integer;
begin
    res:=1;
    for i:=1 to abs(n) do
        begin
            res:= x*res;
        end;
    
    if n>=0 then
        Potencia := res
    else
        Potencia := (1/res);
end;

var
    num, expo:integer;
    

begin
    WriteLn('Ingrese la base: ');
    ReadLn(num);
    WriteLn('Ingrese el exponente: ');
    ReadLn(expo);

    WriteLn('El resultado es: ', Potencia(num,expo):0:3);

end.