Program Ejercicio1;

(*A principio de cada año se abre el calendario de la categoría automovilística Top Race que
se desarrolla en circuitos distribuidos en distintas ciudades del país. En cada fecha puede haber
carreras en distintas ciudades, pero sólo una carrera por ciudad.
Al finalizar el año, en una archivo CARRERAS.DAT se tienen los siguientes datos de los circuitos:
    Código de Circuito (cadena de 3- campo de secuencia, clave secundaria)
    Fecha de la carrera (cadena de 8, AAAAMMDD- campo de secuencia)
    Cantidad de entradas vendidas (entero positivo)

Además, se cuenta con un archivo CIRCUITOS.DAT con la siguiente información:
    Código de Circuito (cadena de 3- clave primaria, desordenado)
    Nombre ciudad (cadena de 20)
    Capacidad máxima de entradas del circuito (entero positivo)
    Valor único de la entrada (real)
Se pide declarar los tipos y resolver desarrollando los subprogramas y el programa principal:
a) Generar el siguiente listado:
Nombre Ciudad: xxxxxxxxxxxxxxxxxxxxx
           Fecha carrera    Entradas vendidas   % Ocupacion
            xxxxxxxxx             99999            xx.xx%
            xxxxxxxxx             99999            xx.xx%
            .........
Total de entradas vendidas en ciudad xxxxxxxxxxxxxxxxxxxxxx: xxx

Nombre Ciudad: xxxxxxxxxxxxxxxxxxxxx
           Fecha carrera    Entradas vendidas   % Ocupacion
            xxxxxxxxx             99999            xx.xx%
            xxxxxxxxx             99999            xx.xx%
            .........
Total de entradas vendidas en ciudad xxxxxxxxxxxxxxxxxxxxxx: xxx

Importe total Recaudado por entradas: $xxxxxxx.xx
Promedio general de entradas vendidas por ciudad: xxxx.xx
Fecha en la que se realizó la mayor recaudación: xxxxxxxx

*)
Type
    ST3 = string[3];
    ST8 = string[8];
    ST20 = string[20];

    TRegCar = record
        codCir:ST3;
        fechaCar:ST8;
        cantEntrVen:word;
    end;

    TRegCir = record
        codCir:ST3;
        nomCiu:ST20;
        capacidadMax:word;
        valorDeEntr:real;
    end;

    TVecCir = array[1..200] of TRegCir;
    TArchCar = file of TRegCar;
    TArchCir = file of TRegCir;

procedure CargarVecCircuitos(var archCir:TArchCir; var vecCir:TRegCir; var cantCir:byte);
var
    i:byte;
    R:TRegCir;
begin
    reset(archCir);
    read(archCir,R);
    i:=0;
    while not Eof(archCir) do
    begin
        i:=i+1;
        vecCir[i]:=R;
        read(archCir,R);
    end;
    cantCir:=i;
    Close(archCir);
end;

function BusquedaCir(vecCir:TVecCir;codCir:ST3;cantCir:byte):byte;
var
    i:byte;
begin
    i:=1;
    while (i<cantCir) and (vecCir[i].codCir<>codCir) do
        i:=i+1;

    BusquedaCir:=i;
end;

procedure ArmarListado(var archCar:TArchCar;vecCir:TVecCir;cantCir:byte);
var
    RCa:TRegCar;
    posCir,contCiudConVen:byte;
    ciudadActual:ST20;
    fechaMayorRec,fechaActual:ST8;
    codCirActual:ST3;
    sumEntrVenFec,sumEntrVenCiu,totalEntradas:word;
    mayorRec, totalRecEntradas,recaudacionFecha:real;
    
begin
    reset(archCar);
    read(archCar,RCa);
    contCiudConVen:=0;
    mayorRec:=0;
    while Not eof(archCar) do
    begin
        posCir:=BusquedaCir(vecCir,RCa.codCir,cantCir);
        codCirActual:=vecCir[posCir].codCir;
        sumEntrVenCiu:=0;
        contCiudConVen:=contCiudConVen+1;
        WriteLn('Nombre Ciudad: ', ciudadActual);
        WriteLn('       Fecha Carrera       Entradas vendidas       % Ocupacion');
        while RCa.codCir = codCirActual do
        begin
            sumEntrVenFec:=RCa.cantEntrVen;
            
            WriteLn('      ',RCa.fechaCar,'        ',RCa.cantEntrVen*100/vecCir[posCir].capacidadMax,'%');
            
            recaudacionFecha:=sumEntrVenFec*vecCir[posCir].valorDeEntr;
            totalRecEntradas:=totalRecEntradas+recaudacionFecha;
            sumEntrVenCiu:=sumEntrVenCiu+sumEntrVenFec;
            
            if recaudacionFecha>mayorRec then
            begin
                fechaMayorRec:=fechaActual;
                mayorRec:=recaudacionFecha;
            end;
            
            read(archCar,RCa);
        end;
        totalEntradas:=totalEntradas+sumEntrVenCiu;
        
        WriteLn('Total de entradas vendidas en ciudad ', ciudadActual,': ', sumEntrVenCiu);
    end;
    close(archCar);
    WriteLn('Importe total Recaudado por entradas: $', totalRecEntradas:0:2);
    WriteLn('Promedio general de entradas vendidas por ciudad: ', totalEntradas/contCiudConVen:0:2);
    Writeln('Fecha en la que se realizo la mayor recaudacion: ', fechaMayorRec);
end;
var
    archCar:TArchCar;
    archCir:TArchCir;
    vecCir:TVecCir;
    cantCir:byte;

begin
    Assign(archCar,'CARRERAS.DAT');
    Assign(archCir,'CIRCUITOS.DAT');

    CargarVecCircuitos(archCar,vecCir,cantCir);
    ArmarListado(archCar,vecCir,cantCir);
end.
