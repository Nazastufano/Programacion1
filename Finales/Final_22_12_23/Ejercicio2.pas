Program Ejercicio2;

(*Desarrollar un único subprograma completamente recursivo que dada una matriz A de NxN
elementos reales, verifique que en cada fila se cumple que los elementos por debajo de la diagonal principal,
si existen, son mayores al correspondiente de la diagonal.

Ejemplo: N=4
    2.1  3   8   5
     4  -6   7   2
    1.7 5.3 -4   3
    5.1 4.5  6  3.6

Escribir el programa principal que invoque el subprograma, incluyendo los tipos, declaraciones e
inicializaciones que se consideren necesarias.*)
const
    max = 20;
type
    TM = array[1..4, 1..4] of Real;


function AnalisisRecursiva(mat:TM;N,i,j:byte):Boolean;
begin
    if i>1 then
        if (j<i) and (mat[i,i] >= mat[i,j]) then
            AnalisisRecursiva := false
        else 
            If (j>1)  Then
                AnalisisRecursiva := AnalisisRecursiva(mat,N,i,j-1)    
            else
                AnalisisRecursiva := AnalisisRecursiva(mat,N,i-1,N)
    else
        AnalisisRecursiva:=true;
end;

var
    A:TM;
    N:byte;
begin
    InicializarMatriz(A,N);
    
    if AnalisisRecursiva(A,N,N,N) then
        WriteLn('Cumple')
    else
        WriteLn('No cumple');
    
end.