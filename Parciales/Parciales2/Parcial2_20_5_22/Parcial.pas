Program Parcial;

{Una Universidad registra los datos de los inscriptos a una carrera a distancia en un archivo de texto 
INSCRIPTOS.TXT, un inscripto por línea y ordenado por orden de inscripción. Cada línea contiene los siguientes 
datos: 
    • DNI (cadena de 8) 
    • Edad (menor a 100) 
    • Código Provincia (cadena de 2) 
Además se cuenta con el archivo PROVINCIAS.TXT que posee los siguientes datos en cada línea: 
    • Código (cadena de 2) 
    • Nombre(cadena de 30) 
    • Distancia de la capital de la provincia hasta la sede de la Universidad (en km) 
Se pide leer los datos de los archivos y almacenarlos en las estructuras necesarias para obtener información 
resumida por provincia y rangos etarios agrupados de a 10 años (por ejemplo: el primer rango de los 10 contiene 
a las personas con edades de 10 a 19 y el último rango de los 90, a las personas de 90 a 99). Luego, en base a esas 
estructuras, informar: 
    a) Dado un código de provincia X, ingresado por teclado (puede no existir), cantidad de rangos etarios 
    sin inscriptos en X. 
    b) La provincia con menos cantidad total de inscriptos en los rangos etarios ubicados entre el rango R y 
    el rango T (R <= T) ingresados por teclado (se ingresa la edad de inicio del rango: por ej. 30 para el 
    rango 30-39). Si hubiera más de una, mostrar la primera. 
    c) Generar un arreglo con los pares provincia-rango etario (poner en el arreglo, para el rango, la edad de 
    inicio) que superen el 10% del total de inscriptos en la carrera. Luego mostrar el arreglo generado. 

Condición para aprobar: los siguientes subprogramas (función o procedimiento, según corresponda), necesarios 
para resolver el problema planteado, deben ser resueltos correctamente en forma recursiva: 
    - Buscar la provincia de nombre X (para el inciso a) 
    - Calcular el total de inscriptos (para el inciso c) 
Nota: No resolver de manera recursiva ningún otro subprograma que no sean los especificados.
Importante: 
    • Los archivos deben recorrerse una sola vez. 
    • La solución se debe implementar usando indefectiblemente registros, vectores y matrices
    • Cada proceso debe ser implementado en un subprograma (según corresponda función o 
    procedimiento) 
    • Se considerarán la eficiencia, claridad y modularización adecuada del código. 
    • Los datos del ejemplo son ilustrativos para realizar una ejecución con los mismos, NO deben figurar 
como constantes en el código desarrollado. 
    • Para entregar, nombrar el archivo .PAS o .LPR con su apellido (NO subir archivo .LPI ni .LPS) 
}
const
    N=5;
    MaxIns = 18;
type
    ST2 = string[2];
    ST30 = string[30];
    ST8 = string[8];
    TRegProv = record
        cod:ST2;
        nombre:ST30;
        distancia:real;
    end;
    TRegInsc = record
        dni:ST8;
        edad:byte;
        cod:ST2;
    end;
    TRegPR = record
        cod:ST2;
        rango:byte;
    end;
    TM = array[1..N,1..9] of word;
    TV = array[1..N] of TRegProv;
    TVInsc = array[1..MaxIns] of TRegInsc;
    TVRegPR = array[1..N*9] of TRegPR;
procedure LecturaP(var vec:TV);
var
    arch:text;
    aux:char;
    cod:ST2;
    nombre:ST30;
    i:byte;
    distancia:real;
begin
    i:=0;
    assign(arch,'PROVINCIAS.TXT');
    reset(arch);
    while not eof(arch) do
    begin
        i:=i+1;
        readln(arch, cod,aux,nombre,distancia);
        vec[i].cod:=cod;
        vec[i].nombre:=nombre;
        vec[i].distancia:=distancia;
    end;
    close(arch);
end;

procedure LecturaI(var vec:TVInsc);
var
    arch:text;
    dni:ST8;
    aux:char;
    cod:ST2;
    edad,i:byte;
begin
    assign(arch,'INSCRIPTOS.TXT');
    reset(arch);
    i:=0;
    while not eof(arch) do
    begin
        i:=i+1;
        readln(arch, dni,edad,aux,cod);
        vec[i].dni:=dni;
        vec[i].edad:=edad;
        vec[i].cod:=cod;
    end;
    close(arch);
end;
procedure InicializarMatr(var matr:TM);
var 
    i,j:byte;
begin
    for i:=1 to N do
        for j:=1 to 9 do
            matr[i,j]:=0;
end;
function Busqueda(vecProv:TV;cod:ST2):integer;
var
    i:byte;
begin
    i:=0;
    while (i<N) and (vecProv[i].cod <> cod) do
        i:=i+1;
    Busqueda:=i;    
end;
procedure ArmarMatriz(var matr:TM;vecIns:TVInsc;vecProv:TV);
var
    i,pos,col:byte;
begin
    InicializarMatr(matr);
    for i:=1 to MaxIns do
    begin
        pos:=Busqueda(vecProv,vecIns[i].cod);
        col:= vecIns[i].edad div 10;
        matr[pos,col]:= matr[pos,col] +1; 
    end;    
end;
function BusquedaRec(vecProv:TV;x:ST2;i:byte):byte;
begin
    if i=0 then
        BusquedaRec:=0
    else
        if x = vecProv[i].cod then
            BusquedaRec:=i
        else
            BusquedaRec:= BusquedaRec(vecProv,x,i-1);
end;
procedure CantSinInsc(matr:TM;vecProv:TV);
var
    cont,pos,j:byte;
    x:ST2;
begin
    writeln('Ingrese un codigo de provincia');
    readln(x);
    cont:=0;
    pos:= BusquedaRec(vecProv,x,N);
    if pos = 0 then
        writeln('La provincia ingresada no esta disponible')    
    else
        begin
            for j:=1 to 9 do
                if matr[pos,j] =0 then
                    cont:= cont+1;
            writeln('La cantidad de rangos etareos sin inscriptos es: ', cont);
        end;
end;

procedure ProvConMenosInscriptos(matr:TM;vecProv:TV);
var
    contMenos,R,T,i,j,cont:byte;
    provMenos:ST2;
    
begin
    writeln('Ingrese una edad minima para el rango inferior');
    readln(R);
    repeat
        writeln('Ingrese una edad maxima para el rango superior');
        readln(T);
    until (R<=T);
    R:= R div 10;
    T := T div 10;
    
    for i := 1 to N do
    begin
        cont:=0;
        for j := R to T do
            cont:=cont+matr[i,j];
        if ((i=1) or (cont<contMenos) and (cont <> 0))then
            begin
                contMenos:=cont;
                provMenos:=vecProv[i].cod;
            end;
    end;
    writeln('La provincia con menos cantidad de inscriptos en el rango R,T es: ', provMenos);    
end;

function TotalInscriptos(matr:TM;i,j:byte):word;
begin
    if i = 0 then
        TotalInscriptos:=0
    else
        if j>1 then
            TotalInscriptos:= matr[i,j] + TotalInscriptos(matr,i,j-1)
        else
            TotalInscriptos:= matr[i,j] + TotalInscriptos(matr,i-1,9);
end;
procedure MostrarArreglo(vec:TVRegPR;k:byte);
var
    i:byte;
begin
    write('[');
    for i:=1 to k do
    begin
        if i<>k then
            write('(',vec[i].cod,', ',vec[i].rango,'), ')
        else
            writeln('(',vec[i].cod,', ',vec[i].rango,')]');
    end;
end;
procedure SuperanTotalInscr(var vec:TVRegPR;vecProv:TV; matr:TM);
var
    total:word;
    i,j,k:byte;
begin
    total:=TotalInscriptos(matr,N,9);
    k:=0;
    for i:=1 to N do
    begin
        for j := 1 to 9 do
        begin
            if matr[i,j]>total*0.1 then
            begin
                k:=k+1;
                vec[k].cod:=vecProv[i].cod;
                vec[k].rango:=j*10;
            end;       
        end;
    end;
    MostrarArreglo(vec,k);
end;
var
    matr:TM;
    vecIns:TVInsc;
    vecProv:TV;
    vecReg:TVRegPR;
begin
    LecturaP(vecProv);
    LecturaI(vecIns);
    ArmarMatriz(matr,vecIns,vecProv);
    CantSinInsc(matr,vecProv);
    ProvConMenosInscriptos(matr,vecProv);
    SuperanTotalInscr(vecReg,vecProv,matr);
end.