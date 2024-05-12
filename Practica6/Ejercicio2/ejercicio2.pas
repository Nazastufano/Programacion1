program Ejercicio2;

(*Ej 2) En un archivo se almacenó el Nombre del alumno y la nota de los K parciales, pasar los datos a un
vector Nbre paralelo a la matriz Notas e informar:
a) Listado de los alumnos que aprobaron los K parciales.
b) Por cada alumno determinar su situación:
    ° Promociona: si el promedio es >= 7
    ° Habilita: si promedio >= 5 y < 7; y la K-ésima nota >= 5
    ° Desaprobado: en otro caso
y generar un arreglo con los nombres de aquellos que promocionaron. *)

const
    K =3;
    N = 3;

type
    ST10 = string[10];
    TV = array[1..N] of ST10;
    TM = array[1..N,1..K] of integer;
var
    arch:text;
    matr:TM;
    vec:TV;

procedure RellenarMatriz(matr: TM); //Rellena la matriz con 0
    var
        i,j:integer;
    begin
        for i := 1 to N do
            begin
                for j := 1 to K do
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
        
        contParciales:=0;
        contAlumnos:=0;

        readln(arch, nombre);
        vec[1]:= nombre;
        writeln(vec[1]);
        
        while not eof(arch) do
            begin
                read(arch, nota);

                contAlumnos:= contAlumnos + 1;
                contParciales:= contParciales + 1;
                
                matr[contAlumnos,contParciales]:= nota;
                writeln(matr[contAlumnos,contParciales]);
            end;
    end;
begin
    GenerarMatriz(arch, vec, matr);

end.