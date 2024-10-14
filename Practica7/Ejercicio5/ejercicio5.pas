program Ejercicio5;
    
(*Ej 5) Ingresar N y M y luego los elementos no nulos de una matriz rala por filas (i, j, valor) y almacenar en
un arreglo de registros.
    a) Mostrar en formato matricial completando los ceros faltantes.
    b) Si es cuadrada, modificarla para obtener la traspuesta. *)
type
    TReg = record
        i,j,valor:byte;
    end;
    TVReg = array[1..5] of TReg;
procedure LlenarVec(var vec:TVReg;var n,m:byte);
var 
    i:byte;

begin
    repeat
        WriteLn('Ingrese la cantidad de filas y columnas (separados por un enter. Ambos menores que 10): ');
        ReadLn(N,M);
    until (N<=10) and(M<=10);

    for i:=1 to 5 do
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
    pos,res,i,j,k:byte;
begin
    for i:=1 to N do
    begin
        for j:=1 to M do
        begin
            res:=0;
            for k:=1 to 5 do
            begin
                if (vec[k].i=i) and (vec[k].j=j) then
                    begin
                        res := 1;
                        pos := k;
                    end;        
            end;
            if res=1 then
                Write(vec[pos].valor,' ')    
            else
                Write('0 ');  
        end;
        WriteLn();
    end;
end;

//b) Si es cuadrada, modificarla para obtener la traspuesta.
procedure Transpuesta(vec:TVReg;N,M:byte);
var
    pos,res,i,j,k:byte;
begin
    for j:=1 to M do
    begin
        for i:=1 to N do
        begin
            res:=0;
            for k:=1 to 5 do
            begin
                if (vec[k].i=i) and (vec[k].j=j) then
                     begin
                        res := 1;
                        pos := k;
                    end;        
            end;
            if res=1 then
                Write(vec[pos].valor,' ')    
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