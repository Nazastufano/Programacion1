Program Ejercicio9;

(*Ej 9) Implementar un procedimiento o función recursiva que determine si los dígitos de un número natural
están dispuestos de forma creciente, esto es,
        si N = dm dm-1 …..d2 d1 y para todo i: 1 <= i <= m, verifica que d i >= d i+1

Por ejemplo: para 2337, 356, 88 o 459 debería retornar verdadero
No se permite el uso de cadenas ni de vectores. *)

function AnlisisNumerico(num,ant:word):Boolean;
begin
    ant:=num;
    num:= num div 10;
    
    if num = 0 then
        AnlisisNumerico:= true
    else
        AnlisisNumerico:= (ant mod 10 >= num mod 10) and (AnlisisNumerico(num,ant));
end;

begin
    WriteLn(AnlisisNumerico(2337,0));
end.