Program Ejercicio17;

(*Ej 17) Mediante una función booleana informar si un número es primo.*)

function Primo(num:word):Boolean;
var
    i:word;
begin
    primo:= true;
    i:= 2;
    while i<sqrt(num) do
    begin
        if (num mod i) = 0 then
            begin
                Primo:= False;
            end;
        i:= i + 1;
    end;
end;

Var 
    numero:   LongWord;
Begin
    Writeln('Ingrese un numero: ');
    ReadLn(numero);

    If Primo(numero) Then
        WriteLn('El numero: ', numero, ' es primo')
    Else
        WriteLn('El numero: ', numero, ' no es primo');
End.
