Program Ejercicio6;

(*Ej 6) Un cuadrado mágico de orden N (impar), es una matriz cuadrada de NxN que contiene números
naturales de 1 a N^2, tal que la suma de cualquier columna, fila o diagonal coincide. Se construye de la
siguiente manera:
     El número 1 se coloca en la casilla central de la primera fila.
     Cada número siguiente se coloca en la casilla correspondiente a
    la fila anterior y columna posterior.
     Si el número es el que sigue a un múltiplo de N, se coloca en la
    casilla de la fila posterior en la misma columna.
     Se considera fila anterior a la primera, la última.
     Se considera columna posterior a la última, la primera
Se pide:
a) Escribir un procedimiento que, dados una matriz Mat y N, genere el cuadrado mágico.
b) Escribir una función booleana que verifique si la matriz Mat es un cuadrado mágico. 

|17 24 1  8  15|
|23 5  7  14 16|
|4  6  13 20 22|
|10 12 19 21 3 |
|11 18 25 2  9 |

*)
const
    N=5;
type
    TM =  array[1..N,1..N] of word;

procedure InicializarMatriz(var matr:TM);
var
    i,j:byte;
begin
    for i:=1 to N do
        for j:=1 to N do
            matr[i,j]:=0;
end;
procedure CuadradoMagico(var matr:TM);
var
    fila,columna,i,j:byte;
begin
    fila := 1;
    columna :=  (N div 2) +1;
    matr[fila, columna]:=1;
    
    for i:=2 to sqr(N) do
    begin    
        if ((i-1) mod N = 0) then
            fila := fila + 1
        else
            begin
                fila:=fila-1;
                columna := columna + 1;
            end;

        if fila = 0 then
            fila:=N;

        if columna = N+1 then
            columna:=1;
        
        matr[fila,columna]:=i;
    end;
end;
procedure MostrarMatriz(matr:TM);
var
    i,j:byte;
begin
    for i:=1 to N do
    begin
        for j:=1 to N do
        begin
            Write(matr[i,j],' ');
        end;  
        WriteLn('');
    end;
end;

function VerificarCuadradoMagico(matr,matr2:TM):Boolean;
var
    i,j:byte;
    res:Boolean;
begin
    res:=true;
    for i:=1 to N do
        for j:=1 to N do
            if matr[i,j]<>matr2[i,j] then
                res:=false;
    VerificarCuadradoMagico:=res;
end;
var
    matr,matr2:TM;
begin
    InicializarMatriz(matr);
    CuadradoMagico(matr);
    mostrarMatriz(matr);

    if VerificarCuadradoMagico(matr,matr2) then
        WriteLn('La matriz es cuadrado magico')
    else
        WriteLn('La matriz no es un cuadrado magico');
end.