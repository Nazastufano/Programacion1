program Ejercicio2;

(*Completar el código para que la siguiente función verifique si a partir de un arreglo A de N elementos
enteros cumple que cada elemento de la izquierda es divisible por su simétrico.

Por ejemplo: N=7;
A = (15, 8, -6, 1, 3, 4, 5); Cumple

Function SimDivisible(A: TV; N: byte):___________;
var
    ____________;
begin
K:= _______;
while (K___N) _____ (A[K]______) do
begin
    K:= K + 1;
    ..........;
    end;
SimDivisible := _________;
end;

RESUELVO EJERCICIO:

Function SimDivisible(A: TV; N: byte): boolean;
var
    k:byte;
begin
K:= 1;
while (K<=N) and (A[K] mod A[N-K+1] = 0) do
begin
    K:= K + 1;
    ..........;
    end;
SimDivisible := k > N div 2;
end;
//El parcial no deja modificarlo, pero en sería mejor que la condición (K<=N) pase a ser (K<=N div 2)
//Para los casos como que el arreglo sea de todos los elementos iguales
*)
begin
end.