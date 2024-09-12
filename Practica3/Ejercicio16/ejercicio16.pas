program Ejercicio16;

(*Ej 16) Una empresa de autos de alquiler posee N vehículos y ha registrado la siguiente información de los
viajes realizados, por cada uno de ellos:
    Patente
    Total de litros de combustible consumidos
Y por cada viaje realizado
    - Kilómetros recorridos. (0 indica fin de datos).
Se pide ingresar los datos e informar:
a) Por cada vehículo el consumo que tuvo (cantidad de litros por km. recorrido)
b) Patente del vehículo que más viajes hizo.
c) Total de litros consumidos por el auto que hizo la menor cantidad de kms. *)

var
    arch:text;
    patente, patenteMasViajes: string[6];
    n,i, contViajes,maxCantViajes,menCantViajes:word;
    litros, menosCantLitros, menCantKm, kilometros, totalKilometros:real;

begin
    Assign(arch, 'datos.TXT');
    Reset(arch);
    ReadLn(arch,n);
    maxCantViajes:= 0;
    menCantViajes:= 999;
    for i:=1 to n do
    begin
        totalkilometros:= 0;
        contViajes:=0;
        
        ReadLn(arch, patente, litros);
        readln(arch,kilometros);
        
        while kilometros <> 0 do
        begin
            contViajes:= contViajes +1;
            totalkilometros:= totalkilometros + kilometros;
            readln(arch,kilometros);
        end;

        if contViajes>maxCantViajes then
            begin
                patenteMasViajes:= patente;
                maxCantViajes:= contViajes;
            end;
        if menCantViajes>contViajes then
            begin
                menCantViajes:= contViajes;
                menosCantLitros:= litros;
            end;

        WriteLn('La cantidad de Litros consumidos por kilometro recorrido del vehiculo ', i, ' es: ', litros/totalkilometros:0:2, 'L/Km');
    end;
    WriteLn('La patente que mas viajes hizo es: ', patenteMasViajes);
    WriteLn('La cantidad de litros consumidos por el auto que menos cantidad de kilometros ha recorrido es: ', menosCantLitros:0:2);
end.