program Ejercicio4;

(*Ej 4) Se pide compactar un arreglo (eliminar los ceros que contiene)
generando otro arreglo.*)

type
    TV = array of integer;

var
    arreglo: TV;
    largo,i:integer;

function BuscaCeros(vec:TV):boolean;
var
    contCeros,i:integer;
begin
    contCeros:=0;
    for i := 0 to (Length(vec)-1) do
        begin
            if vec[i]=0 then
                begin
                    contCeros:= contCeros +1;
                end;
        end;
    if contCeros<>0 then
        BuscaCeros:=true
    else
        begin
            BuscaCeros:=false;
        end;
end;

function CantidadDeCeros(vec: TV):integer;
var
    numCeros,i:integer;
begin
    numCeros:=0;
    for i := 0 to (Length(vec)-1) do
        begin
            if vec[i]=0 then
                begin
                    numCeros := numCeros + 1;
                end;
        end;
    CantidadDeCeros := numCeros;
end;

procedure LlenarArreglo(var vec:TV;var n: integer);
    var
        i: integer;
begin
        
    repeat
        writeln('Ingrese el largo del arreglo: ');
        readln(n);
    until (n>0);

    setLength(vec, n);

    for i := 0 to (Length(vec)-1) do        
        begin
            writeln('Ingrese el valor de la posicion: ', i);
            readln(vec[i]);
        end;
end;

procedure CompactarArreglo(var vec:TV);
var
    cantCeros,k,i:integer;
begin
    cantCeros:= CantidadDeCeros(vec);

    while BuscaCeros(vec) = true do
        begin
            for i := 0 to (Length(vec)-1) do
                begin
                    if (vec[i] = 0) and (i<>(Length(vec)-1)) then
                        begin
                            k:=i;
                            
                            while k <> (Length(vec)-1) do
                                begin
                                    vec[k]:= vec[k+1];
                                    k:= k +1;
                                end;
                        end;
                    
                    if (vec[i]=0) and (i=(Length(vec)-1)) then
                        begin 
                            vec[i]:=1;
                        end;
                end;
            BuscaCeros(vec);
        end;
    setLength(vec, Length(vec)-cantCeros);
end;

procedure MostrarArreglo(vec:TV);
begin
    for i := 0 to (Length(vec)-1) do
        begin
            if i=0 then
                write('(');

            if (i<>Length(vec)-1) then
                write(vec[i], ', ')
            else
                begin
                    write(vec[i], ')');      
                end;
        end;
end;

begin
    LlenarArreglo(arreglo,largo);
    CompactarArreglo(arreglo);
    MostrarArreglo(arreglo);
end.