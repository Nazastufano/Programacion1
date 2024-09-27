program Ejercicio14;

(*Ej 14) Una empresa de autos de alquiler grabó en cada línea del archivo la patente del vehículo (cadena
de 7) y el total recaudado en el día. Se pide leer los datos en dos arreglos paralelos e informar:
    a) El promedio recaudado por auto.
    b) Las patentes de los vehículos que superaron en la recaudación X pesos (X es dato).
    c) La patente del que recaudó menos. *)
const
    N=3;
type
    ST7 = string[7];
    TVecPatente = array[1..N] of ST7;
    TVecRecauda = array[1..N] of real;
    TVecRepeticion = array[1..N] of byte;

procedure BuscarPatente(vPatente:TVecPatente; var indice:byte;patente:ST7);
var
    pos,i:byte;
begin
    pos:=0;
    for i:=1 to indice do
    begin
        if vPatente[i] = patente then
            pos:=i;
    end;

    if pos = 0 then
        indice := indice + 1
    else
        indice := pos;
end;

procedure PromPorAuto(vPatente:TVecPatente; vRecaud:TVecRecauda; vAcum:TVecRepeticion; indice:byte);
var
    i:byte;
begin
    for i:=1 to indice do
    begin
        WriteLn('El auto con la patente: ', vPatente[i], '. Y el promedio recaudado es: ',(vRecaud[i]/vAcum[i]):0:2);
    end;
end;

procedure Superan(vPatente:TVecPatente; vRecaud:TVecRecauda; x:real);
var
    cont,i:byte;
    patentesMasRecaudan:TVecPatente;
begin
    cont:=0;
    for i:=1 to N do
    begin
        if vRecaud[i]>x then
        begin
            cont := cont +1;
            patentesMasRecaudan[cont] := vPatente[i];
        end;
    end;
    
    WriteLn('Las patentes que superaron la cantidad de: $', x:0:2);
    for i:=1 to cont do
    begin
        Write(patentesMasRecaudan[i],' ');
    end;
    WriteLn();
end;
function PatenteMenosRecauda(vPatente:TVecPatente;vRecaud:TVecRecauda):ST7;
var
    i:byte;
    menosRecauda:real;
    patenteMenos:ST7;
begin
    menosRecauda := vRecaud[1];
    for i:=2 to N do
    begin
        if menosRecauda > vRecaud[i] then
        begin
            menosRecauda:=vRecaud[i];
            patenteMenos:=vPatente[i];
        end;
    end;
    PatenteMenosRecauda:=patenteMenos;
end;
var
    arch:Text;
    patente:ST7;
    ganacia,ganaciaASuperar:real;
    posAutos,acumAutos,i,cantAutos:byte;
    vPatente:TVecPatente;
    vRecaud:TVecRecauda;
    vAcum: TVecRepeticion;
begin
    Assign(arch,'datos.TXT');
    Reset(arch);
    posAutos:=0;
    cantAutos:=0;
    while Not eof(arch) do
    begin
        ReadLn(arch,patente,ganacia);
        BuscarPatente(vPatente,posAutos,patente);
        
        vAcum[posAutos]:=vAcum[posAutos] +1;
        vPatente[posAutos] := patente;
        vRecaud[posAutos]:=vRecaud[posAutos] + ganacia;

        if cantAutos<posAutos then
            cantAutos:=posAutos;
    end;
    WriteLn(posAutos);
    close(arch);
    
    PromPorAuto(vPatente,vRecaud,vAcum,cantAutos);
    WriteLn('Ingrese la ganancia a superar: ');
    ReadLn(ganaciaASuperar);
    Superan(vPatente, vRecaud, ganaciaASuperar);

    WriteLn('La patente que menos recauda es: ', PatenteMenosRecauda(vPatente,vRecaud));
end.