program Ejercicio21;

(*Ej 21) Leer un conjunto de números enteros, la presencia de ceros intermedios indica fin de un
subconjunto y comienzo del siguiente, dos ceros consecutivos es fin de datos. Se pide calcular e informar
el máximo en cada subconjunto y el orden del subconjunto más numeroso.
Ejemplo: 3,5,2,0,6,7,4,7,0,2,1,0,0
Respuesta: subconjunto Máximo
 1 5
 2 7
 3 2
El subconjunto con más elementos es: 2
*)

var
    arch:text;
    numero, numeroMax, contElem, contMasElem, contConj, conjMax: integer;
    
begin
    assign(arch, 'datos.TXT');
    reset(arch);
    contMasElem := 0;

    read(arch, numero);
    writeln('Subconjunto - maximo');

    while not eoln(arch) do
        begin
            contElem := 0;
            numeroMax :=0;
            while numero <> 0 do
                begin
                    if numeroMax<numero then
                        begin
                            numeroMax:= numero;
                        end;
                    contElem:= contElem + 1;
                    read(arch, numero);
                end;
            contConj := contConj + 1;

            if contMasElem < contElem then
                begin
                    contMasElem := contElem;
                    conjMax:= contConj;        
                end;

            writeln(contConj, ' - ', numeroMax);
            read(arch, numero);

            if numero = 0 then
                read(arch, numero);
        end;
    close(arch);
    writeln('El subconjunto con más elementos es: ', conjMax);
end.