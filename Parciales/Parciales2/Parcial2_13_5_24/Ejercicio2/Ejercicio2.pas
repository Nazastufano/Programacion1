Program Ejercicio2;
(*Dada una matriz Mat de NxM enteros, generar un vector V con la posición del minimo de cada fila, considerando solo
aquellas filas en las que la suma de sus elementos sea positiva
Nota:
Resolver de forma recursiva, utilizando uno o más subprogramas. No cargar la matriz, escribir los tipos, variables
e invocaciones correspondientes*)

const
    N=3;
    M=3;
type
    TReg = record
        i:byte;
        j:byte;
    end;
    TV = array[1..N] of TReg;
    TM = array[1..N,1..M] of integer;

procedure RellenarMatriz(var mat: TM);
var
    val,i,j:integer;
begin
    for i := 1 to N do
    begin
        for j := 1 to M do
        begin
            writeln('Ingrese el valor de la fila ', i, ' columna ', j);
            readln(val);
            Mat[i,j] := val;
        end;
    end;
end;

procedure MostrarArreglo(vec:TV); //Genera el arreglo de los maximos
var
    i:integer;
begin
    write('(');
    for i := 1 to N do
    begin
        if (i<>N) then
            write('(',vec[i].i, ', ',vec[i].j,'), ')
        else
            write('(',vec[i].i, ', ',vec[i].j,')', ')');      
    end;
end;

procedure posMinimos(var V:TV; Mat:TM; i,j,k:byte;posMin:TReg;min,suma:integer);
begin
    if i=0 then
        MostrarArreglo(V)
    else
        begin
            suma:=suma+mat[i,j];
            if (min>mat[i,j]) or (j=M) then
                begin
                    min:=mat[i,j];
                    posMin.i:=i;
                    posMin.j:=j;  
                end;
            
            if (j=1) and (suma>0) then
                begin
                    k:=k+1;
                    V[k]:=posMin; 
                end;
            
            if j<1 then
                posMinimos(v,mat,i-1,M,k,posMin,min,0)  
            else
                posMinimos(v,mat,i,j-1,k,posMin,min,suma);  
        end;
end;
var
    Mat:TM;
    V:TV;
    pos:TReg;
begin
    RellenarMatriz(mat);
    pos.i:=N;
    pos.J:=M;
    posMinimos(V,mat,N,M,0,pos,0,0);
end.