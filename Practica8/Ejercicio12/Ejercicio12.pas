Program Ejercicio12;

(*Ej 12) Verificar si una matriz A de NxN de números enteros cumple que para cada fila el elemento
respectivo de la diagonal principal es mayor a la suma del resto de los elementos de la fila. *)

const
    N = 2;
type
    TM = array[1..N,1..N] of integer;

procedure RellenarMatriz(var matr: TM);
var
    val,i,j:integer;
begin
    for i := 1 to N do
    begin
        for j := 1 to N do
        begin
            writeln('Ingrese el valor de la fila ', i, ' columna ', j);
            readln(val);
            matr[i,j] := val;
        end;
    end;
end;

function DiagonalMayorSumaFila(matr:TM;i,j:byte;suma,valorDiagonal:integer):Boolean;
begin
    if i=0 then
        DiagonalMayorSumaFila:=true
    else
        begin
            if (i<>j) then
                suma := suma+matr[i,j];
            if j>1 then    
                DiagonalMayorSumaFila := DiagonalMayorSumaFila(matr,i,j-1,suma,matr[i,i])
            else
                DiagonalMayorSumaFila:= (suma<matr[i,i]) and DiagonalMayorSumaFila(matr,i-1,N,0,matr[i-1,i-1]);
        end;
end;
var
    matr:TM;

begin
    RellenarMatriz(matr);
    if DiagonalMayorSumaFila(matr,N,N,0,matr[N,N]) then
        WriteLn('Los valores de la diagonal principal son mayores a la suma de los demas elementos de la fila')
    else
        Writeln('Los valores de la diagonal principal son menores a la suma de los demas elementos de la fila');
end.