Program Ejercicio2;

const
    MAX = 20;

type
    TM = array[1..MAX,1..MAX] of Integer;

function AnalisisRecursivo(mat:TM;i,j,N:byte;maximo:integer):integer;
begin
    if i>0 then
    begin
        if (mat[i,j]=mat[j,i]) and (mat[i,j]>maximo) then  
            maximo:=mat[i,j];
        
        if j>1 then
            AnalisisRecursivo:=AnalisisRecursivo(mat,i,j-1,N,maximo)
        else
            AnalisisRecursivo:=AnalisisRecursivo(mat,i-1,i-1,N,maximo);
    end
    else
        AnalisisRecursivo:=maximo;
end;

var
    mat:TM;
    N:byte;

begin
    CargarMatriz(mat,N);
    
    WriteLn('El maximo elemento simetrico igual es: ', AnalisisRecursivo(mat,N,N,N,mat[N,N]));
end.