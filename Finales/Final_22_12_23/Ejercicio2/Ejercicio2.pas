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
    TM = array[1..max,1..max] of real;

function AnalisisRecursivo(mat:TM;i,j,N:byte):Boolean;
begin
    if i>1 then
        if mat[i,j]>mat[i,i] then
            if j>1 then
                AnalisisRecursivo:=AnalisisRecursivo(mat,i,j-1,N)
            else
                AnalisisRecursivo:=AnalisisRecursivo(mat,i-1,i-2,N)
        else
            AnalisisRecursivo:=false
    else
        AnalisisRecursivo:=true;
        
end;

var
    N:byte;
    mat:TM;
begin
    Armarmatriz(mat,N);

    if AnalisisRecursivo(mat,N,N-1,N) then
        WriteLn('Cumple')
    else
        WriteLn('No cumple');
end.