program Ejercicio22;
//uses crt;
(*Ej 22) A partir de un archivo de texto que contiene palabras separadas entre sí por uno o más blancos
desarrollar un programa para:
a) Mostrar la palabra con más cantidad de vocales del texto.
b) Grabar en un texto de salida las palabras con más de cuatro letras pero escritas al revés.
c) Contar cuántas son palíndromas (capicúas). 
*)
var
    archEntrada, archSalida: text;
    caracter: char;
    cadena, palMasVoca, palabraInvertida:string;
    contVocales, maxVocal, contPalindromas: byte;
    
begin
    //clrscr;
    assign(archEntrada, 'datos.TXT');
    Assign(archSalida, 'salida.TXT');
    reset(archEntrada);
    Rewrite(archSalida);

    contPalindromas := 0;
    
    while (not eof(archEntrada)) do
        begin
            cadena := '';
            palabraInvertida := '';
            contVocales := 0;
            
            repeat
                read(archEntrada, caracter);
            until (caracter <> ' ') or (eof(archEntrada)) or (eoln(archEntrada));
            
            while (caracter <> ' ') and (not eof(archEntrada)) and (not eoln(archEntrada)) do
                begin
                    if upcase(caracter) in ['A', 'E', 'I', 'O', 'U'] then
                        contVocales := contVocales + 1;
                    cadena := cadena + caracter;
                    palabraInvertida := caracter + palabraInvertida;
                    read(archEntrada, caracter);
                end;
            
            cadena := lowerCase(cadena);
            palabraInvertida := lowerCase(palabraInvertida);
            //b)
            if contVocales > 4 then
                Writeln(archSalida, palabraInvertida);
            //c)
            if palabraInvertida = cadena then
                contPalindromas := contPalindromas + 1;
                
            if maxVocal<contVocales then
                begin
                    maxVocal := contVocales;
                    palMasVoca := cadena;
                end;
        end;
    Close(archEntrada);
    Close(archSalida);
    writeln('La palabra con mas cantidad de vocales del texto es: ', palMasVoca); //a)
    WriteLn('La cantidad de polindromas es: ', contPalindromas);
end.