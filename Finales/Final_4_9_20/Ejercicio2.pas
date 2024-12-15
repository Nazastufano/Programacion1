Program Ejercicio2;

(*Sea A una matriz de NxN de números reales no repetidos y distintos de cero. Se 
pide desarrollar una única función booleana recursiva que verifique que las componentes 
simétricas con respecto a la diagonal, tienen signos opuestos.  
NOTA: Indicar la invocación inicial de la función con los parámetros actuales 
Ejemplos:  
N=3     3  4 -8             N=4     11 2  5   9 
    A= -1  6  3 ->cumple        A= -3  21 7  -10 ->no cumple
        2 -5  7                    -8  4  15 -12 
                                   -12 6  11 -1 

*)
type
    TM = array[1..max,1..max] of real;
function AnalisisRecursivo(mat:TM;N,i,j:byte):Boolean;
begin
    if i>0 then
        if (mat[i,j]/mat[j,i]<0) or (i=j) then
            if j>1 then
                AnalisisRecursivo(mat,N,i,j-1)
            else
                AnalisisRecursivo(mat,N,i-1,N)
        else
            AnalisisRecursivo := false
    else
        AnalisisRecursivo:=true;

end;
var
    N:byte;
    mat:TM;
begin
    CargarMatriz(Mat,N);
    if AnalisisRecursivo(mat,N,N,N) then
        Writeln('Cumple')
    else
        WriteLn('No cumple');
end.