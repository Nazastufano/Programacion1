Program Ejercicio1;

(*Desarrollar una única función recursiva entera eficiente que, a partir de una matriz A de 
enteros positivos de NxM, devuelva la cantidad de columnas cuya suma es mayor a un K dado (K es igual 
para todas las columnas). 
Ejemplo; N=5   M=4   K=25 
2  3  2  8
1  5  15 9 
5  1  1  7
3  12 1  6
4  10 1  11
Respuesta = 2  (la 2° y la 4°) 
*)
const
    max = 20;
type
    TM = array[1..Max,1..max] of word;
function analisisRecursivo(A:TM;N,M,i,j:byte;k,suma:word):byte;
begin
    if j>0 then
        begin
            suma:=suma+A[i,j];
            if i>1 then
                analisisRecursivo:=analisisRecursivo(A,N,M,i-1,j,k,suma)
            else
                if suma>k then
                    analisisRecursivo := 1 + analisisRecursivo(A,N,M,N,j-1,k,0)
                else
                    analisisRecursivo := analisisRecursivo(A,N,M,N,j-1,k,0)
        end
    else
        analisisRecursivo:=0;
end;
var
    N,M:byte;
    K:word;
    A:TM;
begin
    CargarMatriz(A,N,M);
    WriteLn('Ingrese un K a superara');
    ReadLn(K);
    WriteLn('Respuesta = ', analisisRecursivo(A,N,M,N,M,K,0));
end.