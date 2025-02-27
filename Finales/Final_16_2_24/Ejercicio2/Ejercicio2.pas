Program Ejercicio2;

(*Desarrollar un único subprograma completamente recursivo que dada una matriz A de NxM elementos reales,
donde la cantidad de filas es impar, verifique que todos los elementos de la matriz SOBRE la fila del medio tienen el mismo signo

Ejemplo: N=5, M=4

     2.1   3    8   5
      4    6    7   2
A=   1.7  5.3  -4   3
     5.1  4.5   6  3.6
    -1.6  3.8  -2  2.7

Escribir el programa principal que ínvoque el subprograma, incluyendo los tipos, declaraciones e inicializaciones que se 
consideren necesarias.

*)
type
    TM = array[1..20,1..30] of real;

function AnalisisRecursivo(A:TM;i,j,N,M:byte):Boolean;
begin
    if i <= N div 2 then
        if (A[i,j]/A[1,1]>0) then
            if j<M then
                AnalisisRecursivo:=AnalisisRecursivo(A,i,j-1,N,M)
            else
                AnalisisRecursivo:=AnalisisRecursivo(A,i-1,M,N,M)
        else
            AnalisisRecursivo:=false
    else
        AnalisisRecursivo:=true;
end;

var
    A:TM;
    N,M:byte;
begin
    repeat
        WriteLn('Ingrese una cantidad de filas impar: ');
        readln(N);
    until (N in [1..20]) and (N mod 2 <> 0);
    repeat
        WriteLn('Ingrese la cantidad de columnas: ');
        ReadLn(M);
    until (M in [1..30]);

    CargarMatriz(A,N,M);

    if AnalisisRecursivo(A,1,1,N,M) then
        WriteLn('Cumple')
    else
        WriteLn('No cumple');
end.