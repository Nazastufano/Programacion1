Program Ejercicio2;

(*2.- Sea Mat una matriz entera, de NxN desarrollar una función recursiva entera que devuelva la cantidad de 
veces que el elemento de la Diagonal Principal es mayor que el de la Diagonal Secundaria ubicado en la 
misma fila. Mostrar la declaración de variables del programa invocante y los parámetros actuales de la 
invocación.  
Ejemplo N = 5


 8  -2   16 -2  10
-2   14 -13  11 5
 7   10 -15  21 1  -> 3
 12 -20  21 -6  36 
-5   5  -12 -23 20

*)
const
    Max = 20;
type
    TM = array[1..Max,1..Max] of integer;

function analisisRecursivo(mat:TM;N,i,j:byte):byte;
var
    val:byte;
begin
    If i>0 Then
    Begin
        If (mat[i,j]>mat[i,N-i+1]) Then
            val := 1
        Else
            val := 0;
        analisisRecursivo := val + analisisRecursivo(mat,N,i-1,j-1);
    End
    else
        analisisRecursivo := 0;
end;
    


var 
    mat:TM;
    N:byte;
begin
    cargarMatriz(mat,N);
    analisisRecursivo(mat,N,N,N);
end.