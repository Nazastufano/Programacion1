Program Ejercicio8;
(*Ej 8) Desarrollar un procedimiento recursivo que devuelva en un arreglo los máximos de cada fila de una
matriz de MxN.*)

const
    N = 3;
    M = 3;
type
    TV = array[1..N] of integer;
    TM = array[1..N,1..M] of integer;

procedure MostrarArreglo(vec:TV); //Genera el arreglo de los maximos
var
    i:integer;
begin
    for i := 1 to N do
    begin
        if i=1 then
            write('(');

        if (i<>N) then
            write(vec[i], ', ')
        else
            write(vec[i], ')');      
    end;
end;

procedure RellenarMatriz(var matr: TM);
var
    val,i,j:integer;
begin
    for i := 1 to N do
    begin
        for j := 1 to M do
        begin
            writeln('Ingrese el valor de la fila ', i, ' columna ', j);
            readln(val);
            matr[i,j] := val;
        end;
    end;
end;

procedure ArregloMaximos(matr:TM;var vec:TV; i,j:byte);
var
    max:integer;
begin
    if i=0 then
        MostrarArreglo(vec)
    else
        begin
            If matr[i,j]>vec[i] Then
                vec[i]:=matr[i,j];
            if j>1 then
                ArregloMaximos(matr,vec,i,j-1)
            else
                ArregloMaximos(matr,vec,i-1,M);
        end;
end;

var
    matr:TM;
    vec:TV;

begin
    RellenarMatriz(matr);
    ArregloMaximos(matr,vec,N,M);
end.