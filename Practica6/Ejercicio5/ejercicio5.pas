Program Ejercicio5;

(*Ej 5) Una Tarjeta de Crédito tiene información de las compras de sus N 
clientes en un archivo y en cada línea se almacenó:
    Número de cliente (puede repetirse)
    Tipo de compras (1=Supermercado, 2=Combustible, 3=Indumentaria, 4=Otros)
    Monto de la compra.
Nota: Un cliente puede registrar más de una compra del mismo tipo.

Leer los datos en un arreglo NroCli paralelo a la matriz acumulativa 
Compras de Nx4 donde la 1º columna corresponde a la compra en Supermercado,
la 2º a Combustible, la 3º a Indumentaria y la 4º a Otros. 
Calcular e Informar:
    a) Total de compras en cada rubro.
    b) Listado con los clientes en los cuales el monto en Supermercado superó a Indumentaria
    c) Promedio de compra por cliente. 
    d) Número de cliente que más consumió.
    e) Cuántos clientes no registraron compras en algún rubro. *)
    
const
    N = 10;
type
    TV = array[1..N] of word;
    TM = array[1..N,1..4] of real;

procedure InicializarArrayWord(var vec:TV);
var
    i:byte;
begin
    for i:=1 to N do
        vec[i]:=0;
end;

procedure InicializarMatriz(var matr:TM);
var
    i,j:byte;
begin
    for i:=1 to N do
        for j:=1 to 4 do
            matr[i,j]:=0;
end;

function Busqueda(NroCli:TV; numCli:word;contClientes:byte):byte;
var
    pos,i:byte;
begin
    pos:=0;
    for i:=1 to contClientes do
    begin
        if numCli = NroCli[i] then
            pos:=i;
    end;

    if pos=0 then
        Busqueda:= contClientes+1
    else
        Busqueda:=pos;
end;

procedure TotalCompras(vec:TV);
var
    i:byte;
begin
    for i:=1 to 4 do
    begin
        Write('La cantidad de compras en ');
        case i of
        1:WriteLn('Supermercado son ', vec[i]);
        2:WriteLn('Combustible son ', vec[i]);
        3:WriteLn('Indumentaria son ', vec[i]);
        4:WriteLn('Otros son ', vec[i]);
        end;
    end;
end;
//  b) Listado con los clientes en los cuales el monto en Supermercado superó a Indumentaria
procedure SuperanIndu(nroCli:TV;matr:TM;contClientes:byte);
var
    i,pos:byte;
    vecAux:TV;
begin
    pos:=0;
    for i:=1 to contClientes do
    begin
        if (matr[i,1]>matr[i,3]) and (matr[i,3]<>0) then
            begin
                pos:=pos+1;
                vecAux[pos]:=nroCli[i];
            end;
    end;
    WriteLn('Los clientes en los cuales el monto en Supermercado ha superado a Indumentaria son: ');
    for i:=1 to pos do
        Write(vecAux[i],'. ');
    
    WriteLn();
end;

procedure Promedio(NroCli,contComprasPorCli:TV;matr:TM;contClientes:byte);
var
    i,j:byte;
    acumMonto:real;
begin
    for i:=1 to contClientes do
    begin
        acumMonto := 0;
        for j:=1 to 4 do
        begin
            acumMonto:=acumMonto+matr[i,j];
        end;
        WriteLn('El promedio del cliente: ', NroCli[i], ' es: ', (acumMonto/contComprasPorCli[i]):0:2)
    end;
end;

function MasConsume(NroCli:TV;matr:TM;contClientes:byte):word;
var
    i,j,pos:byte;
    acum,mayorConsumo:real;
    numMayorConsumo:word;
begin
    mayorConsumo:=0;
    for i:=1 to contClientes do
    begin
        acum:=0;
        for j:=1 to 4 do
        begin
            acum:= acum + matr[i,j];
        end;
        if acum>mayorConsumo then
            begin
                mayorConsumo:=acum;
                pos:=i;
            end;
    end;
    MasConsume:=pos;
end;

function NoRegistranCompras(matr:TM;contClientes:byte):byte;
var
    i,j,cont:byte;
begin
    cont:=0;
    
    for i:=1 to contClientes do
    begin
        j := 0;
        repeat
            j:=j+1;
            If matr[i,j]=0 Then
                cont := cont+1;
        until (matr[i,j] = 0) or (j=4);
    end;
    NoRegistranCompras:=cont;
end;

var
    arch:text;
    compras:TM;
    NroCli,contCompras,contComprasPorCli:TV;
    numCli:word;
    tipoCom,contClientes,indice:byte;
    monto:real;
    
begin
    Assign(arch,'datos.TXT');
    reset(arch);
    InicializarArrayWord(contCompras);
    InicializarArrayWord(contComprasPorCli);
    InicializarMatriz(compras);
    contClientes:=0;
    while not eof(arch) do
    begin
        ReadLn(arch,numCli,tipoCom,monto);
        indice:= Busqueda(nroCli,numCli,contClientes);
        
        NroCli[indice]:= numCli;
        contCompras[tipoCom]:= contCompras[tipoCom] +1;
        contComprasPorCli[indice]:= contComprasPorCli[indice] +1;
        compras[indice,tipoCom]:=compras[indice,tipoCom] + monto;

        if indice>contClientes then
            contClientes:=indice;
    end;
    Close(arch);
    TotalCompras(contCompras);
    
    SuperanIndu(NroCli,compras,contClientes);
    Promedio(NroCli,contComprasPorCli,compras,contClientes);
    WriteLn('El cliente que mas ha consumido es: ', NroCli[MasConsume(NroCli,compras,contClientes)]);
    WriteLn('El numero de clientes que no registraron compras es: ', NoRegistranCompras(compras,contClientes));
end.