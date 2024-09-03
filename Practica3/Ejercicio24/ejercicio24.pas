program Ejercicio24;

Uses SysUtils;

(*Ej 24) En un archivo se han grabado palabras, separadas por uno o más blancos en una misma línea,
finalizando con un punto. Cada palabra está conformada por letras y dígitos (3ab4c3Hd).
Se pide, a partir del archivo descripto generar otro cambiando las parejas “LetraminusculaDigito” por las
repeticiones de la Letra según indique el digito.

Ejemplos: 
    ab4C3hd 1Ab2c3hD2. -> abbbbC3hd 1AbbccchD2.
    Ab0C3hd 1Ab2c0hD2. -> AC3hd 1AbbhD2. 
*)

var
    archEntrada, archSalida:text;
    caracter, caracterAnt:char;
    palabra: string;
    i: byte;

begin
    Assign(archEntrada, 'datos.TXT');
    Assign(archSalida, 'salida.TXT');
    reset(archEntrada);
    Rewrite(archSalida);

    while not eof(archEntrada) do
        begin
            palabra := '';
            Repeat
                read(archEntrada, caracterAnt);
            Until ((caracterAnt <> ' ')) Or (eof(archEntrada)) Or (eoln(archEntrada));

            while ((caracter <> ' ')) and (not eoln(archEntrada)) and (not eof(archEntrada)) do
                begin
                    
                    if caracterAnt in ['a'..'z'] then
                        begin
                            
                            Read(archEntrada, caracter);

                            if (caracter in ['a'..'z']) then
                                begin
                                    Repeat
                                        palabra := palabra + caracterAnt;
                                        caracterAnt := caracter;
                                        Read(archEntrada, caracter);
                                    Until Not (caracter In ['a'..'z']);
        
                                end;

                            if caracter in ['1'..'9'] then                            
                                Begin
                                    For i:=1 To StrToInt(caracter) Do
                                        palabra := palabra + caracterAnt;
                                End
                            else 
                                if caracter = '0' then
                                    begin
                                        Read(archEntrada, caracter);
                                        palabra := palabra + caracter;
                                    end
                                else 
                                    palabra := palabra + caracterAnt + caracter;
                        end
                    else 
                        palabra := palabra + caracterAnt;

                    if ((caracter = ' ')) or (eof(archEntrada)) Or (eoln(archEntrada)) then
                        begin
                            repeat
                                Read(archEntrada, caracter);
                            until ((caracter <> ' ')) Or (eof(archEntrada)) Or (eoln(archEntrada));
                            caracterAnt:= caracter;
                        end
                    else
                        read(archEntrada, caracterAnt);
                end;
            WriteLn(archSalida, palabra);
            
        end;
    Close(archEntrada);
    close(archSalida);
end.