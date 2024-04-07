program Practica1Ejercicio2;

         (*Sea la siguiente sucesión: an = a1 + 3 (n-1), indica que es el n-ésimo término, y a1=1. Se pide:
a) ¿Cuál es el K-ésimo término, siendo K un valor ingresado por teclado?
b) ¿Cuál es la diferencia entre los términos k y (k+1)?*)
   const
     a1 = 1;
   var
     an, an2, n, dif: integer;
begin
    writeln('Ingrese el numero ');
    readln(n);

    an := a1 + 3*(n-1);
    an2 := a1 + 3*(n);
    dif := an2 - an;

    write('el K-esimo termino es: ', an, ' y la diferencia es: ', dif);
    readln();
end.