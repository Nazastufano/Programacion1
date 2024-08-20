program Ejercicio3;
    
(*Ej 3) Dada una cantidad X de horas trabajadas, calcular e imprimir el sueldo bruto y neto de un empleado.
Considerar la paga de $ 200 la hora, un descuento del 11% previsional y el 5% para cobertura médica.*)

var
    cantHoras: integer;
    sueldoBrut, sueldoNet: real;
    nombre: string[10];

const
    valHora = 200;
    descPrev = 0.11;
    descCM = 0.05;

begin
    writeln('Ingrese la cantidad de horas trabajadas en la semana ');
    read(cantHoras);

    sueldoBrut := cantHoras*valHora;
    sueldoNet := sueldoBrut*(1+descPrev+descCM);

    writeln('El sueldo bruto es: ', sueldoBrut:0:2);
    writeln('El sueldo neto es: ', sueldoNet:0:2);
    readln();
end.

