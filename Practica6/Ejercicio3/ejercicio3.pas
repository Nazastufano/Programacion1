program Ejercicio3;

(*Ej 3) En un archivo se almacenaron Y números enteros en cada línea. Cada línea se cargará en una fila
de la matriz si cumple que el primero es divisor del último (el Y-ésimo). Mostrar la matriz generada. La
dimensión será N x Y (N se debe calcular) *)
const
    N=10;
    M=4;
type
    TV = array[1..N] of integer;
    TM = array[1..N,1..M] of integer;

procedure MostrarMatriz(matr:TM;filas:byte);
var
    i,j:byte;
begin
    for i:=1 to filas do
    begin
        for j:=1 to M do
        begin
            Write(matr[i,j],' ');
        end;
        WriteLn();
    end;
end;

var
    arch:text;
    num,numPri:integer;
    filas,i:byte;
    matr:TM;
    vec:TV;
begin
    Assign(arch,'datos.TXT');
    Reset(arch);
    filas := 0;
    while Not eof(arch) do
    begin
        for i:=1 to M do
        begin
            Read(arch,num);  
            if i=1 then
                begin
                    numPri:=num;
                    vec[i] := num;
                end
            else
                vec[i] := num;
        end;
        ReadLn(arch);
        If (num Mod numpri) = 0 Then
            begin
                filas:= filas +1;
                for i:=1 to M do
                    matr[filas,i]:=vec[i];
            end;
    end;
    close(arch);
    MostrarMatriz(matr,filas);
end.