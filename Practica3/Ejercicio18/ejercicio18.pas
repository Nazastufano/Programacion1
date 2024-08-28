program Ejercicio18;

(*Ej 18) Reescribir el ejercicio 17, considerando que los datos están grabados en un archivo (con el formato
que considere más adecuado). *)

const 
    desc = 0.1;

var
    arch:text;
    mayCantArtOferta, contCliSoloOfer, contArticulosOferta: word;
    descuento, aux: char;
    cliente, nombreMayCantArtOfer: string;
    totalDescuento, precio, montoTotal, totalAPagar: real;
    soloOferta: boolean;

begin
    assign(arch, 'datos.TXT');
    reset(arch);

    contArticulosOferta := 0;
    mayCantArtOferta := 0;
    soloOferta := true;

    read(arch, cliente);
    while (not eof(arch) ) do
        begin
            read(arch, precio, aux, descuento);
            
            repeat
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
                totalAPagar := montoTotal - totalDescuento;
                read(arch, precio, aux, descuento); 
            until (precio = 0);

            if mayCantArtOferta < contArticulosOferta then
                begin
                    mayCantArtOferta := contArticulosOferta;
                    nombreMayCantArtOfer := cliente;
                end;
        
            readln(arch, cliente);

            if cliente = '*****' then
                begin
                    if soloOferta then
                        contCliSoloOfer := contCliSoloOfer + 1;
                    
                    writeln('El monto total de la vente es: ', montoTotal:0:2, '. El descuento aplicado es: ', totalDescuento:0:2, '. El total a pagar es: ', totalAPagar:0:2);
                    
                    soloOferta := true;
                    totalAPagar := 0;
                    totalDescuento := 0;
                    montoTotal:= 0;
                    contArticulosOferta := 0;

                    read(arch, cliente);
                end;
        end; 
    close(arch);
    writeln('El cliente que mas articulos en oferta compro es: ', nombreMayCantArtOfer);
    writeln('La cantidad de clientes que compraron unicamente en oferta son: ', contCliSoloOfer);
end.