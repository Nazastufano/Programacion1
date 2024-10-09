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
    N = 10;
    M = 3;
type
    TV = array[1..N] of string;
    TM = array[1..N,1..M] of byte;

procedure ListaAprobados(vecNom:TV;matr:TM;cantAlumnos:byte);
var
    i,j,pos:byte;
    apruebaTodos:Boolean;
    vecAux:TV;
begin
    pos:=0;    
    for i:=1 to cantAlumnos do
    begin
        apruebaTodos := true;

        for j:=1 to M do
        begin
            if matr[i,j]<5 then
                apruebaTodos:=false;
        end;
        
        if apruebaTodos then
        begin
            pos:=pos+1;
            vecAux[pos]:=vecNom[i];
        end;
    end;
    WriteLn('La lista de alumnos que aprobaron los ', M, ' parciales son: ');
    for i:=1 to pos do
        Write(vecAux[i],'. ');
    WriteLn();
end;

procedure NotaFinal(vecNom:TV;matr: TM;cantAlumnos:byte);
var
    i,j,suma,pos:byte;
    prom:real;
    vecAux:TV;
begin
    pos:=0;
    for i:=1 to cantAlumnos do
    begin
        suma:=0;
        for j:=1 to M do
        begin
            suma:= suma + matr[i,j];
        end;
        prom:= suma/M;
        if suma/M>=7 then
            begin
                pos:= pos+ 1;
                vecAux[pos]:= vecNom[i];
                WriteLn('El alumno: ', vecNom[i],' ha promocionado con promedio: ', prom:0:2);
            end
        else    
            if (prom>=5) and (matr[i,j]>=5) then
                WriteLn('El alumno: ', vecNom[i],' ha habilitado con promedio: ', prom:0:2)
            else
                WriteLn('El alumno: ', vecNom[i],' ha desaprobado con promedio: ', prom:0:2)
    end;

    WriteLn('La lista de alumnos que promocionaron son: ');
    for i:=1 to pos do
        Write(vecAux[i],'. ');
end;

var
    arch:Text;
    matr: TM;
    vecNom:TV;
    nombre:string;
    nota,i,cantAlumnos:byte;
begin
    Assign(arch,'datos.TXT');
    Reset(arch);
    cantAlumnos:=0;
    while Not Eof(arch) do
    begin
        cantAlumnos := cantAlumnos + 1;
        ReadLn(arch,nombre);
        vecNom[cantAlumnos]:=nombre;
        for i:=1 to M do
        begin
            read(arch,nota);
            matr[cantAlumnos,i]:= nota;
        end;
        ReadLn(arch);
    end;
    Close(arch);

    ListaAprobados(vecNom,matr,cantAlumnos);
    NotaFinal(vecNom,matr,cantAlumnos);
end.