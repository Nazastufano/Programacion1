program Ejercicio4;

(*Ej 4) Ingresar N números enteros (ordenados en forma descendente), informar cual es la máxima
diferencia entre dos números consecutivos y qué posición ocupa ese par de números dentro de la
secuencia.
Ejemplo: 25 19 11 9 3 -3, la máxima diferencia es 8 y corresponde al par 2 
Nota: La diferencia se calcula sobre un par de números, por lo tanto deben estar en memoria dos valores
consecutivos (Pri y Seg), que se actualizan en cada repetición. *)

var
    ant, i, num, cant, difer, par, maxDifer: integer; 

begin
    maxDifer := 0;
    repeat
        writeln('Escriba la cantidad de numeros que desea ingresar: ');
        readln(cant);
    until (cant>1);
    
    writeln('Ingrese el numero de la primera posicion: ');
    readln(ant);

    for i := 2 to cant do
        begin
            repeat
                writeln('Ingrese un numero menor que el anterior para la posicion: ', i);
                readln(num);   
            until (num<ant);

            difer := ant - num;
           
            if difer > maxDifer then
                begin
                    maxDifer := difer;
                    par := i-1;    
                end;    
            ant := num;
        end;
    writeln('La maxima diferencia es: ', maxDifer, ' y corresponde al par: ', par);
    readln();
end.