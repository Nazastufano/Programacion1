Program EjercicioTipoParcial;

(* Una compañía Láctea recibe la producción diaria, en litros de leche de N Tambos de la zona, durante varios días.
Los datos vienen de la siguiente manera:
Nombre del Tambo y a continuación: 
    Día  de entrega (0=fin de datos)
    Entrega en litros
Se desea conocer:
a) Para cada Tambo, Nombre y el día que más litros de leche entregó.
b) Promedio total de leche por Tambo.
c) Cuántos Tambos superaron X litros en total. (X es dato ingresado por teclado).*)

var
    arch:text;
    n, diaMasLitros,diaDeEntrega, contDias, superaLitros:Byte;
    nombre:string;
    litrosASuperar, contLitros,litros,masLitros, promedio:real;

begin
    Assign(arch, 'datos.TXT');
    Reset(arch);
    ReadLn(arch, n);

    WriteLn('Ingrese la cantidad de litros a superar: ');
    ReadLn(litrosASuperar);

    while (not eof(arch)) or (not eoln(arch)) do
    begin
        contLitros := 0;
        contDias:= 0;
         
        ReadLn(arch,nombre);
        ReadLn(arch, diaDeEntrega, litros);
        masLitros := litros;
        diaMasLitros := diaDeEntrega;

        while (litros <> 0) and (not eoln(arch)) do
        begin
            contLitros:= contLitros + litros;
            contDias:= contDias + 1;
            
            if masLitros<litros then
                begin
                    masLitros:= litros;
                    diaMasLitros:= diaDeEntrega;  
                end;
            
            Read(arch, diaDeEntrega);
            if diaDeEntrega <> 0 then
                Readln(arch,litros);
        end;
        ReadLn(arch);

        if contLitros> litrosASuperar then
            superaLitros:= superaLitros + 1;
            
        WriteLn('El tambo de ', nombre, ' ha entregado mas leche el dia: ', diaMasLitros);
        promedio:= contLitros/contDias;
        WriteLn('El promedio del tambo de ', nombre, ' es de: ', promedio:0:2,'L');
    end;
    WriteLn('La cantidad de tambos que han superado los ', litrosASuperar:0:2,'L han sido: ',superaLitros );
    Close(arch);
end.