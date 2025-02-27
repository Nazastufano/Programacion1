Program Ejercicio2;

(*Sea Mat una matriz entera de NxN, desarrollar una función entera recursiva que 
devuelva el máximo de los elementos simétricos iguales (incluir los de la diagonal)  
Ejemplo N = 5 

 8  -2   16 -2  10
-2   14 -13  15 5
 7   10 -15  21 1   =>21 
 12 -20  21 -6  36
-5   5  -12 -23 20 
*)

const
    max=20;
Type
    TM = array[1..Max,1..max] of integer;

function maxSimetricosIguales(mat:TM;N,i,j:byte;max:integer):integer;
begin
    if i>0 then
        begin
            if (mat[i,j]=mat[j,i]) and (max<mat[i,j]) then
                max:=mat[i,j];
            if j>1 then
                maxSimetricosIguales := maxSimetricosIguales(mat,N,i,j-1,max)
            else
                maxSimetricosIguales := maxSimetricosIguales(mat,N,i-1,N,max);
        end
    else
        maxSimetricosIguales:=max;
end;

var
    mat:TM;
    N:byte;

begin
    CargarMatiz(mat,N);
    WriteLn('El maximo de los elementos simetricos iguales es: ', maxSimetricosIguales(mat,N,N,N,0));
end.