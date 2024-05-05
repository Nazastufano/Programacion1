program Ejercicio1;

(*Ej 1) Leer desde un archivo una matriz de NxM elementos enteros, (N y M se encuentran en la primera
línea del archivo y luego en las restantes N líneas vienen los M elementos). Se pide:
a) Generar un arreglo con el máximo de cada fila y mostrarlo.
b) Generar un arreglo con la suma de los impares de cada columna, no generar elemento si la
columna no tiene impares.
c) Dada una columna X, ingresada por el usuario, hallar el promedio de sus elementos.*)

type
    TM = array of array of integer;
    TV = array of integer;
var
    arch: text;
    n, m: integer;
    matr: TM;    
    vec:TV;

procedure RellenarMatriz(matr: TM); //Rellena la matriz con 0
    var
        i,j:integer;
    begin
        for i := 0 to n-1 do
            begin
                for j := 0 to m-1 do
                    matr[i,j] := 0;
            end;
    end;

procedure MostrarArreglo(vec:TV); //Genera el arreglo de los maximos
    var
        i:integer;
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

procedure ArregloMaximo(var vec:TV; var matr:TM); //Revisa la matriz y busca los maximos de cada fila
    var
        valorMax, valor, i, j:integer;
    begin
        setLength(vec, m);
        for i := 0 to n-1 do
            begin
                valorMax:= matr[i,1];
                for j := 0 to m-1 do
                    begin
                        valor := matr[i,j];
                        if valor>valorMax then
                            valorMax := valor;
                    end;
                vec[i] := valorMax;
            end;

        MostrarArreglo(vec);
    end;

procedure CrearMatriz(var arch:text; var matr:TM); //Ingresa desde el archivo los valores a la matriz
    var
        val,i,j:integer;
    begin
        assign(arch, 'datos.TXT');
        reset(arch);

        read(arch, n);
        read(arch, m);
        setLength(matr, n, m);
        RellenarMatriz(matr);

        for i := 0 to n-1 do
            begin
                for j := 0 to m-1 do
                    begin
                        read(arch, val);
                        matr[i,j] := val;
                    end;
            end;
    end;

begin
    CrearMatriz(arch, matr);
    //a)
    ArregloMaximo(vec,matr);
   
    
    (*
    writeln(Length(matr));    
    writeln(Length(matr[1]));  

    setLength(matr, Length(matr)+ 1, Length(matr[1])+1);
    writeln(Length(matr));
    writeln(Length(matr[1])); 
    *)
end.