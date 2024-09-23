program Ejercicio10;

(*Ej 10) Dado un arreglo A, generar dos arreglos paralelos B y C donde B contiene la suma de los
elementos de A que están entre dos negativos y C la cantidad que se sumó. Mostrar B y C.
Ejemplo:
A=(3, 5, -1, 3, 8, 2, -5, 2, 10, -4, -8, 4, 6, 7,-3, 11, 2) -> B=(13, 12, 0, 17) C=(3, 2, 0, 3) *)

const
    N = 17;
    A: array[1..N] of integer = (3, 5, -1, 3, 8, 2, -5, 2, 10, -4, -8, 4, 6, 7,-3, 11, 2);

type
    TVec = array[1..N] of byte;

procedure MostrarArreglo(vec:TVec;indice:byte);
var
    i:byte;
begin
    Write('(');
    for i:=1 to indice do
    begin
        Write(vec[i]);    
        if i<>indice then
            Write(', ');
    end;
    Writeln(')');
end;

var
    contSuma,suma,i,pos:byte;
    B,C:TVec;

begin
    i:=0;
    pos:=0;
    
    repeat
        i := i + 1;
    until (A[i]<0);

    while i<Length(A) do
    begin
        suma:=0;
        contSuma:=0;
        i := i + 1;
        
        while (A[i]>0)do
        begin
            contSuma:= contSuma + 1;
            suma:=suma + A[i];
            i:= i + 1;
        end;

        if (i<Length(A)) and (A[i]<0) then
            begin
                pos := pos+ 1;
                B[pos]:= suma;
                C[pos]:= contSuma;                 
            end;
    end;
    MostrarArreglo(B,pos);
    Writeln();
    MostrarArreglo(C,pos);
end.