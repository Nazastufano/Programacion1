program Ejercicio2;

(*Ej 2) En un archivo se almacenó el Nombre del alumno y la nota de los K parciales, pasar los datos a un
vector Nbre paralelo a la matriz Notas e informar:
a) Listado de los alumnos que aprobaron los K parciales.
b) Por cada alumno determinar su situación:
    ° Promociona: si el promedio es >= 7
    ° Habilita: si promedio >= 5 y < 7; y la K-ésima nota >= 5
    ° Desaprobado: en otro caso
y generar un arreglo con los nombres de aquellos que promocionaron. *)

type
    ST10 = string[10];
    TV = array of ST10;
    TM = array of array of integer;
var
    arch:text;
    matr:TM;
    vec:TV;

procedure RellenarMatriz(matr: TM); //Rellena la matriz con 0
    var
        i,j:integer;
    begin
        for i := 0 to matr[] do
            begin
                for j := 0 to m-1 do
                    matr[i,j] := 0;
            end;
    end;
procedure GenerarMatriz(var arch:text; var vec:TV; var matr:TM);
    var
        nombre:ST10;
        nota, contAlumnos, contParciales:integer;
    begin
        assign(arch, 'datos.TXT');
        reset(arch);
        
        readln(arch, nombre);
        setLength(vec, 1);
        vec[0]:= nombre;
        writeln(vec[0]);
        
        while not eof(arch) do
            begin
                read(arch, nota);
                        
                writeln(nota);
                while not eoln(arch) do
                    begin
                        setLength(matr, 1, length(matr[1])+1);
                        read(arch, nota);
                        matr[1,1]:= nota;
                        writeln(matr[1,1]);
                    end;
                read(arch);
                readln(arch, nombre);
                if not eof(arch) then
                    begin
                        setLength(vec, length(vec)+1);
                        vec[length(vec)-1]:= nombre;
                    end;
                    
            end;
        
    end;

begin
    GenerarMatriz(arch, vec, matr);

end.