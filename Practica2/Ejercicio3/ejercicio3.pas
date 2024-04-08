program Ejercicio3;

(*Ej 3) Dado el siguiente fragmento de código reescribirlo en 
forma indentada eliminando redundancias y agregando carteles 
aclaratorios
    . . .
    Readln(temp);
    If temp<0 then writeln(‘No salgo de casa….’)
    Else if (temp>=0)and(temp<20) then writeln(‘Hace frio’)
    Else if (temp>=20)and(temp<25)and(temp<29) then writeln(‘Barbaro’)
    Else if(temp>=29) then writeln(´Qué calor!!’); 
    . . .
 
*)

var
    temp: integer;

begin
    writeln('Ingrese la temperatura de hoy'); //Ingresa la temperatura a ser evaluada
    Readln(temp);
    If temp < 0 then  //Verifica si hay temperaturas bajo 0
        writeln('No salgo de casa….')
    Else //Sí no es así, revisa las temperaturas menores a 20°
        if  (temp < 20) then 
            writeln('Hace frio')
        Else 
            if  (temp < 29) then //Lo mismo, pero con temperaturas menores a 29°
                    writeln('Barbaro') 
            Else 
                writeln('Qué calor!!'); //Concluye con las temperaturas mayores a 29°
         
end.