program Ejercicio4;

(*Ej 4) Se tiene en un archivo los elementos de una matriz “rala” (se dice que una matriz es rala cuando la
mayoría de sus elementos son cero). En cada línea del archivo viene:
     fila, columna, dato (distinto de cero)
Se pide:
    a) Armar la matriz original y mostrarla en forma matricial.
    (Obtener N y M, sabiendo que hay al menos un valor no nulo en la última fila de alguna columna y
    en la última columna de alguna fila ).
    b) Si es cuadrada (N=M) determinar si es triangular inferior. *)

const
    N=10;
    M=10;

type
    TM =  array[1..N,1..M] of byte;

procedure InicializarMatriz(var matr:TM);
var
    i,j:byte;
begin
    for i:=1 to N do
    begin
        for j:=1 to M do
        begin
            matr[i,j]:=0;
        end;
    end;
end;

procedure MostrarMatriz(matr:TM; cantFilas, cantColumnas:byte);
var
    i,j:byte;
begin
    for i:=1 to cantFilas do
    begin
        for j:=1 to cantColumnas do
        begin
            Write(matr[i,j], ' ');
        end;
        WriteLn();
    end;
end;

function TriangularInferior(matr:TM; filas: byte):Boolean;
Var 
    i,j:byte;
    EsTrianinf:Boolean;
Begin
    EsTrianinf:=true;
    For i := 2 To filas Do
        For j := 1 To i - 1 Do
            If matr[i, j] <> 0 Then
                EsTrianinf:=false;
    TriangularInferior:=EsTrianinf;
End;


var
    arch:text;
    matr:TM;
    fila,columna,cantFilas,cantColumnas,dato:byte;

begin
    Assign(arch,'datos.TXT');
    Reset(arch);
    InicializarMatriz(matr);
    cantFilas:=0;
    cantColumnas:=0;
    while not eof(arch) do
    begin
        ReadLn(arch,fila,columna,dato);
        matr[fila,columna]:=dato;

        if cantFilas<fila then
            cantFilas:=fila;
        
        if cantColumnas<columna then
            cantColumnas:=columna;
    end;
    close(arch);
    MostrarMatriz(matr,cantFilas,cantColumnas);
    
    if (cantFilas=cantColumnas) and (TriangularInferior(matr,cantFilas)) then
        WriteLn('La mariz es triangular inferior');
end.