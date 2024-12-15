Program Ejercicio1;

(*A principio de cada año se abre el calendario de la categoría de Fórmula Uno. Participan varias
Escuderías en cada carrera (no necesariamente todas) y cada piloto sólo corre para una escurería a lo largo del
año.

Al finalizar el año, un archivo CARRERAS.DAT se registran las Escuderías que ganaron en cada carrera, el
piloto y el tiempo (en segundos) que usó:
    Escudería (cadena de 5- campo de secuencia, clave secundaria).
    Nombre Piloto ganador (cadena de 20).
    Tiempo realizado en la carrera, en segundos (entero positivo).

Hay otros archivos HISTORICO.DAT que tiene datos históricos de las Escuredías que han ganado en las carreras:
    Escudería (cadena de 5- campo de secuencia, clave primaria).
    Cantidad Total de carreras ganadas (entero positivo).
    Mejor tiempo promedio del último año, en segundos (entero positivo).
    
Se pide, asumiendo que los archivos tienen centinela y la carga de los archivos ya está hecha, declarar los tipos y
resolver desarrollando además de los subprogramas, el programa principal:

a. Actualizar o dar de alta en el HISTORICO.DAT, por escudería, la cantidad total de carreras ganadas y el mejor
   tiempo promedio anual (si el actual es mejor al histórico, se reemplaza)
b. Mostrar Escuderías que no ganaron ninguna carrera en el último año (y sí en años anteriores)
c. Mostrar Nombre del Piloto y Escudería que ga tenido el Mejor tiempo en el último año

Nota: Los archivos deben recorrerse una única vez*)
type
    ST5=String[5];
    ST20=string[20];
    TRegHis = record
        escuderia:ST5;
        cantTotalCarGan,mejorTiempoProm:word;
    end;
    TRegCar = record
        escuderia:ST5;
        nombrePilotoGan:ST20;
        tiempoCarrera:word;
    end;
    TArchHis = file of TRegHis;
    TArchCar = file of TRegCar;
procedure MejorTiempo(var mejorTiempo:word;RCar:TRegCar;var nombrePilotoMT:ST20; var escuadraMT:ST5);
begin
    If mejorTiempo<RCar.tiempoCarrera Then
    Begin
        mejorTiempo := Rcar.tiempoCarrera;
        nombrePilotoMT := Rcar.nombrePilotoGan;
        escuadraMT := RCar.escuderia;
    End;
end;
procedure ActualizarArch(var archCar:TArchCar;var archHis:TArchHis; nom:ST20);
var
    archTemp:TArchHis;
    RHis,RAux:TRegHis;
    RCar:TRegCar;
    contCarreras:byte;
    nombrePilotoMT:ST20;
    escuadraMT:ST5;
    mejorTiempo:word;
begin
    Assign(archTemp,'TEMP.DAT');
    reset(archCar);
    Reset(archHis);
    Rewrite(archTemp);
    read(archCar,RCar);
    Read(archHis,RHis);
    mejorTiempo:=0;
    while (Not Eof(archCar)) or (not Eof(archHis)) do
    begin
        if RCar.escuderia=RHis.escuderia then
        begin
            while RCar.escuderia=RHis.escuderia do
            begin                
                RHis.cantTotalCarGan := RHis.cantTotalCarGan+1;    
                
                if Rhis.mejorTiempoProm>RCar.tiempoCarrera then
                    Rhis.mejorTiempoProm:=RCar.tiempoCarrera;
                
                MejorTiempo(MejorTiempo,RCar,nombrePilotoMT,escuadraMT);
                Read(archCar,Rcar);
            end;
            
            Rewrite(archTemp,RHis);
            Read(archHis,RHis);
        end
        else if RCar.escuderia < RHis.escuderia then
        begin
            RAux.escuderia:=RCar.escuderia;
            RAux.cantTotalCarGan:=0;
            RAux.mejorTiempoProm:=0;
            while RAux.escuderia = RCar.escuderia do
            begin
                RAux.cantTotalCarGan:=RAux.cantTotalCarGan+1;
                if RAux.mejorTiempoProm = RCar.tiempoCarrera then
                    RAux.mejorTiempoProm := RCar.tiempoCarrera;
                
                MejorTiempo(MejorTiempo,RCar,nombrePilotoMT,escuadraMT);
                Read(archCar,RCar);
            end;
            Rewrite(archTemp,RAux);
        end
        else
            begin
                Writeln('La escuderia ', RHis.escuderia, ' no ha ganado, pero si en anios anteriores');
                Rewrite(archTemp,RHis);
                Read(archHis,RHis);
            end;
    end;
    WriteLn('El nombre del piloto con mejor tiempo es: ', nombrePilotoMT, ' de la escuderia ', escuadraMT);
    Write(archTemp,RHis);
    Close(archTemp);
    Close(archCar);
    Close(archHis);
    Erase(archHis);
    Rename(archTemp,nom);
end;

var
    archHis:TArchHis;
    archCar:TArchCar;
begin
    Assign(archHis,'HISTORICO.DAT');
    Assign(archCar,'CARRERAS.DAT');

    ActualizarArch(archCar,archHism,'HISTORICO.DAT');
end.