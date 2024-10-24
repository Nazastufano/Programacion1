program Ejercicio1;

(*Una competencia de lanzamiento de jabalina se registra en un archivo de texto que contiene duplas con: el código
del competidor (cadena de 3 caracteres) y la distancia de su lanzamiento (real). No se conoce la cantidad de
competidores, se sabe que son 20 o menos. Dicho archivo no se encuentra ordenado por ningún criterio, y la
cantidad de lanzamientos por competidor es variable (a lo sumo 10).
Utilizar las estructuras adecuadas (registros, vectores y/o matrices) para gestionar los datos del archivo y obtener la
siguiente información:
    a) Promedio de distancia del competidor con mayor cantidad de lanzamientos realizados (suponer único).
    b) Menor marca obtenida en el primer lanzamiento.
    c) Generar un arreglo con los competidores que superaron la distancia X (ingresada por teclado) en algún
    lanzamiento. Mostrar el arreglo generado.
Importante:
     El archivo debe recorrerse una sola vez
     Cada proceso debe ser implementado en un subprograma (según corresponda función o procedimiento)
Condición para aprobar: al menos dos de los siguientes subprogramas (necesarios para resolver el problema
planteado) deben ser resueltos correctamente en forma recursiva.
    - Determinar posición del competidor (°) con mayor cantidad de lanzamientos
    - Obtener la distancia promedio de los lanzamientos de un determinado competidor (°)
    - Determinar posición del competidor con mínima distancia en su primer lanzamiento
    - Mostrar un arreglo que almacena cadenas de 3 caracteres.*)
const
    N=20;
type    
    ST3 = string[3];
    TV = array[1..20] of ST3;
    TVLanz = array[1..10] of byte;
    TM = array[1..20,1..10] of real;
function Busqueda(vecComp:TV;K:byte;cod:ST3):byte;
var
    i:byte;
begin
    i:=1;
    while (i<=K) and (cod<>vecComp[i]) do
        i:=i+1;
    if i=K+1 then
        Busqueda:=0
    else
        Busqueda:= i;
end;

procedure LecturaArch(var vecComp:TV;var matr:TM;var cantLanz:TVLanz;var K:byte);
var
    arch:Text;
    cod:ST3;
    distancia:real;
    indice,cantL:Byte;
begin
    Assign(arch,'datos.TXT');
    Reset(arch);
    K:=0;
    while NOT Eof(arch) do
    begin
        ReadLn(arch,cod,distancia);
        indice:=Busqueda(vecComp,K,cod);
        if indice=0 then
            begin
                k:=k+1;
                vecComp[k]:=cod;
                matr[k,1]:=distancia;
                cantLanz[k]:=1;
            end
        else
            begin
                vecComp[indice]:=cod;
                cantLanz[indice]:=cantLanz[indice]+1;
                cantL:=cantLanz[indice];
                matr[indice,cantL]:=distancia;
            end;
    end;
    Close(arch);
end;
//a) Promedio de distancia del competidor con mayor cantidad de lanzamientos realizados (suponer único).

//- Determinar posición del competidor (°) con mayor cantidad de lanzamientos
function PosicionMasLanzamientos(cantLanz:TVLanz;i,pos,mayCantL:byte):byte;
begin
    if cantLanz[i]>mayCantL then
    begin
        mayCantL:=cantLanz[i];
        pos:=i;
    end;    
    if i=1 then
        PosicionMasLanzamientos:=pos
    else
        PosicionMasLanzamientos:= PosicionMasLanzamientos(cantLanz,i-1,pos,mayCantL);
end;

//- Obtener la distancia promedio de los lanzamientos de un determinado competidor (°)
function DistanciaProm(matr:TM;vecLanz:TVLanz;j,pos:byte):real;
begin
    if j=1 then
        DistanciaProm:= matr[pos,j]/vecLanz[pos]
    else
        DistanciaProm:= matr[pos,j]/vecLanz[pos] + DistanciaProm(matr,vecLanz,j-1,pos);
end;


procedure PromDistanciaMasLanzamientos(matr:TM;vecComp:TV;cantLanz:TVLanz;K:byte);
var
    posMasLanz,masLanz:byte;
    prom:real;
begin
    posMasLanz:=PosicionMasLanzamientos(cantLanz,K,K,masLanz);
    masLanz:=cantLanz[posMasLanz];
    prom := DistanciaProm(matr,cantLanz,masLanz,posMasLanz);
    WriteLn('El promedio del lanzador con mas lanzamientos es: ', prom:0:2);
end;


//b) Menor marca obtenida en el primer lanzamiento.
//- Determinar posición del competidor con mínima distancia en su primer lanzamiento
Function PosMarcaMenosDistancia(matr:TM;i,pos:byte;minLanz:real):   byte;
Begin
    If matr[i,1]<minLanz Then
        Begin
            minLanz := matr[i,1];
            pos := i;
        End;

    If i=1 Then
        PosMarcaMenosDistancia := pos
    Else
        PosMarcaMenosDistancia := PosMarcaMenosDistancia(matr,i-1,pos,minLanz);
End;

procedure MenorMarcaPriLanz(matr:TM;K:byte);
var
    pos:byte;
begin
    pos:=PosMarcaMenosDistancia(matr,K,K,matr[K,1]);
    
    WriteLn('La menor marca obtenida en el primer lanzamiento es: ', matr[pos,1]:0:2);
end;

{c) Generar un arreglo con los competidores que superaron la distancia X (ingresada por teclado) en algún
    lanzamiento. Mostrar el arreglo generado.}
//- Mostrar un arreglo que almacena cadenas de 3 caracteres.
Procedure MostrarArregloRec(vecComp:TV;i,cantSuperan:byte);
Begin
    If i=1 Then
        Write('(',vecComp[i],', ')
    Else
        Begin
            MostrarArregloRec(vecComp,i-1,cantSuperan);
            If i=cantSuperan Then
                WriteLn(vecComp[i],')')
            Else
                Write(vecComp[i],', ');
        End;
End;

procedure SuperanLanzamientoX(matr:TM;vecComp:TV;cantLanz:TVLanz;k:Byte);
var
    i,j,cantSuperan:Byte;
    x:real;
    vec:TV;
    supera:Boolean;
begin
    WriteLn('Ingrese una distancia a superar');
    ReadLn(x);
    cantSuperan:=0;
    i:=1;
    
    while (i<=K) do
    begin
        supera:=false;
        j:=1;
        while (j<=cantLanz[i]) and (supera=false) do
        begin
            if matr[i,j]>x then
            begin
                cantSuperan:=cantSuperan+1;
                vec[cantSuperan]:=vecComp[i];
                supera:=true;
            end;
            j:=j+1;
        end;
        i:=i+1;
    end;
    if cantSuperan<>0 then
        begin
            WriteLn('Los competidores que superan la marca ', x:0:2, ' son: ');
            MostrarArregloRec(vec,cantSuperan,cantSuperan);
        end
    else
        WriteLn('Ningun competidor supera la marca de ', x:0:2);
end;

var
    vecComp:TV;
    matr:TM;
    cantLanz:TVLanz;
    K:byte;

begin
    LecturaArch(vecComp,matr,cantLanz,K);
    PromDistanciaMasLanzamientos(matr,vecComp,cantLanz,K);
    MenorMarcaPriLanz(matr,K);
    SuperanLanzamientoX(matr,vecComp,cantLanz,K);
end.