Program Ejercicio1;

(*1.- Sea A un vector de N elementos reales (N par) desarrollar una función recursiva que verifique 
si A cumple que la primera mitad tiene todos sus elementos negativos y la segunda mitad todos positivos. 
Si A contiene algún cero, no verifica la condición solicitada. 
 
Ejemplo :  N=6     A= (-1.5, -8.2, -4.35, 5,  7.44,  3.8) ->  Cumple 
           N=6     A= (-1.5, 0, -4.35, 5,  7.44,  3.8) ->  No cumple
*)
const
    MAX = 20;
type
    TV = array[1..MAX] of real;

function AnalisisRecrusivo(A:TV;i,N:byte):Boolean;
begin
    if i<=N then
        if ((i <= N div 2) and (A[i]<0)) or ((i > N div 2) and (A[i]>0)) then
            AnalisisRecrusivo:=AnalisisRecrusivo(A,i+1,N)
        else
            AnalisisRecrusivo:=false
    else
        AnalisisRecrusivo:=true;

end;
var
    N:byte;
    A:TV;
begin
    repeat
        WriteLn('Ingrese un valor par de N: ');
        readln(N);
    until (N mod 2 = 0);

    CargarVector(A,N);
    if AnalisisRecrusivo(A,1,N) then
        WriteLn('Cumple')
    else
        WriteLn('No cumple');
end.