Program Ejercicio11;

    (*Ej 11) Dado un día (entre 1 y 31) y suponiendo que el día 1 es Lunes, determinar a qué día de la semana
corresponde el número ingresado. *)

var
    dia: byte;
begin

    repeat
        writeln('Ingrese un dia entre 1 y 31');
        readln(dia);
        
        if (dia < 1) or (dia > 31) then
            writeln('Ingrese un dia valido');
    until (dia in [1..31]);
    
    dia := dia mod 7;

    Case dia Of 
        0:   writeln('El dia ingresado es Domingo');
        1:   writeln('El dia ingresado es Lunes');
        2:   writeln('El dia ingresado es Martes');
        3:   writeln('El dia ingresado es Miercoles');
        4:   writeln('El dia ingresado es Jueves');
        5:   writeln('El dia ingresado es Viernes');
        6:   writeln('El dia ingresado es Sabado');
    End;
end.