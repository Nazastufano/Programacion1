program Ejercicio10;

(*Ej 10) Dado el siguiente procedimiento:

Procedure Maximo (Mat:TM; N:Byte; Func:TFunc; var maxk:Byte);
Var
    max, prom: real;
    k: byte;
Begin
    max:= Func(Mat, 1, N);
    maxk:= 1;
    For k:= 2 to N do
    Begin
        prom := Func(Mat, k, N);
        if max < prom then
        begin
            max := prom;
            maxk := k;
        end;
    end;
End;

a) Desarrollar las funciones de tipo TFunc y un programa completo (incluir declaraciones, directivas al
compilador, etc) que utilizándolas calcule para una matriz cuadrada:
    i. la fila de máximo promedio
    ii. la columna de máximo promedio
b) Indicar las modificaciones que serían necesarias para utilizar un tipo procedimiento, en lugar de
TFunc, muestre los cambios para el punto i. del inciso a)*)
const
    N=4;
type
    TM = array[1..N,1..N] of word;
    TFunc = function(mat:TM;k,n:byte):real;
    TProc = procedure(mat:TM;k,n:byte;var prom:real);
    
const
    Mat:TM = ((1,7,4,3),(2,2,5,10),(2,8,5,20),(5,8,10,9));

function MaxPromF (mat:TM;k,n:byte):real;
var
    j:byte;
    suma:word;
begin
    suma:=0;
    for j:=1 to N do
    begin
        suma:= suma + mat[k,j];
    end;
    MaxPromF:=suma/N;
end;

function MaxPromC (mat:TM;k,n:byte):real;
var
    i:byte;
    suma:word;
begin
    suma:=0;
    for i:=1 to N do
    begin
        suma:= suma + mat[i,k];
    end;
    MaxPromC:=suma/N;
end;

Procedure Maximo (Mat:TM; N:Byte; Func:TFunc; var maxk:Byte);
Var
    max, prom: real;
    k: byte;
Begin
    max:= Func(Mat, 1, N);
    maxk:= 1;
    For k:= 2 to N do
    Begin
        prom := Func(Mat, k, N);
        if max < prom then
        begin
            max := prom;
            maxk := k;
        end;
    end;
End;
//B)
//Las modificaciones necesarias serian, crear el siguiente procedimiento:
Procedure MaxPromFProc(mat:TM;k,n:byte;Var prom:real);
var
    j:byte;
    suma:word;
begin
    suma:=0;
    for j:=1 to N do
    begin
        suma:= suma + mat[k,j];
    end;
    prom:= suma/N;
end;
//Luego en el procedimiento maximo, habria que dejarla de la siguiente manera:

Procedure Maximo2 (Mat:TM; N:Byte; Proc:TProc; var maxk:Byte);
Var
    max, prom: real;
    k: byte;
Begin
    Proc(Mat, 1, N,max);
    maxk:= 1;
    For k:= 2 to N do
    Begin
        Proc(Mat, k, N, prom);
        if max < prom then
        begin
            max := prom;
            maxk := k;
        end;
    end;
End;

var
    funcion1,funcion2:TFunc;
    procedimiento:TProc;
    maxk:byte;
begin
    maxk:=0;
    funcion1:= @MaxPromF;
    funcion2:= @MaxPromC;

    Maximo(mat,N,funcion1,maxk);
    WriteLn('La fila con promedio maximo es: ',maxk);
    Maximo(mat,N,funcion2,maxk);
    WriteLn('La columna con promedio maximo es: ',maxk);

    procedimiento:= @MaxPromFProc;
    Maximo2(mat,N,procedimiento,maxk);
    WriteLn('La fila con promedio maximo es: ',maxk);

end.