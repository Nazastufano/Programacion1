Program Ejercicio3;

(*Ej 3) Dado un conjunto de puntos en el plano, almacenar en un arreglo sus coordenadas junto con la
distancia al centro de coordenadas y a qué cuadrante pertenece.
Usando el arreglo, se pide:
    Informar el más cercano y más lejano al centro.
    Porcentaje de puntos en cada cuadrante (1..4, centro, eje X, eje Y).
Cada punto en el plano P tiene una coordenada X y otra Y. Desarrollar la función Distancia que dados
dos puntos P y Q devuelva la distancia entre ambos.
*)
const
    N=4;
type
    TReg = record
        x,y:integer;
        cuadrante:byte;
        distancia:real;
    end;
    TVReg = array[1..N] of TReg;

function cuadrante(x,y:Integer):byte;
var
    pos:byte;
begin
    //1 => x=0 ^ y=0, 2 => x=0 ^ y≠0, 3 => x≠0 ^ y=0
    //4 => x>0 ^ y>0, 5 => x<0 ^ y>0, 6 => x<0 ^ y<0, 7 => x>0 ^ y<0
    if (x=0) and (y=0) then
        pos:=1;
    if (x=0) and (y<>0) then
        pos:=2;
    if (x<>0) and (y=0) then
        pos:=3;
    if (x>0) and (y>0) then
        pos:=4;
    If (x<0) And (y>0) Then
        pos:=5;
    If (x<0) And (y<0) Then
        pos:=6;
    If (x>0) And (y<0) Then
        pos:=7;
    
    cuadrante:=pos;
end;
procedure LlenarArreglo(var vec:TVReg);
var
    i:byte;
    x,y:Integer;

begin
    for i:=1 to N do
    begin
        WriteLn('Ingrese la posicion en x: ');
        ReadLn(x);
        WriteLn('Ingrese la posicion en y: ');
        ReadLn(y);
        vec[i].x:=x;
        vec[i].y:=y;
        vec[i].cuadrante:=cuadrante(x,y);
        vec[i].distancia:= sqrt(Sqr(x)+Sqr(y));
    end;
end;
function MasCercano(vec:TVReg):byte;
var
    i,pos:byte;
    masCerca:real;
begin
    masCerca := vec[1].distancia;
    pos:=1;
    for i:=2 to N do
    begin
        if vec[i].distancia<masCerca then
            begin
                masCerca := vec[i].distancia;
                pos:=i;
            end;
    end;
    MasCercano:=pos;
end;

function MasLejano(vec:TVReg):byte;
var
    i,pos:byte;
    masLejos:real;
begin
    masLejos := vec[1].distancia;
    pos:=1;
    for i:=2 to N do
    begin
        if vec[i].distancia>masLejos then
            begin
                masLejos := vec[i].distancia;
                pos:=i;
            end;
    end;
    MasLejano:=pos;
end;

procedure PorcentajePorZona(vec:TVReg);
var
    i:byte;
    casos:array[1..7] of byte;
begin
    for i:=1 to 7 do
        casos[i]:=0;
    
    for i:=1 to N do
        casos[vec[i].cuadrante]:=casos[vec[i].cuadrante] + 1;
    
    for i:=1 to 7 do
    begin
        Write('El porcentaje en ');
        case i of
            1: WriteLn('el centro es: ', (casos[i]*100/n):0:2,'%');
            2: WriteLn('el eje x es: ', (casos[i]*100/n):0:2,'%');
            3: WriteLn('el eje y es: ', (casos[i]*100/n):0:2,'%');
            4..7: WriteLn('el cuadrante: ', i-3, ' es: ', (casos[i]*100/n):0:2,'%');
        end;
    end;
end;

var
    puntos:TVReg;
    pos:byte;
begin
    LlenarArreglo(puntos);
    pos:=MasCercano(puntos);
    WriteLn('El punto que se encuntra mas cerca del centro de coordenadas es: (', puntos[pos].x,', ',puntos[pos].y,')');
    pos:=MasLejano(puntos);
    WriteLn('El punto que se encuntra mas lejos del centro de coordenadas es: (', puntos[pos].x,', ',puntos[pos].y,')');
    PorcentajePorZona(puntos);
end.