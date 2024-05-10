program Ejercicio7;

(*Ej 7) Crear una función recursiva que busque el elemento 
mínimo de una matriz cuadrada*)

const 
    N=2;
    M=2;

type
    TM = array[1..N,1..M] of integer;

var
    valorMinimo: integer;
    matr:TM;

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

procedure ElementMin(Mat :TM; i:byte; j:byte; var min:integer);
Begin
    if (i = N) and (j = M) then
        min := Mat[N, M];

    if min > Mat[i, j] then
        min := Mat[i, j];

    if i>0 then
        begin
            if j > 1 then {sigue analizando la misma fila}
                ElementMin(Mat, i, j - 1, min) {misma fila, columna de la izquierda}
            else
                ElementMin(Mat, i - 1, M, min) {fila anterior, última columna}
        end
    else
        writeln('El valor minimo es: ', min);
end; 

begin
    RellenarMatriz(matr);

    ElementMin(matr, N, M, valorMinimo);
end.