Program Ejercicio1;

(*En un archivo de texto INTERPRETES.TXT se encuentran los intérpretes de una plataforma de
reproducción de canciones, con un intérprete por línea con la siguiente infromación: IdInterprete (cadena de
10), GeneroMusical (1 al 6), FirmóContrato [S/N]

Además, se ingresa la siguiente información de N intérpretes por teclado:
    IdInterprete (cadena de 10)
    Temas grabados por este interprete, ingresando para cada uno: IdTema (cadena de 6, fin de ingreso
    ZZZ), Duración (en segundos), Disponible [S/N]

Desarrollar el ingreso de los datos de los intérpretes y las canciones almacenando para cada intérprete que
haya firmado contrato: la cantidad de temas grabados que están disponibles, la duración total de los mismos
y la cantidad de temas no disponibles.

Luego resolver, solo considerando los intérpretes que hayan firmado contrato:
    a) Si existe alguno que siendo del género musical 2 o 3 tenga todos sus temas disponibles. En caso de
       existir más de uno dar el nombre del que tenga más temas grabados (total)
    b) Generar un arreglo con los Id de los intérpretes que verifiquen que la duración total de sus temas
       disponibles, supere a la duración media de los temas disponibles de todos los intéroretes. Mostrar el
       vector generado.
    c) Dado un intérprete I, un nuevo tema musical disponible T y su duración D (datos ingresados por
       teclado), agregar la información a las estructuras correspondientes solo si el intérprete ya estaba en
       el archivo INTERPRETES.TXT y había firmado contrato.
*)

Const 
    MAX = 10;
Type 
    ST10 = string[10];
    ST6 = string[6];
    TVIdInter = array[1..MAX] Of ST10;
    TVGenMus = array[1..MAX] of 1..6;
    TVAcum = array[1..MAX] of word;
    TVCont = array[1..MAX] of byte;

Procedure LecturaArch(var vecIdInter:TVIdInter; var vecGenMus:TVGenMus; var cantInterpretes:byte);
var
    arch:text;
    idInterprete:ST10;
    firma,aux:Char;
    genMus:1..6;
begin
    Assign(arch,'INTERPRETES.TXT');
    Reset(arch);
    cantInterpretes:=0;
    while Not eof(arch) do
    begin
        readln(arch, idInterprete, aux, genMus, aux, firma);
        if firma = 'S' then
        begin
            cantInterpretes:= cantInterpretes +1;
            vecIdInter[cantInterpretes]:=idInterprete;
            vecGenMus[cantInterpretes]:= genMus;
        end;
    end;
    Close(arch);
end;

function Busqueda(vecIdInter:TVIdInter; idInterprete:ST10; cantInterpretes:byte):byte;
var
    i:byte;
begin
    i:=1;
    while (i<=cantInterpretes) and (vecIdInter[i]<>idInterprete) do
        i:=i+1;
    if i<=cantInterpretes then
        Busqueda:=i
    else
        Busqueda:=0;
end;

procedure DatosPorTeclado(var vecCanDisp,vecCanNoDisp:TVCont;var vecAcumCanc:TVAcum; vecIdInter:TVIdInter; cantInterpretes:byte);
var
    idInterprete:ST10;
    idCancion:ST6;
    duracion:word;
    disponible:char;
    pos,i:byte;
    vecAux:TVIdInter;
begin
    i:=0;
    vecAux:=vecIdInter;
    while (i<cantInterpretes) do
    begin
        repeat
            WriteLn('Ingrese un nombre de interprete');
            ReadLn(idInterprete);
            pos:= Busqueda(vecAux, idInterprete, cantInterpretes);
        until (pos<>0) and (idInterprete<>'');
        
        vecAux[pos]:='';
        vecCanDisp[pos]:=0;
        vecCanNoDisp[pos]:=0;
        vecAcumCanc[pos]:=0;
        i:=i+1;

        WriteLn('Ingrese un id de cancion');
        ReadLn(idCancion);
        while (idCancion<>'ZZZ') do
        begin        
            Writeln('Ingrese la duracion en segundos del tema');
            ReadLn(duracion);        
            repeat
                WriteLn('El tema esta disponible?');
                ReadLn(disponible);  
                disponible:= upCase(disponible);
            until (disponible = 'S') or (disponible = 'N');
            
            if disponible = 'S' then
                begin
                    vecAcumCanc[pos] := vecAcumCanc[pos]+duracion;
                    vecCanDisp[pos] := vecCanDisp[pos] +1;
                end
            else
                vecCanNoDisp[pos]:=vecCanNoDisp[pos] +1;
            
            WriteLn('Ingrese un id de cancion ("ZZZ" fin de datos)');
            ReadLn(idCancion);
            idCancion:=upCase(idCancion);
        end;
    end;
end;
//a)
procedure Genero2o3TodosDispo(vecIdInter:TVIdInter;vecGenMus:TVGenMus;vecCanDisp,vecCanNoDisp:TVCont;cantInterpretes:byte);
var
    i,masCanciones,pos:byte;
    
begin
    masCanciones:=0;
    for i:=1 to cantInterpretes do
    begin
        if ((vecGenMus[i] = 2) or (vecGenMus[i] = 3)) and (vecCanNoDisp[i] = 0) and (masCanciones<vecCanDisp[i]) then
            begin
                masCanciones:=vecCanDisp[i];
                pos:=i;
            end;
    end;
    WriteLn('El artista ', vecIdInter[pos], ' de genero musical ', vecGenMus[pos], ' tiene todos los temas disponibles.');
end;
procedure MostrarArreglo(vec:TVIdInter;cant:byte);
var
    i:byte;
begin
    Write('(');
    for i:=1 to cant do
    begin
        if i<>cant then
            Write(vec[i],', ')
        else
            WriteLn(vec[i],')');
    end;
end;
//b)
procedure DuracionTotalSuperaProm(vecIdInter:TVIdInter;vecAcumCanc:TVAcum;vecCanDisp:TVCont;cantInterpretes:byte);
var
    i,cantSuperan:byte;
    prom:real;
    vecAux:TVIdInter;
begin
    prom:=0;
    cantSuperan:=0;
    for i:=1 to cantInterpretes do
        prom := prom + vecAcumCanc[i]/vecCanDisp[i];
    for i:=1 to cantInterpretes do
        if vecAcumCanc[i]>prom then
            begin
                cantSuperan:=cantSuperan+1;
                vecAux[cantSuperan]:=vecIdInter[i];
            end;
    if cantSuperan=0 then
        WriteLn('Ningun musico supera la media de tiempo por tema')
    else
        MostrarArreglo(vecAux,cantSuperan);
end;
//c)
procedure AgregarInterprete(vecIdInter:TVIdInter;var vecAcumCanc:TVAcum; var vecCanDisp:TVCont;cantInterpretes:byte);
var
    idInterprete:ST10;
    idTema:ST6;
    duracion:word;
    pos:byte;
begin
    WriteLn('Ingrese el Id de un artista');
    ReadLn(idInterprete);
    WriteLn('Ingrese el id del tema');
    ReadLn(idTema);
    WriteLn('Ingrese la duracion del tema');
    ReadLn(duracion);
    pos:= Busqueda(vecIdInter,idInterprete,cantInterpretes);
    if pos <>0 then
        begin
            vecAcumCanc[pos] := duracion;
            vecCanDisp[pos]:= vecCanDisp[pos] +1;
        end
    else
        WriteLn('El interprete ingresado no esta disponible o no tiene contrato');
end;
var
    vecIdInter:TVIdInter;
    vecGenMus:TVGenMus;
    cantInterpretes:byte;
    vecCanDisp,vecCanNoDisp:TVCont;
    vecAcumCanc:TVAcum;
Begin
    LecturaArch(vecIdInter,vecGenMus,cantInterpretes);
    DatosPorTeclado(vecCanDisp,vecCanNoDisp,vecAcumCanc,vecIdInter,cantInterpretes);
    Genero2o3TodosDispo(vecIdInter,vecGenMus,vecCanDisp,vecCanNoDisp,cantInterpretes);
    DuracionTotalSuperaProm(vecIdInter,vecAcumCanc,vecCanDisp,cantInterpretes);
    AgregarInterprete(vecIdInter,vecAcumCanc,vecCanDisp,cantInterpretes);
End.
