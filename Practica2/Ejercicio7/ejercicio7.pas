program Ejercicio7;

    (*Ej 7) Un negocio vende camisas, éstas pueden ser de hombre 
    o de mujer. Los talles que fabrican son: S,
M, L y X. El precio base unitario es de $1000 para hombres y 
$1200 para mujer, se debe agregar el IVA
del 21%. Hay una promoción en los talles S de hombre y X 
de mujer con un 5% de descuento. Además, si
la compra supera la docena se considera venta mayorista 
y obtiene un descuento extra del 7% del total.
Determinar cuáles son los datos necesarios para calcular 
el importe a facturar en una venta. *)

const
    precioBaseH = 1000;
    precioBaseM = 1200;
    iva = 0.21;
var

    respuesta, genero, talle: char;
    contCompra: integer;
    totalAPagar: real;

begin
    contCompra := 0;
    totalAPagar := 0;
    respuesta := 'a';

    repeat
        repeat
            writeln('La camisa deseada es de hombre = "H" o de mujer = "M": ');
            readln(genero);
            genero := UpCase(genero);
        until (genero = 'M') or (genero = 'H'); 

        repeat
            writeln('De que talle es la camisa deseada ("S", "M", "L", "X"): ');
            readln(talle);
            talle := UpCase(talle);
        until (talle = 'S') or (talle = 'M')  or (talle = 'L') or (talle = 'X'); 
        

        if (talle = 'S') and (genero = 'H') then //descuento
            totalAPagar := totalAPagar + precioBaseH - precioBaseH*0.05
        else
            if (talle = 'X') and (genero = 'M') then
                totalAPagar := totalAPagar + precioBaseM - precioBaseM*0.05
            else
                if genero = 'M' then
                    totalAPagar := totalAPagar + precioBaseH
                else
                    totalAPagar := totalAPagar + precioBaseM;

        repeat
            writeln('Desea seguir comprando? "S", "N"');
            readln(respuesta);
            respuesta := UpCase(respuesta);

            if (respuesta <> 'S') or (respuesta <> 'N') then
                writeln('Por favor, responda correctamente')
            else
                contCompra := contCompra + 1;

        until (respuesta = 'S') or (respuesta = 'N');
    until respuesta = 'N';

    if contCompra>12 then
        begin
            totalAPagar := totalAPagar - totalAPagar*0.07;
            totalAPagar := totalAPagar + totalAPagar*iva;
        end
    else
        totalAPagar := totalAPagar + totalAPagar*iva;
    writeln('El monto a pagar es: $', totalAPagar:5:2);
    readln();
    
end.