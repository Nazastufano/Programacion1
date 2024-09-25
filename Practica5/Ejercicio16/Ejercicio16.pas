Program Ejercicio16;

(*Ej 16) Se pide compactar un arreglo, como en el ejercicio 4, pero sin usar estructura auxiliar. 
(Ej 4) Se pide compactar un arreglo (eliminar los ceros que contiene) generando otro arreglo.)*)

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
    i,pos:byte;
begin
    pos:=0;
    for i:=1 to N do
    begin
        if vec[i] <> 0 then
            begin                
                pos:= pos +1;
                vec[pos] := vec[i];
            end;   
    end;
    for i:=pos+1 to N do
    begin
        vec[i]:=0;
    end;
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
    for i:=1 to N do
    begin
        if vec[i]<>0 then
            Write(vec[i],' ');
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