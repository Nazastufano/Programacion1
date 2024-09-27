program Ejercicio19;
    
(*Ej 19) Leer desde archivo un conjunto de números, con elementos negativos no consecutivos que
delimitan subconjuntos. Obtener e informar el valor máximo de cada subconjunto (el máximo entre dos
negativos).

Ejemplo:
    2 3 4 -7 4 5 -5 7 5 3 9 8 7 -1 3 1 -2 -> 5 9 3
    2 3 4 -7 4 5 -5 7 5 3 9 8 7 -1 3 1 -> 5 9 *)

var
    arch: text;
    cadenaMax,aux: string;
    numeroMax, numero: integer;

begin
    assign(arch, 'datos.TXT');
    reset(arch);

    cadenaMax := '';
    numeroMax := 0;

    repeat
        read(arch, numero);
    until (numero < 0);
    
    while (not eoln(arch)) do
        begin
            if numero < 0 then
                read(arch, numero);

            while (numero >= 0) and (not eoln(arch))do   
                begin
                    if numeroMax < numero then
                        numeroMax := numero;
                    read(arch, numero);
                end;

            if numero < 0 then
                begin
                    str(numeroMax,aux);
                    cadenaMax := cadenaMax + ' ' + aux;
                    numeroMax := 0;
                end;
        
            read(arch, numero);
        end;
    close(arch);
    writeln(cadenaMax);
end.