Program Final;

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
    ST15 = String[15];
    TVPartidos = array[1..5] of word;
    TRegVA = record
        nroDistrito:word;
        partidos:TVPartidos;
    end;
    TRegVP = record
        cantVotos,nroDistrito:word;
        nroPartido:1..5;
    end;
    TRegDis = record
        nroDistrito:word;
        nombre:ST15;
    end;
    TVDistritos = Array[1..50] of TRegDis;
    TArchVAcum = file of TRegVA;
    TArchVPar = file of TRegVP;
    TArchDistr = file of TRegDis;

procedure CargarArreglo(var archDistr:TArchDistr;var vecDistritos:TVDistritos);
var
    i:byte;
    
begin
    reset(archDistr);
    i:=0;
    while not eof(archDistr) do
    begin
        i:=i+1;
        Read(archDistr,vecDistritos[i].nroDistrito,vecDistritos[i].nombre);
    end;
    Close(archDistr);
end;

function Busqueda(vecDistritos:TVDistritos;cod:word):byte;
var
    i:byte;
begin
    i:=1;
    while vecDistritos[i].nroDistrito<>cod do
        i:=i+1;
    Busqueda:=i;
end;

procedure InformarGanador(vecDistritos:TVDistritos;RVA:TRegVA);
var
    i,partidoGanador:byte;
    maxVotos:word;
begin
    i:=Busqueda(vecDistritos,RVA.nroDistrito);
    maxVotos:=0;
    for i:=1 to 5 do
        if maxVotos<RVA.partidos[i] then
        begin
            partidoGanador := i;
            maxVotos:=RVA.partidos[i];
        end;
    WriteLn('Nombre distrito: ', vecDistritos[i].nombre,' Partido ganador: ', partidoGanador);
end;
procedure ActualizarVotos(var archVAcum:TArchVAcum;var archVPar:TArchVPar; vecDistritos:TVDistritos;nom:ST15);
var
    RVA,RAux:TRegVA;
    RVP:TRegVP;
    i:byte;
    ArchTemp:TArchVAcum;
    
begin
    Assign(ArchTemp,'TEMP.DAT');
    Reset(archVAcum);
    Reset(archVPar);
    Rewrite(ArchTemp);
    read(archVAcum,RVA);
    read(archVPar,RVP);
    while (NOT eof(archVAcum)) or (NOT eof(archVPar)) do
    begin
        if RVA.nroDistrito=RVP.nroDistrito then
        begin
            while RVA.nroDistrito=RVP.nroDistrito do
            begin
                RVA.partidos[RVP.nroDistrito]:=RVA.partidos[RVP.nroDistrito]+RVP.cantVotos;
                Read(archVPar,RVP);
            end;
            InformarGanador(vecDistritos,RVA);
            Write(ArchTemp,RVA);
            Read(archVAcum,RVA);
        end
        else if RVA.nroDistrito>RVP.nroDistrito then
        begin
            RAux.nroDistrito:=RVP.nroDistrito;
            RAux.partidos[RVP.nroPartido]:=RVP.cantVotos;
            Write(ArchTemp,RVAux);
            read(archVPar,RVP);
        end
            else
                Write(ArchTemp,RVA);
        
    end;
    Write(ArchTemp,RVA);
    Close(ArchTemp);
    Close(archVAcum);
    Close(archVPar);
    Erase(archVAcum);
    Rename(ArchTemp,nom);
end;
var
    vecDistritos:TVDistritos;
    archVAcum:TArchVAcum;
    archVPar:TArchVPar;
    archDistr:TArchDistr;
    x:word;

begin
    Assign(archVAcum,'VOTOS_ACUM.DAT');
    Assign(archVPar,'VOTOS_PARCIAL.DAT');
    Assign(archDistr,'DISTRITO.DAT');

    WriteLn('Ingrese un X a superar');
    ReadLn(x);


end.