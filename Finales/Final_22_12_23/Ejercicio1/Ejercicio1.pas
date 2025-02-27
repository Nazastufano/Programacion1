Program Ejercicio1;

(*En las últimas elecciones se almacenó en dos archivos VOTOS_ACUM.DAT y
VOTOS_PARCIAL.DAT la sigueinte información (ambos archivos tienen centinela):

VOTOS_ACUM
# NRO. de DISTRITO (entero) {campo de secuencia, clave primaria}
# PARTIDOS (arreglo de 5 elementos, contiene un la posición i los votos acumulados del partido i)

VOTOS_PARCIAL
# NRO. de DISTRITO {campo de secuencia, clave secundaria}
# NRO. de PARTIDO (1..5)
# CANT. de VOTOS

Se cuenta, además, con un archivo DISTRITO.DAT (donde la cantidad máxima de distritos es 50):
# NRO. de DISTRITO
# NOMBRE (cadena 15)

Se pide, definir tipos y:
    a) Obtener un archivo de VOTOS_ACUM actualizando, informando además, el ganador en cada distrito:
       Nombre del Distrito y Partido Ganador
    b) Mostrar el siguiente listado sólo para aquellos con más de X votos, ingresado por teclado
        TOTALES GENEREALES POR PARTIDO
            PARTIDO         TOTALES
                1           999
                2           999
            ....            ....
*)

Type
    unoAlCinc = 1..5;

    ST15 = string[15];
    TVPar = array[1..5] of word;
    
    TRegVoAc = record
        nroDistrito:word;
        partidos:TVPar;
    end;
    
    TRegVoPa = record
        nroDistrito,cantVotos:word;
        nroPartido:unoAlCinc;
    end;

    TRegDis = record
        nroDistrito:word;
        nombre:ST15;
    end;

    TVecDi = array[1..50] of TRegDis;
    TArchVoAc = file of TRegVoAc;
    TArchVoPa = file of TRegVoPa;
    TArchDis = file of TRegDis;

procedure CargarVectorDis(var archDis:TArchDis; var vecDis:TVecDi; var cantDis:byte);
var
    i:byte;
    R:TRegDis;

begin
    reset(archDis);
    read(archDis,R);
    i:=0;
    while NOT eof(archDis) do
    begin
        i:=i+1;
        vecDis[i]:=R;
        read(archDis,R);
    end;
    cantDis:=i;
    Close(archDis);
end;

function BusquedaDis(vecDis:TVecDi; numDis:word;cantDis:byte):byte;
var
    i:byte;
begin
    i:=1;
    while (i<cantDis) and (vecDis[i].nroDistrito= numDis) do
        i:=i+1;
    BusquedaDis:=i;
end;

function BusquedaBin(vecDis:TVecDi;numDis:word;cantDis:byte):Boolean;
var
    i:byte;
begin
    i:=1;
    while (i<=cantDis) and (vecDis[i].nroDistrito = numDis) do
        i:=i+1;
    if i<=cantDis then
        BusquedaDis:=true
    else
        BusquedaDis:=false;
end;

procedure MostrarTabla(vecAcumPar:TVPar;x:word);
var
    i:byte;
begin
    WriteLn('TOTALES GENERALES POR PARTIDO');
    WriteLn('   PARTIDO         TOTALES');
    for i:=1 to 5 do
        if vecAcumPar[i]>x then
            WriteLn('    ',i,'          ',vecAcumPar[i]);
end;

procedure InicializarVecAcumPar(var vecAcumPar:TVPar);
var
    i:byte;
begin
    for i:=1 to 5 do
        vecAcumPar[i]:=0;
end;
function DevolverGanardor(vecVotPar:TVPar):byte;
var
    posGan,i:byte;
    masVotos:word;
begin
    masVotos:=vecVotPar[1];
    posGan:=1;
    for i:= 2 to 5 do
        if masVotos<vecVotPar[i] then
        begin
            masVotos:=vecVotPar[i];
            posGan:=i;
        end;
    DevolverGanardor:=posGan;
end;

procedure InformarGanador(vecDis:TVecDi;RVA:TRegVoAc;cantDis:byte);
var
    pos:byte;
begin
    posDis:=BusquedaDis(vecDis,RVA.nroDistrito,cantDis);
    WriteLn('El partido ganador del distrito ', vecDis[posDis].nombre, ' es el partido ', DevolverGanardor(RVA.partidos));
end;

procedure ActualizarArch(var archVoAc:TArchVoAc;var archVoPa:TArchVoPa; var vecAcumPar:TVPar; var vecDis:TVecDi; cantDis:byte;nom:ST15);
var
    archTemp:TArchVoAc;
    RVA,RAux:TRegVoAc;
    RVP:TRegVoPa;
    disActual,partActual,posDis:byte;

begin
    Assign(archTemp,'TEMP.DAT');
    Reset(archTemp);
    Reset(archVoAc);
    Reset(archVoPa);
    read(archVoAc,RVA);
    read(archVoPa,RVP);

    while (Not eof(archVoAc)) or (not eof(archVoPa)) do
    begin
        if RVA.nroDistrito = RVP.nroDistrito then
        begin
            while RVA.nroDistrito = RVP.nroDistrito do
            begin
                RVA.partidos[RVP.nroPartido]:=RVA.partidos[RVP.nroPartido]+RVP.cantVotos;
                vecAcumPar[RVP.nroPartido]:=vecAcumPar[RVP.nroPartido]+RVP.cantVotos;
                
                Read(archVoPa,RVP);
            end;
            InformarGanador(vecDis,RVA,cantDis);
            Write(archTemp,RVA);
            read(archVoAc,RVA);
        end
        else if RVA.nroDistrito > RVP.nroDistrito then
            begin
                disActual:=RVP.nroDistrito;
                if BusquedaBin(vecDis,disActual,cantDis) then
                begin
                    while disActual=RVP.nroDistrito do
                    begin
                        RAux.partidos[RVP.nroPartido]:=RVP.cantVotos;
                        read(archVoPa,RVP);
                    end;
                    RAux.nroDistrito:=disActual;
                    InformarGanador(vecDis,RAux,cantDis);
                    Write(archTemp,RAux);
                end;
            end
        else
            begin
                Write(archVoAc,RVA);
                read(archVoAc,RVA);
            end;
    end;
    Write(archTemp,RVA);
    Close(archTemp);
    Close(archVoAc);
    Close(archVoPa);
    Erase(archVoAc);
    Rename(archTemp,nom);
end;
var
    archVoAc = TArchVoAc;
    archVoPa = TArchVoPa;
    archDis = TArchDis;
    vecDis = TVecDi;
    vecAcumPar = TVPar;
    cantDis:byte;
    x:word;

begin
    Assign(archVoAc,'VOTOS_ACUM.DAT');
    Assign(archVoPa,'VOTOS_PARCIAL.DAT');
    Assign(archDis,'DISTRITO.DAT');

    WriteLn('Ingrese la cantidad de votos a superar: ');
    Read(x);

    CargarVectorDis(archDis,vecDis,cantDis);
    InicializarVecAcumPar(vecAcumPar);
    ActualizarArch(archVoAc,archVoPa,vecAcumPar,vecDis,cantDis,'VOTOS_ACUM.DAT');
    MostrarTabla(vecAcumPar,x);
end.