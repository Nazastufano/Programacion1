program Ejercicio9;

(*Ej 9) Dado un conjunto de números leídos desde un archivo, informar si están ordenados en forma
ascendente*)

var
    arch: text;
    ant, num: char;
    ordenado: boolean;

begin
    Assign(arch, 'datos.TXT');
    Reset (arch); 
    readln(arch, ant);
    ordenado:=true;

    while NOT eof (arch) do
        begin
            readln(arch, num);
            
            if ant > num then
                ordenado:= false;
            ant := num;
        end;
    close(arch);

    if ordenado then
        writeln('El archivo esta ordenado')
    else
        writeln('El archivo no esta ordenado');
    readln();
end.