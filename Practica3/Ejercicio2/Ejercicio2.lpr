program Ejercicio2;

(*Se debe liquidar el sueldo de N empleados, de ellos se sabe el nombre y la antigüedad en años.
Todos parten de un básico de $15000 y la antigüedad se calcula según la siguiente tabla:
- Hasta 5 años …………. 5%
- De 6 a 10 años……….. 8%
- De 11 a 15 años…….. 12%
- Más de 15 años …… 20%
Además se descuenta un 11% por cargas sociales y $500 por seguro obligatorio.
Calcular e informar:
a) Nombre y sueldo de cada empleado.
b) Nombre del empleado que más cobra (suponer que es único).
c) Monto del sueldo promedio. *) 

const
  sueldoBasico = 15000;
var
  empleados, antiguedad: integer;
  sueldo: real; 
  nombreEmpleado:

begin
    writeln('Ingrese el numero de empleados');
    readln(empleados); (*Repreguntar si es un numero negativo*)

    if empleados<=0 then
        begin
            repeat
                writeln('Ingrese un numero de empleados valido');
                readln(empleados);
            until empleados>0;
        end;

    for i=1 to empleados do
        begin
            write('Ingrese el nombre del empleado' + i);

        end;

end.

