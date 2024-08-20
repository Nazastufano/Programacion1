program Ejercicio5;
        
(*Ej 5) Hacer un programa para cada ítem donde dado un entero N de más de 3 cifras se logre:
a) quitarle las 3 últimas cifras
b) hallar la cifra que se encuentra en posición de las centenas.*)

var
    entero: integer;

begin
    Writeln('Ingrese un entero de más de 3 cifras (Ej: 1000): ');
    readln(entero);
    
    if entero < 1000 then
        begin
            repeat
                Writeln('Por favor, ingrese un numero correcto, mayor de 3 cifras: ');
                readln(entero);    
            until entero >= 1000;
        end;
    
    Writeln('El numero ingresado retirandole 3 cifras es: ', Trunc(entero/1000));
    
    writeln('La cifra que se encuentra en las centenas es: ', ((entero Div 100) mod 10));

    readln();
end.

