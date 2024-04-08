program Ejercicio2;
    (*Ej 2) Sean las siguientes estructuras selectivas, reescribirlas de 
    tal forma que realicen lo mismo, pero con condicionales simples.

If a and b then
    Sentencia 1
else
    Sentencia 2;

If a or b then
    Sentencia 1
else
    Sentencia 2;*)
begin
    if a then
        if b then
            Sentencia 1
        else
            Sentencia 2
    else
        Sentencia 2;

    
    if a then
        Sentencia 1
    else
        if b then
            Sentencia 1
        else
            Sentencia 2;
end.