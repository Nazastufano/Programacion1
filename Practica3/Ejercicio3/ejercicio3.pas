Program Ejercicio3;

(*Ej 3) Ingresar N números enteros, informar cuántas veces un número supera al anterior. *)

var
    anterior, numero: integer;
    i, cant,cantSupAnt: byte;
begin
    
    writeln('Ingrese la cantidad de numeros que desea ingresar: ');
    readln(cant);

    writeln('Ingrese el numero de la primera posicion: ');
    readln(anterior);

    for i := 2 to cant do
        begin
            writeln('Ingrese el numero de la posicion: ', i);
            readln(numero);

            if numero>anterior then
                cantSupAnt:= cantSupAnt + 1;
            
            anterior := numero;
        end;

    if cantSupAnt = 1 then
        writeln('De los numeros ingresados, se superaron ', cantSupAnt, ' vez al anterior')
    else
        writeln('De los numeros ingresados, se superaron ', cantSupAnt, ' veces al anterior');

    readln();
end.
