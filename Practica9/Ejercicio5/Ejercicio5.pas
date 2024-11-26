Program Ejercicio5;

(*Ej 5) Dado un archivo ALUMNOS.DAT con las notas de alumnos cuyo diseño de registro es:
    # MATRICULA (campo de secuencia, clave primaria)
    # NOTA en MATEMÁTICA (0..10)
    # NOTA en FISICA I (0..10)
    # NOTA en QUIMICA I (0..10)
y un archivo de inscriptos (INSCRIPTOS.DAT) en QUIMICA II y FISICA II cuyo diseño de registro es:
    # MATRICULA (campo de secuencia, clave primaria)
    # QUIMICA II (1=inscripto, 0=no inscripto)
    # FISICA II (1=inscripto, 0=no inscripto)
Obtener un listado con la matrícula de aquellos alumnos inscriptos que no cumplan con los requisitos de
equivalencia exigidos, que son: para FISICA II, tener aprobados MATEMATICA y FISICA I, y para
QUIMICA II, tener aprobado QUIMICA I. (se aprueba con NOTA >=4) *)

Type
    TRegAl = record
        matricula:word;
        notaM,notaF,notaQ:1..10;
    end;
    TRegIns = record
        matricula:word;
        quimica,fisica:0..1;
    end;
    TArchAlumnos = file of TRegAl;
    TArchInscriptos = file of TRegIns;

procedure GrabaArchAlumnos(var archAlumnos:TArchAlumnos);
var
    arch:text;
    R:TRegAl;
begin
    Assign(arch,'ALUMNOS.TXT');
    Reset(arch);
    Rewrite(archAlumnos);
    while not eof(arch) do
    begin
        ReadLn(arch,R.matricula,R.notaM,R.notaF,R.notaQ);
        Write(archAlumnos,R);
    end;
    close(arch);
end;
procedure GrabaArchInscriptos(var archInscriptos:TArchInscriptos);
var
    arch:text;
    R:TRegins;
begin
    Assign(arch,'INSCRIPTOS.TXT');
    Reset(arch);
    Rewrite(archInscriptos);
    while NOT eof(arch) do
    begin
        readln(arch,R.matricula,R.quimica,R.fisica);
        Write(archInscriptos,R);
    end;
    Close(arch);
end;
procedure ListaInscriptosNoCumplen(var archAlumnos:TArchAlumnos;var archInscriptos:TArchInscriptos);
var
    RAl:TRegAl;
    RIn:TRegIns;
begin
    Reset(archAlumnos);
    Reset(archInscriptos);
    Read(archAlumnos,RAl);
    Read(archInscriptos,RIn);
    WriteLn('La lista de matriculas que no cumplen');
    while (NOT eof(archAlumnos)) or (NOT eof(archInscriptos)) do
    begin
        if RAl.matricula<RIn.matricula then
            Read(archAlumnos,RAl)
        else 
            if RAl.matricula>RIn.matricula then
            begin
                Writeln('Matricula inexistente');
                Read(archInscriptos,RIn);
            end
            else
                begin
                    if ((RIn.quimica=1) and (Ral.notaQ<4)) or ((RIn.fisica=1) and ((RAl.notaM<4) or (Ral.notaF<4))) then
                        Writeln(RIn.matricula);
                        
                    Read(archAlumnos,RAl);
                    Read(archInscriptos,RIn);
                end;
    end;
    Close(archAlumnos);
    Close(archInscriptos);
end;
var
    archAlumnos:TArchAlumnos;
    archInscriptos:TArchInscriptos;
begin
    Assign(archAlumnos,'ALUMNOS.DAT');
    Assign(archInscriptos,'INSCRIPTOS.DAT');
    GrabaArchAlumnos(archAlumnos);
    GrabaArchInscriptos(archInscriptos);
    ListaInscriptosNoCumplen(archAlumnos,archInscriptos);
end.