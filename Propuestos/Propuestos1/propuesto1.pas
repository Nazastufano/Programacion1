program Propuesto1;

(*Ejercicios propuestos 1)Una compañía Láctea recibe la producción diaria de, en litros de leche, de N tambos de la zona,
durante varios días consecutivos (no se conoce).

Los datos vienen de la siguiente manera:

*Código del Tambo (cadena de 4 caracteres) y a continuación
la entrega diaria en litros, 0=fin de datos.

Se pide, armar 3 vectores paralelos, COD, TOT, PROM y además calcular e informar:
    a) Código del tambo que más leche entregó a la compañía.
    b) Cuántos superaron un promedio de X litros de entrega.
    c) Dado un código, el total y el promedio diario entregado, (si es que existe dicho código).

COD con los códigos de cada Tambo
TOT con los totales de litros entregados
PROM con el promedio diario entregado

Ejemplo:
N=4
AA12
200 100 50 150 100 0
BB07 
200 110 90 120 0
CC33
85 110 60 0
DD45
80 120 80 140 0

*)


type
    ST4 = string[4];
    VTInt = array of integer;
    VTSt = array of string;
    VTReal = array of real;

var
    arch: text;
    tambo, codMasLeche: ST4;
    TOT: VTInt;
    PROM: VTReal;
    COD: VTSt;
    contDias, litro, contSuperoLitros, litrosASuperar, totalLitros, nTambos, masLeche, i: integer;
    promedio: real;

begin
    assign(arch, 'datos.TXT');
    reset(arch);

    nTambos:= 0;
    promedio:= 0;

    SetLength(TOT, 0);
    SetLength(PROM, 0);
    SetLength(COD, 0);

    read(arch, tambo);
    read(arch, litro);

    repeat
        writeln('Ingrese la cantidad de litro a superar: ');
        readln(litrosASuperar);        
    until (litrosASuperar>0);

    while not eof(arch) do
        begin
            nTambos:= nTambos + 1;
            promedio:=0;
            totalLitros:=0;
            contDias:=0;

            while (litro<>0) and (not eoln(arch)) do
                begin
                    totalLitros:= totalLitros + litro;
                    contDias:= contDias +1;
                    read(arch, litro);
                end;
            promedio:= (totalLitros/contDias);
            
            if litro = 0 then
                readln(arch);

            SetLength(COD, nTambos);
            SetLength(TOT, nTambos);
            SetLength(PROM, nTambos);

            COD[nTambos - 1] := tambo;
            TOT[nTambos - 1] := totalLitros;
            PROM[nTambos - 1] := promedio;
            
            if masLeche<totalLitros then
                begin
                    masLeche:= totalLitros;
                    codMasLeche:= tambo;
                end;

            if litrosASuperar<TotalLitros then
                contSuperoLitros := contSuperoLitros +1;

            read(arch, tambo);
            read(arch,litro);
        end;
    close(arch);
    
    writeln('El tambo que mas leche le dio a la compania es: ', codMasLeche);
    writeln('La cantidad de tambos que superaron los ', litrosASuperar, ' son: ', contSuperoLitros, ' tambo/s');
    writeln('Ingrese un tambo a buscar: ');
    readln(tambo);

    for i := 0 to nTambos do
        if tambo = COD[i] then
            begin
                writeln('El tambo: ', COD[i], ' tiene un total de ', TOT[i], ' Litros entregados y un promedio de ', PROM[i]:0:2, ' litros por dia');
            end;
end.