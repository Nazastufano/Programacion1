program Ejercicio8;
(* Ej 8) Un club cobra a sus socios una cuota básica por mes que
incluye dos deportes, su costo depende de la edad del socio:
 Si es mayor de 18: $1800
 Si está entre 13 y 18: $1200
 Si tiene entre 5 y 12 años: $750
 En otro caso no paga 
Además, se cobra $250 por cada deporte adicional que realiza, 
excepto pileta escuela que cuesta $800. Si
la cuota se abona después del día 15 tiene un recargo del 5%.
Determinar los datos a ingresar, para calcular e informar cuánto
paga un socio.
*)

var
    respuesta, precio, tiempo, edad: integer;
    totalAPagar: real;
    respuestaP: char;
    
begin
    
    repeat
        writeln('Ingrese la edad del socio');
        readln(edad);
        if edad < 0 then
            writeln('Por favor, ingresa una edad valida');
    until edad >= 0;

    case edad of
        0..4: precio := 0;
        5..12: precio := 750;
        13..18: precio := 1200;
        else precio := 1800; 
    end;
    
    repeat
        writeln('De los 4 deportes adicionales, cuantos desea hacer?');
        readln(respuesta);    
    until (respuesta in [0..4]);

    totalAPagar := precio + totalAPagar + 250*respuesta;

    repeat
        writeln('La pileta escuela está disponible, desea incluirla?');
        readln(respuestaP);
        respuestaP := UpCase(respuestaP);
    until (respuestaP = 'S') or (respuestaP = 'N');

    if respuestaP = 'S' then
        totalAPagar := totalAPagar + 800;
    
    repeat
        writeln('Hace cuantos dias usted no paga la cuota?');
        readln(tiempo);
    until (tiempo>0);

    if tiempo > 15 then
        totalAPagar := totalAPagar + totalAPagar*0.05;
    writeln('El total a pagar es: ', totalAPagar:5:2);
    readln();
end.