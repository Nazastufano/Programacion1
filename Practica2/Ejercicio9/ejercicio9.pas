program Ejercicio9;

(*Ej 9) A un vendedor le pagan un sueldo básico de $8000 por mes
más una comisión del 5% de las ventas;
si superó en ventas un monto X (dato ingresado por teclado)
se le agrega un 3%. Por presentismo cobra
$1000 más ó 2% de las ventas, lo que resulte mayor. 
Si faltó más de 2 días se le descuenta un 7% del total.
Definir los datos a ingresar. Calcular e informar lo que debe 
cobrar el vendedor. 
*)

const 
    sueldoBasico = 8000;
    comision = 0.05;
    comision2 = 0.03;
    comision3 = 0.02;
    presentismo = 1000;
    descuento = 0.07;

var
    ventasRealizadas: word;
    ausencia:byte;
    montoASuperar, sueldoTotal: real;

begin
    
    writeln('Ingrese el monto a superar: ');
    readln(montoASuperar);

    writeln('Cuantas ventas hizo el vendedor: ');
    readln(ventasRealizadas);
    
    writeln('Dias de ausencia: ');
    readln(ausencia);

    sueldoTotal := sueldoBasico*(1 + ventasRealizadas*comision);
    
    if sueldoTotal>montoASuperar then
        sueldoTotal := sueldoTotal + sueldoBasico*comision2;
    
    if ausencia = 0 then
        if ventasRealizadas*sueldoBasico*comision > presentismo then
            sueldoTotal := sueldoTotal + ventasRealizadas*sueldoBasico*comision3
        else
            sueldoTotal := sueldoTotal + presentismo
    else
        if ausencia>2 then
            sueldoTotal := sueldoTotal*(1-descuento);

    writeln('El sueldo total del empleado es: ', sueldoTotal:0:2);
    readln();
        
end.