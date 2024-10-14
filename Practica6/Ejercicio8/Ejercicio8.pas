Program Ejercicio8;

(*Ej 8) Sea un conjunto A de enteros y una relación R, se pide
a) Generar la matriz booleana MatR que representa una relación R.
b) Determinar si R es:
     Reflexiva
     Simétrica

Ejemplo :
A = {1,2,3,9,18}
R = relación de Divisibilidad
                { 1 si aiRaj
 MatR[ i , j ] ={
                { 0 en otro caso
Respuesta: R es Reflexiva – R no es Simétrica 

      A 1 2 3 9 18
                    A
        1 1 1 1 1   1
        0 1 0 0 1   2
 MatR = 0 0 1 1 1   3
        0 0 0 1 1   9
        0 0 0 0 1   18

*)
const
    M=5;
    N=5;
type
    TM = array[1..N,1..M] of byte;
    TV = array[1..N] of byte;
const
    vec:TV = (1,2,3,9,18);


procedure Relacion(var matr:TM; vec:TV);
var
    i,j:byte;
begin
    for i:=1 to N do
    begin
        for j:=1 to M do
        begin
            if (vec[j] mod vec[i])=0 then         
                matr[i,j]:=1
            else
                matr[i,j]:=0;
        end;
    end;
end;

function Reflexiva(matr:TM):Boolean;
var
    i,j:byte;
begin
    i:=1;
    j:=1;
    while (matr[i,j]=1) and (j<M) and (i<N) do
    begin
        i:=i+1;
        j:=j+1;
    end;
    if (j <> M) or (i<>N) then
        Reflexiva:=false
    else
        Reflexiva:=true;
end;

function Simetrica(matr:TM):Boolean;
var
    i,j:byte;
    res:Boolean;
begin
    res:=true;
    for i:=1 to N do
    begin
        for j:=1 to M do
        begin
            if matr[i,j]<>matr[j,i] then
                res:=false;
        end;
    end;
    Simetrica:=res;
end;

procedure MostrarMatriz(matr:TM);
var
    i,j:byte;
begin
    for i:=1 to N do
    begin
        for j:=1 to M do
        begin
            Write(matr[i,j],' ');
        end;
        WriteLn('');
    end;
end;

var
    matr:TM;

begin
    Relacion(matr,vec);
    MostrarMatriz(matr);
    if Reflexiva(matr) then
        WriteLn('La matriz relacion es reflexiva')
    else
        WriteLn('La matriz relacion no es reflexiva');
    if Simetrica(matr) then
        WriteLn('La matriz relacion es simetrica')
    else
        WriteLn('La matriz relacion no es simetrica');
end.