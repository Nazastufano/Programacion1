program Ejercicio5;
        
(*Ej 5) Hacer un programa para cada ítem donde dado un entero N de más de 3 cifras se logre:
a) quitarle las 3 últimas cifras
b) hallar la cifra que se encuentra en posición de las centenas.*)

var
    entero: integer;
    resultado: real;

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
    
    resultado := (entero/1000);
    Writeln('El numero ingresado retirandole 3 cifras es: ', Trunc(resultado));
    
    entero := (entero div 100);
    entero := (entero mod 10);
    resultado := entero;
    writeln('La cifra que se encuentra en las centenas es: ', resultado:1:0);

    readln();
end.

