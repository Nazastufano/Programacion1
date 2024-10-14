program Ejercicio4;

(*Ej 4) En una competencia intervienen N equipos deportivos de los cuales se registró:
     Nombre del Club
     Cantidad de partidos jugados
     El resultado de cada encuentro ( G = ganado, E = empatado, P = perdido)
Se pide almacenar los datos en una estructura adecuada junto con el total del puntaje obtenido. Por cada
partido ganado son 3 puntos, empatado 1 y perdido 0.
A partir de lo almacenado, informar:
    a) Listado con los nombres de los clubes junto con el puntaje obtenido.
    b) Nombre de el/los punteros de la Tabla.
    c) Porcentaje de los que no perdieron ningún partido sobre el total de clubes. *)
const
    N=4;
type
    ST20 = string[20];
    TVecRes = array[1..50] of char;
    TReg = record
        nombreEquipo:ST20;
        cantPartidos:byte;
        resPartidos:TVecRes;
    end;
    TVReg = array[1..N] of TReg;
    TVPuntos = array[1..N] of byte;
procedure ArmarFixture(var vec:TVReg);
var
    i,j:byte;
    res:char;
begin
    for i:=1 to N do
    begin
        WriteLn('Ingrese el nombre del club: ');
        readln(vec[i].nombreEquipo);
        WriteLn('Ingrese la cantidad de partidos jugados: ');
        ReadLn(vec[i].cantPartidos);
        for j:=1 to vec[i].cantPartidos do
        begin
            WriteLn('Ingrese el resultado del encuentro: ',j, ' ("G", "E", "P")');
            ReadLn(res);
            vec[i].resPartidos[j]:=upCase(res);
        end;
    end;
end;

procedure SumaPuntos(vec:TVReg; var puntos:TVPuntos);
var
    i,j,suma:byte;
begin
    for i:=1 to N do
    begin
        suma:=0;
        for j:=1 to vec[i].cantPartidos do
        begin
            case vec[i].resPartidos[j] of
                'G': suma := suma +3; 
                'E': suma := suma +1; 
                'P': suma := suma +0;
            end;
        end;
        puntos[i]:=suma;
    end;
end;
//a) Listado con los nombres de los clubes junto con el puntaje obtenido.
procedure MostrarTabla(vec:TVReg;puntos:TVPuntos);
var
    i:byte;
begin
    for i:=1 to N do
        Writeln(vec[i].nombreEquipo,'. tiene ', puntos[i],' puntos');
end;

//b) Nombre de el/los punteros de la Tabla.
procedure MostrarPunteros(vec:TVReg;puntos:TVPuntos);
var
    i,maxPuntos:byte;
begin
    maxPuntos:=puntos[1];
    for i:=2 to N do
    begin
        if maxPuntos<puntos[i] then
            maxPuntos:=puntos[i];
    end;
    Write('El nombre de el/los punteros es: ');
    for i:=1 to N do
    begin
        if puntos[i]=maxPuntos then
            WriteLn(vec[i].nombreEquipo, '.');
    end;
end;
//c) Porcentaje de los que no perdieron ningún partido sobre el total de clubes.
procedure PorcentajeDeInvictos(vec:TVReg);
var
    cont,i,j:byte;
begin
    cont := 0;
    for i:=1 to N do
    begin
        j:=1;
        while (j<=vec[i].cantPartidos) and (vec[i].resPartidos[j]<>'P') do
            j:= j+1;
        
        if j=vec[i].cantPartidos+1 then 
            cont:=cont+1;
    end;
    WriteLn('El porcentaje de clubes invictos es: ',(cont*100/N):0:2,'%');
end;

var
    equipos:TVReg;
    puntos:TVPuntos;
begin
    ArmarFixture(equipos);
    SumaPuntos(equipos,puntos);
    MostrarTabla(equipos,puntos);
    MostrarPunteros(equipos,puntos);
    PorcentajeDeInvictos(equipos);
end.