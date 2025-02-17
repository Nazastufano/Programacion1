program Ejercicio1;

(*Una plataforma de reproducción de música mantiene información de los temas
musicales que han tenido y tienen disponibles para reproducción en un archivo y por otro
lado los interpretes.

ARCHIVOCANCIONES.DAT con la siguiente información y diseño:
    IDINTERPRETE Cadena de 6 (1er campo de secuencia, clave secundaria)
    GENERO MUSICAL (1..5) (2do campo de secuencia, clave secundaria)
    NOMBRE TEMA  Cadena de 30
    DISPONIBLE   S/N
    DURACION     (en segundos)

ARCHIVOINTERPRETES.DAT con la siguiente inforamcion y diseño:
    IDINTERPRETE Cadena de 6 (desordenado, clave primaria)
    NOMBRE       Cadena de 30
    TIENECONTRATO   S/N

Se pide escribir los tipos, la declaracion de variables y el programa principal para mostrar un
listado como el que se ve abajo, considerando un dato X (leido por teclado) que
    Para cada interprete con contrato, su nombre y los temas musicales disponibles del genero
    X, finalmente la cantidad total de temas disponibles y no disponibles (considerando todos
    los generos)
    Al final del listado, la duracion total en minutos de los temas del genero X
    
        Nombre Interprete xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
            Nombre de los Temas de genero 9
                xxxxxxxxxxxxxxxxxxxxxxxx
                xxxxxxxxxxxxxxxxxxxxxxxx
            Cantidad de Temas Disponibles 999
            Cantidad de Temas No Disponibles 999    
        Nombre Interprete xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
            Nombre de los Temas de genero 9
                xxxxxxxxxxxxxxxxxxxxxxxx
                xxxxxxxxxxxxxxxxxxxxxxxx
            Cantidad de Temas Disponibles 999
            Cantidad de Temas No Disponibles 999
            ......
        Duracion Total de los Temas del Genero 9: 9999,99

Debe utilizarse en la resolución alguna tecnica de tratamiento de archivos vistas en la
asignatura.
*)

Type
    ST6 = string[6];
    ST30 = string[30];
    oneToFive = 1..5;
    TRegCan = record
        idInterprete:ST6;
        generoMusical:oneToFive;
        nombreTema:ST30;
        disponible:char;
        duracion:word;
    end;
    TRegInt = record
        idInterprete:ST6;
        nombre:ST30;
        tieneContrato:char;
    end;
    TV = array[1..1000] of ST6;
    TArchCan = file of TRegCan;
    TArchInt = file of TRegInt;
procedure armarVector(var archInt:TArchInt;var vecInterpretes:TV);
var
    R:TRegInt;
    i:word;
begin
    reset(archInt);
    Read(archInt,R);
    i:=0;
    while not eof(archInt) do
    begin
        i:=i+1;
        vecInterpretes[i]:=r.idInterprete;
        read(archInt,R);
    end;
    Close(archInt);
end;
function Busqueda(vecInterpretes:TV;idInterprete:ST6):word;
var
    i:word;
begin
    while(vecInterpretes[i]<>idInterprete) do
        i:=i+1;
    Busqueda:=i;
end;
procedure ArmarTabla(var archCan:TArchCan; var archInt:TArchInt; vecInterpretes:TV; x:oneToFive);
var
    duracionTotal:real; // temas de genero x
    temasDispo,temasNoDispo:word; //todos los generos
    RCa:TRegCan;
    RIn:TRegInt;
begin
    reset(archCan);
    Reset(archInt);
    Read(archCan,RCa);
    Seek(archInt,Busqueda(vecInterpretes,RCa.idInterprete)-1);
    Read(archInt,RIn);
    
    duracionTotal:=0;
    while (not eof(archInt)) do
    begin
        if RIn.tieneContrato = 'S' then  
        begin
            temasDispo:=0;
            temasNoDispo:=0;
            WriteLn('Nombre Interprete ', RIn.nombre);
            WriteLn('   Nombre de los temas de genero ', x);
            while RCa.idInterprete = RIn.idInterprete do
            begin
                if RCa.disponible = 'S' then
                begin
                    temasDispo:=temasDispo+1;
                    if RCa.generoMusical = x then
                    begin
                        WriteLn('       ', RCa.nombreTema);
                        duracionTotal:=duracionTotal+RCa.duracion;
                    end;
                end
                else
                    temasNoDispo:=temasNoDispo+1;
                Read(archCan,RCa);
            end;
            WriteLn('Cantidad de Temas Disponibles ', temasDispo);
            WriteLn('Cantidad de Temas No Disponibles ', temasNoDispo);
        end;
        Read(archCan,RCa);
        Seek(archInt,Busqueda(vecInterpretes,RCa.idInterprete)-1);
        Read(archInt,RIn);
    end;
    WriteLn('Duración Total de los Temas del Genero', x,': ',duracionTotal/60:0:2);
    Close(archCan);
    Close(archInt);
end;

var
    archCan:TArchCan;
    archInt:TArchInt;
    x:oneToFive;
    vecInterpretes:TV;
begin
    Assign(archCan,'ARCHIVOCANCIONES.DAT');
    Assign(archInt,'ARCHIVOINTERPRETES.DAT');
    
    repeat
        WriteLn('Ingrese un genero musical del entre los 5 disponibles (1..5)');
        ReadLn(x);
    until (x in [1..5]);
    
    armarVector(archInt,vecInterpretes);
    ArmarTabla(archCan,archInt,vecInterpretes,x);
end.