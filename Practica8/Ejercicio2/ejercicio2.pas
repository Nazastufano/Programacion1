program Ejercicio2;

(*Ej 2) Implementar la siguiente función recursiva 
     {    1     si t = 0
f(t)={ 1+f(t-1) si t es par
     {  f(t-1)  si t es impar
*)

function funcionDeT(t:integer):integer;
begin
    if t=0 then
        funcionDeT:= 1
    else
        if t mod 2 = 0 then
            funcionDeT:= 1 + funcionDeT(t-1)
        else
            funcionDeT:= funcionDeT(t-1);
end;

begin
    writeln(funcionDeT(400));
end.