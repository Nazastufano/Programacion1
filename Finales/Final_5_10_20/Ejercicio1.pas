Program Ejercicio1;

(*La Federación de Fórmula 1 tiene registrado en un archivo CARRERAS toda la información acerca de las 
carreras en los últimos años, las escuderías que intervinieron y todos sus pilotos. Además se cuenta con un 
archivo PILOTOS que contiene los datos de los 50 mejores pilotos que participaron en las mismas. La 
estructura de los archivos es la siguiente: 
 
Archivo CARRERAS 
- FECHA de la CARRERA (ANU 10  AAAA/MM/DD, 1er. campo de secuencia, clave secundaria) 
- ESCUDERIA (1..10, 2do. campo de secuencia, clave secundaria) 
- COD_PILOTO (1..50) 
- PUESTO en la carrera (1..30, 99=Abandonó) 
- TIEMPO 

Archivo ESCUDERIAS 
- COD_ESCUDERIA (1..10, clave primaria) 
- NOMBRE ( ANU 20) 

Archivo PILOTOS
- COD_PILOTO (1..50, clave primaria) 
- NOMBRE ( ANU 20) 
- MEJOR_TIEMPO_PERSONAL 
 
Se pide generar el siguiente listado: 
 
                    Carreras 
 
Fecha: 9999/99/99 
Escudería      (.)Mejor Piloto     Puesto     Tiempo    Superó marca personal   
XXXXXXX         XXXXXXXXX           99        99.99     si/no    
XXXXXXX         XXXXXXXXX           99        99.99     si/no         
...             ...                 ...       …..       ...    
Cantidad  de pilotos que abandonaron  99   
 
Fecha: 9999/99/99 
Escudería       Mejor Piloto       Puesto     Tiempo    Superó marca personal
XXXXXXX         XXXXXXXXX           99        99.99     si/no
XXXXXXX         XXXXXXXXX           99        99.99     si/no
...             ...                 ...       …..       ...
Cantidad de pilotos que abandonaron  99 
                                . . . . 
 
La Escudería XXXXXXXX con su piloto: XXXXXXXX hizo el mejor tiempo 

Listado de escuderías con cantidad de podios  
    Escudería        Podios 
    XXXXXXX         99    
    XXXXXXX         99     
      ………           ……  
    TOTAL           999 
(.)Mejor Piloto: corresponde al piloto que registró el mejor tiempo 

NOTA:Los archivos deberán recorrerse una sola vez.  *)

type
    ST2 = string[2];
    ST10 = string[10];
    ST20 = string[20];
    TVCont = array[1..10] of byte;
    TRegEsc = record
        codEsc:1..10;
        nomEsc:ST20;
    end;
    TRegPil = record
        codPil:1..50;
        nomPil:ST20;
        mejorTiemPers:real;
    end;
    TRegCar=record
        fecha:ST10;
        codEsc:1..10;
        codPil:1..50;
        puesto:byte;
        tiempo:real;
    end;
    TRegAux = record
        nomPil:ST20;
        puesto:byte;
        tiempo:real;
        res:ST2;
    end;
    TVRegEsc = array[1..10] of TRegEsc;
    TVRegPil = array[1..50] of TRegPil;
    
    TArchCar = file of TRegCar;
    TArchEsc = file of TRegEsc;
    TArchPil = file of TRegPil;

procedure ArmarVecPil(var archPil:TArchPil; var vecPil:TVRegPil);
var
    i:byte;
    R:TRegPil;
begin
    reset(archPil);
    i:=0;
    Read(archPil,R);
    while NOT eof(archPil) do
    begin
        i:=i+1;
        vecPil[i]:=R;
        read(archPil,R);
    end;
    Close(archPil);
end;

procedure ArmarVecEsc(var archEsc:TArchEsc; var vecEsc:TVRegEsc);
var
    i:byte;
    R:TRegEsc;
begin
    Reset(archEsc);
    read(archEsc,R);
    i:=0;
    while not eof(archEsc) do
    begin
        i:=i+1;
        vecEsc[i]:=R;
        read(archEsc,R);
    end;
    Close(archEsc);
end;
procedure InicializarVec(var vecCont:TVCont);
var
    i:byte;
begin
    for i:=1 to 10 do
        vecCont[i]:=0;
end;

procedure mostrarTabla(vecCont:TVCont;vecEsc:TVRegEsc);
var
    i:byte;
    suma:word;
begin
    WriteLn('Listado de escuderías con cantidad de podios');
    WriteLn('Escuderia        Podios');
    suma:=0;
    for i:=1 to 10 do
    begin
        WriteLn(vecEsc[i].nomEsc, '     ', vecCont[i]);
        suma:=suma+vecCont[i];
    end;
    WriteLn('TOTAL      ', suma);
end;
procedure ArmarTabla(var archCar:TArchCar; vecEsc:TVRegEsc;vecPil:TVRegPil);
var
    pilotoMT, escuderiaMT:ST20;
    mejorTiempo,mTEsc:real;
    cantAbandonos:byte;
    fechaActual:ST10;
    codEscActual:1..10;
    RCa:TRegCar;
    posMejorPil:1..50;
    RAux:TRegAux;
    vecCont:   TVCont;
begin
    reset(archCar);
    read(archCar,RCa);
    mejorTiempo:=0;
    InicializarVec(vecCont);
    while NOt eof(archCar) do
    begin
        fechaActual:=RCa.fecha;
        cantAbandonos:=0;
        Write('Fecha: ', fechaActual);
        while fechaActual = RCa.fecha do
        begin
            Write('Escuderia      Mejor Piloto     Puesto     Tiempo    Supera marca personal');
            codEscActual:=RCA.codEsc;
            mTEsc:=0;
            while (codEscActual = RCA.codEsc) and (fechaActual =   RCa.fecha) do
            begin
                if RCa.tiempo<vecPil[RCa.codPil].mejorTiemPers then
                    begin
                        Raux.tiempo := RCa.tiempo;
                        RAux.res := 'si'
                    end
                else
                    RAux.res:='no';
                
                if RCa.puesto=99 then
                    cantAbandonos:=cantAbandonos+1
                else
                    begin
                        if RCa.puesto<=3 then
                            vecCont[vecEsc[RCa.codEsc]]:=vecCont[vecEsc[RCa.codEsc]]+1;
                        if (mTEsc>RCa.tiempo) or (mTEsc=0) then
                        begin
                            RAux.nomPil:=vecPil[RCa.codPil].nomPil;
                            Raux.puesto:=RCa.puesto;
                            mTEsc:=RCa.tiempo;
                        end;

                        if (mejorTiempo>RCa.tiempo) or (mejorTiempo=0) then
                        begin
                            mejorTiempo := rca.tiempo;
                            escuderiaMT:=vecEsc[codEscActual].nomEsc;                    
                            pilotoMT:=vecPil[rca.codPil].mejorTiemPers;
                        end;
                    end;
                
                Read(archCar,RCa);
            end;
            Write(vecEsc[codEscActual].nomEsc,'    ',RAux.nomPil,'    ',RAux.puesto,'   ',RAux.tiempo,'    ',RAux.res);
        end;
        Writeln('Cantidad de pilotos que abandonaron ', cantAbandonos);
    end;
    WriteLn('La Escuderia ', escuderiaMT,' con su piloto: ', pilotoMT,' hizo el mejor tiempo');
    Close(archCar);
    mostrarTabla(vecCont,vecEsc);
end;
var
    vecEsc:TVRegEsc;
    vecPil:TVRegPil;
    archCar:TArchCar;
    archPil:TArchPil;
    archEsc:TArchEsc;
    
begin
    Assign(archCar,'CARRERAS.DAT');
    Assign(archPil,'PILOTOS.DAT');
    Assign(archEsc,'ESCUDERIAS.DAT');
    
    ArmarVecPil(archPil, vecPil);
    ArmarVecEsc(archEsc, vecEsc);
    ArmarTabla(archCar,vecEsc,vecPil);
end.