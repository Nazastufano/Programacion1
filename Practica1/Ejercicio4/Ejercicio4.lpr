program Ejercicio4;
   (*Ej 4) Dado un terreno de 10 x 30 se quiere embaldosar una superficie de N x M. Calcular e informar:
a) Qué superficie representa del total del terreno.
b) Si cada baldosa es de 0.25 x 0.25. ¿Cuántas se deben comprar para hacer el trabajo?*)
   
const
   supTerr= 300;
   bald = 0.25*0.25;
var
   n, m, sup, supEmb, totalBaldosas: real;

begin
   repeat
      writeln('Ingrese el ancho de a embaldosar: ');
      read(n);

      writeln('Ingrese el largo de a embaldosar: ');
      read(m);

      if m*n >= supTerr then
         writeln('Las dimensiones ingresadas son mayores a la superficie disponible');   
   until m*n <=supTerr;

   sup := n*m;
   supEmb := sup*100/supTerr;
   writeln('La superficie de total de terreno es: ', supEmb:2:1, '%');


   totalBaldosas := sup/bald;
   writeln('Debe comprar: ', totalBaldosas:3:0);
   readln();
end.

