program Final;

(*Se cuenta con un archivo con los datos de las mudanzas realizadas por distintas empresas de transporte y 
otro archivo con los nombres de las provincias argentinas, de la siguiente manera: 
 
Archivo MUDANZAS 
 EMPRESA: ANU10 (1er campo de secuencia, clave secundaria) 
 COD_PROVINCIA (Destino 1..23)  (2do campo de sec, clave secundaria) 
 CANT_PAQ_ENVIO 
 PESO_ENVIO (en kilos) 
 COSTO_ENVIO (en pesos) 

Archivo PROVINCIA  
 COD_PROVINCIA (1..23) (clave primaria) 
 NOMBRE  

Se pide, recorriendo una sola vez el archivo Mudanzas, generar el siguiente listado: 
  
Empresa  xxxxxxxxxx 
    Provincia  Total de Paquetes    Peso Total Monto Total 
    Xxxxxxx   9999   999.99  $ 99.999.99 
    Xxxxxxx   9999   999.99  $ 99.999.99 
     .....    .....   .....  ..... 
 Peso promedio por paquete : 999.99 
 Provincia destino con mayor monto total: Xxxxxxx 
 
Empresa  xxxxxxxxxx 
    Provincia  Total de Paquetes    Peso Total Monto Total 
    Xxxxxxx   9999   999.99  $ 99.999.99 
    Xxxxxxx   9999   999.99  $ 99.999.99 
     .....    .....   .....  ..... 
 Peso promedio por paquete : 999.99 
 Provincia destino con mayor monto total: Xxxxxxx 
.......... 
 
La empresa xxxxx es la que más paquetes transportó. 
 
Xxxxxx es la provincia destino con mayor recepción de paquetes  *)
type
    ST10=string[10];
    ST15 =String[15];
    TRegMud = record
        empresa:ST10;
        cod:1..23;
        cantEnvios:byte;
        costoEnvio,pesoEnvio:real;
    end;
    TRegProv = record
        nombre:st15;
        codProv:1..23;
    end;
    TVCont = array[1..23] Of word;
    TVProv = array[1..23] of TRegProv;
    TArchProvinicas = file of TRegProv;
    TArchMudanzas = file of TRegMud;
procedure ArmarVector(var archProvinicas:TArchProvinicas; var vecProvincias:TVProv);
var
    i:byte;
    RPr:TRegProv;
begin
    i:=0;
    reset(archProvinicas);
    while not Eof(archProvinicas) do
    begin
        i:=i+1;
        read(archProvinicas,RPr);
        vecProvincias[i].nombre:=Rpr.nombre;
        vecProvincias[i].codProv:=Rpr.codProv;
    end;
    Close(archProvinicas);
end;
procedure InicializarVec(var vecCont:TVCont);
var
    i:byte;
begin
    for i:=1 to 23 do
        vecCont[i]:=0;
end;
procedure ProvMasPaquetes(vecCont:TVCont;vecProvincias:TVProv);
var
    pMP,i:byte;
    mayorCantPa:Word;
begin
    mayorCantPa:=0;

    for i:=1 to 23 do
        if vecCont[i]>mayorCantPa then
        begin
            mayorCantPa:=vecCont[i];
            pMP:=i
        end;
    Writeln(vecProvincias[pMP], ' es la provincia destino con mayor recepción de paquetes');
end;
procedure ArmarLista(var archMudanzas:TArchMudanzas;vecProvincias:TVProv);
var
    acumPaquetes,mayorCantidadPaquetes,totalPaquetes:word;
    pesoTotal,montoTotal,mayorMontoTotal:real;
    RMu:TRegMud;
    provMayorMonto,provActual:1..23;
    empresaMasPaquetes,empresaActual:ST10;
    vecCont:TVCont;
begin
    Reset(archMudanzas);
    read(archMudanzas,RMu);
    mayorMontoTotal:=0;
    mayorCantidadPaquetes:=0;
    InicializarVec(vecCont);
    while (not eof(archMudanzas)) do
    begin
        empresaActual:=RMu.empresa;
        Writeln('Empresa ', empresaActual);
        acumPaquetes:=0;
        while empresaActual = RMu.empresa do
        begin
            Writeln('Provincia  Total de Paquetes    Peso Total Monto Total');
            provActual:=RMu.cod;
            pesoTotal := 0;
            montoTotal :=0;
            totalPaquetes:=0;
            while (provActual=RMu.cod) and (empresaActual = RMu.empresa) do
            begin
                pesoTotal:=pesoTotal+RMu.pesoEnvio;
                totalPaquetes:=totalPaquetes+RMu.cantEnvios;
                montoTotal:=montoTotal+RMu.costoEnvio;
                read(archMudanzas,RMu);
            end;
            vecCont[provActual] := vecCont[provActual]+totalPaquetes;
            If montoTotal>mayorMontoTotal Then
            begin
                provMayorMonto:=provActual;
                mayorMontoTotal:=montoTotal;
            end;                
            
            acumPaquetes:=acumPaquetes+totalPaquetes;
            WriteLn(vecProvincias[provActual].nombre, ' ', totalPaquetes, ' ', pesoTotal:0:2, ' ', montoTotal:0:2);
        end;
        if acumPaquetes>mayorCantidadPaquetes then
        begin
            mayorCantidadPaquetes:=acumPaquetes;
            empresaMasPaquetes:=empresaActual;
        end;
        WriteLn('Peso promedio por paquete: ', pesoTotal/totalPaquetes:0:2);
        WriteLn('Provincia destino con mayor monto total ', vecProvincias[provMayorMonto].nombre);
    end;
    Close(archMudanzas);
    WriteLn('La empresa ', empresaMasPaquetes, ' es la empresa que mas ha transportado');
    ProvMasPaquetes(vecCont,vecProvincias);
end;
var
    archProvinicas:TArchProvinicas;
    archMudanzas:TArchMudanzas;
    vecProvincias:TVProv;
begin
    Assign(archProvinicas,'PROVINCIAS.DAT');
    Assign(archMudanzas,'MUDANZAS.DAT');
    ArmarVector(archProvinicas,vecProvincias);
    ArmarLista(archMudanzas,vecProvincias);
end.