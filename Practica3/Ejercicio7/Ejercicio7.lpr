program Ejercicio7practica3;
        (*Dado un conjunto de alumnos, no se sabe cuántos son, de cada uno de ellos se conoce:
- Nombre (‘***’ indica fin de datos)
- Nota1, Nota2 y Nota3
Ingresar la información e informar:
a) El promedio de cada alumno y su condición:
− ‘Aprobado’ si su promedio es mayor o igual a 4
− ‘Desaprobado’ si su promedio es menor a 4.
b) Porcentaje de alumnos Aprobados
*)
var
   contAlumnos, i,contAA: byte;
   nombre: string;
   promedio, nota, notaTotal, porcentajeAA: real;

begin
  writeln('Ingrese el nombre del alumno');
  readln(nombre);

  while nombre <> '***' do
    begin
         contAlumnos:= contAlumnos + 1;
         nota := 0;
         promedio:=0;
         notaTotal:= 0;
         for i:=1 to 3 do
             begin
                  writeln('Ingrese nota ', i);
                  readln(nota);
                  notaTotal:= notaTotal + nota;
             end;
         promedio := (notaTotal)/3;

         if promedio >= 4 then
             begin
               writeln('Aprobado');
               contAA := contAA +1;
             end
         else
             writeln('Desaprobado');

         writeln('El promedio de ', nombre, ' es: ', promedio:5:2);


         writeln('Ingrese el nombre del alumno');
         readln(nombre);

    end;

      porcentajeAA:= (contAA*100)/contAlumnos;
      writeln('El promedio de alumnos aprobados es: ', porcentajeAA:5:2, '%');


end.

