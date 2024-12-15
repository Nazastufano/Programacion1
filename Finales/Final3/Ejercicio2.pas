Program Ejercicio2;

(*Dada una matriz que contiene las cantidades de empleados de una empresa, donde las columnas
representan las sucursales y las filas son las categorías de los empleados, desarrollar una función recursiva que
calcule y retorne la cantidad de sucursales que tienen al menos X empleados en total.
Escribir el programa principal que invoque la función, incluyendo los tipos, declaraciones e inicializaciones que
se consideren necesarias.
Todo el tratamiento de la matriz debe ser recursivo y resuelto mediante una única función.*)
const
    Max = 20;
Type
    TM = array[1..Max,1..Max] of word;
function AnalisisRecursivo(mat:TM;N,M,i,j,x,suma:byte):byte;
begin
    if j>0 then
        if i>1 then
            AnalisisRecursivo:=AnalisisRecursivo(mat,N,M,i-1,j,x,suma+mat[i,j])
        else
            if suma+mat[i,j]>x then
                AnalisisRecursivo:= 1 + AnalisisRecursivo(mat,N,M,N,j-1,x,0)
            else
                AnalisisRecursivo := AnalisisRecursivo(mat,N,M,N,j-1,x,0)
    else
        AnalisisRecursivo:=0;
end;
var
    mat:TM;
    x,N,M:byte;
    
begin
    CargarMatriz(mat,N,M);
    WriteLn('Ingrese la cantidad de empleados a superar: ');
    readln(x);
    AnalisisRecursivo(mat,N,M,N,M,x,0);
end.