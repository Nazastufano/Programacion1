program Ejercicio4;

(*Ej 4) Escribir un subprograma recursivo que retorne una cadena de caracteres recibida como parametro
con su contenido invertido.
    Ejemplo: ‘lamina’ -> ‘animal’ *)

function StringInvertido(st:string;largo:byte):string;
begin
    if largo = 0 then
        StringInvertido:= ''
    else
        StringInvertido := st[largo] + StringInvertido(st,largo-1);
end;

var 
    palabra: string;

begin
    writeln('Ingrese una cadena para invertir');
    readln(palabra);
    writeln(StringInvertido(palabra,Length(palabra)));
end.