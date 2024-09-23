program Ejercicio9;

(*Ej 9) Dado un archivo de números enteros no nulos, almacenar en un arreglo A aquellos que formen una
secuencia ascendente. A partir de A generar B con la misma cantidad de elementos de A pero poniendo
ceros en aquellas componentes simétricas donde la simétrica derecha no sea múltiplo de la izquierda.
Escribir ambos arreglos.
Ejemplo: Archivo: 5, 7, 1, 12, 15, -10, 10, 24, -25, 26, 50, 13
    A = (5, 7, 12, 15, 24, 26, 50) -> B= (5, 0, 12, 15, 24, 0, 50)*)

const
    N = 10;

type
    TVec = array[1..N] of integer;

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

procedure GenerarArreglo(vecA:TVec; var vecB:TVec; indice:byte);
var
    i,j:byte;
begin
    vecB:=vecA;
    for i:= 1 to indice div 2 do
    begin
        j:= indice -i +1;

        if (vecA[j] mod vecA[i] <> 0) then
        begin
            vecB[i] := 0;
            vecB[j] := 0;
        end;
    end;
end;

var
    arch:Text;
    num,numAnt:integer;
    i,cant:byte;
    vec,vecB:TVec;
begin
    Assign(arch,'datos.TXT');
    Reset(arch);
    cant:= 1;
    
    Read(arch,numAnt);
    vec[cant]:=numAnt;
    while not eof(arch) do
    begin
        Read(arch,num);

        if num>numAnt then
        begin
            cant:= cant +1;
            vec[cant]:= num;
        end;

        numAnt:=vec[cant];
    end;
    close(arch);
    GenerarArreglo(vec,vecB,cant);
    
    Write('A = ');
    MostrarArreglo(vec,cant);
    
    WriteLn();
    Write('B = ');
    MostrarArreglo(vecB,cant);

    
end.