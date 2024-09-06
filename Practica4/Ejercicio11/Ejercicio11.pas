program Ejercicio11;
(*Ej 11) Dada la ecuación de una parábola y = ax^2 + bx + c, escribir un programa que mediante un menú de opciones iterativo permita:
    a) Encontrar el eje de simetría, sabiendo que y1 = -b/(2.a) y si presenta un mínimo ó un máximo en
    f(y1).
    b) Informar hacia dónde es abierta la parábola.
    c) Calcular y mostrar las raíces, informar en caso que no existan. Para ello debe analizar si el
    discriminante, D = b^2 – 4ac, es mayor, menor ó igual a cero.
    d) Dado un conjunto de valores de x informar su imagen.
Usar procedimientos y/o funciones según corresponda
*)
function Parabola(a,b,c,x:real):real;
begin
    Parabola := a*sqr(x) + b*x + c;
end;

function EjeSimetria(a,b:real):real;
begin
    EjeSimetria := (-b/2*a);
end;

procedure VerificarMaxMin(a,b:real);
var
    y1:real;
begin
    y1 := EjeSimetria(a,b);
    
    if (a>0) then
        WriteLn('El minimo es: ', y1:0:2)
    else
        WriteLn('El maximo es: ', y1:0:2);

end;

procedure AperturaParabola(a:real);
begin
    if a>0 then
        WriteLn('La apertura de la parabola es hacia arriba')    
    else
        WriteLn('La apertura de la parabola es hacia abajo');
end;

procedure Raices(a,b,c:real);
var
    y1,x2, discri:real;

begin
    discri := sqr(b)-4*a*c;

    if (discri>0) then
        begin
            y1 := (-b+sqrt(discri))/2*a;
            x2 := (-b-sqrt(discri))/2*a;
            WriteLn('Las raices son y1: ', y1:0:2 , ' y x2: ', x2:0:2);
        end
    else 
        WriteLn('No existen raices dentro de los reales');
end;

function Imagen(res:real; cad:string):String;
begin
    str(res:0:2,cad);
    Imagen := cad + ', ';
end;


var
    c1,c2,c3,espeX:real;
    cadImagenes:string;
    seguir, opcion:char;
begin
    cadImagenes:='';
    WriteLn('Ingrese los coefecientes a, b, c (Separados por un enter): ');
    readln(c1, c2, c3);
    
    while opcion <> 'F' do
    begin
        repeat
            WriteLn('Ingrese la opcion (A = Verificar Maximos o Minimos, B = Direccion de la apertura de la parabola, C = Raices, D = Imagen de un conjunto, F = Fin de datos)');
            ReadLn(opcion);
            opcion := upCase(opcion);
        until (opcion = 'A') or (opcion = 'B') or (opcion = 'C') or (opcion = 'D') or (opcion='F');
        
        case opcion of
        'A': VerificarMaxMin(c1,c2);
        'B': AperturaParabola(c1);
        'C': Raices(c1,c2,c3);
        'D': begin
            while seguir <> 'N' do
                begin
                    WriteLn('Ingrese el valor de x: ');
                    ReadLn(espeX);
                    cadImagenes := cadImagenes + Imagen(Parabola(c1,c2,c3,espeX),cadImagenes);
                    
                    repeat
                        WriteLn('Desea seguir ingresando valores? S/N');
                        ReadLn(seguir);
                        seguir := Upcase(seguir);
                    until (seguir = 'S') or (seguir = 'N');

                    if seguir = 'N' then
                        cadImagenes := Copy(cadImagenes, 1, Length(cadImagenes)-2);
                end;
                Writeln('[', cadImagenes, ']');
        end;
        end;
    end;
end.