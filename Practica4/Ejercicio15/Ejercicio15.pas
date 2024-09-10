program Ejercicio15;

(*Ej 15) Desarrollar un procedimiento y los tipos necesarios para el cálculo de una serie finita. Los
parámetros serán:
    N = cantidad de términos a sumar, con N>0
    RES = resultado
    F = función para calcular cada uno de los términos de la serie
El procedimiento calculará: RES = F(1) + F(2) + F(3) +...+ F(n)
y se pide utilizarlo para evaluar por medio de un menú
    RES1 = 1 + 1/4 + 1/9 +...+1/ n2
    RES2 = 1 + 1/2 + 1/4 +...+ 1/ 2 (n-1)
    RES3 = 1 + 1/2! + 1/3! +...+ 1/ n!
Resolver utilizando el tipo función. ¿Cómo cambiaría F por P de tipo procedimiento?*)

Function Factorial(n: word): word;
    var
        i: byte;
        res: word;
    begin
        res:= 1;

        if n = 0 then
            Factorial := 1
        else
            begin
                for i:=1 to n do
                    begin
                        res:= res*i;
                    end;
                Factorial := res
            end;
    end;

function Potencia(x:real; n:integer): real;
var
    i: byte;
    res:real;
begin
    res:=1;
    for i:=1 to abs(n) do
        begin
            res:= x*res;
        end;
    
    if n>=0 then
        Potencia := res
    else
        Potencia := (1/res);
end;

procedure Serie(n:byte; var res:real; tipoFuncion: byte);
var
    i: byte;
begin
    res:= 0;
    case tipoFuncion of
    1: begin
        for i:= 1 to n do
        begin
            res:= res + (1/sqr(i));
        end;
    end;
    2: begin
        for i:= 0 to n-1 do
        begin
            res:= res + 1/Potencia(2,i);
        end;
    end;
    3: begin
        for i := 1 to n do
        begin
            res := res + (1/Factorial(i));
        end;
    end;
    end;
    WriteLn(res:0:3);
end;

function SerieFuncion(n:byte; tipoFuncion: byte): real;
var
    i: byte;
    res:real;
begin
    res:= 0;
    case tipoFuncion of
    1: begin
        for i:= 1 to n do
        begin
            res:= res + (1/sqr(i));
        end;
    end;
    2: begin
        for i:= 0 to n-1 do
        begin
            res:= res + 1/Potencia(2,i);
        end;
    end;
    3: begin
        for i := 1 to n do
        begin
            res := res + (1/Factorial(i));
        end;
    end;
    end;
    SerieFuncion:= res;
end;

var
    respuesta: real;
    terminos,tipoSerie:byte;
begin
    repeat
        WriteLn('Ingrese la cantidad de terminos a sumar, con N>0: ');
        readln(terminos);  
    until terminos>0;
     
    repeat
        WriteLn('Ingrese el tipo de serie que desea calcular: ');
        Readln(tipoSerie);    
    until tipoSerie in [1..3];
    
    Serie(terminos, respuesta, tipoSerie);
    
    WriteLn('La respuesta con el ejercicio hecho en funcion es: ', SerieFuncion(terminos,tipoSerie):0:3);
end.