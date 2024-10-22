Program Parcial2Recu;

(*Un Municipio de una localidad turística registra el ingreso de turistas de manera resumida para los últimos N 
años, y para cada año por trimestre. La cantidad de turistas está compuesta por dos valores: cantidad de turistas 
mayores de edad y cantidad de turistas menores de edad. Ambas cantidades están en miles de personas. 
Estos datos se tienen en un archivo de texto TURISTAS.TXT, en la primera línea el valor de N y en las siguientes N 
líneas, una por cada año en orden descendente (comenzando desde 2021). En cada línea se tienen 8 valores: los 
primeros 4 corresponden a los mayores de edad en cada uno de los trimestres, y los últimos 4 a los menores de 
edad.

En otro archivo ESCALAS.TXT, se almacenan escalas de asistencia turística por trimestre, una escala por fila con su 
descripción (cadena de 15) y su tope máximo de turistas (por ej MUY BAJA 2000, indica que si ingresaron 2000 
turistas o menos, la escala correspondiente es muy baja). Las escalas a manejar son: MUY BAJA, BAJA, MEDIA, 
ALTA, MUY ALTA, EXTRAORDINARIA.  
Además, se establece como un registro FAMILIAR a los trimestres donde la cantidad de turistas menores de edad 
es igual o mayor a la de los mayores de edad.

Se pide leer los datos de los archivos y almacenar la información necesaria en las estructuras adecuadas, 
paraluego: 
    a) Generar un arreglo con los años, la cantidad total de turistas mayores de edad y menores de edad que 
       tengan al menos 2 trimestres con escala X o mayor (X ingresado por teclado; tener en cuenta uso de la 
       función Trim (agregar sysutils en sección Uses)). Luego mostrar el arreglo generado. 
    b) Obtener el trimestre con menor asistencia promedio teniendo en cuenta todos los años. En caso de que 
       exista más de uno, quedarse con el primero obtenido. 
    c) Dado un año K ingresado por teclado (puede no existir entre los que estaban en el archivo), calcular el 
       porcentaje de registros de tipo FAMILIAR. 

Condición para aprobar: los siguientes subprogramas (función o procedimiento, según corresponda), necesarios 
para resolver el problema planteado, deben ser resueltos correctamente en forma recursiva: 
    - Calcular la asistencia promedio para un trimestre en todos los años (para el inciso b)  
    - Contar registros de tipo FAMILIAR para un año determinado (para el inciso c)  
Nota: No resolver de manera recursiva ningún otro subprograma que no sean los especificados. 

Importante: 
    • Los archivos deben recorrerse una sola vez. 
    • La solución se debe implementar usando indefectiblemente registros
    , vectores y matrices 
    • Cada proceso debe ser implementado en un subprograma (según corresponda función o 
    procedimiento) 
    • Se considerarán la eficiencia, claridad y modularización adecuada del código. 
    • Los datos del ejemplo son ilustrativos para realizar una ejecución con los mismos, NO deben figurar 
    como constantes en el código desarrollado. 
    • Para entregar, nombrar el archivo .PAS o .LPR con su apellido (NO subir archivo .LPI ni .LPS) 
*)
uses
    sysutils;

Type
    ST15 = string[15];
    TM = array[1..10,1..8] of word;
    TRegEsc = record
        escala:ST15;
        topeMax:real;
    end;
    TVRegEsc = array[1..6] of TRegEsc;
    TRegFam = record
        trimestre:byte;
        anio:word;
    end;
    TVRegFam = array[1..10*4] of TRegFam;
    TRegAP =record
        anio:word;
        cantMen,cantMay:word;
    end;
    TVRegAP = array[1..10] of TRegAP;
procedure LecturaT(var matr:TM; var N:byte);
var
    arch:text;
    i,j:byte;
    val:word;
begin
    Assign(arch,'TURISTA.TXT');
    reset(Arch);
    ReadLn(arch,N);
    for i:=1 to N do
    begin
        for j:= 1 to 8 do
        begin
            Read(arch,val);
            matr[i,j]:=val;
        end;
        ReadLn(arch);
    end;
    Close(arch);
end;

procedure LecturaE(var vecEscal:TVRegEsc);
var
    arch:text;
    escala:ST15;
    topeMax:real;
    i:byte;
begin
    Assign(arch,'ESCALAS.TXT');
    Reset(arch);
    i:=0;
    while not eof(arch) do
    begin
        ReadLn(arch,escala,topeMax);
        i:=i+1;
        vecEscal[i].escala:=escala;
        vecEscal[i].topeMax:=topeMax;
    end;
    Close(arch);
end;
procedure GenerarRegistroFam(var vecFam:TVRegFam;matr:TM;N:byte);
var
    i,j,k:byte;
begin
    k:=0;
    for i:=1 to N do
        for j:=1 to 4 do
            if matr[i,j]<=matr[i,j+4] then
            begin
                k:=k+1;  
                vecFam[k].trimestre:=j;
                vecFam[k].anio:=2022-i;
            end;
end;

function BuscarPos(vecEscal:TVRegEsc;x:ST15):byte;
var
    i:Byte;
begin
    i:=1;
    while (i<=6) and (x<>trim(vecEscal[i].escala)) do
        i:=i+1;
    if i=7 then
        BuscarPos:=0
    else
        BuscarPos:=i;
end;
procedure MostrarArreglo(vecAP:TVRegAP;k:byte);
var
    i:byte;
begin
    Write('[');
    for i:=1 to k do
    begin
        if i<>k then
            Write('(',vecAP[i].anio,', ',vecAP[i].cantMay,', ',vecAP[i].cantMen,'), ')
        else    
            Write('(',vecAP[i].anio,', ',vecAP[i].cantMay,', ',vecAP[i].cantMen,')]');
    end;
    WriteLn();
end;
{a) Generar un arreglo con los años, la cantidad total de turistas mayores de edad y menores de edad que 
       tengan al menos 2 trimestres con escala X o mayor (X ingresado por teclado; tener en cuenta uso de la 
       función Trim (agregar sysutils en sección Uses)). Luego mostrar el arreglo generado. }
procedure GenerarArregloSuperanEscala(var vecAP:TVRegAP; matr:TM;vecEscal:TVRegEsc;N:byte);
var
    i,j,k,pos,cont:byte;
    x:ST15;
    suma:word;
begin
    WriteLn('Ingrese la escala');
    ReadLn(x);
    x:= upCase(x);
    pos:=BuscarPos(vecEscal,x);
    if pos<> 0 then
    begin
        k:=0;
        for i:=1 to N do
        begin
            cont:=0;    
            for j:= 1 to 4 do
            begin
                suma:=matr[i,j]+matr[i,j+4];
                If suma>=vecEscal[pos].topeMax Then
                    cont:=cont+1;
            end;
            if cont>=2 then
            begin
                k:=k+1;
                vecAP[k].anio:=2022-i;
                vecAP[k].cantMen:=matr[i,1]+ matr[i,2]+ matr[i,3]+ matr[i,4];
                vecAP[k].cantMay:=matr[i,5]+ matr[i,6]+ matr[i,7]+ matr[i,8];
            end;
        end;  
        if k=0 then
            WriteLn('No superan la escala')
        else
            MostrarArreglo(vecAP,k);
    end
    else
        begin
            WriteLn('La escala ingresada no existe');
        end;
end;

{b) Obtener el trimestre con menor asistencia promedio teniendo en cuenta todos los años. En caso de que 
       exista más de uno, quedarse con el primero obtenido.
    - Calcular la asistencia promedio para un trimestre en todos los años (para el inciso b) }
function AsistenciaPromedio(matr:TM;i,j:byte):real;
begin
    if i=1 then
        AsistenciaPromedio:= (matr[i,j] + matr[i,j+4])/4
    else
        AsistenciaPromedio := (matr[i,j] + matr[i,j+4])/4 + AsistenciaPromedio(matr,i-1,j);
end;

procedure MenorAsistenciaProm(matr:TM;N:byte);
var
    j,trimMenosAs:byte;
    prom,menProm:real;

begin
    for j:=1 to 4 do
    begin
        prom:=AsistenciaPromedio(matr,N,j);
        if (menProm>prom) or (j=1) then
        begin
            menProm := prom;
            trimMenosAs:=j;
        end;
    end; 
    WriteLn('El trimestre con menos promedio de asistencias es: ', trimMenosAs);
end;

{c) Dado un año K ingresado por teclado (puede no existir entre los que estaban en el archivo), calcular el 
       porcentaje de registros de tipo FAMILIAR.
       - Contar registros de tipo FAMILIAR para un año determinado (para el inciso c) }

function

var
    matr:TM;
    vecEscal:TVRegEsc;
    vecFam:TVRegFam;
    vecAP:TVRegAP;
    N:byte;
begin
    LecturaT(matr,N);
    LecturaE(vecEscal);
    GenerarRegistroFam(vecFam,matr,N);
    GenerarArregloSuperanEscala(vecAP,matr,vecEscal,N);
    MenorAsistenciaProm(matr,N);
end.