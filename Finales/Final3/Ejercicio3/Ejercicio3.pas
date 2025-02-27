Program Ejercicio3;

(*a) Marcar y justificar los errores para que la siguiente función obtenga la posición del elemento X en el arreglo V
de N elementos enteros

Function PosX(var V:TV; N:byte):byte; 1)
var 
I,X: integer; 2) 7)
begin
Write('Ingrese X'); readln(X); 6)
PosX := 0; 3)
For i := 1 to N-1 do 4) 5)
If V[i] = X then
PosX :=i;
End;

b) Reescriba el subprograma anterior para que sea claro y eficiente.


a) 
1) Las funciones no pueden tener parametros variables
2) No está indentada
3) Le da valor a la funcion antes de ejecutar, si bien esto no está mal, es preferible usar una variable aux
4) No recorre el vector completo
5) Utiliza un for para recorrer el vector a pesar de poder encontrar el valor X, no es necesario seguir recorriendo
6) No se puede utilizar write, ni readln en funciones
7) Si bien no trae consecuencias graves, i está declarado como integer pese a que N es byte. i deberia ser byte
*)

function PosX(V:TV;N:byte;x:integer):byte;
var
    i:byte;
    
begin
    i:=1;
    while (i<=N) and (V[i]<>x) do
        i:=i+1;
    if i<=N then
        PosX:=i
    else
        PosX:=0;
end;
var
    V:TV;
    N,pos:byte;
    x:integer;
begin
    WriteLn('Ingrese el valor de X');
    readln(x);
    pos:=PosX(V,N,x);
    if pos=0 then
        WriteLn('El elemento x no se encuentra en el vector')
    else
        WriteLn('La posicion del vector x es: ', pos);
end.