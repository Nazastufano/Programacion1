program Ejercicio1;
    (*Ej 1) Informar si un caracter ingresado es letra minúscula,
mayúscula u otro cualquiera.*)

var
    caracter: char;
    
begin
    writeln('Ingrese un caracter');
    readln(caracter);

    case caracter of
        'a'..'z': writeln('El caracter ingresado es una minuscula');        
        'A'..'Z': writeln('El caracter ingresado es una mayuscula');
        else
            writeln('El caracter ingresado es otro cualquiera');
    end;    

    readln();
end.