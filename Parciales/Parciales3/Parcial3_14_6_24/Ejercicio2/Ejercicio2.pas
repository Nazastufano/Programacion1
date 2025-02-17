Program Ejercicio2;
    (*Este programa pretende leer una matriz de nxn enteros y generar un vector con el número de
las columnas que verifiquen tener al menos dos 0 y el valor de la diagonal par

Program parcial3;
Type
    TMAT = array[1..20,1..20] of integer;
    TVEC = array[1..30] of real; //no es necesario 30 posiciones ya que la maxima de columnas es 20 y va a almacenar bytes, no reales
var
    Mat:TMAT;
    V:TVEC;
    i,j,n,m,k:byte; //m no es necesario
    Cont:integer; //puede ser byte
    Cumple:boolean; //se puede ahorrar
begin
    Writeln('Ingrese n y m'); //la matriz es n*n
    Readln(n,m); //pedir solo N
    For i:=1 to n do
        For j:=1 to M do // no es M es N
            readln(Mat[i,j]);
    For j:=1 to m do //es n
        begin
            Cont:=0; k:=0;// va afuera
            For i:=1 to m do // es n
                if Mat[i,j] = 0 then
                    Cont:=Cont+1;
            if Cont > 2 then // es >= 2
                Cumple:=true;
            if (Cumple = true) and (Mat[j,j] div 2 = 0) then //correccion -> (cumple) and (Mat[j,j] mod 2 = 0)
            begin
                V[k] := j; // segundo
                k:=k+1;    // ^ al reves, primero
            end;
        end;
    for i:=1 to k do
        Writeln(V[k]); // es i
end.

Se pide:
    a) Marcar y explicar en esta hoja los errores semánticos detectados
    b) Reescribirlo corrigiendo los errores señalados en a), modularizando y haciendo los
       cambios necesarios para mejorar su eficiencia.
*)
Type
    TMAT = array[1..20,1..20] of integer;
    TVEC = array[1..20] of byte;
procedure armarMatriz(var Mat:TMAT;n:byte;);
begin
    For i:=1 To n Do
        For j:=1 To n Do
            readln(Mat[i,j]);
end;
procedure CargarPosicionVector(var V:TVEC;var k:byte);
var
    i,j, cont:byte;
begin
    For j:=1 To n Do
    begin
        Cont:=0; 

        For i:=1 to m do
            if Mat[i,j] = 0 then
                Cont:=Cont+1;
        
        if (Cont >= 2) and (Mat[j,j] mod 2 = 0) then
        begin
            k:=k+1;
            V[k] := j;
        end;  
    end;
end;
procedure MostrarVector(V:TVEC;k:byte);
var
    i:byte;
begin
    for i:=1 to k do
        writeln(V[i]);
end;
var
    Mat:TMAT;
    V:TVEC;
    n,k:byte;
begin
    k := 0;
    repeat
        Writeln('Ingrese n'); 
        Readln(n);
    until n in [1..20];
    
    armarMatriz(Mat,n);
    CargarPosicionVector(V,k);
    MostrarVector(V,k);
end.