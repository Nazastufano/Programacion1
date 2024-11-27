Program Final;

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

type
    ST3 = string[3];
    ST8 = string[8];
    ST10 = string[10];
    TRegEm = record
        legajo:word;
        nombre:ST10;
        sueldo:real;
    end;
    TRegHT = record
        cantHoras,legajo:word;
        fecha:ST8;
        codPozo:ST3;
    end;
    TRegPP = record
        cod:ST3;
        descripicion:ST10;
        montoQuinc,valorHora:Real;
        cantHorasQuinc:word;
    end;
    TVRegPP = array[1..10] Of TRegPP;

    TArchEmpleados = file of TRegEm;
    TArchHorasTrab = file of TRegHT;
    TArchPozoPetrolo = file of TRegPP;
function Busqueda(vec:TVRegPP;cod:ST3):byte;
var
    i:byte;
begin
    i:=1;
    while vec[i].cod<>cod do
        i:=i+1;
    Busqueda:=i;
end;

procedure MostrarTabla(vec:TVRegPP);
var
    i:byte;
begin
    WriteLn('Codigo Pozo       Descripcion       cantidad horas quincena       monto quincena');
    for i:=1 to 10 do
        WriteLn(vec[i].cod,' ', vec[i].descripicion,' ', vec[i].cantHorasQuinc, ' $',vec[i].montoQuinc);
end;
procedure ArmarVector(var archPozoPetrolo:TArchPozoPetrolo;var vec:TVRegPP);
var
    i:byte;
    aux:char;
begin
    reset(archPozoPetrolo);
    i:=0;
    while not eof(archPozoPetrolo) do
    begin
        i:=i+1;
        Read(archPozoPetrolo,vec[i].cod,aux,vec[i].descripicion,vec[i].valorHora);
        vec[i].montoQuinc:=0;
        vec[i].cantHorasQuinc:=0;
    end;
    Close(archPozoPetrolo);
end;

procedure Ejercicicio(var archEmpleados:TArchEmpleados;var archHOrasTrab:TarchHorasTrab; var vec:TVRegPP);
var
    REm:TRegEm;
    RHT:TRegHT;
    cantLegajosErro,cantEmpNoTra:word;
    i:byte;
    fecha:string[2];
begin
    reset(archEmpleados);
    Reset(archHOrasTrab);
    cantLegajosErro:=0;
    cantEmpNoTra:=0;
    
    read(archEmpleados,REm);
    Read(archHOrasTrab,RHT);
    while (NOT eof(archEmpleados)) or (NOT eof(archHOrasTrab)) do
    begin
        if REm.legajo=RHT.legajo then
        begin
            while REm.legajo=RHT.legajo do
            begin
                i:=Busqueda(vec,RHT.codPozo);
                Rem.sueldo:=Rem.sueldo+vec[i].valorHora*RHT.cantHoras;
                
                fecha:=RHT.fecha[7]+RHT.fecha[8];
                if fecha in ['01'..'15'] then
                begin
                    vec[i].montoQuinc:=vec[i].montoQuinc+Rem.sueldo;
                    vec[i].cantHorasQuinc:=vec[i].cantHorasQuinc+RHT.cantHoras;
                end;

                read(archHOrasTrab,RHT);
            end;
            read(archEmpleados,REm);
        end
        else if REm.legajo>RHT.legajo then
            begin
                cantLegajosErro:=cantLegajosErro+1;
                Read(archHOrasTrab,RHT);
            end
        else
            begin
                cantEmpNoTra:=cantEmpNoTra+1;
                read(archEmpleados,REm);
            end;
    end;
    close(archEmpleados);
    Close(archHOrasTrab);
    
    WriteLn('La cantidad de empleados que no trabajaron en el mes es: ',cantEmpNoTra);
    WriteLn('La cantidad de legajos erroneos distintos es: ',cantLegajosErro);
    MostrarTabla(vec);
end;

var
    archEmpleados:TArchEmpleados;
    archHOrasTrab:TarchHorasTrab;
    archPozoPetrolo:TArchPozoPetrolo;
    vec:TVRegPP;
begin
    Assign(archEmpleados,'EMPLEADOS.dat');
    Assign(archHOrasTrab,'HORAS-TRABAJO.dat');
    Assign(archPozoPetrolo,'Pozo-Petrolero.dat');

    ArmarVector(archPozoPetrolo,vec);
    Ejercicicio(archEmpleados,archHOrasTrab,vec);
end.