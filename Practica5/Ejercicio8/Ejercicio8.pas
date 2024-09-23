program Ejercicio8;

(*Ej 8) Dado un arreglo V de N elementos ordenados en forma ascendente con componentes repetidas,
generar W con la frecuencia de los elementos de V. Mostrar W
    Ejemplo: N=10; V=(2,2,3,3,3,3,7,9,9,9) -> W=(2,4,1,3) *)

const
    N = 10;
type
    TVec = array[1..N] of byte;

procedure MostrarArreglo(vec:TVec);
var
    i:byte;

begin
    i := 1;
    Write('(');
    while vec[i]<>0 do
    begin
        Write(vec[i]);    
        i:= i + 1;
        if vec[i]<>0 then
            Write(', ');
    end;
    Writeln(')');
end;


procedure ArmarVector(var vec:TVec);
var
    i,res:byte;
begin
    for i:= 1 to N do
    begin
        if i=1 then
            begin
                WriteLn('Ingrese el valor de la posicion: ', i);  
                ReadLn(res);
                vec[i]:= res;
            end
        else
            begin
                repeat
                    WriteLn('Ingrese el valor de la posicion: ', i);  
                    ReadLn(res);
                until (vec[i-1] <= res);
                vec[i]:= res;
            end;
    end; 
end;

function Frecuencia(vec:TVec):TVec;
var
    i,contNum:byte;
    vecAux,vecFrec:TVec;
begin
    contNum := 1;
    vecAux[1]:= vec[1];
    vecFrec[1] := 1;

    for i:=2 to N do
    begin
        if (vec[i]<>vecAux[contNum]) then
            begin
                contNum := contNum +1;
                vecFrec[contNum]:= 1;
                vecAux[contNum]:= vec[i];
            end
        else
            vecFrec[contNum] := vecFrec[contNum] + 1;
    end;

    for i:=contNum+1 to N do
        vecFrec[i]:= 0;

    Frecuencia:= vecFrec;
end;


var
    vecFrec,vec:TVec;
begin
    ArmarVector(vec);
    
    vecFrec := Frecuencia(vec);
    
    MostrarArreglo(vecFrec);   
end.