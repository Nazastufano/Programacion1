program Ejercicio18;

(*Ej 18) Desarrollar la Función MCD que devuelve el máximo común divisor entre dos números. *)

function MCD(num1,num2:word):word;
var
    i,tope:Word;
begin
    MCD := 0;
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
var
    numero1,numero2:word;
begin
    WriteLn('Ingrese 2 numeros separados por un enter: ');
    readln(numero1, numero2);
    if MCD(numero1,numero2) = 0 then
        WriteLn('No existe maximo comun divisor entre: ', numero1,' y ', numero2)
    else
        WriteLn('El maximo comun divisor entre: ', numero1,' y ', numero2,' es: ', MCD(numero1,numero2));    
end.