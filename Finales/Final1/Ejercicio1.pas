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
Fecha en la que se realizó la mayor recaudación: xxxxxxxx*)
type
    ST3 = string[3];
    ST8 = string[8];
    ST20 = string[20];
    TRegCar = record
        codCir:ST3;
        fecha:ST8;
        cantEntradas:word;
    end;
    TRegCir = record
        codCir:ST3;
        nomCiudad:ST20;
        capacidadMaxEntr:word;
        valorEntrada:real;
    end;
    TV = array[1..50] of ST3;
    TArchCar = file of TRegCar;
    TArchCir = file of TRegCir;
procedure crearTablaAux(var archCar:TArchCar;var vec:TV;var cantCircuitos:byte);
var
    i:byte;
    R:TRegCar;
begin
    Reset(archCar);
    read(archCar,R);
    i:=0;
    while NOT eof(archCar) do
    begin
        i := i+1;
        vec[i]:=R.codCir;
        read(archCar,R);
    end;
    cantCircuitos:=i;
    close(archCar);
end;
function Busqueda(vec:TV;cod:ST3;cantCircuitos:byte):byte;
var
    i:byte;
begin
    i:=1;
    while (i<=cantCircuitos) and (vec[i]<>cod) do
        i:=i+1;
    
    Busqueda:=i;
end;
procedure ArmarTabla(var archCar:TArchCar; var archCir:TArchCir;var vec:TV);
var
    RCa:TRegCar;
    RCi:TRegCir;
    acumEntradas,acumEntradasCiudad:word;
    cantCiudades:byte;
    fechaMayorRec:ST8;
    maxRecaud,acumPrecio,recaud:real;
begin
    Reset(archCar);
    Reset(archCir);
    
    read(archCir,RCi);
    acumPrecio := 0;
    cantCiudades:=0;
    maxRecaud:=0;
    acumEntradas := 0;
    while (not eof(archCir)) do
    begin
        acumEntradasCiudad :=0;
        WriteLn('Nombre Ciudad: ', RCi.nomCiudad);
        Seek(archCar,Busqueda(vec,RCi.codCir,cantCircuitos)-1);
        read(archCar,RCa);
        WriteLn('Fecha carrera      Entradas vendidas       % Ocupacion');
        cantCiudades:=cantCiudades+1;
        While RCa.codCir=RCi.codCir Do
        begin
            WriteLn(RCa.fecha,'     ', RCa.cantEntradas,'     ', RCi.capacidadMaxEntr/RCa.cantEntradas:0:2,'%');
            recaud:=RCa.cantEntradas*RCi.valorEntrada;
            if maxRecaud < recaud then
            begin
                maxRecaud:=recaud;
                fechaMayorRec:=RCa.fecha;
            end;
            acumEntradasCiudad:=acumEntradasCiudad+RCa.cantEntradas;
            acumPrecio := acumPrecio+ recaud;
            Read(archCir,RCi);
        end;
        WriteLn('Total de entradas vendidas en cidudad ', RCi.nomCiudad,': ', acumEntradasCiudad);
        acumEntradas:=acumEntradas + acumEntradasCiudad;
    end;
    WriteLn('Importe total Recaudado por entradas: $', acumPrecio);
    WriteLn('Promedio general de entradas vendidas por ciudad: ', acumEntradas/cantCiudades:0:2);
    WriteLn('Fecha en la que se realizó la mayor recaudación: ', fechaMayorRec);
    close(archCar);
    Close(archCir);
end;
var
    archCar:TArchCar;
    archCir:TArchCir;
    vec:TV;
    cantCircuitos:byte;
Begin
    Assign(archCar,'CARRERAS.DAT');
    Assign(archCir,'CIRCUITOS.DAT');
    crearTablaAux(archCar,vec,cantCircuitos);
    ArmarTabla(archCar,archCir,vec);
End.