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

const
    recargo = 0.05;

var
    dias: word;
    edad, respuesta: byte;
    precio, totalAPagar: real;
    respuestaP: char;
    
begin
    
    writeln('Ingrese la edad del socio');
    readln(edad);

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
        writeln('La pileta escuela está disponible, desea incluirla? S/N');
        readln(respuestaP);
        respuestaP := UpCase(respuestaP);
    until (respuestaP = 'S') or (respuestaP = 'N');

    if respuestaP = 'S' then
        totalAPagar := totalAPagar + 800;
    
    repeat
        writeln('Hace cuantos dias usted no paga la cuota?');
        readln(dias);
    until (dias>0);

    if dias > 15 then
        totalAPagar := totalAPagar*(1 + recargo);
    writeln('El total a pagar es: $', totalAPagar:0:2);
    readln();
end.