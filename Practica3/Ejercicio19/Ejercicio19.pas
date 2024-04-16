program Ejercicio19;
    
(*Ej 19) Leer desde archivo un conjunto de números, con elementos negativos no consecutivos que
delimitan subconjuntos. Obtener e informar el valor máximo de cada subconjunto (el máximo entre dos
negativos).

Ejemplo:
    2 3 4 -7 4 5 -5 7 5 3 9 8 7 -1 3 1 -2 -> 5 9 3
    2 3 4 -7 4 5 -5 7 5 3 9 8 7 -1 3 1 -> 5 9 *)

var
    arch: text;
    cadenaMax: string;
    numero, numeroMax: char;

begin
    assign(arch, 'datos.TXT');
    reset(arch);

    cadenaMax := '';
    numeroMax := ' ';
    repeat
        read(arch, numero);
    until (numero= '-');
    
    read(arch, numero);
    read(arch, numero);
    
    while (not eoln(arch)) do
        begin
            if numero = '-' then
                begin
                    read(arch, numero);
                    read(arch, numero);
                    cadenaMax := cadenaMax + ' ' + numeroMax;
                    numeroMax := ' ';
                end
            else
                begin
                    if numeroMax<numero then
                        numeroMax:= numero    
                end;
                
            
            read(arch, numero);
        end;
    writeln(cadenaMax);
    close(arch);
end.

// Busca cadena de caracteres mas larga entre 2 negativos
(*while (not eoln(arch)) do
        begin
            if numero <> '-' then
                cadena := cadena + numero
            else
                begin
                    if cadenaMax<cadena then
                        cadenaMax := cadena;
                                  
                    cadena := '';
                    read(arch, numero);
                    read(arch, numero);        
                end;
            read(arch, numero);
        end;*)