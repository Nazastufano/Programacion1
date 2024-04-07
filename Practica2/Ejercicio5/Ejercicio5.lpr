program Practica2Ejercicio5;

(*Ej 5) Dados tres números enteros mostrar el mayor de ellos. Plantear tres soluciones:
a) Alternativas secuenciales
b) Alternativas anidadas con expresiones lógicas compuestas
c) Alternativas anidadas con expresiones lógicas simples*)

var mayor, numero1, numero2, numero3: integer;

(*begin
     writeln('ingrese un numero: ');
     readln(numero1);
     writeln('ingrese otro numero: ');
     readln(numero2);
     writeln('ingrese otro numero: ');
     readln(numero3);
     if numero1>numero2 then
        if numero1>numero3 then
        begin
             mayor := numero1;
             writeln('El numero1 es mayor' );
        end
        else
            writeln('el numero 3 es el mayor')
     else
         if numero2>numero3 then
            writeln('numero2 es el mayor')
         else
             writeln('numero 3 es mayor');
     readln();
end.
*)
begin
     writeln('ingrese un numero: ');
     readln(numero1);
     writeln('ingrese otro numero: ');
     readln(numero2);
     writeln('ingrese otro numero: ');
     readln(numero3);

     if (numero1> numero2) and (numero1>numero3) then
        writeln('numero1 es el mayor')
     else
         if (numero1<numero2) or (numero1<numero3) then
            if numero2>numero3 then
               writeln('numero 2 es el mayor')
            else
                writeln('numero 3 es el mayor')
         else
             writeln('los numeros son iguales');
     readln();
end.
