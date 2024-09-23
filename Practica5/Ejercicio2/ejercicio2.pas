program Ejercicio2;

(*Ej 2) Dado un archivo de enteros, se pide almacenar en un vector V sólo los elementos impares y en otro
vector W, los pares, ignorando si hubiese, los ceros.*)
const
    N = 10;
type
    TVec = array[1..N] of Integer;

procedure MostrarArreglo(vec:TVec);
var
    i: byte;
begin
    i:=1;
    while vec[i] <> 0 do
    begin
        WriteLn('El elemento de la posicion ', i, ' es: ',vec[i]);
        i := i+1;
    end;
end;

Procedure RellenarArreglo(vec:TVec; pos:byte);
var
    i:byte;
begin
    for i:= pos-1 to N do
    begin
        vec[i]:= 0;
    end;
end;

var
    arch:text;
    V,W: TVec;
    num:Integer;
    posV,posW: byte;
begin
    Assign(arch, 'datos.TXT');
    Reset(arch);
    
    posV:=1;
    posW:=1;
    while not eof (arch) do
    begin
        Read(arch, num);

        if num<>0 then
        begin
            if (num mod 2) <> 0 then
                begin
                    V[posV]:= num; 
                    posV := posV + 1;
                end
            else
                begin
                    W[posw]:= num; 
                    posW := posW + 1;
                end;
        end;
    end;
    Close(arch);
    RellenarArreglo(V,posV);
    RellenarArreglo(W,posW);

    MostrarArreglo(V);
    WriteLn();
    MostrarArreglo(W);
end.