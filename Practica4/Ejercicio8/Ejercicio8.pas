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
        Descuento := valor*(0.95)
    else    
        If (tC = 'C') And (dias>=15) Then
            Descuento := valor*(0.90)
        else
            If (tC = 'S') And (dias<=15) Then
                Descuento := valor*(0.85)                
            else
                Descuento:= valor;
end;

function Ahorrado(tC:char; dias:byte; valor:real):real;
begin    
    If (tC = 'O') and ((dias = 10) Or (dias = 20) Or (dias = 30)) And (valor>300) Then
        Ahorrado := valor*(0.5)
    else    
        If (tC = 'C') And (dias>=15) Then
            Ahorrado := valor*(0.10)
        else
            If (tC = 'S') And (dias<=15) Then
                Ahorrado := valor*(0.15)                
            else
                Ahorrado:= 0;
end;


type
    ST10 = String[10];

var
    arch:text;
    codCliente: ST10;
    dia, contCliSinDesc:byte;
    monto, montoTotal, ahorro:real;
    tipoCompra:char;
    descS, descC, descO:   Boolean;

begin
    Assign(arch, 'datos.txt');
    reset(arch);
    contCliSinDesc:= 0;
    while not eof(arch) do
        begin
            descS := false;
            descC := false;
            descO := false;

            ahorro:= 0;
            montoTotal:= 0;

            readln(arch, codCliente);
            
            Read(arch, tipoCompra);
            tipoCompra:= upCase(tipoCompra);
            while tipoCompra <> 'F' do
            begin
                readln(arch, dia, monto);
                montoTotal:= montoTotal + Descuento(tipoCompra, dia, monto);
                ahorro:= ahorro + Ahorrado(tipoCompra, dia, monto);
                
                If (tipoCompra = 'O') and ((dia = 10) Or (dia = 20) Or (dia = 30)) And (monto>300) Then
                    descO := true;
                If (tipoCompra = 'C') And (dia>=15) Then
                    descC := true;
                If (tipoCompra = 'S') And (dia<=15) Then
                    descS := true;   
                
                Read(arch, tipoCompra);
                tipoCompra := upCase(tipoCompra);
            end;
            if tipoCompra = 'F' then
                ReadLn(arch);
            
            WriteLn('El cliente: ',codCliente, '. Ha ahorrado: $', ahorro:0:2);

            If (descO= false) And (descC = false) And (descS = false) Then
                WriteLn('El cliente: ', codCliente, '. Ha gastado: $', montoTotal:0:2);    
                            
            if descO and descS and descC then
                contCliSinDesc:= contCliSinDesc +1;
            
        end;
    close(arch);
    WriteLn('La cantidad de clientes que obtuvieron desceuento en los 3 rubros son: ', contCliSinDesc);
end.