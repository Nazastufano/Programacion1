Program Parcial;

{En un archivo de texto se han grabado números naturales, uno por línea. Se pide leerlos, teniendo en cuenta
solamente los que están ubicados en el rango de 1 a 99.
Se pide, calcular e informar:- la cantidad de números analizados en cada una de las decenas (ej. 34 corresponde a decena 3).
    - el número máximo que apareció en cada decena.
Por fin de proceso, indicar si hubo o no números en todas las decenas mediante una función.}
type
    TVDecenas = array[0..9] of byte;
    TVMax = array[0..9] of word;

procedure InicializarByte(var vec:TVDecenas);
var
    i:byte;
begin
    for i:=0 to 9 do
        vec[i]:=0;
end;

procedure InicializarWord(var vec:TVMax);
var
    i:byte;
begin
    for i:=0 to 9 do
        vec[i]:=0;
end;

procedure LecturaArch(var vecDecenas:TVDecenas;var vecMax:TVMax);
var
    arch:text;
    num:word;
    pos:0..9;
begin
    Assign(arch,'datos.TXT');
    Reset(arch);
    InicializarByte(vecDecenas);
    InicializarWord(vecMax);
    while Not eof(arch) do
    begin
        ReadLn(arch,num);
        if num in [1..99] then
        begin
            pos:=num div 10;
            if vecMax[pos]<num then
                vecMax[pos]:=num;
            vecDecenas[pos]:=vecDecenas[pos]+1;
        end;
    end;
end;
function numEnTodasLasDecenas(vecDecenas:TVDecenas):Boolean;
var
    i:byte;
begin
    i:=0;
    while (i<=9) and (vecDecenas[i]<>0) do
        i:=i+1;
    if i<=9 then
        numEnTodasLasDecenas:=false
    else
        numEnTodasLasDecenas:=true;
end;
procedure MostrarArreglos(vecDecenas:TVDecenas;vecMax:TVMax);
var
    i:byte;
begin
    WriteLn('Cantidad Mayor');

    for i:=0 to 9 do
        WriteLn(vecDecenas[i]:4,' ',vecMax[i]:7);
    
    if numEnTodasLasDecenas(vecDecenas) then
        WriteLn('Hay numeros en todas las decenas')
    else
        WriteLn('No hay numeros en todas las decenas');
end;

var
    vecDecenas:TVDecenas;
    vecMax:TVMax;
begin
    LecturaArch(vecDecenas,vecMax);
    MostrarArreglos(vecDecenas,vecMax);
end.