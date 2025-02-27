Program Ejercicio4;

(*Desarrolle un único subprograma eficiente que verifique si el elemento X se encuentra en la
matriz de caractes A.
Incluir la declaración de variables del programa, y en el programa principal lo necesario para la invocación
del subprograma (asumir que la matriz ya fue cargada).*)
const
    MAX = 20;
type
    TM = array[1..MAX,1..MAX] of char;

function BuscarElemento(A:TM;N,M:byte;X:char):Boolean;
var
    i,j:byte;
begin
    i:=1;
    j:=1;
    while (i<=N) and (A[i,j]<>X) do
    begin
        j:=1;
        
        while (j<=M) and (A[i,j]<>X) do
            j:=j+1;
        
        if A[i,j]<>X then
            i:=i+1
    end;

    if i<=N then
        BuscarElemento:=true
    else
        BuscarElemento:=false;
end;
var
    A:TM;
    N,M:byte;
    X:charM
begin
    CargarMatriz(A,N,M);
    
    WriteLn('Ingrese un caracter para buscar en la matriz A: ');
    readln(x);

    if BuscarElemento(A,N,M,x) then
        WriteLn('El elemento se encuentra en la matriz')
    else
        WriteLn('El elemento no se ecuentra en la matriz');
end.