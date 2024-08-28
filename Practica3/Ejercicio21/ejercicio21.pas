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
    numero, numeroMax: char;
    contMasElem, contElem, contConj, conjMax: byte;

begin
    assign(arch, 'datos.TXT');
    reset(arch);
    contMasElem := 0;
    conjMax := 0;

    writeln('Subconjunto - maximo');

    while not eof(arch) do
        begin
            contElem := 0;
            numeroMax := '0';

            repeat
                Read(arch, numero);
            until ((numero <> ' ') and (numero <> ',') and (numero <> '0')) or (Eof(arch)) or (eoln(arch));
            
            while ((numero <> '0')) and (Not Eof(arch)) and (Not eoln(arch)) do
                begin
                    if numeroMax < numero then
                        numeroMax := numero;
                        
                    contElem := contElem + 1;
                    read(arch, numero);
                end;
            
            if numero = '0' then
                begin
                    contConj := contConj + 1;

                    If contMasElem < contElem Then
                        Begin
                            contMasElem := contElem;
                            conjMax := contConj;
                        End;

                    writeln(contConj, ' - ', numeroMax);
                end;
        end;
    close(arch);
    writeln('El subconjunto con más elementos es: ', conjMax);
end.