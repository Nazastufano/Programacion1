program Ejercicio1;

(*Ej 1) Dados N números enteros, calcular e informar:

a) El máximo, qué lugar ocupa la primera aparición y cuántas ocurrencias tiene.
b) El mínimo de los impares (informar si no existe)

Ejemplo: N = 10, 78, 45, 80, 56, 80, 32, 90, 89, 90, 45
    a) 90 - 7º lugar - 2 ocurrencias
    b) 45 
*)

var
    cant, num, i, max, minImpar, numRepe, posicion: integer;

begin
    max := -32767;
    minImpar := 32767;
    repeat
        writeln('Cuantos numeros desea ingresar: ');
        readln(cant);

        if cant<=0 then
            writeln('Ingrese un numero valido');
    until (cant>0);

    for i := 1 to cant do
        begin
            writeln('Ingrese el numero de la posicion: ', i);
            readln(num);

            if (num > max) and (max <> num) then
                begin
                    max:= num;
                    posicion:= i;
                    numRepe := 0;
                end;            
            
            if num = max then
                numRepe := numRepe + 1;

            if ((num mod 2) <> 0) and (num < minImpar) then
                minImpar := num;
        end;

    writeln(max, ' - posicion ', posicion, ' - ', numRepe, ' ocurrencias');

    if minImpar = 32767 then
        writeln('No existe numero minimo impar')
    else
        writeln('El numero minimo impar es: ', minImpar);  
end.