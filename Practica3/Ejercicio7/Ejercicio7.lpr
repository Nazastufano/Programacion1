
Program Ejercicio7practica3;





(*Dado un conjunto de alumnos, no se sabe cuántos son, de cada uno de ellos se conoce:
- Nombre (‘***’ indica fin de datos)
- Nota1, Nota2 y Nota3
Ingresar la información e informar:
a) El promedio de cada alumno y su condición:
− ‘Aprobado’ si su promedio es mayor o igual a 4
− ‘Desaprobado’ si su promedio es menor a 4.
b) Porcentaje de alumnos Aprobados
*)

Var 
    contAlumnos, i,contAA:   byte;
    nombre:   string;
    promedio, nota, notaTotal, porcentajeAA:   real;

Begin
    writeln('Ingrese el nombre del alumno');
    readln(nombre);

    While nombre <> '***' Do
        Begin
            contAlumnos := contAlumnos + 1;
            nota := 0;
            promedio := 0;
            notaTotal := 0;
            For i:=1 To 3 Do
                Begin
                    writeln('Ingrese nota ', i);
(*VALIDAR NOTAS*)
                    readln(nota);
                    notaTotal := notaTotal + nota;
                End;
            promedio := (notaTotal)/3;

            If promedio >= 4 Then
                Begin
                    writeln('Aprobado');
                    contAA := contAA +1;
                End
            Else
                writeln('Desaprobado');

            writeln('El promedio de ', nombre, ' es: ', promedio:5:2);


            writeln('Ingrese el nombre del alumno');
            readln(nombre);

        End;

    porcentajeAA := (contAA*100)/contAlumnos;
    writeln('El promedio de alumnos aprobados es: ', porcentajeAA:5:2, '%');
End.
