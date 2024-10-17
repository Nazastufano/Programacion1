program Ejercicio6;

(*Ej 6) Sea A un arreglo de reales y un valor X real ingresado 
por teclado, se pide determinar en qué posición se encuentra X,
devolver 0 en caso de no encontrarlo. 
Implementar:
    a) considerando el arreglo desordenado, una búsqueda lineal
    recursiva.
    b) para un arreglo ordenado en forma ascendente, una 
    búsqueda binaria recursiva *)

Const
    N = 4;
    
Type
    TV = array[1..N] of real;

Const
    a: TV = (5.3, 1.2, 12.1, 8.3);
    b: TV = (1.2,5.3,8.3,12.1);

var
    val:real;

function BuscarValor(vec:TV; val:real; indice:byte):byte;
begin
    if indice<>0 then
        if (val = vec[indice]) then
            BuscarValor := indice
        else
            BuscarValor := BuscarValor(vec,val,indice-1)
    else
        BuscarValor:=0;
end;

function BusquedaBinariaRecursiva(vec:TV; inicio:byte; fin:byte; val: real): byte;
var
    medio: byte;
begin
    if inicio > fin then
        BusquedaBinariaRecursiva := 0  // Elemento no encontrado
    else
    begin
        medio := (inicio + fin) div 2;
        if vec[medio] = val then
            BusquedaBinariaRecursiva := medio  // Elemento encontrado en la posición 'medio'
        else 
            if vec[medio] > val then
                BusquedaBinariaRecursiva := BusquedaBinariaRecursiva(vec, inicio, medio - 1, val)  // Buscar en la mitad izquierda
            else
                BusquedaBinariaRecursiva := BusquedaBinariaRecursiva(vec, medio + 1, fin, val);  // Buscar en la mitad derecha
    end;
end;

begin
    writeln('Ingrese un valor a buscar: ');
    readln(val);

    writeln('La posicion de X es: ', BuscarValor(a,val,N));
    writeln('La posicion de X es: ', BusquedaBinariaRecursiva(b,1,N,val));
end.