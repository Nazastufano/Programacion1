program Ejercicio4;

(*Ej 4) Se pide compactar un arreglo (eliminar los ceros que contiene) generando otro arreglo.*)

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

procedure CompactarArreglo(var vec:TVec);
var
    vec2:TVec;
    i,pos:byte;
begin
    pos:=1;
    for i:=1 to N do
    begin
        if vec[i] <> 0 then
            begin
                vec2[pos] := vec[i];
                pos:= pos +1;
            end;   
    end;
    for i:= pos to N do
    begin
        vec2[i]:= 0;
    end;
    vec:=vec2;
end;

procedure MostrarArreglo(vec: TVec);
var
    i: byte;
begin
    for i:= 1 to N do
    begin
        Write(vec[i],' ');
    end;
    WriteLn();
end;

procedure MostrarArregloSinCero(vec: TVec);
var
    i: byte;
begin
    i:= 1;
    while vec[i] <> 0 do
    begin
        Write(vec[i],' ');
        i:= i + 1;
    end;
    WriteLn();
end;

var
    vec:TVec;
begin
    CargarArreglo(vec);
    Writeln('Vector antes de compactar: ');
    MostrarArreglo(vec);
    CompactarArreglo(vec);
    Writeln('Vector despues de compactar: ');
    MostrarArregloSinCero(vec);
end.