Program Ejercicio4;

(*Ej 4) Una fábrica de camperas tiene organizado su stock de la siguiente manera en un archivo de tipo:
    # CODIGO de ARTICULO (cadena de 4) (1er. campo de secuencia, clave secundaria)
    # TALLE ( S, M, L, X) (2do. campo de secuencia, clave secundaria)
    # COLOR (1=Negro, 2=Marrón, 3=Azul, 4=Rojo) (3er. campo de secuencia, clave secundaria)
    # CANTIDAD de PRENDAS
    # PRECIO de COSTO
       Clave primaria: CODIGO de ARTICULO + TALLE + COLOR
Se desea obtener el siguiente listado:
                                Stock de Prendas
        Código: XXXX
            Talle               Cantidad                Precio Costo
            X                   999                     $ 99999.99
            . . . . . . . . .
        Código: XXXX
        . . .
        Cantidad Total: 9999
        Porcentaje de Prendas Negras: 99.99 % *)
Type
    ST4 = String[4];
    TReg = record
        codArt:ST4;
        talle:char;
        color,cantPrendas:byte;
        precio:real;
    end;
    TArchStock = file of Treg;
procedure GrabarArchStock(var archStock:TArchStock);
var 
    arch:Text;
    R:TReg;
    aux:Char;
begin
    Assign(arch,'STOCK.TXT');
    Reset(arch);
    Rewrite(archStock);
    while Not eof(arch) do
    begin
        ReadLn(arch,R.codArt,aux,R.talle,R.color,R.cantPrendas,R.precio);
        Write(archStock,R);
    end;
    Close(arch);
    Close(archStock);
end;
procedure ArmarLista(var archStock:TArchStock);
var
    R:TReg;
    artActual:ST4;
    talleActual:char;
    cantPrendas,cantColorNegro,totalNegras,totalPrendas,colorActual:byte;
    montoTotal:real;
begin
    Reset(archStock);
    WriteLn('                        Stock de Prendas');
    Read(archStock,R);
    totalNegras:=0;
    totalPrendas:=0;
    while Not Eof(archStock) do
    begin
        WriteLn('Codigo: ',R.codArt);
        artActual:=R.codArt;
        while artActual=R.codArt do
        begin
            WriteLn('Talle               Cantidad                Precio Costo');
            montoTotal:=0;
            cantPrendas:=0;
            totalNegras:=0;
            talleActual:=R.talle;
            while (artActual = R.codArt) and (talleActual=R.talle) do
            begin
                colorActual:=R.color;
                cantPrendas:=0;
                while (artActual = R.codArt) and (talleActual=R.talle) and (colorActual=R.color) do
                begin
                    cantPrendas:=cantPrendas+R.cantPrendas;
                    if R.color=1 then
                        totalNegras:=totalNegras+1;
                    montoTotal:=montoTotal+R.precio;
                    Read(archStock,R);
                end;
            end;
            WriteLn(talleActual, cantPrendas:24, '$':20,montoTotal:0:2)
        end;
        totalPrendas:=totalPrendas+cantPrendas;
    end;
    WriteLn('Cantidad total: ', totalPrendas);
    WriteLn('El porcentaje de prendas negras es: ',totalNegras*100/totalPrendas:0:2,'%');
    Close(archStock);
end;
var
    archStock:TArchStock;
begin
    Assign(archStock,'STOCK.DAT');
    GrabarArchStock(archStock);
    ArmarLista(archStock);
end.