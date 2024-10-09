program Ejercicio1;

(*Ej 1) Leer desde un archivo una matriz de NxM elementos enteros, (N y M se encuentran en la primera
línea del archivo y luego en las restantes N líneas vienen los M elementos). Se pide:
a) Generar un arreglo con el máximo de cada fila y mostrarlo.
b) Generar un arreglo con la suma de los impares de cada columna, no generar elemento si la
columna no tiene impares.
c) Dada una columna X, ingresada por el usuario, hallar el promedio de sus elementos.*)

type
    TMat = array[1..10, 1..10] of integer;

procedure MostrarMatriz(matr:TMat;n,m:byte);
var
    i,j:byte;
begin
    for i:= 1 to N do
    begin
        for j:=1 to M do
        begin
            Write(matr[i,j],' ');
        end;
        Writeln();
    end;
end;

procedure MaxPorFila(matr:TMat;n,m:byte);
var
    i,j:byte;
    vecAux: array[1..10] of integer;
    max:integer;
begin
    for i:= 1 to N do
    begin
        max:= matr[i,1];
        for j:=1 to M do
        begin
            if max<matr[i,j] then
                max:=matr[i,j];
        end;
        vecAux[i]:=max;
    end;
    
    WriteLn('Los maximos de cada fila son: ');
    for i:=1 to N do
    begin
        Write(vecAux[i], ' ');
    end;
end;

procedure SumaImpares(matr:TMat;n,m:byte);
var
    i,j,pos:byte;
    vecAux: array[1..10] of integer;
    sumatoriaImpares:integer;
    hayImpar:Boolean;
begin
    for i:= 1 to N do
    begin
        sumatoriaImpares := 0;
        hayImpar:=false;
        for j:=1 to M do
        begin
            if matr[i,j] mod 2 <> 0 then
                begin
                    sumatoriaImpares:=sumatoriaImpares+matr[i,j];
                    hayImpar:=true;  
                end;
        end;
        if hayImpar then
        begin
            pos:=pos+1;
            vecAux[pos] := sumatoriaImpares;
        end;
    end;
    WriteLn('La sumatoria de los impares en cada fila es: ');
    for i:=1 to pos do
    begin
        Write(vecAux[i], ' ');
    end;
    WriteLn();
end;

procedure PromPorColumna(matr:TMat;n,m:byte);
var
    i, columna:byte;
    suma:real;
begin
    suma:=0;
    repeat
        WriteLn('Ingrese una columna de para sacar el promedio: (1..', m,')');
        ReadLn(columna);
    until columna in [1..m];

    for i:= 1 to n do
    begin
        suma:=suma + matr[i,columna];
    end;
    
    WriteLn('El promedio de la columna: ',columna, ' es: ', (suma/n):0:2);
end;

var
    arch:Text;
    num:Integer;
    i,j,n,m,columna:byte;
    matr:TMat;

begin
    Assign(arch,'datos.TXT');
    Reset(arch);
    ReadLn(arch,n,m);
    for i:=1 to N do
    begin
        for j:=1 to M do
        begin
            Read(arch,num);
            matr[i,j]:=num;
        end;    
        ReadLn(arch);
    end;
    MostrarMatriz(matr,n,m);

    MaxPorFila(matr,n,m);
    SumaImpares(matr,n,m);
    PromPorColumna(matr,n,m);
end.