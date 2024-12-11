Program Ejercicio1;

(*1.- Sea A un vector de N elementos reales (N par) desarrollar una función recursiva que verifique 
si A cumple que la primera mitad tiene todos sus elementos negativos y la segunda mitad todos positivos. 
Si A contiene algún cero, no verifica la condición solicitada. 
 
Ejemplo :  N=6     A= (-1.5, -8.2, -4.35, 5,  7.44,  3.8)   Cumple 
           N=6     A= (-1.5, 0, -4.35, 5,  7.44,  3.8)   No cumple*)
type
    TV=array[1..6] Of real;
const
    A: TV = (-1.5, -8.2, -4.35, 5,  7.44,  3.8);

function AnalisisVec(vec:TV;i,N:byte):Boolean;
begin
    if i>0 then
        if ((i>N div 2) and (vec[i]>0)) or ((i<=N Div 2) and (vec[i]<0)) then
                AnalisisVec:=AnalisisVec(vec,i-1,N)
            else
                AnalisisVec:=false
    else
        AnalisisVec:=true;
end;

begin
    if AnalisisVec(A,6,6) then
        WriteLn('Cumple')
    else
        WriteLn('No cumple');
end.