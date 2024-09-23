program Ejercicio1;

(*Ej 1) Dado un arreglo A de N elementos reales, desarrollar subprogramas para:
a) Calcular la suma de sus elementos.
b) Mostrar los elementos que se encuentran en posiciones pares.
c) Calcular el máximo y el mínimo elemento.
d) Generar un arreglo B con los elementos de A permutado ( B[1]=A[N], B[2]=A[N-1] … B[N]=A[1] ).
Escribir el programa principal con las invocaciones a cada uno de los subprogramas, mostrando los
resultados correspondientes.
*)
const   
    N = 5;
type
    TVec = array[1..N] of real;

procedure CargarVec(var vecA:TVec);
var
    i:byte;
    val:real;
begin
    for i:= 1 to N do
    begin
        WriteLn('Ingrese el valor real de la posicion: ', i);
        ReadLn(val);
        vecA[i]:= val;
    end;
end;

function SumaVec(vec:TVec):real;
var
    suma: real;
    i: byte;
begin
    suma:= 0;
    for i:= 1 to N do
    begin
        suma:= suma + vec[i];
    end;
    SumaVec:= suma;
end;

procedure MostrarPares(vec:TVec);
var
    i:Byte;
begin
    for i:= 1 to N do
    begin
        if i mod 2 = 0 then
            WriteLn('El valor de la posicion ',i, ' es: ', vec[i]:0:2);
    end;
end;

function MostrarMax(vec:TVec):real;
var
    i:byte;
    max:real;
begin
    for i:=1 to n do
    begin
        if (vec[i]>max) or (i=1) then
            max:= vec[i];
    end;
    MostrarMax:= max;
end;

Function MostrarMin(vec:TVec):real;
var
    i:byte;
    min:real;
Begin
    for i:=1 to n do
    begin
        if (vec[i]<min) or (i=1) then
            min:= vec[i];
    end;
    MostrarMin:= min;
End;

procedure InvertirArreglo(var vecB:TVec; vec:TVec);
var
    i:byte;
begin

    for i:=N downto 1 do
    begin
        vecB[N-i+1]:=vec[i];
    end;
    
end;

var
    i: byte;
    vecB, vecA:TVec;

begin
    CargarVec(vecA);
    WriteLn('La suma de los elementos del vector es: ', SumaVec(vecA):0:2);
    MostrarPares(vecA);
    WriteLn('El valor mas grande de los elementos es: ', MostrarMax(vecA):0:2);
    WriteLn('El valor mas chico de los elementos es: ', MostrarMin(vecA):0:2);
    
    InvertirArreglo(vecB,vecA);
    for i:= 1 to N do
    begin
        WriteLn('El vector invertido en la posicion ', i, ' tiene el valor: ', vecB[i]:0:2);
    end;
end.