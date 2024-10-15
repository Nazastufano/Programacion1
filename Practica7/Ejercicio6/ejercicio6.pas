Program Ejercicio6;

(*Ej 6) Idem ejercicio 5, leer dos matrices y calcular la matriz resultante de la suma de ambas.*)
const   
    datos = 3;
type
    TReg = record
        i,j,valor:byte;
    end;
    TVReg = array[1..datos] of TReg;

procedure tamanioMatriz(var n,m:byte);
begin
    repeat
        WriteLn('Ingrese la cantidad de filas y columnas (separados por un enter. Ambos menores que 10): ');
        ReadLn(N,M);
    until (N<=10) and(M<=10);
end;

procedure LlenarVec(var vec:TVReg;n,m:byte);
var 
    i:byte;

begin
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

procedure MostrarMatriz(vecAux:array of TReg;N,M,pos:byte);
var
    i,j,k:byte;
begin
    for i:=1 to N do
    begin
        for j:=1 to M do
        begin
            k:=0;
            while (k<=pos) and ((vecAux[k].i<>i) or (vecAux[k].j<>j)) do
                k:=k+1;
        
            if k <> pos+1 then
                Write(vecAux[k].valor,' ')    
            else
                Write('0 ');  
        end;
        WriteLn();
    end;
end;

procedure SumarMatrices(vec,vec2:TVReg;n,m:byte);
var
    i,j,k,pos:byte;
    vecAux: array[1..6] of TReg;
begin
    for i:=1 to datos do
        vecAux[i]:=vec[i];

    pos:=datos;
    for j := 1 to datos do
    begin
        k:=0;
        while (k<=datos) and ((vecAux[k].i<>vec2[j].i) or (vecAux[k].j<>vec2[j].j)) do
            k:=k+1;
        
        if k = datos + 1 then
            begin
                pos:=pos+1;
                vecAux[pos] := vec2[j];
            end
        else
            vecAux[k].valor := vecAux[k].valor + vec2[j].valor;
    end;

    MostrarMatriz(vecAux,n,m,pos);
end;

var
    datosMatrizRala,datosMatrizRala2:TVReg;
    n,m:byte;
begin
    tamanioMatriz(n,m);
    LlenarVec(datosMatrizRala,n,m);
    LlenarVec(datosMatrizRala2,n,m);
    SumarMatrices(datosMatrizRala,datosMatrizRala2,n,m);
end.