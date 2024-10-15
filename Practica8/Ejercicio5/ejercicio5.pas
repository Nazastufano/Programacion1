program Ejercicio5;

(*Ej 5) Sea V un arreglo de enteros, mediante procesos 
recursivos se pide:
    a) Calcular e informar la suma de sus elementos.
    b) Mostrar sus elementos.
    c) Mostrarlos en orden inverso.
    d) Obtener el máximo de sus elementos.
    e) Obtener el promedio. 
*)

Const
    N = 12;
    
Type
    TV = array[1..N] of integer;

Const
    a: TV = (5,1,12,8,-1,3,10,9,14,0,15,7);

//a) Calcular e informar la suma de sus elementos.
function SumaElementos(vec:TV;largo:byte):integer;
begin
    if largo = 1 then
        SumaElementos:=vec[largo]
    else
        SumaElementos := vec[largo] + SumaElementos(vec,largo-1)
end;

//b) Mostrar sus elementos.
procedure MostrarElementos(vec:TV;largo:byte);
begin
    if largo <> 1 then
        MostrarElementos(vec,largo-1);
    Write(vec[largo],' ');
end;

//c) Mostrarlos en orden inverso.
procedure MostrarElementosInv(vec:TV;largo:byte);
begin
    Write(vec[largo],' ');
    if largo <> 1 then
        MostrarElementosInv(vec,largo-1);
end;

//d) Obtener el máximo de sus elementos.
procedure Maximo(vec:TV;largo:byte;var max:integer);
begin
    if largo > 0 then
        begin
            Maximo(vec,largo-1,max);
            if max<vec[largo] then
                max:=vec[largo];
        end
    else
        max:= 0;
end;

//e) Obtener el promedio.
function Promedio(vec:TV;largo:byte):real;
begin
    if largo=1 then
        Promedio:=vec[largo]/N
    else
        Promedio:= vec[largo]/N + Promedio(vec,largo-1);
end;

var
    max:integer;
begin
    WriteLn('La suma de los elementos es: ', SumaElementos(a,Length(a)));
    MostrarElementos(a,Length(a));
    WriteLn();
    MostrarElementosInv(a,Length(a));
    WriteLn();
    Maximo(a,Length(a),max);
    WriteLn('El maximo es: ', max);
    Writeln('El promedio es de los elementos: ', Promedio(a,Length(a)):0:2);
end.