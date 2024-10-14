program Ejercicio9;

(*Ej 9) Sean T1 y T2 dos matrices de NxN que representan las fichas (rojas, azules) de un tablero, la
primera almacena el caracter ‘R’ ó ‘A’ y la segunda enteros (cantidad de fichas). Se pide calcular e
informar:
a) Color predominante (presente en más casillas)
b) Color con más fichas
c) Cantidad de columnas de un solo color
Por ejemplo, si N=4 y T1 y T2 fueran las siguientes
Los resultados deberían ser:

                    
    A R R A             1 7 4 3
T1= R R R A        T2 = 2 2 5 10
    R R A A             2 8 5 20
    R R A R             5 8 10 9     

a) R
b) R
c) 1 *)

const
    N=4;

type
    TMChar = array[1..N,1..N] of char;
    TMWord = array[1..N,1..N] of word;
const
    Tablero:TMChar = (('A','R','R','A'),('R','R','R','A'),('R','R','A','A'),('R','R','A','R'));
    Fichas:TMWord = ((1,7,4,3),(2,2,5,10),(2,8,5,20),(5,8,10,9));

function ColorPredominante(matr:TMChar):boolean;
var
    i,j,contA,contR:byte;
begin   
    contA:=0;
    contR:=0;
    for i:=1 to N do
    begin
        for j:=1 to N do
        begin
            if matr[i,j]='A' then
                contA:=contA +1
            else
                contR:=contR +1;
        end;
    end;
    if contA>=contR then
        ColorPredominante:=true
    else
        ColorPredominante:=false;
end;

procedure MasFichas(matr1:TMChar;matr2:TMWord);
var
    i,j:byte;
    sumaR,sumaA:word;
begin
    sumaR:=0;
    sumaA:=0;
    for i:=1 to N do
    begin
        for j:=1 to N do
        begin
            if matr1[i,j]='A' then
                sumaA:= sumaA + matr2[i,j]
            else
                sumaR:= sumaR + matr2[i,j]
        end;
    end;

    if sumaR=sumaA then
        Writeln('Hay la misma cantidad de fichas')
    else
        if sumaR<sumaA then
            Writeln('Hay mas cantidad de fichas azules')
        else
            Writeln('Hay mas cantidad de fichas rojas');
end;

function CantidadDeColumnasSoloColor(matr:TMChar):byte;
var
    i,j,cont:byte;
    iguales:Boolean;
begin
    cont:=0;
    for j:=1 to N do
    begin
        iguales:=true;
        for i:=1 to N do
        begin
            if matr[i,1] <> matr[i,j] then
                iguales:=false;
        end;
        if iguales then
            cont:=cont+1;
    end;
    CantidadDeColumnasSoloColor:=cont;
end;

begin
    if ColorPredominante(Tablero) then
        WriteLn('El color predominante es el azul')
    else
        WriteLn('El color predominante es el rojo');

    MasFichas(Tablero,Fichas);

    WriteLn('La cantidad de columnas del mismo color son: ',CantidadDeColumnasSoloColor(Tablero));
end.