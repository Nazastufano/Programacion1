Program Ejercicio5;

(*Ej 5) Dado un archivo de enteros, almacenarlos en un arreglo, luego obtener el promedio de todos los
números divisores del máximo y con ellos armar otro arreglo. Mostrar ambos arreglos y el promedio
obtenido.*)

const
    N = 10;
type
    TVec = array[1..N] of integer;

function Promedio(vec:TVec):Real;
var
    i:byte;
    suma:real;
begin
    suma := 0;
    i:=1;
    while vec[i] <> 0 do
    begin
        suma:= suma + vec[i];
        i:= i +1;
    end;
    Promedio := suma/(i-1);
end;

procedure ArmarArreglo(var vec2:TVec; vec:TVec; numero:Integer);
var
    i,posicion: byte;
begin
    posicion:=1;
    for i:= 1 to N do
    begin
        if (numero mod vec[i]) = 0 then 
        begin
            vec2[posicion]:= vec[i]; 
            posicion:= posicion +1;
        end;
    end;
    
    for i:= posicion to N do
    begin
        vec2[i] := 0;
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
    i:= 1;
    while vec[i] <> 0 do
    begin
        Write(vec[i],' ');
        i:= i + 1;
    end;
    WriteLn();
end;

var
    vec,vec2:TVec;
    arch:text;
    num,numMax:integer;
    pos:byte;

begin
    Assign(arch, 'datos.txt');
    Reset(arch);

    pos:=1;
    while not eof(arch) do
    begin
        Read(arch,num);

        if (num>numMax) or (pos=1) then
            numMax:= num;

        vec[pos]:= num;
        pos := pos +1;
    end;
    Close(arch);
    
    ArmarArreglo(vec2,vec,numMax);
    WriteLn('El arreglo del archivo es: ');
    MostrarArreglo(vec);
    WriteLn('El arreglo armado con los divisores del numero maximo (', numMax,') del arreglo: ');
    MostrarArregloSinCero(vec2);
    WriteLn('El promedio obtenido del arreglo de los divisores del numero maximo es: ', Promedio(vec2):0:2);
end.