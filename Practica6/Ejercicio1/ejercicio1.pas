program Ejercicio1;

(*Ej 1) Leer desde un archivo una matriz de NxM elementos enteros, (N y M se encuentran en la primera
línea del archivo y luego en las restantes N líneas vienen los M elementos). Se pide:
a) Generar un arreglo con el máximo de cada fila y mostrarlo.
b) Generar un arreglo con la suma de los impares de cada columna, no generar elemento si la
columna no tiene impares.
c) Dada una columna X, ingresada por el usuario, hallar el promedio de sus elementos.*)

var
    arch: text;
    i,j,n, m: integer;
    matr: array of array of integer;    


begin
    assign(arch, 'datos.TXT');
    reset(arch);

    read(arch, n);
    read(arch, m);
    
    setLength(matr, n, m);

    for i := 1 to n-1 do
        begin
            for j := 1 to m-1 do
                matr[i,j] := 0;
        end;
    
    writeln(Length(matr));    
    writeln(Length(matr[1]));  

    setLength(matr, Length(matr)+ 1, Length(matr[1])+1);
    writeln(Length(matr));
    writeln(Length(matr[1])); 

end.