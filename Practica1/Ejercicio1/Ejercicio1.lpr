program Ejercicio1;
     
     (*Ej 1)En una pinturería informan que para obtener el color “gris mara” se debe mezclar 9.5 litros de Negro
y 4.5 litros de Blanco. Se quiere asesorar a un cliente con las cantidades que necesita mezclar para
obtener el color si:
a) Tiene N litros de pintura Blanca. ¿Cuánto debe comprar de pintura Negra? .
b) Tiene M litros de pintura Negra. ¿Cuánto debe comprar de pintura Blanca?*)

var
     cantBlanco, cantNegro: real;

begin 
     writeln('Ingrese la cantidad de pintura negra que usted tiene: ');
     readln(cantNegro);
     
     cantBlanco := ((cantNegro*4.5)/9.5);
     
     writeln('A usted le falta ' , cantBlanco:3:1 , 'L de pintura blanca');
     readln();
      
     (*writeln('Ingrese la cantidad de pintura blanca que usted tiene: ');
     readln(cantBlanco);
     
     cantNegro := ((cantBlanco*9.5)/4.5);
     
     writeln('A usted le falta ' , cantNegro:3:1 , 'L de pintura negra');
     readln(); *)
end.

