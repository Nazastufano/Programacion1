program Ejercicio1;

(*Ej 1) Dado un arreglo A de N elementos reales, desarrollar subprogramas para:
a) Calcular la suma de sus elementos.
b) Mostrar los elementos que se encuentran en posiciones pares.
c) Calcular el máximo y el mínimo elemento.
d) Generar un arreglo B con los elementos de A permutado ( B[1]=A[N], B[2]=A[N-1] … B[N]=A[1] ).
Escribir el programa principal con las invocaciones a cada uno de los subprogramas, mostrando los
resultados correspondientes.
*)

type
    TVecI = array of real;

var
    N, resp: integer;
    arreglo1, arreglo2: TVecI;
    resultado:real;

procedure LlenarArreglo(var A: TVecI);
    var
        i: integer;
        valor: real;
    begin
        for i := 0 to N - 1 do
            begin
                writeln('Escriba el valor ', (i+1) , ' para el arrglo: ');
                readln(valor);
                A[i] := valor;
            end;
    end;

function SumaArreglo(A: TVecI): real;
    var
        i:integer;
        suma:real;
    begin
        for i := 0 to N -1 do
            begin
                suma:= suma + A[i];    
            end;
        SumaArreglo := suma;
    end;

function MostrarMin(A:TVecI):real;
    var
        i:integer;
        min, minFinal:real;
    begin
        for i := 0 to N-1 do
            begin
                min := A[i];
                
                if i=0 then
                    minFinal:= min;
                
                if min<minFinal then
                    minFinal := min;
            end;
        MostrarMin:= minFinal;
    end;

function MostrarMax(A:TVecI):real;
    var
        i:integer;
        max, maxFinal:real;
    begin
        for i := 0 to N-1 do
            begin
                max := A[i];
                
                if i=0 then
                    maxFinal := max;
                
                if max>maxFinal then
                    maxFinal := max;
            end;
        MostrarMax:= maxFinal;
    end;

procedure MostrarPares(var A: TVecI);
    var
        i:integer;
    begin
        for i := 0 to N - 1 do
            if (i mod 2 = 0) then
                begin
                    writeln('Un elemento par es: ', A[i]:0:2);
                end;
    end;

procedure LlenarOtroArreglo(var A, B: TVecI);
    var
        i, pos:integer;
    begin
        pos:= Length(A) - 1; 
        for i := 0 to Length(A) - 1 do
            begin
                B[i]:= A[pos];
                pos :=pos -1;
            end;
    end;

begin
    repeat
        writeln('Ingrese el tamaño del arreglo: ');
        readln(N);        
    until (N>0);

    SetLength(arreglo1, N);
    SetLength(arreglo2, N);

    LlenarArreglo(arreglo1);
    repeat    
        repeat
            writeln('Que opcion desea llevarle a cabo al array? (1 = sumar sus valores, 2 = Mostrar las posiciones pares, 3 = llenar otro array con las posiciones invertidas y mostrar sus posiciones pares, 4 = mostrar el valor minimo del array, 5 = mostrar el valor maximo del array, 6 = salir)');
            readln(resp)            
        until (resp in [1..6]);

        case resp of
            1:
                begin
                    resultado := SumaArreglo(arreglo1);
                    writeln('La suma de los valores del arreglo es: ',resultado:0:2);
                end;
            2:  MostrarPares(arreglo1);
            3: 
                begin
                    LlenarOtroArreglo(arreglo1, arreglo2);
                    MostrarPares(arreglo2);    
                end;
            4:
                begin
                    resultado := MostrarMin(arreglo1);
                    writeln('El valor minimo es: ', resultado:0:2);    
                end;
            5:
                begin
                    resultado := MostrarMax(arreglo1);
                    writeln('El valor maximo es: ', resultado:0:2);    
                end;
        end;        
    until (resp = 6);

end.