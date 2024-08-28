program Ejercicio23;

(*Ej 23) Un archivo contiene palabras (letras mayúsculas, minúsculas, dígitos, caracteres especiales)
separadas entre sí por uno o más blancos. Se debe verificar para cada una si se trata de una contraseña
válida, y en ese caso grabarla en un archivo de salida. Indicar al final del proceso el porcentaje de
palabras que no son contraseñas válidas y mostrar la contraseña inválida más larga (puede no existir).
    Una contraseña válida debe:
 estar conformada como mínimo por 8 caracteres,
 incluir obligatoriamente, al menos una letra mayúscula y al menos una minúscula
 incluir exactamente cuatro dígitos.
 no contener caracteres diferentes de letras y digitos. 
 
Ejemplo:
eR68G12a  91jY643ebjp    eRty74kLh   24fG92   aj85gT32  eL8j$8215 dGb9357jKoup

La salida del programa sería:
El % de contraseñas inválidas es 57.14
La longitud de la contraseña inválida más larga es de 11 caracteres 

*)
var
    palabra, palabraMasLarga:string;
    archSalida, archEntrada:text;
    caracter:char;
    contContras, contContrasInvalidas, contCaracteres, cantNumer:byte;
    minus, mayus, caracEspeciales: boolean;
begin
    Assign(archEntrada, 'datos.TXT');
    Assign(archSalida, 'salida.TXT');
    Reset(archEntrada);
    Rewrite(archSalida);

    contContrasInvalidas:= 0;
    contContras := 0;
    palabraMasLarga := '';

    while not eof(archEntrada) do
        begin
            palabra := '';
            contContras := contContras + 1;
            cantNumer := 0;
            contCaracteres := 0;
            mayus:= false;
            minus:= false;
            caracEspeciales := false;

            Repeat
                Read(archEntrada, caracter);
            Until (caracter <> ' ') Or (Eoln(archEntrada)) Or (Eof(archEntrada));

            while (caracter <> ' ') and (not Eof(archEntrada)) and (not eoln(archEntrada)) do
                begin
                    Case caracter Of 
                        'A'..'Z':   mayus := true;
                        'a'..'z':   minus := true;
                        '0'..'9':   cantNumer := cantNumer + 1;
                        Else
                            caracEspeciales := true;
                    End;

                    palabra := palabra + caracter;
                    contCaracteres := contCaracteres + 1;
                    read(archEntrada, caracter);
                end;

            If (contCaracteres >= 8) and (minus = true) and (mayus = true) and (cantNumer = 4) And (caracEspeciales = false) Then
                WriteLn(archSalida, palabra)
            Else
                Begin
                    contContrasInvalidas := contContrasInvalidas + 1;
                    If (Length(palabraMasLarga) < Length(palabra))  Then
                        palabraMasLarga := palabra;
                End;
        end;
    Close(archSalida);
    Close(archEntrada);
    WriteLn('El % de contraseñas invalidas es ', (contContrasInvalidas*100/contContras):0:2, '%');

    if palabraMasLarga <> '' then    
        WriteLn('La longitud de la contraseña inválida más larga es de ', Length(palabraMasLarga),' caracteres. Y la palabra es: ', palabraMasLarga)
    else
        WriteLn('No hay contraseñas invalidas');
end.