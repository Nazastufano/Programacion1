Program Ejercicio18;

(*Ej 18) Reescribir el ejercicio 17, considerando que los datos están grabados en un archivo (con el formato
que considere más adecuado).*)


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

Const 
    desc =   0.1;

Var 
    arch:   text;
    i,cantArt,contArtOfert, maxCantArtOfert,contSoloOferta:   byte;
    nombre, nombreMasOfertas:   String[15];
    promo:   char;
    precio, precioBaseTotal, descTotal, precioFinal:   real;
    soloOferta:   Boolean;

Begin
    Assign(arch, 'datos.TXT');
    reset(arch);

    maxCantArtOfert := 0;
    contSoloOferta := 0;

    ReadLn(arch, nombre);
    While Not eof(arch) Do
        Begin
            While nombre <> '*****' Do
                Begin
                    precioBaseTotal := 0;
                    descTotal := 0;
                    precioFinal := 0;                    
                    contArtOfert := 0;
                    soloOferta := true;

                    ReadLn(arch, cantArt);
                    For i:= 1 To cantArt Do
                        Begin
                            readln(arch, precio, promo, promo);
                            promo := upCase(promo);

                            precioBaseTotal := precioBaseTotal + precio;

                            If promo = 'S' Then
                                Begin
                                    contArtOfert := contArtOfert +1;
                                    descTotal := precio*desc;
                                    precio := precio*(1-desc);
                                End
                            Else
                                soloOferta := false;

                            precioFinal := precioFinal + precio;

                        End;
                    
                    If maxCantArtOfert< contArtOfert Then
                        Begin
                            maxCantArtOfert := contArtOfert;
                            nombreMasOfertas := nombre;
                        End;
                    If soloOferta Then
                        contSoloOferta := contSoloOferta + 1;

                    WriteLn('El cliente: ', nombre, '. Monto total: ', precioBaseTotal:0:2,'. Total descuento: ', descTotal :0:2,'. Total a pagar: ', precioFinal:0:2);
                    ReadLn(arch, nombre);
                End;
            ReadLn(arch, nombre);
        End;
    close(arch);
    WriteLn('El nombre del cliente con mayor cantidad de articulos en oferta es: ', nombreMasOfertas);
    WriteLn('La cantidad de clientes que solo compraron en oferta es: ',contSoloOferta);
End.