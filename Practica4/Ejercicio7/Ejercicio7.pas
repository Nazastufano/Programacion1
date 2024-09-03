program Ejercicio7;

(*Ej 7) Un estudio contable registró la facturación de varios comercios en los últimos N meses, por cada uno
se tiene:
    Nombre
    Tipo (S/N) si es Responsable Inscripto o No, y luego por cada uno de los N meses:
        - Importe facturado mensual sin IVA
Se desea saber:
a) Listar Nombre, tipo y cuánto pagó de IVA en los N meses.
b) El nombre del comercio Responsable Inscripto que menos facturó en total. 

Desarrollar la función Impuesto con los parámetros necesarios de modo tal que
devuelva el monto de IVA que debe pagar. Sabiendo que si es Responsable Inscripto, 
corresponde el 21% de la compra, si no lo es, el 21%+10%.
*)

function Impuesto(RI:char; monto:real):real;
begin
    if RI = 'S' then
        Impuesto := monto*0.21
    else
        Impuesto := monto*0.31;
end;


var
    meses,i: byte;
    nombre, nombreMenosFactura: String[15];
    tipo, resp:char;
    importe,sumaIVA, menosFactura, montoTotal:real;

begin
    menosFactura:= 340000000;
    repeat
        WriteLn('Cuantos meses se han registrado?');
        ReadLn(meses);
    until (meses>0);
    

    while resp <> 'N' do
        begin
            sumaIVA:= 0;
            montoTotal:= 0;
            WriteLn('Ingrese el nombre del comercio');
            ReadLn(nombre);   

            repeat
                WriteLn('Es responsable Inscripto? (S/N)');
                ReadLn(tipo);
                tipo:= upcase(tipo);
            until (tipo = 'S') or (tipo = 'N');
            
            For i:=1 To meses Do
                begin
                    WriteLn('Ingrese el importe del mes: ', i);
                    ReadLn(importe);
                    sumaIVA:= Impuesto(tipo, importe) + sumaIVA;
                    montoTotal:= montoTotal + importe + Impuesto(tipo, importe);
                end;
            
            if menosFactura> montoTotal then
                begin
                    menosFactura:= montoTotal;
                    nombreMenosFactura:= nombre;
                end;
            
            if tipo = 'S' then
                WriteLn('El comercio: ', nombre, '. Responsable inscripto. Ha pagado: $', sumaIVA:0:2, ' en iva')
            else
                WriteLn('El comercio: ', nombre, '. No es Responsable inscripto. Ha pagado: $', sumaIVA:0:2, ' en iva');

            
            repeat
                WriteLn('Desea seguir ingresando nombres? (S/N)');
                ReadLn(resp);
                resp:= upcase(resp);
            until (resp = 'S') or (resp = 'N');
        end;
    WriteLn('El comercio que menos ha facturado es: ', nombreMenosFactura, ' Con un monto de: $', menosFactura:0:2);
end.