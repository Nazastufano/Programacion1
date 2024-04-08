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
    montoASuperar, ausencia, ventasRealizadas: integer;
    sueldoTotal: real;
begin
    repeat
        writeln('Ingrese el monto a superar: ');
        readln(montoASuperar); 
        if montoASuperar < 0 then
            writeln('Por favor, ingrese un monto valido');  
    until (montoASuperar>0);

    repeat
        writeln('Cuantas ventas hizo el vendedor: ');
        readln(ventasRealizadas); 
        if ventasRealizadas < 0 then
            writeln('Por favor, ingrese un numero valido');  
    until (ventasRealizadas>0);
    
    repeat
        writeln('Dias de ausencia: ');
        readln(ausencia);
        if ausencia < 0 then
            writeln('Por favor, ingrese un numero valido'); 
    until (ausencia>=0);
    
    sueldoTotal := sueldoBasico + ventasRealizadas*sueldoBasico*comision;
    
    if sueldoTotal>montoASuperar then
        sueldoTotal := sueldoTotal + sueldoBasico*comision2;
    
    if ausencia = 0 then
        if ventasRealizadas*sueldoBasico*comision > presentismo then
             sueldoTotal := sueldoTotal + ventasRealizadas*sueldoBasico*comision3
        else
            sueldoTotal := sueldoTotal + presentismo
    else
        if ausencia>2 then
            sueldoTotal := sueldoTotal - sueldoTotal*descuento;

    writeln('El sueldo total del empleado es: ', sueldoTotal:5:2);
    readln();
        
end.