Program Ejercicio1;
(*Una veterinaria realiza diferntes practicas sobre mascotas, detalladas en el archivo
PRACTICAS.DAT. Por otro lado, conserva los datos de los dueños de las mascotas en un archivo llamado
CLIENTES.DAT. Cada archivo contiene la siguiente informacion y diseño:

PRACTICAS.DAT                                          |  CLIENTES.DAT
°CodPractica (4 caracteres, desordenado) a lo sumo 40  |  °NombreCliente (10 caracteres, desordenado)
°Descripcion (10 caracteres)                           |  °Telefono (15 caracteres)
°Costo                                                 |  °Cantidad de mascotas

Diariamente mantiene un registro de las prácticas que realiza a las masctoas de sus clientes en un
archivo VETERINARIA.DAT.

VETERINARIA.DAT
°NombreCliente (10 caracteres, Campo secuencia, clave secundaria)
°NombreMascota (10 caracteres, Campo secuencia)
°CodPractica (4 caracteres)
°Fecha (8 caracterees, formato aaaammdd)
°Alta (S/N) (S significa que con esta practica termino el tratamiento)

CONSIDERAR QUE NombreCliente+NombreMascota es Clave secundaria

Se pide, escribir los tipos, las declaración de variables y el programa principal para resolver lo siguiente:
    Mostrar un informe como se detalla abajo, solo con las prácticas realizadas en 2024.
    Al final del listado, informar la cantidad de cada uno de los distintos tios de Prácticas realizados

                          Informe del Registro de Práctticas en 2024                          
Cliente xxxxxxxxxx      Telefono xxxxxxxxxx
Mascota           Mes Ultima Práctica         Importe Total         Terminó algún tratamiento?
  xxxxxxxxxx               99                   $99999,99                   X  
  xxxxxxxxxx               99                   $99999,99                   X
Importe total de todas las prácticas: $ 999999,99
Cliente xxxxxxxxxx      Telefono xxxxxxxxxx
Mascota           Mes Ultima Práctica         Importe Total         Terminó algún tratamiento?
  xxxxxxxxxx               99                   $99999,99                   X
  xxxxxxxxxx               99                   $99999,99                   X
Importe total de todas las prácticas:   $ 999999,99
Cantida de Clientes erróneos en el archivo VETERINARIA.DAT:9999
*)

type
    ST2 = string[2];
    ST4 = string[4];
    ST8 = string[8];
    ST10 = string[10];
    ST15 = string[15];

    TRegPra = record
        codPractica:ST4;
        descripcion:ST10;
        costo:real;
    end;
    TRegPC = record
        practica:TRegPra;
        cantRep:word;
    end;
    TRegCT = record
        nombreCli:ST10;
        telefono:ST15;
    end;
    TRegCli= record
        RCliTel:TRegCT;
        cantMasc:byte;
    end;
    TRegVet = record
        nombreCli:ST10;
        nombreMas:ST10;
        codPractica:ST4;
        fecha:ST8;
        alta:char;
    end;

    TVecPra = array[1..40] of TRegPC;
    TVecCli = array[1..1000] of TRegCT;
    
    TArchPra = file of TRegPra;
    TArchCli = file of TRegCli;
    TArchVet = file of TRegVet;

procedure ArmarVecPrac(var archPra:TArchPra; var vecPra:TVecPra);
var
    RPra:TRegPra;
    i:byte;
begin
    reset(archPra);
    read(archPra,RPra);
    i:=0;
    while NOT eof(archPra) do
    begin
        i:=i+1;
        vecPra[i].practica:=RPra;
        vecPra[i].cantRep:=0;
        read(archPra,RPra);
    end;
    Close(archPra);
end;
procedure ArmarVecClie(var archCli:TArchCli; var vecCli:TVecCli);
var
    RCli:TRegCli;
    i:word;
begin
    reset(archCli);
    read(archCli,RCli);
    i:=0;
    while NOT eof(archCli) do
    begin
        i:=i+1;
        vecCli[i].nombreCli:=RCli.RCliTel.nombreCli;
        vecCli[i].telefono:=RCli.RCliTel.telefono;
        Read(archCli,RCli);
    end;
    Close(archCli);
end;
function BusquedaPrac(vecPra:TVecPra; codPractica:ST4):byte;
var 
    i:byte;
begin
    i:=1;
    while (vecPra[i].practica.codPractica<>codPractica) do
        i:=i+1;
    
    BusquedaPrac:=i;
end;
function BusquedaClie(vecCli:TVecCli; nombreCli:ST10):word;
var
    i:word;
begin
    i:=1;
    while (vecCli[i].nombreCli<>nombreCli) and (i<=1000) do
        i:=i+1;
    
    if i<=1000 then
        BusquedaClie:=i
    else
        BusquedaClie:=0;
end;

procedure MostrarVector(vecPra:TVecPra);
var
    i:byte;
begin
    i:=1;
    WriteLn('La cantidad de veces que se repitieron las practicas son: ');
    while i<=40 do
        WriteLn('La practica ', vecPra[i].practica.descripcion,': ', vecPra[i].cantRep);
end;

procedure ArmarInforme(var archVet:TArchVet;var vecPra:TVecPra; vecCli:TVecCli);
var
    RVet:TRegVet;
    mes, mesUltPra:ST2;
    anno:ST4;
    clieActual,mascActual:   ST10;
    termAlgPrac:boolean;
    posPra:byte;    
    cantCliErr,posCli:word;
    importeTPP,importeTPC:real;
begin
    reset(archVet);
    read(archVet,RVet);
    cantCliErr:=0;
    WriteLn('                          Informe del Registro de Practicas en 2024                          ');
    while not Eof(archVet) do
    begin
        clieActual := Rvet.nombreCli;
        posCli:=BusquedaClie(vecCli,clieActual);
        
        if posCli<>0 then
        begin
            importeTPC:=0;
            WriteLn('Cliente ',clieActual,'         Telefofono', vecCli[posCli].telefono);
            WriteLn('Mascota           Mes Ultima Practica         Importe Total         Termino algun tratamiento?');
            while clieActual = Rvet.nombreCli do
            begin
                mesUltPra := '01';
                importeTPP:=0;
                termAlgPrac:=false;
                mascActual:= RVet.nombreMas;

                while (clieActual = Rvet.nombreCli) and (mascActual= RVet.nombreMas) do
                begin
                    anno:=RVet.fecha[1] + RVet.fecha[2] + RVet.fecha[3] + RVet.fecha[4];
                    if anno = '2024' then
                    begin
                        mes:= RVet.fecha[5] + RVet.fecha[6];
                        if mes>mesUltPra then
                            mesUltPra:=mes;
                            
                        posPra:= BusquedaPrac(vecPra,RVet.codPractica);
                        importeTPP:=importeTPP+vecPra[posPra].practica.costo;
                        vecPra[posPra].cantRep:=vecPra[posPra].cantRep+1;
                            
                        if RVet.alta = 'S' then
                            termAlgPrac:=true;    
                    end;
                    
                    Read(archVet,RVet);
                end;
                importeTPC:=importeTPC+importeTPP;
                if termAlgPrac then
                    res:='Si'
                else
                    res:='No';
                WriteLn('   ',mascActual,'      ',mesUltPra,'       $',importeTPP,'         ',res);
            end;
            WriteLn('Importe total de todas las practicas: $',importeTPC);
        end    
        else
            begin
                cantCliErr := cantCliErr + 1;
                
                while clieActual = Rvet.nombreCli do
                    Read(archVet,Rvet);
            end;
    end;
    Close(archVet);
    WriteLn('Cantidad de Clientes erroneos en el archivo VETERINARIA.DAT: ', cantCliErr);
end;

var
    archPra: TArchPra;
    archCli: TArchCli;
    archVet: TArchVet;
    vecPra:TVecPra;
    vecCli:TVecCli;

begin
    Assign(archPra,'PRACTICAS.DAT');
    Assign(archCli,'CLIENTES.DAT');
    Assign(archVet,'VETERINARIA.DAT');
    ArmarVecPrac(archPra,vecPra);
    ArmarVecClie(archCli,vecCli);
    ArmarInforme(archVet,vecPra,vecCli);
    MostrarVector(vecPra);
end.