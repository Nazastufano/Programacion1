program Ejercicio19;

(*Ej 19) Hacer un programa que dada una fracción (numerador y denominador) la simplifique usando la
función MCD. *)

function MCD(num1,num2:word):word;
var
    i,tope:Word;
begin
    MCD := 1;
    if num1>num2 then
        tope:= num2
    else
        tope:= num1;

    for i := tope downto 1 do
        begin
            if ((num1 mod i) = 0) and ((num2 mod i) = 0) and (i>MCD) then
                MCD := i;
        end;
end;

function Simplificar(n, num1, num2:word):real;
begin
    Simplificar:= n/MCD(num1,num2);
end;

var
    numerador, denominador:word;
begin
    WriteLn('Ingrese el numerador y el denominador separados por un enter: ');
    ReadLn(numerador, denominador);

    WriteLn('La division: ', numerador, '/', denominador, ' simplificada usando MCD es: ', Simplificar(numerador, numerador,denominador):0:0,'/',Simplificar(denominador, numerador,denominador):0:0);
end.