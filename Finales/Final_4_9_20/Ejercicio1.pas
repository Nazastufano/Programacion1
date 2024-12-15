Program Ejercicio1;

(*La Facultad otorga becas (ayuda económica) a sus alumnos en base a su promedio. 
A fin de año se actualiza la situación de cada alumno de acuerdo a su desempeño. Además 
incorporan nuevos alumnos con beca y se dan de baja otros a quienes ya no corresponde la beca. 
Las becas son otorgadas automáticamente según el siguiente criterio: 
    Promedio >8 -> Beca completa 
    6<= Promedio <=8- > Media Beca  
    En otro caso -> Sin Beca 

Se cuenta con los siguientes archivos binarios: 
BECADOS 
# Legajo (ANU5, campo de secuencia, clave primaria) 
# Código Carrera (1..10) 
# Promedio  
# Tipo de Beca (1-Completa, 2-Media) 

NOVEDADES 
#Legajo (ANU5, campo de secuencia, clave primaria) 
# Código Carrera (1..10) 
# Promedio(Nuevo) 

CARRERA 
# Código Carrera(1..10) 
# Descripción (ANU12) 

Se pide actualizar el archivo BECADOS de la siguiente forma: 
    -Para un mismo Legajo en BECADOS y NOVEDADES, si corresponde, actualizar su 
    promedio y el tipo de Beca, en caso de perderla, darlo de baja. 
    -Si el Legajo de NOVEDADES no figura en ALUMNOS, si corresponde, incorporarlo con su 
    Tipo de Beca. 
    -Si el Legajo de BECADOS no figura en NOVEDADES, darlo de baja. 

Por fin de proceso informar: 
    Total de alumnos que bajaron o perdieron su Beca. 
    Cantidad de alumnos que se dieron de alta con Beca Completa 
    Cantidad de Alumnos con Beca de cada Carrera 

Codigo Carrera Cantidad Becados 
1      XXXXXXXXXXXX      99
…          …             ….
10     XXXXXXXXXXXX      99 

Nota: SOLO debe desarrollar el Procedimiento/Función que resuelva lo pedido  y la definición de 
Tipos/Variables usadas. Asumir que los archivos ya fueron cargados  *)

type
    ST5 = String[5];
    ST12 = String[12];

    TRegCar = record
        cod:1..10;
        desc:ST12;
    end;
    TRegBec = record
        legajo:ST5;
        cod:1..10;
        prom:real;
        tipoBeca:1..2;
    end;

    TRegNov = record
        legajo:ST5;
        cod:1..10;
        prom:real;
    end;
    TV = array[1..10] of word;
    TVRegCar = array[1..10] of TRegCar;
    TArchBec = file of TRegBec;
    TArchNov = File of TRegNov;
    TArchCar = File of TRegCar;
procedure InicializarVec(var vec:TV);
var 
    i:byte;
begin
    for i:=1 to 10 do
        vec[i]:=0;
end;
procedure CargarVecCarreras(var archCar:TArchCar;var vecRegCar: TVRegCar);
var
    i:byte;
    R:TRegCar;
begin
    reset(archCar);
    read(archCar,R);
    i:=0;
    while NOT eof(archCar) do
    begin
        i:=i+1;
        vecRegCar[i]:=R;
        Read(archCar);
    end;
    Close(archCar);
end;

function CalcularTipoBeca(prom:real):byte;
begin
    if prom>8 then
        CalcularTipoBeca:=1
    else if (prom<=8) and (prom>=6) then
        CalcularTipoBeca:=2
    else
        CalcularTipoBeca:=0;
end;
procedure ActualizarBecados(var archBec:TArchBec; var archNov:TArchNov; var vec:TV;nom:ST12);
var
    totalAlumnPerdBaja,cantAlumnosNuevos:word;
    
    archTemp:TArchBec;
    RAux,RBe:TRegBec;
    RNo:TRegNov;
    i:byte;
begin
    Assign(archTemp,'TEMP.DAT');
    Reset(archBec);
    Reset(archNov);
    Rewrite(archTemp);
    read(archBec,RBe);
    read(archNov,RNo);
    totalAlumnPerdBaja:=0;
    cantAlumnosNuevos:=0;

    while (NOT eof(archNov)) or (NOT eof(archBec)) do
    begin
        if RBe.legajo=RNo.legajo then
        begin
            i:=CalcularTipoBeca(RNo.prom);
            RBe.prom:=RNo.prom;
            if (i<RBe.tipoBeca) then
                totalAlumnPerdBaja := totalAlumnPerdBaja+1;
                
            if (i<>0) then
            begin
                RBe.tipoBeca := i;
                Write(archTemp,RBe);
                vec[RBe.cod]:=vec[RBe.cod]+1;
            end;    
                
            read(archBec,RBe);
            read(archNov,RNo);
        end
        else if RBe.legajo<RNo.legajo then
        begin
            totalAlumnPerdBaja:=totalAlumnPerdBaja+1;
            Read(archBec,RBe);
        end
            else
            begin
                RAux.legajo:=RNo.legajo;
                RAux.cod:=RNo.cod;
                RAux.prom:=RNo.prom;
                i:=CalcularTipoBeca(RAux.prom);
                if i<>0 then
                begin
                    RAux.tipoBeca := i;
                    if i=1 then
                        cantAlumnosNuevos := cantAlumnosNuevos+1;
                    vec[RAux.cod]:=vec[RAux.cod]+1;
                    Write(archTemp,RAux);
                end;
                read(archNov,RNo);
            end;
    end;
    Write(archTemp,RBe);
    Close(archBec);
    Close(archNov);
    Close(archTemp);
    Erase(archBec);
    Rename(archTemp,nom);
end;
procedure ArmarTabla(vecCont:TV;vecRegCar:TVRegCar);
var
    i:byte;
begin
    WriteLn('Codigo Carrera Cantidad Becados');
    for i:=1 to 10 do
        WriteLn(vecRegCar[i].cod,'  ',vecRegCar[i].desc,'   ',vecCont[i]);
end;
var
    archBec:TArchBec;
    archNov:TArchNov;
    archCar:TArchCar;
    vecRegCar:TVRegCar;
    vecCont:TV;
begin
    Assign(archBec,'BECADOS.DAT');
    Assign(archNov,'NOVEDADES.DAT');
    Assign(archCar,'CARRERA.DAT');
    InicializarVec(vecCont);
    CargarVecCarreras(archCar,vecRegCar);
    ActualizarBecados(archBec,archNov,vecCont,'BECADOS.DAT');
    ArmarTabla(vecCont,vecRegCar);
end.