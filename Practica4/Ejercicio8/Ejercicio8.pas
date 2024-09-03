Program Ejercicio8;
(*Ej 8) En un archivo de texto se registraron las compras de N titulares de tarjetas de crédito de la siguiente
forma:
    - Código de Cliente y a continuación sus compras: no se sabe cuántas son, por cada una:
        • Tipo de compra: (C=combustible, S=supermercado, O=otros, F=fin de datos) 
        • Día (1..31)
        • Monto
El banco ofrece un descuento de:
    - 5% los días 10, 20 y 30 para el tipo Otros si el monto supera los $300. 
    - 10% para Combustible en la 2º quincena.
    - 15% para Supermercado en la 1º quincena.
Se pide:
    a) Código del cliente y total abonado, por cada cliente que no se benefició con ningún descuento.
    b) Cuántos clientes obtuvieron descuento en los tres rubros.
    c) Informar cuánto ahorró cada cliente.
En la solución debe desarrollar la función Descuento, que a partir del tipo de compra, día y monto
devuelva el correspondiente descuento. 

*)

function Descuento(tC:char; dias:byte; valor:real):real;
begin    
    If (tC = 'O') and ((dias = 10) Or (dias = 20) Or (dias = 30)) And (valor>300) Then
        begin
            Descuento := valor*(0.95);  
        end
    else    
        If (tC = 'C') And (dias>=15) Then
            begin
                Descuento := valor*(0.90);
            end
            
        else
            If (tC = 'S') And (dias<=15) Then
                begin
                    Descuento := valor*(0.85);
                end
            else
                Descuento:= valor;
    
end;
type
    ST10 = String[10];

var
    arch:text;
    codCliente: ST10;
    dia:byte;
    monto, montoTotal:real;
    tipoCompra,aux:char;
    descuentoActivo, descS, descC, descO:Boolean;
begin
    Assign(arch, 'datos.txt');
    reset(arch);

    while not eof(arch) do
        begin
            montoTotal:= 0;
            readln(arch, codCliente);
            
            Readln(arch, tipoCompra, dia, monto);
            tipoCompra:= upCase(tipoCompra);
            while tipoCompra <> 'F' do
            begin
                montoTotal:= montoTotal + Descuento(tipoCompra, dia, monto);

                Readln(arch, tipoCompra, dia, monto);
                tipoCompra := upCase(tipoCompra);
            end;
            
            
        end;
    close(arch);
    WriteLn(montoTotal:0:2);
end.