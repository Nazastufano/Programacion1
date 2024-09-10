Program Ejercicio16;

(*Ej 16) Mediante una función booleana determinar si un número es capicúa*)

function Capicua(num:word):Boolean;

Var 
    Original, Reverso, Resto:   word;
Begin
    Reverso := 0;
    Original := num;

    While num > 0 Do
        Begin
            Resto := num Mod 10;
            Reverso := Reverso * 10 + Resto;
            num := num Div 10;
        End;

    Capicua:= original = reverso;
end;
var
    numero:word;
begin
    Writeln('Ingrese un numero: ');
    ReadLn(numero);

    if Capicua(numero) then
        WriteLn('El numero: ', numero, ' es capicua')
    else
        WriteLn('El numero: ', numero, ' no es capicua');
end.