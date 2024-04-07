program ejercicio1Practica4;
(*Ej 1) Desarrollar una función booleana que dado un 
   caracter diga si es letra o no*)
Function esLetra(caracter: char): boolean;
        begin
             caracter := upCase(caracter);
             if caracter in ['A'..'Z'] then
               esLetra := true;
        end;
var
  letra: char;


begin
     writeln('Escriba un caracter');
     readln(letra);
     if esLetra(letra) then
        writeln('El caracter ingresado es una letra')
     else
        writeln('El caracter ingresado no es una letra');

     readln();

end.

