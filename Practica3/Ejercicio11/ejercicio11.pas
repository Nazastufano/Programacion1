program Ejercicio11;

(*Ej 11) Reescriba utilizando archivo de texto para ingreso de datos los siguientes ejercicios:
a) Ej 6, considerar en la primera línea del archivo el saldo inicial y en cada una de las líneas siguientes
un movimiento: Tipo, Monto (notar que no es necesario el tipo F).
b) Ej 7, en cada línea del archivo: Nombre (15 caracteres) y las tres notas reales*)

var
    arch1, arch2: text;
    saldo, dinero, contAA, contAlumnos: integer;
    movimiento: char;
    nombre: string[15];
    nota1, nota2, nota3, promedio, porcentajeAA: real;

begin
    //a)
    assign(arch1, 'datos1.TXT');
    reset(arch1);
    readln(arch1, saldo);

    while NOT eof(arch1) do
    begin
        read(arch1, movimiento);
        readln(arch1, dinero);

        case movimiento of
            'D':
                begin
                    if dinero>0 then
                        saldo := saldo + dinero
                    else
                        writeln('Movimiento invalido');   
                end;
            'R':
                begin
                    if dinero>0 then
                        saldo := saldo - dinero
                    else
                        writeln('Movimiento invalido');                    
                end;
        end;
        writeln(saldo);
    end;
    close(arch1);
    readln();

    //b)
    assign(arch2, 'datos2.TXT');
    reset(arch2);
    while NOT eof(arch2) do
        begin
            readln(arch2, nombre);
            read(arch2, nota1);
            read(arch2, nota2);
            read(arch2, nota3);
            contAlumnos:= contAlumnos +1;
            promedio := (nota1+nota2+nota3)/3;

            If promedio >= 4 Then
                Begin
                    write('Aprobado. ');
                    contAA := contAA +1;
                End
            Else
                write('Desaprobado. ');
            writeln('El promedio de: ', nombre, ' es ', promedio:0:2);
            readln(arch2, nombre);
        end;
    close(arch2);
    porcentajeAA := (contAA*100)/contAlumnos;
    writeln('El promedio de alumnos aprobados es: ', porcentajeAA:5:2, '%');
    readln();
end.
