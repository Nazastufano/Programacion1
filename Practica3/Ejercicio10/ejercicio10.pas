program Ejercicio10;

(*Ej 10) Leer desde un archivo números enteros ordenados de menor a mayor, puede haber elementos
repetidos.
Calcular y mostrar cada número con su respectiva frecuencia.
Ejemplo: 2, 2, 3, 3, 3, 3, 7, 9, 9, 9 

Numero Frecuencia
    2       2
    3       4
    7       1
    9       3
*)
var
    arch: text;
    ant, numero, repeticiones: integer;
begin
    assign(arch, 'datos.TXT');
    reset(arch);
    read(arch, ant);
    repeticiones := 1;

    writeln('Numero - Frecuencia');

    while NOT eoln (arch) do
        begin
            read(arch, numero);

            if (numero = ant) then
                repeticiones := repeticiones + 1;
            
            if (numero <> ant) or (eoln(arch)) then
                begin
                    writeln(ant, ' - ', repeticiones);
                    repeticiones := 1;
                end;
            ant := numero; 
        end;
    close(arch);
    readln();
end.