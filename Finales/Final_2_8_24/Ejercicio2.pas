program Ejercicio2;

(*a) Completar el código para que, dada una matriz A de NxM elementos enteros, el programa genere
     un arrreglo con el número de las filas en las que su último elemento, ya sea parte de la misma fila.
  b) Reescribir el programa considerando la modularización y eficiencia de la nueva solución, generando
     el vector en un único módulo completamente recursivo

Program Totalizador;
type
    TMAT = array [1..20, 1..20]
    TVEC = array [1..20] of ....;
var
    Mat:TMAT;
    V:TVEC;
    i,j,k,n,m:byte;
begin
    write('ingrese N y M: ');
    readln(N,M);
    for i:=1 to N do
        for j:=1 to .... do
            readln(Mat[i,j]);
    k:=....;
    for i:=1 to .... do
    begin
        j:=...;
        while (j....M) and (Mat[i,j]..........) do
            j:=.....;
        if ......... then
        begin
            k:=.....;
            V[k]:=.....;
        end;
    end;
    writeln('El vector generado es: ');
    for ...:=1 to ... do
        write(V[...]);
end.



//a)

Program Totalizador;

Type 
    TMAT =   array [1..20, 1..20] of integer;
    TVEC =   array [1..20] Of byte;

Var 
    Mat:   TMAT;
    V:   TVEC;
    i,j,k,n,m:   byte;
Begin
    write('ingrese N y M: ');
    readln(N,M);
    For i:=1 To N Do
        For j:=1 To M Do
            readln(Mat[i,j]);
    k := 0;
    For i:=1 To N Do
        Begin
            j := 1;
            While (j<M) And (Mat[i,j]<>Mat[i,M]) Do
                j := j+1;
            If j<=M Then
            Begin
                k := k+1;
                V[k] := i;
            End;
        End;
    writeln('El vector generado es: ');
    For i :=1 To k Do
        write(V[i]);
End.


*)

Type 
    TMAT =   array [1..20, 1..20] Of integer;
    TVEC =   array [1..20] Of byte;

procedure ArmarMatriz(var MAT:TMAT; N,M:byte);
var
    i,j:byte;
begin
    For i:=1 To N Do
        For j:=1 To M Do
            readln(Mat[i,j]);
end;

procedure MostrarVector(V:TVEC;k:byte);
var
    i:byte;
begin
    writeln('El vector generado es: ');
    For i :=1 To k Do
        write(V[i],' ');
end;


procedure calcFilas(MAT:TMAT; var V:TVEC; N,M,i,j:byte; var K:byte);
begin
    if i<N+1 then
    begin
        If (MAT[i,j]=MAT[i,M]) and (M<>j) Then
        begin
            k:=k+1;
            V[k]:=i;
        end;
        
        if (j<M) and (MAT[i,j] <> MAT[i,M]) then
            calcFilas(MAT, V, N, M, i, j+1, k)
        else
            calcFilas(MAT, V, N, M, i+1, 1, k);
    end;
end;
var
    MAT:TMAT;
    V:TVEC;
    N,M,K:byte;
begin
    write('ingrese N y M: ');
    readln(N,M);
    ArmarMatriz(MAT,N,M);
    k:=0;
    calcFilas(MAT, V, N, M, 1, 1, K);
    MostrarVector(V,K);
end.