program Ejercicio4;

(*Ej 4) Dadas dos fechas (dia, mes y año) indicar cuál
    es la más antigua y a qué trimestre pertenece. *)

var
    anio1, anio2: word;
    mes, dia1, dia2, mes1, mes2: byte;
begin

    repeat
        writeln('Ingese el primer dia');
        readln(dia1);
        writeln('Ingese el segundo dia');
        readln(dia2);
    until (dia1 in [1..31]) and (dia2 in [1..31]);

    repeat
        writeln('Ingese el primer mes');
        readln(mes1);
        writeln('Ingese el segundo mes');
        readln(mes2);        
    until (mes1 in [1..12]) and (mes2 in [1..12]);

    writeln('Ingese el primer año');
    readln(anio1);
    writeln('Ingese el segundo año');
    readln(anio2);


    if ((anio1=anio2) and (mes1=mes2) and (dia1=dia2)) then
        Begin
            writeln('Las fechas son iguales');
            mes := mes1;
        End
    else        
        begin
            if (anio1<anio2) or ((anio1=anio2) and (mes1<mes2)) or ((anio1=anio2) and (mes1=mes2) and (dia1<dia2)) then
                begin
                    Begin
                        writeln('La fecha 1 es mas antigua');
                        mes := mes1;
                    End
                end
            else            
                Begin
                    writeln('La fecha 2 es mas antigua');
                    mes := mes2;
                End
        end;

    case mes of
        1..3: writeln('Pertenece al primer trimestre');
        4..6: writeln('Pertenece al segundo trimestre');
        7..9: writeln('Pertenece al tercer trimestre');
        10..12: writeln('Pertenece al cuarto trimestre');
    end;
end.