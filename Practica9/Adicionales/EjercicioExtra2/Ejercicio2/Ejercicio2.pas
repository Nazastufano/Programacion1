Program Ejercicio2;

(*La Facultad otorga becas (ayuda económica) a sus alumnos en base a su promedio.
A fin de año se actualiza la situación de cada alumno de acuerdo a su desempeño. Además incorporan nuevos
alumnos con beca y se dan de baja otros a quienes ya no corresponde la beca.
Las becas son otorgadas automáticamente según el siguiente criterio:
    Promedio >8 -> Beca completa
    6<= Promedio <=8 -> Media Beca
    En otro caso -> Sin Beca
Se cuenta con los siguientes archivos binarios:

BECADOS
    ● Legajo (ANU5, campo de secuencia, clave
    primaria)
    ● Código Carrera (1..10)
    ● Promedio
    ● Tipo de Beca (1-Completa, 2-Media)

NOVEDADES
    ● Legajo (ANU5, campo de secuencia, clave
    primaria)
    ● Código Carrera (1..10)
    ● Promedio(Nuevo)

CARRERA
    ● Código Carrera(1..10)
    ● Descripción (ANU12)

Se pide actualizar el archivo BECADOS de la siguiente forma:

    ● Para un mismo Legajo en BECADOS y NOVEDADES, si corresponde, actualizar su promedio y el tipo de Beca,
    en caso de perderla, darlo de baja.
    ● Si el Legajo de NOVEDADES no figura en ALUMNOS, si corresponde, incorporarlo con su Tipo de Beca.
    ● Si el Legajo de BECADOS no figura en NOVEDADES, darlo de baja.

Por fin de proceso informar:

    - Total de alumnos que bajaron o perdieron su Beca.
    - Cantidad de alumnos que se dieron de alta con Beca Completa
    - Cantidad de Alumnos con Beca de cada Carrera
        
        Codigo      Carrera     Cantidad Becados
        1         XXXXXXXXXXXX        99
        …              ….             …
        10        XXXXXXXXXXXX        99

Nota: SOLO debe desarrollar el Procedimiento/Función que resuelva lo pedido y la definición de Tipos/Variables
usadas y los procedimientos/funciones invocados. Asumir que los archivos ya fueron cargados *)

type
    ST5 = string[5];
    ST12 = string[12];

    TRegBec = record
        legajo:ST5;
        codCarrera:1..10;
        promedio:real;
        tipoBeca:1..2;
    end;

    TRegNov = record
        legajo:ST5;
        codCarrera:1..10;
        promedioNuevo:real;
    end;

    TRegCar = record
        codCarrera:1..10;
        descripcion:ST12;
    end;

    TRegCCB = record
        datosCarrera:TRegCar;
        cantBec:word;
    end;

    TVCar = array[1..10] of TRegCCB;
    TArchBec = file of TRegBec;
    TArchNov = file of TRegNov;
    TArchCar = file of TRegCar;

function CalcularBeca(prom:real):byte;
begin
    if prom>8 then
        CalcularBeca:=2
    else if (prom>=6) and (prom<=8) then
        CalcularBeca:=1
    else
        CalcularBeca:=0;
end;

procedure CargarVectorCarreras(var archCar:TArchCar;var vecCar:TVCar);
var
    R:TRegCar;
    i:byte;
begin
    reset(archCar);
    Read(archCar,R);
    i:=0;
    while NOT eof(archCar) do
    begin
        i:=i+1;
        vecCar[i].datosCarrera:=R;
        vecCar[i].cantBec:=0;
        read(archCar,R);
    end;
    Close(archCar);
end;
procedure MostrarTabla(vecCar:TVCar);
var
    i:byte;
begin
    WriteLn('Codigo     Carrera     Cantidad Becados');
    for i:=1 to 10 do
        WriteLn(i, '    ', vecCar[i].datosCarrera.descripcion,'     ',vecCar[i].cantBec);
end;
procedure ActualizarListado(var archBec:TArchBec; var archNov:TArchNov; var vecCar:TVCar; nom:ST12);
var
    cantAlumnosNuevos, totalPerBajBeca:word;
    tipoBeca:byte;
    archTemp:TRegBec;
    RBe,RAux:TRegBec;
    RNo:TRegNov;
    
begin
    Assign(archTemp,'TEMP.DAT');
    Reset(archTemp);
    reset(archBec);
    reset(archNov);
    Read(archBec,RBe);
    read(archNov,RNo);
    cantAlumnosNuevos:=0;
    totalPerBajBeca:=0;
    while (not eof(archBec)) or (not eof(archNov)) do
    begin
        if RBe.legajo = RNo.legajo then
        begin
            tipoBeca:=CalcularBeca(RNo.promedioNuevo);
            if tipoBeca<>0 then
            begin
                if CalcularBeca(RBe.promedio)>tipoBeca then
                    totalPerBajBeca:=totalPerBajBeca+1;
                
                vecCar[RNo.codCarrera].cantBec:=vecCar[RNo.codCarrera].cantBec+1;
                
                RBe.promedio:=RNo.promedioNuevo;
                RBe.tipoBeca:=tipoBeca;
                
                Write(archTemp,RBe);
                Read(archBec,RBe);
            end
            else
                totalPerBajBeca:=totalPerBajBeca+1;
            
            read(archNov,RNo);
        end
        else if RBe.legajo > RNo.legajo then
        begin
            tipoBeca:=CalcularBeca(RNo.promedioNuevo);
            if tipoBeca <> 0 then
            begin
                RAux.legajo:=RNo.legajo;
                RAux.codCarrera:=RNo.codCarrera;
                Raux.promedio:=RNo.promedioNuevo;
                RAux.tipoBeca:=tipoBeca;
                if tipoBeca=2 then
                    cantAlumnosNuevos:=cantAlumnosNuevos+1;
                Write(archTemp,RAux);
            end;
            read(archNov,RNo);
        end
        else
            Read(archBec,RBe);
    end;
    Write(archTemp,RBe);
    Close(archTemp);
    Close(archBec);
    Close(archNov);
    Erase(archBec);
    Rename(archTemp,nom);
end;

var
    archBec:TArchBec;
    archNov:TArchNov;
    archCar:TArchCar;
    vecCar:TVCar;

begin
    Assign(archBec,'BECADOS.DAT');
    Assign(archNov,'NOVEDADES.DAT');
    Assign(archCar,'CARRERA.DAT');

    CargarVectorCarreras(archCar,vecCar);
    ActualizarListado(archBec,archNov,vecCar,'BECADOS.DAT');
    MostrarTabla(vecCar);
end.