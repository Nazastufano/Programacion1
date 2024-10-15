program Ejercicio5;
    
(*Ej 5) Ingresar N y M y luego los elementos no nulos de una matriz rala por filas (i, j, valor) y almacenar en
un arreglo de registros.
    a) Mostrar en formato matricial completando los ceros faltantes.
    b) Si es cuadrada, modificarla para obtener la traspuesta. *)
const
    datos = 3;
type
    TReg = record
        i,j,valor:byte;
    end;
    TVReg = array[1..datos] of TReg;
procedure LlenarVec(var vec:TVReg;var n,m:byte);
var 
    i:byte;

begin
    repeat
        WriteLn('Ingrese la cantidad de filas y columnas (separados por un enter. Ambos menores que 10): ');
        ReadLn(N,M);
    until (N<=10) and(M<=10);

    for i:=1 to datos do
    begin
        repeat
            WriteLn('Ingrese la posicion i<=N: ');
            Readln(vec[i].i);
            WriteLn('Ingrese la posicion j<=M: ');
            Readln(vec[i].j);
        until (vec[i].i<=N) and(vec[i].j<=M);

        WriteLn('Ingrese el valor: ');
        Readln(vec[i].valor);
    end;
end;

procedure MostrarMatriz(vec:TVReg;N,M:byte);
var
    i,j,k:byte;
begin
    for i:=1 to N do
    begin
        for j:=1 to M do
        begin
            k:=0;
            while (k<=datos) and ((vec[k].i<>i) or (vec[k].j<>j)) do
                k:=k+1;
        
            if k <> datos+1 then
                Write(vec[k].valor,' ')    
            else
                Write('0 '); 
        end;
        WriteLn();
    end;
end;

//b) Si es cuadrada, modificarla para obtener la traspuesta.
procedure Transpuesta(vec:TVReg;N,M:byte);
var
    i,j,k:byte;
begin
    for j:=1 to M do
    begin
        for i:=1 to N do
        begin
            k:=0;
            while (k<=datos) and ((vec[k].i<>i) or (vec[k].j<>j)) do
                k:=k+1;
        
            if k <> datos+1 then
                Write(vec[k].valor,' ')    
            else
                Write('0 ');  
        end;
        WriteLn();
    end;
end;


var
    datosMatrizRala:TVReg;
    n,m:byte;
begin
    LlenarVec(datosMatrizRala,n,m);
    MostrarMatriz(datosMatrizRala,n,m);

    if N=M then
    begin
        WriteLn('La matriz transpuesta es: ');
        Transpuesta(datosMatrizRala,n,m);
    end;
end.