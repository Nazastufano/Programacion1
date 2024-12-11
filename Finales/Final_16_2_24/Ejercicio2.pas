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
const
    max=20;
    
Type
    TM = array [1..max,1..max] of real;

function AnalisisRecursivo(mat:TM;N,M,i,j:byte):Boolean;
begin
    if i<1 then
        AnalisisRecursivo:=true
    else
        if ((mat[N,M]>0) or (mat[N,M]<0)) and (mat[N,M]/mat[i,j]>0) then
            if j>1 then
                AnalisisRecursivo := AnalisisRecursivo(mat,N,M,i,j-1)
            else
                AnalisisRecursivo := AnalisisRecursivo(mat,N,M,i-1,M)
        else
            AnalisisRecursivo:=false;
end;

var
    mat:TM;
    N,M:byte;
begin
    CargarMatriz(mat,N,M);  
    if AnalisisRecursivo(A, N div 2, M, N div 2, M) then
        WriteLn('Cumple')
    else
        WriteLn('No cumple');
    
end.