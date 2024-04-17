program Ejercicio22;

(*Ej 22) A partir de un archivo de texto que contiene palabras separadas entre sí por uno o más blancos
desarrollar un programa para:
a) Mostrar la palabra con más cantidad de vocales del texto.
b) Grabar en un texto de salida las palabras con más de cuatro letras pero escritas al revés.
c) Contar cuántas son palíndromas (capicúas). 
*)
var
    arch: text;
    caracter: char;
    cadena, palMasVoca:string;
    contVocales,maxVocal: integer;
begin
    assign(arch, 'datos.TXT');
    reset(arch);
    //a)
    while (not eoln(arch)) do
        begin
            cadena := '';
            contVocales := 0;
            
            if caracter = ' ' then
                read(arch, caracter)
            else
                begin
                    while (caracter <> ' ') and (not eoln(arch)) do
                        begin
                            if caracter in ['a', 'e', 'i', 'o', 'u', 'A', 'E', 'I', 'O', 'U'] then
                                contVocales := contVocales + 1;
                            cadena := cadena + caracter;
                            read(arch, caracter);
                        end;
                end;

            if maxVocal<contVocales then
                begin
                    maxVocal := contVocales;
                    palMasVoca := cadena;
                end;
            read(arch, caracter);
        end;
    writeln('La palabra con mas cantidad de vocales del texto es: ', palMasVoca);
end.