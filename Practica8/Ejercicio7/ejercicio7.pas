Program Ejercicio7;

(*Ej 7) Crear una función recursiva que busque el elemento mínimo de una matriz cuadrada.*)
const
    N = 2;
    M = 2;

Type 
    TM = array[1..N,1..M] Of integer;

Procedure RellenarMatriz(Var matr: TM);
Var 
    val:   integer;
    i,j:byte
Begin
    For i := 1 To N Do
    Begin
        For j := 1 To M Do
        Begin
            writeln('Ingrese el valor de la fila ', i, ' columna ', j);
            readln(val);
            matr[i,j] := val;
        End;
    End;
End;

function BuscarMin(matr:TM;i,j:byte;min:Integer):integer;
begin
    if i=0 then
        BuscarMin:=min
    else
        begin
            if (matr[i,j]<min) or ((i=N) and (j=M)) then
                min:=matr[i,j];
            if j>1 then
                BuscarMin := BuscarMin(matr,i,j-1,min)
            else
                BuscarMin := BuscarMin(matr,i-1,M,min);  
        end;
end;

Var 
    matr:   TM;

begin
    RellenarMatriz(matr);
    WriteLn('El minimo es: ', BuscarMin(matr,N,M,0));
end.