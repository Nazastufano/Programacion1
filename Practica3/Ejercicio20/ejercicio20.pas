program Ejercicio20;

(*Ej 20) Leer desde un archivo números enteros, calcular y escribir el promedio de los elementos positivos y
distintos de cero que se encuentran entre dos negativos no consecutivos.
Ejemplos:
    -7 6 -1 0 2 4 -8 -7 3 1 -24 6 7 0 9 -> debe escribir : 6 3 2
    7 6 -1 0 2 4 -8 -7 3 1 -24 6 7 0 9 -8 -> debe escribir : 3 2 7.33 *)

uses
    SysUtils;

var
    arch: text;
    contNumeros, numero, sumaNumeros: integer;
    cadenaNum, promedioST:string;
    promedio: real;

begin
    assign(arch, 'datos.TXT');
    reset(arch);

    cadenaNum := '';

    repeat
        read(arch, numero);    
    until (numero < 0);
    
    while (not eof(arch)) do
        begin
            repeat
                if numero<0 then
                    begin
                        contNumeros := 0;
                        sumaNumeros := 0;    
                    end;

                if numero = 0 then
                    read(arch, numero); 

                read(arch, numero);
            until (numero >= 0);

            while (numero >= 0) and (not eoln(arch)) do
                begin
                    if numero<>0 then
                        begin
                            contNumeros := contNumeros + 1;
                            sumaNumeros := sumaNumeros + numero;
                            read(arch, numero);         
                        end;
                    if numero = 0 then
                        read(arch, numero);   
                end;
            
            if (not eoln(arch)) or (numero<0) then
                begin
                    promedio := (sumaNumeros/contNumeros);
                    promedioST := FloatToStr(promedio);
                    cadenaNum := cadenaNum + ' ' + promedioST;
                end;
                
        end;
    close(arch);
    writeln('El promedio de los elementos positivos y distintos de cero que se encuentran entre dos negativos no consecutivos es: ', cadenaNum);
end.