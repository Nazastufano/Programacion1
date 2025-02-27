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

Type
    ST5 = string[5];
    ST20 = string[20];

    TRegCar = record
        escuderia:ST5;
        nomPilGan:ST20;
        tiempoCarr:word;
    end;

    TRegHis = record
        escuderia:ST5;
        cantTotalCarGan,mejorTiempoAA:word;
    end;
    TArchCar = file of TRegCar;
    TArchHis = file of TRegHis;

procedure ActualizarDatos(var RHi:TRegHis;var RCa, RMejorPiloto:TRegCar);
begin
    RHi.cantTotalCarGan:=RHi.cantTotalCarGan+1;
    if RHi.mejorTiempoAA>RCa.tiempoCarr then
        RHi.mejorTiempoAA:=RCa.tiempoCarr;
                
    if RMejorPiloto.tiempoCarr>RCa.tiempoCarr then
        RMejorPiloto:=RCa;
end;

procedure ActualizarHistorico(var archCar:TArchCar;var archHis:TArchHis;nom:ST20);
var
    RCa,RMejorPiloto:TRegCar;
    RHi,RAux:TRegHis;
    archTemp:TArchHis;
    
begin
    Assign(archTemp,'TEMP.DAT');
    Rewrite(archTemp);
    reset(archCar);
    reset(archHis);
    Read(archCar,RCa);
    read(archHis,RHi);
    
    RMejorPiloto:=RCa;
    
    while (not eof(archCar)) or (not eof(archHis)) do
    begin
        if RCa.escuderia=RHi.escuderia then
        begin
            while RCa.escuderia=RHi.escuderia do
            begin
                ActualizarDatos(RHi,RCa,RMejorPiloto);
                read(archCar,RCa);
            end;
            Write(archTemp,RHi);
            read(archHis,RHi);
        end
        else if RCa.escuderia<RHi.escuderia then
        begin
            RAux.escuderia:=RCa.escuderia;
            RAux.cantTotalCarGan:=0;
            RAux.mejorTiempoAA:=RCa.tiempoCarr;
            while RAux.escuderia=RCa.escuderia do
            begin
                ActualizarDatos(RAux,RCa,RMejorPiloto);
                read(archCar,RCa);
            end;
            
            Write(archTemp,RAux);
        end
        else
            begin
                WriteLn('La escuderia ', RHi.escuderia, ' no ha ganado, pero si anteriormente');
                Write(archTemp,RHi);
                read(archHis,RHi);
            end;
    end;
    WriteLn('El nombre del piloto y la escuderia del que ha tenido el mejor tiempo es: ', RMejorPiloto.nomPilGan, ' en ', RMejorPiloto.escuderia);
    Write(archTemp,RHi);
    Close(archTemp);
    Close(archCar);
    Close(archHis);
    Erase(archHis);
    Rename(archTemp,nom);
end;
var
    archCar:TArchCar;
    archHis:TArchHis;
begin
    Assign(archCar,'CARRERAS.DAT');
    Assign(archHis,'HISTORICO.DAT');
    
    ActualizarHistorico(archCar,archHis,'HISTORICO.DAT');
end.