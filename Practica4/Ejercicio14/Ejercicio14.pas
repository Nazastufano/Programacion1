Program Ejercicio14;

(*Ej 14) Modificar el código del ejemplo 8, dado en la teoría, para que el procedimiento Evalua(), devuelva
además, la cantidad de palabras más largas y el programa muestre además, dicho resultado.
Considerar que cada palabra finaliza con punto y vienen en líneas diferentes *)

{Ej 8. Dado un archivo de texto que contiene palabras separadas por uno o más blancos
terminando con un punto. Se pide leerlo e informar la/s palabra/s más larga/s y su longitud.
Ejemplo:
www dd aaa tttt fff ssss dddd.
Escribe:
 estas son las palabras mas largas
 tttt ssss dddd
 tienen 4 caracteres 
}

Type
    St20=string[20];

Procedure Evalua(Var Todas: String; Var Max, contPalMasLargas: byte);

Var 
    Arch:   Text;
    Car:   char;
    Pal:   St20;
    i:   byte;
Begin
    Assign (Arch, 'texto.txt');
    Reset(Arch);
    Max := 0;
    contPalMasLargas := 0;
    While not eof(arch) Do
            Begin { es el comienzo de palabra}
                Pal := '';
                i := 0;
                Read(arch, car);
                While (Car <> '.') Do
                    Begin {cuenta los caracteres y arma la palabra}
                        i := i+1;
                        Pal := Pal + Car;
                        Read(Arch, Car);
                    End;

                
                If i>Max Then {evalua si es mas larga}
                    Begin
                        Todas := Pal;
                        Max := i;
                        
                    End
                Else
                    If i = Max Then {evalua si es igual}
                        begin
                            contPalMasLargas := contPalMasLargas + 1;
                            Todas := Todas + ' ' + Pal;
                        end;
                
                Readln(arch);
            End;
        Close(Arch);
    End;
Var 
    Todas:   string;
    Max, contPalMasLargas :   byte;
Begin
    Evalua(Todas, max, contPalMasLargas);
    Writeln ('estas son las palabras mas largas') ;
    writeln (Todas);
    Writeln ('Tienen ', Max, ' caracteres') ;
    WriteLn('La cantidad de palabras mas largas es: ', contPalMasLargas);
    Readln;
End.
