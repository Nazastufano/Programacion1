program Ejercicio16;

(*Ej 16) Una empresa de autos de alquiler posee N vehículos y ha registrado la siguiente información de los
viajes realizados, por cada uno de ellos:
 Patente
 Total de litros de combustible consumidos
Y por cada viaje realizado
 - Kilómetros recorridos. (0 indica fin de datos).
Se pide ingresar los datos e informar:
a) Por cada vehículo el consumo que tuvo (cantidad de litros por km. recorrido)
b) Patente del vehículo que más viajes hizo.
c) Total de litros consumidos por el auto que hizo la menor cantidad de kms. *)

var
    arch: text;
    n, kilometros, menCantLitros, litros, contKilometros, minCantKm, i, nViajes, masViajes: integer;
    patente, patenteMasViajes: string[6];
    cantLitros: real;

begin
    assign(arch, 'datos.TXT');
    reset(arch);
    readln(arch, n);
    masViajes := 0;
    minCantKm := 30000;
    for i := 1 to n do
        begin
            nViajes := 0;
            contKilometros := 0;
            read(arch, patente, litros);
            repeat
                readln(arch, kilometros);
                contKilometros := kilometros + contKilometros;
                
                if kilometros <> 0 then
                    nViajes := nViajes +1;
            until (kilometros = 0); 

            if nViajes>masViajes then
                begin
                    masViajes := nViajes;
                    patenteMasViajes := patente;    
                end;

            if minCantKm>contKilometros then
                begin
                    minCantKm := contKilometros;
                    menCantLitros := litros;    
                end; 

            cantLitros := litros/contKilometros;
            writeln('El vehiculo: ',i, ' consumio ', cantLitros:0:2, 'L/Km');
        end;    
    writeln('El vehiculo que mas km recorrio tiene la patente: ', patenteMasViajes);
    writeln('Los litros del vehiculo que menos km recorrio son: ', menCantLitros);
end.