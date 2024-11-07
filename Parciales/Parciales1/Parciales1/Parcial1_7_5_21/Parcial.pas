Program Parcial;

{En un archivo se han grabado los datos de ingreso al Campus Virtual de un conjunto de alumnos, la identificación de 
los mismos está encriptada para mantener su anonimato. Se tiene de cada uno registrado: nombre, cantidad de días 
sin acceder y cantidad de accesos a cada una de las actividades (Foros, apuntes de la cátedra, y tareas). 
En cada línea hay: 
    ● Identificación encriptada 
    ● Cantidad de días sin acceder  
    ● Cantidad de accesos a Apuntes 
    ● Cantidad de accesos a Tareas 
    ● Cantidad de accesos a Foros 
Se pide leer el archivo y seleccionar solo los alumnos que no superan los X días desde el último acceso, almacenando 
sus datos en arreglos  VNom, VApuntes, VTareas y VForos.
    - VNom contendrá el nombre 
    - VApuntes, VTareas y VForos: contendrán las veces que accedió a cada actividad 
La identificación deberá desencriptarse, el nombre se obtiene con las letras mayúsculas de una cadena de longitud 
variable terminada con un punto. 
Luego, a partir de los arreglos obtenidos, calcular e informar:
    a) Para cada alumno, nombre, cantidad total de accesos y qué % de ellos corresponden a foros.
    b) Dado un rango de accesos Totales [E1, E2] obtener promedio general de acceso a los Foros.
    c) Nombre del alumno que tuvo más accesos a los Foros, sin haber accedido a los Apuntes (suponer único).
 
Debe resolver cada item (lectura, a, b y c ) mediante una función o procedimiento, según corresponda. Los valores 
de X, E1 y E2 se piden por teclado antes del respectivo cálculo. }
const
    MAX = 10;
Type
    ST10= string[10];
    TVNom = array[1..MAX] of ST10;
    TVByte = array[1..MAX] of byte;

procedure LecturaArch(var vecNom:TVNom;var vecAApuntes,vecATareas,vecAForos:TVByte;var cantAlumnos:byte);
var
    arch:text;
    nombre:ST10;
    car:char;
    x,dias,aApuntes,aTareas,aForos:byte;
begin
    Assign(arch,'datos.TXT');
    Reset(arch);
    WriteLn('Ingrese un dia para mostrar los almunos que no superen x dias de conexion');
    ReadLn(x);

    cantAlumnos := 0;
    while Not Eof(arch) do
    begin
        nombre:='';
        repeat
            Read(arch,car);
            if car in ['A'..'Z'] then
                nombre:=nombre+car;
        until car = '.';
        ReadLn(arch,dias,aApuntes,aTareas,aForos);

        if dias<x then
        begin
            cantAlumnos:=cantAlumnos+1;
            vecNom[cantAlumnos]:=nombre;
            vecAApuntes[cantAlumnos]:=aApuntes;
            vecATareas[cantAlumnos]:=aTareas;
            vecAForos[cantAlumnos]:=aForos;
        end;
    end;
    Close(arch);
end;
//a)
procedure MostrarDatos(vecNom:TVNom;vecAApuntes,vecATareas,vecAForos:TVByte;cantAlumnos:byte);
var
    i:byte;
    suma:word;
begin
    for i:=1 to cantAlumnos do
    begin
        suma:=vecAApuntes[i]+vecATareas[i]+vecAForos[i];
        WriteLn('El alumno ',vecNom[i], ' tiene un total de ', suma,' accesos y el ', vecAForos[i]*100/suma:0:2,'% corresponde a foros');
    end;
end;
//b)
procedure PromedioDeAccesoAForosEnE1E2(vecAApuntes,vecATareas,vecAForos:TVByte;cantAlumnos:byte);
var
    cantAcceden,i,e1,e2:byte;
    suma,acumAForos:word;
begin
    cantAcceden:=0;
    acumAForos:=0;
    WriteLn('Ingrese una cantidad de accesos minima');
    ReadLn(e1);
    WriteLn('Ingrese una cantidad de accesos maxima');
    ReadLn(e2);
    for i:=1 to cantAlumnos do
    begin
        suma := vecAApuntes[i]+vecATareas[i]+vecAForos[i];
        if (suma>=e1) and (suma<=e2) then
        begin
            acumAForos:=acumAForos+vecAForos[i];
            cantAcceden:=cantAcceden+1;
        end;
    end;
    if cantAcceden<>0 then
        WriteLn('El promedio de acceso a foros en el intervalo [',e1,', ',e2,'] es de ', acumAForos/cantAcceden:0:2)
    else
        WriteLn('En ese intervalo no han accedido alumnos a los foros');
end;
//c)
procedure NomAlumnMasAFSinAA(vecNom:TVNom;vecAApuntes,vecAForos:TVByte;cantAlumnos:byte);
var
    masAccesos,i,pos:byte;
    nomMasAccesos:ST10;
    
begin
    masAccesos:=0;
    for i:=1 to cantAlumnos do
        if (masAccesos<vecAForos[i]) and (vecAApuntes[i]=0) then
        begin
            masAccesos:=vecAForos[i];
            nomMasAccesos:=vecNom[i];
            pos:=i;
        end;
    if masAccesos<>0 then
        WriteLn('El nombre del alumno con mas accesos a foros sin haber accedido a apuntes es: ', vecNom[pos], ' (con ', vecAForos[pos],')')
    else
        WriteLn('Todos los alumnos han ingresado a apuntes');
end;

var
    vecNom:TVNom;
    vecAApuntes,vecATareas,vecAForos:TVByte;
    cantAlumnos:byte;
begin
    LecturaArch(vecNom,vecAApuntes,vecATareas,vecAForos,cantAlumnos);
    MostrarDatos(vecNom,vecAApuntes,vecATareas,vecAForos,cantAlumnos);
    PromedioDeAccesoAForosEnE1E2(vecAApuntes,vecATareas,vecAForos,cantAlumnos);
    NomAlumnMasAFSinAA(vecNom,vecAApuntes,vecAForos,cantAlumnos);
end.