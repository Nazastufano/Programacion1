Program Ejercicio2;

(*Se tiene un archivo que contiene la información de las Carpas de un Balneario, y otro con los 
Consumos de los ocupantes de las mismas realizados en el último día, según el siguiente diseño: 
Archivo CARPAS  
     NroCarpa (entero, campo de secuencia, clave 
    primaria) 
     DNI_Cliente 
     ConsumoAcumulado 
Archivo Consumos (.) 
     NroCarpa (entero, campo de secuencia, clave 
    secundaria) 
     Concepto 
     Importe 
Se pide, recorriendo una sola vez los archivos: 
a) Actualizar el archivo Carpas, poniendo al día el importe acumulado de consumos de cada carpa y 
   eliminar aquellas que poseen un consumo cuyo concepto sea “Cierre” listando los datos 
   actualizados del registro eliminado. 
   (.) En caso de “Cierre”: Este Concepto aparecerá como último consumo del día y el Importe 
   asociado es $0. 
b) Por fin de proceso informar por pantalla: 
     Nro de Carpa que más consumió en el día. (No incluir los consumos erróneos).
     Cantidad de Carpas sin consumo en el día
     Cantidad de consumos erróneos (carpas inexistentes)

*)

Type
    ST8 = String[8];
    ST20 = String[20];
    TRegCar = record
        NroCarpa:integer;
        DniCliente:ST8;
        consumAcum:real;
    end;
    TRegCon = record
        NroCarpa:integer;
        concepto:ST8;
        importe:real;
    end;
    TArchCar = file of TRegCar;
    TArchCon = file of TRegCon;

procedure ActualizarDatos(var archCar:TArchCar; var archCon:TArchCon; nom:ST20);
var
    nroCarpaMasConsum:integer;
    masConsum,acumImporte:real;
    cantCarpSinConsum,cantConsumError:byte;
    archTemp:TArchCar;
    RCa:TRegCar;
    RCo:TRegCon;
    guardar:Boolean;

begin
    Assign(archTemp,'TEMP.DAT');
    Rewrite(archTemp);
    reset(archCar);
    Reset(archCon);
    read(archCar,RCa);
    read(archCon,RCo);
    masConsum:=0;
    cantCarpSinConsum:=0;
    cantConsumError:=0;
    while (NOT eof(archCar)) or (NOT eof(archCon)) do
    begin
        if RCa.NroCarpa=RCo.NroCarpa then
        begin
            guardar:=true;
            acumImporte:=0;
            while RCa.NroCarpa=RCo.NroCarpa do
            begin
                if RCo.importe<>0 then
                    acumImporte:=acumImporte+RCo.importe
                else
                    begin
                        RCa.consumAcum:=RCa.consumAcum+acumImporte;
                        WriteLn('Registro eliminado: ', RCa.NroCarpa,'    ',Rca.DniCliente,'    ',RCa.consumAcum);
                        guardar:=false;
                    end;

                Read(archCon,RCo);
            end;            
            if guardar then
                Write(archTemp,RCa);
            
            if (acumImporte>masConsum) and (guardar=true) then
            begin
                masConsum:=acumImporte;
                nroCarpaMasConsum:=RCa.NroCarpa;
            end;
            
            read(archCar,RCa);
        end
        else if RCa.NroCarpa < RCo.NroCarpa then
        begin
            cantCarpSinConsum:=cantCarpSinConsum+1;
            Write(archTemp,RCa);
            read(archCar,RCa);
        end
            else
            begin
                cantConsumError:=cantConsumError+1;
                Read(archCon,RCo);
            end;
    end;
    WriteLn('El Nro de Carpa que mas ha consumido en el dia es ',nroCarpaMasConsum);
    WriteLn('La cantidad de Carpas sin consumo en el dia es ',cantCarpSinConsum);
    WriteLn('La cantidad de consumos erroneos es ',cantConsumError);
    read(archTemp,RCa);
    Close(archCar);
    Close(archCon);
    Close(archTemp);
    Erase(archCar);
    Rename(archTemp,nom);
end;
var
    archCar:TArchCar;
    archCon:TArchCon;
begin
    Assign(archCar,'CARPAS.DAT');
    Assign(archCon,'CONSUMOS.DAT');
    ActualizarDatos(archCar,archCon,'CARPAS.DAT');
end.    