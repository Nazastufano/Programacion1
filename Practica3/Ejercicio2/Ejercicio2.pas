program Ejercicio2;

(*Ej 2) Se debe liquidar el sueldo de N empleados, de ellos se sabe el nombre y la antigüedad en años.
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
    empleados, i, aniosDeTrabajo: integer;
    sueldo, mayorSueldo, sueldoPromedio, sueldoTotal, antiguedad: real; 
    nombreEmpleado, emplMayorSueldo: string[10];

begin
    emplMayorSueldo := '';
    sueldoTotal:= 0;
    mayorSueldo := 15000;

    writeln('Ingrese el numero de empleados');
    readln(empleados);

    if empleados<=0 then //Valída que no haya empleados negativos 
        begin
            repeat
                writeln('Ingrese un numero de empleados valido');
                readln(empleados);
            until empleados>0;
        end;

    for i:=1 to empleados do //Ejecuta el procedimiento para cada empleado
        begin
            writeln('Ingrese el nombre del empleado ', i);
            readln(nombreEmpleado);

            writeln('Hace cuantos años trabaja en la compania? ', i);
            readln(aniosDeTrabajo);
            
            if aniosDeTrabajo<0 then //Valída que no trabaje años negativos
                begin
                    repeat
                        writeln('Valor de antiguedad incorrecto. Ingreselo nuevamente: ');
                        readln(aniosDeTrabajo);
                    until aniosDeTrabajo > 0;
                end;
            
            case aniosDeTrabajo of    
                0..5: antiguedad := 0.05;
                6..10: antiguedad := 0.08;
                11..15: antiguedad := 0.12;
                else 
                    antiguedad := 0.2;
            end;
            
            sueldo := sueldoBasico*(1 + antiguedad - 0.11) - 500;
            //Sumás la antigüedad, le restás $500 y el 11% al sueldo básico
            //Da como resultado el sueldo de dicho empleado
        
            writeln('El empleado ', nombreEmpleado, ' tiene un sueldo de ', sueldo:5:2);
            
            if (mayorSueldo = 15000) or (sueldo > mayorSueldo) then
                begin
                    mayorSueldo := sueldo;
                    emplMayorSueldo := nombreEmpleado;
                end;
                
            sueldoTotal := sueldoTotal + sueldo;
        end;
    writeln('El empleado con mayor sueldo es: ', emplMayorSueldo);

    sueldoPromedio := sueldoTotal/empleados;
    writeln('El sueldo promedio es: ', sueldoPromedio:5:2);

    readln();
end.

