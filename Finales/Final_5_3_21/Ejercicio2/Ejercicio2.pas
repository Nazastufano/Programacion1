Program Ejercicio2;

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

Type
    ST10 = string[10];
    prov = 1..23;
    TRegMud = record
        empresa:ST10;
        codProv:prov;
        cantPaqEnvio:word;
        costoEnvio,pesoEnvio:real;
    end;

    TRegPro = record
        codProv:prov;
        nombre:String;
    end;

    TRegPP = record
        datosProv:TRegPro;
        sumPaqu:word;
    end;

    TVProv = array[1..23] of TRegPP;

    TArchMud = file of TRegMud;
    TArchPro = file of TRegPro;

procedure CargarVecProv(var archPro:TArchPro;var vecProv:TVProv);
var
    i:byte;
    R:TRegPro;
begin
    reset(archPro);
    read(archPro,R);
    i:=0;
    while NOT eof(archPro) do
    begin
        i:=i+1;
        vecProv[i].datosProv:=R;
        vecProv[i].sumPaqu:=0;
        read(archPro,R);
    end;
    close(archPro);
end;

function ProvMasPaquetes(vecProv:TVProv):string;
var
    posMasP,i:prov;
    nombre:String;
begin
    maxPaqu:=0;
    for i:=1 to 23 do
        if vecProv[i].sumPaqu>maxPaqu then
        begin
            maxPaqu:=vecProv[i].sumPaqu;
            nombre:=vecProv[i].datosProv.nombre;
        end;
    ProvMasPaquetes:=nombre;
end;

Procedure ArmarListado(var archMud:TArchMud;var vecProv:TVProv);
var
    RMu:TRegMud;
    RPr:TRegPro;
    empresaActual,nomEmMasPaq:ST10;
    sumaPaq,totalPaqEmp,masPaqEmp:word;
    sumaPeso,totalPesEmp, mayorMontoTotal,sumaMonto:real;
    provinciaActual,provMayMont:prov;
begin
    reset(archMud);
    read(archMud,RMu);

    masPaqEmp:=0;
    while (NOT eof(archMud)) or (NOT eof(archPro)) do
    begin
        empresaActual:=RMu.empresa;
        mayorMontoTotal:=0;
        totalPaqEmp:=0;
        totalPesEmp:=0;
        WriteLn('Empresa ', empresaActual);
        WriteLn('Provincia      Total de Paquetes       Peso Total  Monto Total');
        while (empresaActual=RMu.empresa) do
        begin
            provinciaActual:=RMu.codProv;
            sumaPaq:=0;
            sumaMonto:=0;
            sumaPeso:=0;
            while (empresaActual=RMu.empresa) and (provinciaActual=RMu.codProv) do
            begin
                sumaPaq:=sumaPaq+RMu.cantPaqEnvio;
                sumaMonto:=sumaMonto+RMu.costoEnvio;
                sumaPeso:=sumaPeso+RMu.pesoEnvio;
                vecProv[provinciaActual].sumPaqu:=vecProv[provinciaActual].sumPaqu+sumaPaq;
                read(archMud,RMu);
            end;
            WriteLn(provinciaActual,'           ',sumaPaq,'         ',sumaPeso:0:2,'           $',sumaMonto:0:2);
            if sumaMonto>mayorMontoTotal then
            begin
                mayorMontoTotal:=sumaMonto;
                provMayMont:provinciaActual;
            end;
            totalPesEmp:=totalPesEmp+sumaPeso;
            totalPaqEmp:=totalPaqEmp+sumaPaq;
        end;
        WriteLn('Peso promedio por paquete: ', totalPaqEmp/totalPesEmp:0:2);
        WriteLn('Provincia destino con mayor monto total: ', vecProv[provMayMont].datosProv.nombre);
        if totalPaqEmp>masPaqEmp then
        begin
            masPaqEmp:=totalPaqEmp;
            nomEmMasPaq:=empresaActual;
        end;
    end;
    Close(archMud);
    WriteLn('La empresa ', nomEmMasPaq, ' es la que mas paquetes transporto');
    WriteLn(ProvMasPaquetes(vecProv),' es la provincia destino con mayor recepcion de paquetes');
end;
var
    archMud:TArchMud;
    archPro:TArchPro;
    vecProv:TVProv;

begin
    Assign(archMud,'MUDANZAS.DAT');
    Assign(archPro,'PROVINCIA.DAT');
    
    CargarVecProv(archPro,vecProv);
    ArmarListado(archMud,vecProv);
end.