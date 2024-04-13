program Ejercicio5;

(*Ej 5) Generar y mostrar los múltiplos de K menores que un valor Q. (K y Q se leen de teclado).*)

var
    num, i, multiplosM, resultado: integer;

begin
    writeln('Ingrese un numero: ');
    readln(num);
    
    repeat
        writeln('Ingrese un numero para mostrar los multiplos menores que ese valor: ');
        readln(multiplosM);    
    until (multiplosM > 0);
    
    write('Los multiplos de: ', num, ', menores que: ', multiplosM, ', son: ');
    
    for i := multiplosM downto 1 do
        begin
            resultado := num*i;
            if i=1 then
                writeln(resultado)
            else
                write(resultado, ', ');    
        end;
    readln();       
end.