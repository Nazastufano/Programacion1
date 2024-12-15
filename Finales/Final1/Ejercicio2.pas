Program Ejercicio2;

(*Dado un vector A de N elementos, cargado únicamente con letras en mayúsculas. Y otro vector B
cargado con caracteres que forman una palabra en mayúscula. Se pide desarrollar una función o procedimiento,
según corresponda, que en forma recursiva, retorne si la palabra cargada en el vector B se ecuentra del vector A.

Ejemplo
A:                                          B:
J   T   H   O   L   A   A   R   T   Z       H   O   L   A
Respuesta: True
*)
const
    max=20;
type
    TV = array[1..Max] of char;

function BuscarPalabra(A,B:TV;N,M,i,j:byte):Boolean;
begin
    if i<N+1 then
        if j=M then
            BuscarPalabra:=true
        else
            if A[i]=B[j] then
                BuscarPalabra(A,B,N,M,i+1,j+1)
            else
                BuscarPalabra(A,B,N,M,i+1,j)
    else
        BuscarPalabra:=false;
end;
var
    A,B:TV;
    N,M:byte;
Begin
    ArmarVectores(A,B,N,M);
    BuscarPalabra(A,B,N,M,1,1);
End.
