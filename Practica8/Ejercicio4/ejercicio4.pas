program Ejercicio4;

(*Ej 4) Escribir un subprograma recursivo que retorne una cadena de caracteres recibida como parametro
con su contenido invertido.
    Ejemplo: ‘lamina’ -> ‘animal’ *)
var 
    palabra: string;

function InvertirPalabra(str:string):string;
begin
    
    if length(str) = 1 then
        InvertirPalabra := str
    else
        InvertirPalabra := InvertirPalabra(Copy(str, 2, Length(str) - 1)) + str[1];
end;

begin
    writeln('Ingrese una cadena para invertir');
    readln(palabra);
    writeln(InvertirPalabra(palabra));
end.