program Ejercicio1;

(* Ej 1) La siguiente función calcula la potencia n-ésima de 
un número X (X^n) en forma iterativa, siendo n y X enteros. 
Se pide:
    a) Desarrollarla en forma recursiva.
    b) Considerar n negativo.

function potencia(X,n: integer): integer; //X elevado a n 
var
    i: integer;
    mult: integer;
begin
    mult := 1; //inicialización
    for i := 1 to n do
    mult := mult * X; //hacemos "n" veces "X*X" 
    potencia := mult;
end;
*)

//a)
function potencia(X,n: integer): integer; //X elevado a n 
begin
    if n=0 then
        potencia:= 1
    else
        potencia:= X * potencia(X, n-1);
        
end;

//b)
function potenciaNeg(X,n: integer): real; //X elevado a n 
begin
    if n=0 then
        potenciaNeg:= 1
    else
        if n>0 then
            potenciaNeg:= X * potenciaNeg(X, n-1)
        else
            potenciaNeg:= 1/X*potenciaNeg(X, n+1);
end;

begin
    WriteLn('El resultado de la potencia es: ', Potencia(2,3));
    WriteLn('El resultado de la potencia es: ', PotenciaNeg(2,-3):0:4);
end.