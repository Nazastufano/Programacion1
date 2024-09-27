program Ejercicio17;

(*Ej 17) La cajera de un supermercado ha registrado varias ventas, de cada una sabe:
    Nombre del cliente ( “ ***** “ indica fin de datos )
    Cantidad de artículos que compró el cliente y por cada uno se conoce:
- Precio base del artículo
- Si está o no en promoción ( ‘S’ ó ‘N’ )
En el caso de estar en promoción, se realiza un descuento del 10% sobre el precio base.
Se pide ingresar los datos e informar:
a) Monto total de cada venta, el total del descuento y el precio final a pagar.
b) Nombre del cliente que compró la mayor cantidad de artículos en oferta.
c) Cuántos clientes compraron solo artículos en oferta. *)

const 
    desc = 0.1;
    
var
    cliente, nombreMayCantArtOfer: string[10];
    contCliSoloOfer, articulos, contArticulosOferta, mayCantArtOferta: word;
    descuento: char;
    soloOferta: boolean;
    totalDescuento, totalAPagar, precio, montoTotal: real;
    i:byte;

begin
    writeln('Ingrese el nombre del cliente: ');
    readln(cliente);
    contCliSoloOfer:=0;
    while cliente <> '*****' do
        begin
            contArticulosOferta := 0;
            soloOferta := true;
            
            writeln('Cuantos articulos compro: ');
            readln(articulos);
            
            for i := 1 to articulos do
                begin
                    repeat
                        writeln('Ingrese el precio del articulo: ');
                        readln(precio);
                    until (precio>0);
                    
                    repeat
                        writeln('El articulo esta en descuento? ');
                        readln(descuento);
                        descuento := UpCase(descuento);
                    until ((descuento = 'S') or (descuento = 'N'));

                    if descuento = 'S' then
                        begin
                            totalDescuento := totalDescuento + (precio*desc);
                            montoTotal := montoTotal + precio;
                            contArticulosOferta := contArticulosOferta +1;
                        end
                    else
                        begin
                            soloOferta := false;
                            montoTotal := montoTotal + precio;                            
                        end;
                end;
            
            totalAPagar := montoTotal - totalDescuento;
            
            if soloOferta then
                contCliSoloOfer := contCliSoloOfer +1;

            if mayCantArtOferta<contArticulosOferta then
                begin
                    mayCantArtOferta := contArticulosOferta;
                    nombreMayCantArtOfer:= cliente;
                end;

            writeln('El monto total de la vente es: ', montoTotal:0:2, '. El descuento aplicado es: ', totalDescuento:0:2, '. El total a pagar es: ', totalAPagar:0:2);

            writeln('Ingrese el nombre del cliente: ("*****" para fin de datos)');
            readln(cliente);
        end;
    writeln('El cliente que mas articulos en oferta compro es: ', nombreMayCantArtOfer);
    writeln('La cantidad de clientes que compraron unicamente en oferta son: ', contCliSoloOfer);
end.