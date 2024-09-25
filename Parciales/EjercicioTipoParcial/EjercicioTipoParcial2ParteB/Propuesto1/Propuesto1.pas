Program Propuesto1;

(*Ejercicios propuestos 1)Una compañía Láctea recibe la producción diaria de, en litros de leche, de N tambos de la zona,
durante varios días consecutivos (no se conoce).

Los datos vienen de la siguiente manera:

    *Código del Tambo (cadena de 4 caracteres) y a continuación
        la entrega diaria en litros, 0=fin de datos.

Se pide, armar 3 vectores paralelos, COD, TOT, PROM y además calcular e informar:
    a) Código del tambo que más leche entregó a la compañía.
    b) Cuántos superaron un promedio de X litros de entrega.
    c) Dado un código, el total y el promedio diario entregado, (si es que existe dicho código).

COD con los códigos de cada Tambo
TOT con los totales de litros entregados
PROM con el promedio diario entregado

Ejemplo:
N=4
AA12
200 100 50 150 100 0
BB07 
200 110 90 120 0
CC33
85 110 60 0
DD45
80 120 80 140 0

COD   TOT  PROM
AA12  600  120
BB07  520  130
CC33  245  85
DD45  420  105

*)
const
    N = 4;

type
    ST4 = string[4];
    TVCod = array[1..N] of ST4;
    TVTot = array[1..N] of word;
    TVProm = array[1..N] of real;

function MasLeche(vCod:TVCod; vTot:TVTot):ST4;
var
    i:byte;
    mas:word;
    codMas:ST4;
begin
    mas:=vTot[1];
    codMas:=vCod[1];
    for i:=2 to N do
    begin
        if mas<vTot[i] then
        begin
            mas:=vTot[i];
            codMas:=vCod[i];
        end;
    end;
    MasLeche:=codMas;
end;

function Superaron(x:word;vProm:TVProm):byte;
var
    i,cont:byte;
begin
    cont:=0;
    for i:=1 to N do
    begin
        if vProm[i]>x then
            cont:=cont+1;
    end;
    Superaron:=cont;
end;

procedure BuscarCodigo(vCod:TVCod; vProm:TVProm; vTot:TVTot;cod:ST4);
var
    i,pos:byte;
begin
    pos:=0;
    for i:=1 to N do
    begin
        if vCod[i] = upCase(cod) then
        begin
            pos:=i;
        end;
    end;
    if pos = 0 then
        WriteLn('El codigo ingresado no existe')
    else
        WriteLn('Del codigo entregado el total es: ',vTot[pos], ' y el promedio es: ',vProm[pos]:0:2);
end;

var
    arch:text;
    codigo:ST4;
    x:word;
    num,litros,contPasadas,i:byte;
    vCod:TVCod;
    vTot:TVTot;
    vProm:TVProm;
begin
    Assign(arch,'datos.TXT');
    Reset(arch);
    
    ReadLn(arch,num);
    WriteLn('Ingrese la cantidad a superar: ');
    ReadLn(x);

    for i:=1 to num do
    begin
        readln(arch,codigo);
        contPasadas:=0;
        
        read(arch,litros);
        vTot[i] := litros;
        while litros<>0 do
        begin
            contPasadas := contPasadas + 1;
            read(arch,litros);
            vTot[i] := vTot[i] + litros;
        end;
        ReadLn(arch);
        vProm[i] := vTot[i]/contPasadas;
        vCod[i] := codigo;
    end;
    Close(arch);
    WriteLn('El codigo del tambo que mas leche ha distribuido es: ', MasLeche(vCod,vTot));
    WriteLn('La cantidad de tambos que superaron el prom de: ', x, ' son: ', Superaron(x,vProm));
    
    WriteLn('Ingrese un codigo para mostrar el promedio y el total entregado: ');
    ReadLn(codigo);
    BuscarCodigo(vCod,vProm,vTot,codigo);
end.