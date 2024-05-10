program Ejercicio8;

(*Ej 8) Desarrollar un procedimiento recursivo que devuelva 
en un arreglo los máximos de cada fila de una matriz de MxN. 
*)

const
    N = 3;
    M = 3;
type
    TV = array[1..N] of integer;
    TM = array[1..N,1..M] of integer;

var
    matr:TM;
    vec:TV;

procedure MostrarArreglo(vec:TV); //Genera el arreglo de los maximos
    var
        i:integer;
    begin
        for i := 1 to N do
            begin
                if i=1 then
                    write('(');

                if (i<>N) then
                    write(vec[i], ', ')
                else
                    begin
                        write(vec[i], ')');      
                    end;
            end;
    end;

procedure RellenarMatriz(var matr: TM); //Rellena la matriz con 0
    var
        val,i,j:integer;
    begin
        for i := 1 to N do
            begin
                for j := 1 to M do
                    begin
                        writeln('Ingrese el valor de la fila ', i, ' columna ', j);
                        readln(val);
                        matr[i,j] := val;
                    end;
            end;
    end;

procedure MaximosDeFila(var vec:TV; matr:TM; i:byte; j:byte);
begin
    if (j=M) then
        vec[i] := matr[i, j];
    
    if matr[i, j] < vec[i] then
        vec[i] := matr[i, j];        
    
    if i>0 then
        begin
            if j > 1 then {sigue analizando la misma fila}
                MaximosDeFila(vec,matr, i, j - 1) {misma fila, columna de la izquierda}
            else
                MaximosDeFila(vec,matr, i - 1, M) {fila anterior, última columna}
        end
    else
        MostrarArreglo(vec);
end;

begin
    RellenarMatriz(matr);
    MaximosDeFila(vec,matr,N,M);
end.