program Ejercicio2;


(*Dada una matriz de NxN enteros positivos, calcular la cantidad de columnas que tienen algún elemento
mayor al promedio de todas las celdas del triángulo superior de la matriz.
Resolver completamente de forma recursiva, utilizando uno o más subprogramas. No s epermite el uso de ciclos.
Escribir los tipos, variables e invocaciones correspondientes a la inicialización, carga y uso de la matriz
para obtener y mostrar los resultados pedidos. No implemetnar la carga de la matriz*)


const
    N=3;

type
    TM = array[1..N,1..N] of integer;

function promElemColMayProm(Mat:TM;i,j:byte;suma:real):real;
begin   
    if j=1 then
        promElemColMayProm:= suma/(N*(N-1)/2)
    else
        begin
            suma:=suma+mat[i,j];
            if i>1 then
                promElemColMayProm:= promElemColMayProm(mat,i-1,j,suma)
            else
                promElemColMayProm:= promElemColMayProm(mat,j-2,j-1,suma);
        end;
end;

function cantSuperanProm(mat:TM; i, j, cont:byte; prom:real; max:integer):byte;
begin
    if j=0 then
        cantSuperanProm:=cont
    else
        begin
            if max<mat[i,j] then
                max:=mat[i,j];
            if i>1 then
                cantSuperanProm := cantSuperanProm(mat,i-1,j,cont,prom,max)
            else
                begin
                    if max>prom then
                        cont:=cont+1;
                    cantSuperanProm := cantSuperanProm(mat,N,j-1,cont,prom,0);    
                end;
        end;
end;

procedure RellenarMatriz(var mat: TM);
var
    val,i,j:integer;
begin
    for i := 1 to N do
    begin
        for j := 1 to N do
        begin
            writeln('Ingrese el valor de la fila ', i, ' columna ', j);
            readln(val);
            Mat[i,j] := val;
        end;
    end;
end;

var
    mat:TM;
begin
    RellenarMatriz(mat);
    WriteLn('Prom:', promElemColMayProm(mat,N-1,N,0):0:2);
    Write('res:', cantSuperanProm(mat,N,N,0,promElemColMayProm(mat,N-1,N,0),0));
end.