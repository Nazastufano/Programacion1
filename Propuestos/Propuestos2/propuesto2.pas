program Propuesto2;

(*pro2 ) Una compañía Láctea recibe la producción diaria en litros de leche, de N tambos de la zona,
durante quince días.
Los datos vienen de la siguiente manera, sin orden alguno:
* Código del Tambo (cadena de 4 caracteres) puede repetirse
* dia
* la entrega en litros.

Se pide, armar 3 vectores paralelos, COD, TOT, ENTREGAS y además calcular e
informar:
    a) Código del tambo que más leche entregó a la compañía.
    b) Cuántos superaron un promedio de X litros de entrega.
    c) Dado un código, el total y el promedio diario entregado, (si es que existe dicho código).

COD con los códigos de cada Tambo
TOT con los totales de litros entregados
ENTREGAS con La cantidad total de entregas

TAMBOS.TXT
AA12 2 200
AA12 3 100
BB07 3 200
BB07 4 110
AA12 5 50
CC33 5 85
DD45 5 80
AA12 8 150
DD45 8 120
BB07 11 100
CC33 12 60
DD45 12 80
BB07 14 120
DD45 14 140
AA12 15 100

COD TOT ENTREGAS
AA12 600 5
BB07 520 4
CC33 245 3
DD45 420 4
*)


type
    ST4 = string[4];
    VTInt = array of integer;
    VTSt = array of ST4;

var
    arch:text;
    ACod: VTSt;
    ATot, AEntregas: VTInt;
    cod,codMasLeche:ST4;
    i, litros,masLeche, litrosASuperar,contSuperoLitros: integer;
    primeraVuelta:boolean;
begin
    assign(arch, 'TAMBOS.TXT');
    reset(arch);

    SetLength(ACod, 1);
    SetLength(ATot, 1);
    SetLength(AEntregas, 1);

    primeraVuelta:= true;

    repeat
        writeln('Ingrese la cantidad de litro a superar: ');
        readln(litrosASuperar);        
    until (litrosASuperar>0);

    while not eof(arch) do
        begin
            readln(arch);
            read(arch, cod, dias, litros);
            
            if primeraVuelta then
                begin
                    primeraVuelta := false;
                    ACod[0] := cod;
                    ATot[0] := litros;
                    AEntregas[0] := 0;
                end;
                
            for i := 0 to (length(ACod)) do
                begin
                    if cod = ACod[i-1] then
                        begin
                            ATot[i-1] := ATot[i-1] + litros;
                            AEntregas[i-1] := AEntregas[i-1] + 1;
                            break;
                        end;       
                end; 
            if (i = length(ACod)) and (not eof(arch)) then
                begin
                    SetLength(ACod, length(ACod) + 1);
                    SetLength(ATot, length(ACod) + 1);
                    SetLength(AEntregas, length(ACod) + 1);
                    ACod[i-1] := cod;
                    ATot[i-1] := ATot[i-1] + litros;
                    AEntregas[i-1] := AEntregas[i-1] + 1;
                end;


        end;
    close(arch);
    
    for i := 0 to length(ACod)-2 do
    begin
        if masLeche<ATot[i] then
            begin
                masLeche:= ATot[i];
                codMasLeche:= ACod[i];
            end;
        if litrosASuperar<ATot[i] then
                contSuperoLitros := contSuperoLitros +1;
    end;

    
    writeln('El tambo que mas leche le dio a la compania es: ', codMasLeche);
    writeln('La cantidad de tambos que superaron los ', litrosASuperar, ' son: ', contSuperoLitros, ' tambo/s');
    writeln('Ingrese un tambo a buscar: ');
    readln(cod);

    for i := 0 to length(ACod)-2  do
        if cod = ACod[i] then
            begin
                writeln('El tambo: ', ACod[i], ' tiene un total de ', ATot[i], ' Litros entregados y un promedio de ', (ATot[i]/AEntregas[i]):0:2, ' litros por dia');
            end;
end.