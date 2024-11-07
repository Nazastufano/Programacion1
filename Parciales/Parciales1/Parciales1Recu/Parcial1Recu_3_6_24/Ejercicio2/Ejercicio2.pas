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
        __________;
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
        K := K + 1;
        N := N - 1;
    end;
    SimDivisible := k > N div 2;
end;
*)
begin
end.