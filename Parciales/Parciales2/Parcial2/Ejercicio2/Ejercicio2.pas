Program Ejercicio2;

(*Ej2)Dada una matriz de números naturales Mat de N filas y M columnas, y un vector de números naturales Vec de
N elementos, informar cuantas filas de Mat cumplen que todos sus elementos son múltiplo del elemento correspondiente en el 
vector Vec. Este ejercicio debe ser resuelto totalmente en forma recrusiva.*)

const
    M = 3;
    N = 3;
type
    TM = array[1..N,1..M] of word;
    TV = array[1..N] of word;
const
    vecConst: TV = (3,3,3);
    matrizConst: TM = ((3, 3, 3), (3, 5, 9), (9, 9, 9));

function Cumple(matr:TM; vec:TV; i:byte; j:byte):byte;
begin
    if i=0 then
        Cumple:=0
    else
        if (matr[i,j] mod vec[i]=0) then
            if (j>1) then
                Cumple:=Cumple(matr,vec,i,j-1)
            else
                Cumple:=Cumple(matr,vec,i-1,M) + 1
        else
            Cumple := Cumple(matr,vec,i-1,M);  
end;    

begin
    writeln('La cantidad de filas que son multiplo del vector son: ', Cumple(matrizConst, vecConst, N, M));
end.