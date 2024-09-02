program Ejercicio5;

(*Ej 5) Calcular la solución por determinantes de un sistema de dos ecuaciones lineales con dos incógnitas
(se supone compatible y determinado). Desarrollar la función que dados a,b,d,e obtenga x. Recordar que
el determinante

X = |a  b| se calcula:   x = a*e – d*b
    |c  d|

Aplicarlo para los siguientes sistemas de ecuaciones:
2x + 3y = 5     6x + 3y = 12    4x + 1y = 8
3x - 2y = 1     2x + 1y = 1     6x + 3y = 12 *)

function Determinante(a,b,c,d:Integer):integer;
begin
    Determinante:= (a*d) - (b*c);
end; 


var
    x1,y1,x2,y2,c1,c2:integer;
    resX,resY,det:real;

begin
    WriteLn('Ingrese el primer valor de x: ');
    ReadLn(x1);
    WriteLn('Ingrese el primer valor de y: ');
    ReadLn(y1);
    WriteLn('Ingrese el valor de la primer constante: ');
    ReadLn(c1);
    WriteLn('Ingrese el segundo valor de x: ');
    ReadLn(x2);
    WriteLn('Ingrese el segundo valor de y: ');
    ReadLn(y2);
    WriteLn('Ingrese el valor de la segunda constante: ');
    ReadLn(c2);

    det:= Determinante(x1,x2,y1,y2);
    resX:= Determinante(c1,y1,c2,y2);
    resY:= Determinante(x1,c1,x2,c2);

    WriteLn('El resultado de x es: ', (resX/det):0:2);
    WriteLn('El resultado de y es: ', (resY/det):0:2);
    WriteLn('El resultado del determinante es: ', Determinante(x1,x2,y1,y2));
end.
