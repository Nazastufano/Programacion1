Program Ejercicio1;


(*En el archivo ‘TORNEO2020’ se registraron los resultados de todos los torneos de gimnasia artística del año 2020.
Además se cuenta con el archivo ‘PARTICIPANTES’, con los datos de los gimnastas que compitieron (DNI y Nombre)
en el orden que se inscribieron (no son más de 50).

ARCHIVO TORNEO 2020 
● Mes (clave secund, 1er campo secuencia)
● Día (clave secund, 2do campo secuencia)
● DNI (clave secund, 3er campo secuencia)
● Disciplina (1-Salto, 2-Paralelas, 3-Viga, 4-Suelo) (puede repetirse)
● Puntos

TABLA PARTICIPANTE
● DNI (clave primaria – Desordenada)
● Nombre

Se pide procesar el archivo TORNEO2020 y luego:
    a) Armar un listado con el siguiente formato
       RESULTADOS DEL TORNEO
       MES: 99
              DIA: 01
                     Nombre SALTO(°) PARALELAS(°) VIGA(°) SUELO(°)TOTAL(#)
                     XXXXXXXXXX 99 99 99 99 999
                     XXXXXXXXXX 99 99 99 99 999
                     XXXXXXXXXX 99 99 99 99 999
              Promedio de puntos totales del día: 01 fue 999,99
              
              DIA: 02
                     Nombre SALTO PARALELAS VIGA SUELO TOTAL
                     XXXXXXXXXX 99 99 99 99 999
              Promedio de puntos totales del día: 02 fue 999,99
        ...
      El máximo puntaje total diario lo obtuvo el atleta DNI: 99.999.99 Total: 999 el día: 99/99

Nota (°) En cada disciplina informar la mejor marca del día
     (#)TOTAL es la suma de las mejores puntuaciones logradas en cada disciplina
    b) Por fin del proceso informar DNI, Nombre y Puntaje Total de cada gimnasta, que se obtiene sumando el
       TOTAL de todos los días que participó
                        DNI      Nombre    Puntos
                    99.999.999   XXXXXXX   99999
                    99.999.999   XXXXXXX   88888
                    …               …        …..
                    99.999.999   XXXXXXX   55555

*)

Type
    meses = 1..12;
    dias = 1..31;
    disip = 1..4;
    ST8 = string[8];
    ST10 = string[10];
    TRegTor = record
        mes:meses;
        dia:dias;
        dni:ST8;
        disiplina:disip;
        puntos:word;
    end;

    TRegPar = record
        dni:ST8;
        nombre:ST10;
    end;

    TRegPP = record
        datos:TRegPar;
        puntos:word;
    end;

    TVPar = array[1..40] of TRegPP;
    TV4 = array[1..4] of byte;
    TArchTor = file of TRegTor;
    TArchPar = file of TRegPar;

procedure ArmarVecPar(var archPar:TArchPar; var vecPar:TVPar);
var
    R:TRegPar;
    i:byte;
begin
    reset(archPar);
    read(archPar,R);
    i:=0;
    while NOT eof(archPar) do    
    begin
        i:=i+1;
        vecPar[i].datos:=R;
        vecPar[i].puntos:=0;
        read(archPar,R);
    end;
    Close(archPar);
end;
procedure InicializarVecPuntos(var vecPuntos:TV4);
var
    i:disip;
begin
    for i:=1 to 4 do
        vecPuntos[i]:=0;
end;

function TotalPuntos(vecPuntos:TV4):word;
var
    i:disip;
    total:word;
begin
    total:=0;
    
    for i:= 1 to 4 do
        total:=total+vecPuntos[i];
    
    TotalPuntos:=total;
end;

function BusquedaPar(vecPar:TVPar; dni:ST8):byte;
var
    i:byte;
begin
    i:=1;
    while (i<40) and (vecPar[i].datos.dni<>dni) do
        i:=i+1;
    
    BusquedaPar:=i;
end;
procedure armarListaDePuntos(vecPar:TVPar);
var
    i:byte;
begin
    WriteLn('DNI    Nombre    Puntos');
    for i:=1 to 40 do
        WriteLn(vecPar[i].datos.dni,'    ',vecPar[i].datos.nombre,'    ',vecPar[i].puntos);
    
end;
procedure armarTabla(var archTor:TArchTor; var vecPar:TVPar);
var
    RTo:TRegTor;
    mesActual,mesMasPuntos:meses;
    diaActual,diaMasPuntos:dia;
    dniActual,dniMasPuntos:ST8;
    disipActual:disip;
    cantPartDia,posPar:byte;
    sumaPuntos,puntosPorParti,maxPuntaje:word;
    vecPuntos:TV4;
begin
    reset(archTor);
    read(archTor,RTo);
    WriteLn('RESULTADOS DEL TORNEO');
    maxPuntaje:=0;
    while Not Eof(archTor) do
    begin
        mesActual:=RTo.mes;
        WriteLn('MES: ', mesActual);
        while mesActual = RTo.mes do
        begin
            diaActual:=RTo.mes;
            WriteLn('   DIA: ',diaActual);
            WriteLn('       Nombre     SALTO    PARALELAS    VIGA    SUELO    TOTAL');
            cantPartDia:=0;
            prom:=0;
            while (diaActual=RTo.dia) and (mesActual = RTo.mes) do
            begin
                posPar:= BusquedaPar(vecPar,RTo.dni);
                dniActual:=vecPar[posPar].datos.dni;
                sumaPuntos:=0;
                cantPartDia:=cantPartDia+1;
                InicializarVecPuntos(vecPuntos);
                while (RTo.dni = dniActual) and (diaActual=RTo.dia) and (mesActual = RTo.mes) do
                begin
                    disipActual:=RTo.disiplina;
                    while (disipActual = RTo.disiplina) and (RTo.dni = dniActual) and (diaActual=RTo.dia) and (mesActual = RTo.mes) do
                    begin
                        if vecPuntos[RTo.disiplina]<RTo.puntos then
                            vecPuntos[RTo.disiplina]:=RTo.puntos;
                        
                        read(archTor,RTo);
                    end;
                end;
                puntosPorParti:=TotalPuntos(vecPuntos);
                vecPar[posPar].puntos:=vecPar[posPar].puntos+puntosPorParti;
                if puntosPorParti>maxPuntaje then
                begin
                    diaMasPuntos:=diaActual;
                    mesMasPuntos:=mesActual;
                    dniMasPuntos:=dniActual;
                    maxPuntaje:=puntosPorParti;
                end;

                sumaPuntos := sumaPuntos + puntosPorParti;
                WriteLn(vecPar[posPar].datos.nombre,'       ', vecPuntos[1],'   ', vecPuntos[2],'   ', vecPuntos[3],'   ', vecPuntos[4],'   ', puntosPorParti);
            end;
            WriteLn('Promedio de puntos totales del dia: ', diaActual, ' fue ', sumaPuntos/cantPartDia:0:2);
        end;
        WriteLn('El maximo puntaje total diario lo obtuvo el atleta DNI: ',dniMasPuntos, ' Total: ', maxPuntaje, ' dia: ', diaMasPuntos,'/',mesMasPuntos);
    end;
    Close(archTor);
end;

var
    archTor:TArchTor;
    archPar:TArchPar;
    vecPar:TVPar;

Begin
    Assign(archTor,'TORNEO2020.DAT');
    Assign(archPar,'PARTICIPANTES.DAT');
    
    ArmarVecPar(archPar,vecPar);
    armarTabla(archTor,vecPar);
    armarListaDePuntos(vecPar);
End.
