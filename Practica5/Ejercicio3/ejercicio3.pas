program Ejercicio3;

(*Ej 3) Dado un arreglo V y un número K, cambiar todas las ocurrencias de K por 0. *)

const
    N = 5;
type
    TVec = array[1..N] of integer;

procedure CargarArreglo(var vec:TVec);
var
    i: byte;
    val:integer;
begin
    for i:=1 to N do
    begin
        WriteLn('Ingrese el elemento de la posicion: ', i);
        ReadLn(val);
        vec[i]:= val;
    end; 
end;

procedure RemplazarValor(Var vec:TVec; num:Integer);
var
    i: byte;
begin
    for i:= 1 to N do
    begin
        if num = vec[i] then
            vec[i]:= 0;
    end;
end;

procedure MostrarArreglo(vec: TVec);
var
    i: byte;
begin
    WriteLn('Los elementos del arreglo son: ');
    for i:= 1 to N do
    begin
        Write(vec[i],' ');
    end;
    WriteLn();
end;

var
    vec: TVec;
    numero:Integer;

begin
    CargarArreglo(vec);
    MostrarArreglo(vec);

    WriteLn('Ingrese el numero que deseas remplazar con ceros: ');
    ReadLn(numero);
    RemplazarValor(vec,numero);

    MostrarArreglo(vec);
end.