Program Ejercicio11;

    (*Ej 11) Dado un día (entre 1 y 31) y suponiendo que el día 1 es Lunes, determinar a qué día de la semana
corresponde el número ingresado. *)

var
    dia: integer;
begin

    repeat
        writeln('Ingrese un dia entre 1 y 31');
        readln(dia);
        
        if (dia < 1) or (dia > 31) then
            writeln('Ingrese un dia valido');
    until (dia in [1..31]);
 
    case dia of
        1, 8, 15, 22, 29: writeln('El dia ingresado es Lunes');
        2, 9, 16, 23, 30: writeln('El dia ingresado es Martes');
        3, 10, 17, 24, 31: writeln('El dia ingresado es Miercoles');
        4, 11, 18, 25: writeln('El dia ingresado es Jueves');
        5, 12, 19, 26: writeln('El dia ingresado es Viernes');
        6, 13, 20, 27: writeln('El dia ingresado es Sabado');
        7, 14, 21, 28: writeln('El dia ingresado es Domingo');
    end;

end.