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
    TV =

var
    arch:text;
begin
    assign(arch, 'datos.TXT');
    reset(arch);
end.