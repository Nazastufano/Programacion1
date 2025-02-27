Program Ejercicio1;

(*Una empresa Petrolera tiene un archivo EMPLEADOS.dat y otro HORAS-TRABAJO.dat con el registro de
horas trabajadas por cada empleado en el mes anterior.

EMPLEADOS
Legajo (Clave primaria - campo de secuencia)
Nombre
Sueldo (inicialmente 0)

HORAS-TRABAJO
Legajo (Clave secundaria - campo de secuencia)
Fecha (formato AAAAMMDD)
Cantidad-Horas
Codigo-Pozo (ANU3)

Además, se cuenta con un archivo Pozo-Petrolero.dat dinde se especifica código, descripción y un valor
para las horas según el pozo (no son más de 10).

Pozo-Petrolero
Código Descripcion ValorHora
A55    Tupungato   1200
B14    Chubut      3000
B74    Cacheuta    1500
A99    Neuquén     3000
...    ......      ....

Se pide, aplicando la técnica que corresponda, en un único reocrrido:
    a) Procesar el archivo HORAS-TRABAJO actualizando el sueldo en EMPLEADOS siempre que sea posible.
    b) Informar cuántos empleados no trabajaron en el mes.
    c) Informar cuántos legajos erróneos distintos hubieron en el archivo HORAS-TRABAJO.
    d) Por fin de proceso mostrar para la primera quincena un informe con el siguiente formato:
    
    CódigoPozo   Descripción     Cant de Horas 1eraQuincena    Monto Total 1eraQuinc
    999          XXXXXXXXXXXX    999                           $999.999.99
    999          XXXXXXXXXXXX    999                           $999.999.99
    ...          ............    ...                           ........   

Nota: Describir los tipos utilizados y los subprogramas necesarios para resolver lo pedido.
*)

Type
    ST3 = string[3];
    ST8 = string[8];
    ST10 =string[10];
    TRegEmp = record
        legajo:word;
        nombre:ST10;
        sueldo:real;
    end;

    TRegHT = record
        legajo:word;
        fecha:ST8;
        cantHoras:byte;
        codPozo:ST3;
    end;

    TRegPP = record
        codPozo:ST3;
        descripcion:ST10;
        valorHora:real;
    end;

    TRegVecPP = record
        datosPozo:TRegPP;
        horasQuinc:word;
        montoTotal:real;
    end;

    TVecPP = array[1..10] of TRegVecPP;
    TArchEmp = file of TRegEmp;
    TArchHT = file of TRegHT;
    TArchPP = file of TRegPP;

procedure ArmarVectorPozos(var archPP:TArchPP;var vecPozos:TVecPP;var cantPozos:byte);
var
    R:TRegPP;
    i:byte;

begin
    reset(archPP);
    read(archPP,R);
    i:=0;
    while Not eof(archPP) do
    begin
        i:=i+1;
        vecPozos[i].datosPozo:=R;
        vecPozos[i].horasQuinc:=0;
        vecPozos[i].montoTotal:=0;
        read(archPP,R);
    end;
    cantPozos:=i;
    close(archPP);
end;

function Busqueda(vecPozos:TVecPP;codPozo:ST3;cantPozos:byte):byte;
var
    i:byte;
begin
    i:=1;
    while (i<cantPozos) and (vecPozos[i].datosPozo.codPozo<>codPozo) do
        i:=i+1;
    Busqueda:=i;
end;

procedure MostrarDatosPozos(vecPozos:TVecPP;cantPozos:byte);
var
    i:byte;
begin
    WriteLn('CodigoPozo     Descripcion     Cant de Horas 1eraQuincena      Monto Total 1eraQuinc');
    for i:=1 to cantPozos do
        WriteLn(vecPozos[i].datosPozo.codPozo,'     ',vecPozos[i].datosPozo.descripcion,'     ',vecPozos[i].horasQuinc,'     $',vecPozos[i].montoTotal);
end;

procedure ActualizarSueldos(var archEmp:TArchEmp;var archHT:TArchHT;var vecPozos:TVecPP);
var
    REm:TRegEmp;
    RHT:TRegHT;
    dia:string;
    legajoActual,empleadosNoTrab,erroresHT:word;
    numPozo:byte;
    sueldo:real;
begin
    reset(archEmp);
    reset(archHT);
    read(archEmp,Rem);
    read(archHT,RHT);
    empleadosNoTrab:=0;
    erroresHT:=0;
    while (NOT eof(archEmp)) or(NOT eof(archHT)) do
    begin
        if REm.legajo=RHT.legajo then
        begin
            legajoActual:=REm.legajo;
            
            while legajoActual=REm.legajo do
            begin
                numPozo:=Busqueda(vecPozos, RHT.codPozo,cantPozos);
                sueldo:=RHT.cantHoras*vecPozos[numPozo].datosPozo.valorHora;
                REm.sueldo:= REm.sueldo + sueldo;
                dia:=RHT.fecha[7] + RHT.fecha[8];
                if (dia>='01') and (dia<='15') then
                begin
                    vecPozos[numPozo].horasQuinc:=RHT.cantHoras;
                    vecPozos[numPozo].montoTotal:=sueldo;
                end;
                Read(archHT,RHT);    
            end;
            Read(archEmp,REm);
        end 
        else if REm.legajo<RHT.legajo then
            begin
                empleadosNoTrab:=empleadosNoTrab+1;
                read(archEmp,REm);
            end
        else
            begin
                legajoActual:=RHT.legajo;
                erroresHT:=erroresHT+1;
                while legajoActual=RHT.legajo do
                    read(archHT,RHT);
            end;
    end;
    WriteLn('La cantidad de emplados que no trabajaron es: ', empleadosNoTrab);
    WriteLn('La cantidad de legajos erroneos distintos es: ', erroresHT);
    close(archEmp);
    Close(archPP);
end;
var
    archEmp:TRegEmp;
    archHT:TRegHT;
    archPP:TregPP;
    vecPozos:TVecPP;
    cantPozos:byte;
begin
    Assign(archEmp,'EMPLEADOS.dat');
    Assign(archHT,'HORAS-TRABAJO.dat');
    Assign(archPP,'Pozo-Petrolero.dat');

    ArmarVectorPozos(archPP,vecPozos,cantPozos);
    ActualizarSueldos(archEmp,archHT,vecPozos);
    MostrarDatosPozos(vecPozos,cantPozos);
end.