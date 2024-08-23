program Ejercicio5;

(*Ej 5) Generar y mostrar los múltiplos de K menores que un valor Q. (K y Q se leen de teclado).*)

var
    num, multiplosM, resultado: integer;
    i, contNum:byte;
begin
    //num = K, multiplosM = Q;
    contNum:=1;
    writeln('Ingrese un numero: ');
    readln(num);
    
    repeat
        writeln('Ingrese un numero para mostrar los multiplos menores que ese valor: ');
        readln(multiplosM);    
    until (multiplosM > num);
    
    write('Los multiplos de: ', num, ', menores que: ', multiplosM, ', son: ');

    repeat
        begin
            resultado := num*contNum;
            if contNum = 1 then
                write(resultado, ', ')
            else
                if contNum <> (multiplosM div num) then
                    write(resultado, ', ')
                else
                    write(resultado, '.');
            contNum:= contNum + 1;
        end;
    until (contNum*num > multiplosM);
    
end.