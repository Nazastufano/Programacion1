program Ejercicio15;

(* Ej 15) A partir de un archivo de texto que contiene una secuencia de caracteres terminada en punto,
desarrollar un programa para cada item:
a) Cuántas palabras comienzan con una letra que ingresa por teclado.
b) Cuántas palabras contienen una letra que ingresa por teclado. 
*)

var
    arch:text;
    caracter:char;
    letra: string[1];
    palabra: string;
    contadorComienzanCon, contadorContienen: word;

begin
    contadorComienzanCon := 0;
    contadorContienen := 0;

    assign(arch, 'datos.TXT');
    reset(arch);

    writeln('Ingrese un caracter: ');
    readln(letra);

    while (NOT eof(arch)) do
        begin
            palabra := '';
            
            repeat
                read(arch, caracter);
                palabra := palabra + caracter;
            until ((caracter = ' ') or (caracter = '.'));

            if (UpCase(letra) = UpCase(palabra[1])) then
                contadorComienzanCon := contadorComienzanCon + 1;

            if Pos(UpCase(letra), UpCase(palabra)) > 0 then
                contadorContienen := contadorContienen + 1;
        end;

    close(arch);
    writeln('Cantidad de palabras que comienzan con la letra ', letra, ': ', contadorComienzanCon);
    writeln('Cantidad de palabras que contienen la letra ', letra, ': ', contadorContienen);
end.