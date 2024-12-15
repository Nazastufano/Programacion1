Program Ejercicio1;

(*Un balneario cuenta con un archivo VERANO2021 con los consumos de los 
clientes que alquilaron carpa ó sombrilla en la temporada 2021 y otro archivo con los 
clientes que dejaron hecha una reserva durante el 2020. 
Las Tarifas fueron: Carpa  $ 80.000,  Sombrilla  $ 50.000  y cada Visita  $200 
 
VERANO2021 
● Cliente (ANU5 campo de secuencia, 
clave primaria) 
● Nombre 
● CodCarSom(ANU 3) 
(Carpas C01..C50 - Sombrillas S01..S99) 
● Cantidad de visitantes  
● Gastos de consumos 

RESERVAS
● Cliente (ANU5 campo de secuencia, 
clave primaria) 
● Importe reserva 
 
Se tiene además un archivo histórico con la cantidad de veces que se 
alquiló cada carpa y sombrilla con anterioridad al 2021, 

HISTÓRICO
CodCarSom
Cant

Se pide, actualizar el Histórico a partir de VERANO2021 y emitir el siguiente 
listado: 
 
Liquidación Temporada 2021 
Cliente               Consumos        Reserva(.)     Importe Total(..) 
Xxxxx                 $ 9999.99        $ 9999           $ 99999.99 
Xxxxx                 $ 9999.99        $ 9999           $ 99999.99 
 . . . . . . . . 
Promedio de Importe Total por cliente: $ 99999.99 
 
(.) Si no reservó corresponde 0 
(..)Importe Total= Valor carpa ó sombrilla + Consumos + importe* Visitantes - Reserva 
 
Informar además: 
a) Monto total en reservas hechas y NO usadas en el 2021. 
b) Cantidad de clientes que no hicieron reserva previa. 
c) Código de carpa con mayor gasto de consumos. 

*)
Type
    ST3 = string[3];
    ST5 = string[5];
    ST20 = string[20];
    TRegRes = record
        cliente:ST5;
        importe:real;
    end;
    TRegVer = record
        cliente:ST5;
        nombre:ST20;
        codCarSom:ST3;
        cantVisit:byte;
        gastosConsumo:real;
    end;
    TRegHis = record
        codCarSom:ST3;
        cant:byte;
    end;

    TVST3 = array[1..150] of ST3;
    TArchHis = file of TRegHis;
    TArchVer = file of TRegVer;
    TArchRes = file of TRegRes;
function Busqueda(vecST3:TVST3;cod:ST3):byte;
var
    i:byte;
begin
    i:=1;
    while (i<=150) and (vecST3[i]<>cod) do
        i:=i+1;
    Busqueda:=i;
end;
procedure ArmarTabla(var archHis:   TArchHis; var vecST3:TVST3);
var
    i:byte;
    RHi:TRegHis;
begin
    i:=0;
    Reset(archHis);
    read(archHis,RHi);
    while not eof(archHis) do
    begin
        i:i+1;
        vecST3[i]:=RHi.codCarSom;
        read(archHis,RHi);
    end;
    Close(archHis);
end;

procedure actualizarDatos(var importeTotal,acumImporteTotal,mayorConsumo:Real; var cantClientes:byte; RVe:TRegVer; codCarMasConsum:ST3; importe:real);
begin
    cantClientes := cantClientes+1;

    if RVe.codCarSom in ['C01'..'C50'] then
        importeTotal:=80000
    else
        importeTotal:=50000;

    importeTotal:= importeTotal + RVe.gastosConsumo + RVe.cantVisit*200 - importe;
    WriteLn(RVe.cliente,'   $', RVe.gastosConsumo,'     $',importe,'     $', importeTotal);
    acumImporteTotal:=acumImporteTotal+importeTotal;

    if (RVe.gastosConsumo>mayorConsumo) and (RVe.codCarSom In ['C01'..'C50']) then
    begin
        mayorConsumo:=RVe.gastosConsumo;
        codCarMasConsum:=RVe.codCarSom;
    end;
end;

procedure ActualizarArch(var archHis:   TArchHis; var archVer:   TArchVer; var archRes:TArchRes; vecST3:TVST3;nom:ST20);
var
    archTemp:TArchHis;
    RVe:TRegVer;
    RRe:TRegRes;
    RHi:TRegHis;
    codCarMasConsum:ST3;
    cantClientesSinRes,cantClientes:byte;
    acumImporteTotal,mayorConsumo,montoTotalReservasNoUsadas,importeTotal:real;
begin
    Assign(archTemp,'TEMP.DAT');
    Rewrite(archTemp);
    
    Reset(archHis);
    Reset(archVer);
    Reset(archRes);
    read(archVer,RVe);
    read(archRes,RRe);
    cantClientesSinRes:=0;
    cantClientes:=0;
    acumImporteTotal:=0;
    
    WriteLn('Liquidación Temporada 2021');
    while (NOT eof(archRes)) or (NOT eof(archVer)) do
    begin
        WriteLn('Cliente               Consumos        Reserva     Importe Total');
        Seek(archHis,Busqueda(vecST3,RVe.codCarSom)-1);
        read(archHis,RHi);
        RHi.cant:=RHi.cant+1;
        
        if RVe.cliente=RRe.cliente then
        begin
            actualizarDatos(importeTotal,acumImporteTotal,mayorConsumo,cantClientes,RVe,codCarMasConsum,RRe.importe);
            
            Read(archVer,RVe);
            Read(archRes,RRe);
        end
        else if RVe.cliente<RRe.cliente then
        begin    
            cantClientesSinRes:=cantClientesSinRes+1;
            actualizarDatos(importeTotal,acumImporteTotal,mayorConsumo,cantClientes,RVe,codCarMasConsum,0);
        
            read(archVer,RVe);
        end
            else
            begin
                montoTotalReservasNoUsadas:=montoTotalReservasNoUsadas+RRe.importe;
                Read(archRes,RRe);
            end;
        Write(archTemp,RHi);
    end;
    WriteLn('Promedio de Importe Total por cliente:   $', acumImporteTotal/cantClientes);
    WriteLn('Monto total en reservas hechas y NO usadas en el 2021: ', montoTotalReservasNoUsadas);
    WriteLn('Cantidad de clientes que no hicieron reserva previa: ', cantClientesSinRes);
    WriteLn('Codigo de carpa con mayor gasto de consumos: ', codCarMasConsum);
    
    close(archTemp);
    close(archHis);
    close(archVer);
    Close(archRes);
    Erase(archHis);
    Rename(archTemp,nom);

end;
var
    archHis:TArchHis;
    archVer:TArchVer;
    archRes:TArchRes;
    vecST3:TVST3;
begin
    Assign(archHis,'HISTORICO.DAT');
    Assign(archVer,'VERANO2021');
    Assign(archRes,'RESERVAS.DAT');
    
    ArmarTabla(archHis,vecST3);
    ActualizarArch(archHis,archVer,archRes,vecST3,'HISTORICO.DAT');
end.