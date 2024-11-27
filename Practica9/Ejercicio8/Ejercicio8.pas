Program Ejercicio8;

(*Ej 8) La fábrica de Camperas (descripta en el ejercicio 4) debe satisfacer un pedido de un cliente, y cuenta
con la siguiente información:
    # ARTICULO (1er. campo de secuencia, clave secundaria)
    # TALLE (2do. campo de secuencia)
    # COLOR (3er. campo de secuencia)
    # CANTIDAD
        ARTICULO + TALLE + COLOR es Clave primaria
        ARTICULO + TALLE es Clave secundaria
Por cada pedido se pide actualizar el stock, en caso de no poder entregar lo posible e informar la cantidad
adeudada. *)
type
    ST15 = string[15];
    ST4 = string[4];
    TRegCam = record
        articulo:ST4;
        talle:char;
        color,cantidad:byte;
    end;
    TRegSt =   Record
        codArt:   ST4;
        talle:   char;
        color,cantPrendas:   byte;
        precio:   real;
    end;
    TArchStock = file Of TRegST;
    TArchCompra = file of TRegCam;

Procedure GrabarArchStock(Var archStock:TArchStock);
Var 
    arch:   Text;
    R:   TRegST;
    aux:   Char;
Begin
    Assign(arch,'STOCK.TXT');
    Reset(arch);
    Rewrite(archStock);
    While Not eof(arch) Do
        Begin
            ReadLn(arch,R.codArt,aux,R.talle,R.color,R.cantPrendas,R.precio);
            Write(archStock,R);
        End;
    Close(arch);
    Close(archStock);
End;
procedure GrabarArchCompra(var archCompra:TArchCompra);
var
    arch:text;
    R:TRegCam;
    aux:Char;
begin
    Assign(arch,'COMPRA.TXT');
    Reset(arch);
    Rewrite(archCompra);
    while NOT eof(arch) do
    begin
        ReadLn(arch,R.articulo,aux,R.talle,R.color,R.cantidad);
        Write(archCompra,R);
    end;
    Close(arch);
    Close(archCompra);
end;
procedure ArctualizarStock(var archCompra:TArchCompra;var archStock:TArchStock;nom:ST15);
var
    RSt:TRegSt;
    RCa:TRegCam;
    archTemp:TArchStock;
    cantAdeudada:word;
begin
    Assign(archTemp,'TEMP.DAT');
    Reset(archCompra);
    Reset(archStock);
    Rewrite(archTemp);
    read(archCompra,RCa);
    Read(archStock,RSt);
    cantAdeudada:=0;
    while (not eof(archCompra)) or (not Eof(archStock)) do
    begin
        if RSt.codArt=RCa.articulo then
        begin
            while RSt.codArt=RCa.articulo do
            begin
                if RSt.talle = RCa.talle then
                begin
                    while (RSt.codArt=RCa.articulo) and (RSt.talle=RCa.talle) do
                    begin
                        if (RSt.codArt=RCa.articulo) and (RSt.talle=RCa.talle) and (RSt.color=RCa.color) then
                        begin
                            if RSt.cantPrendas-RCa.cantidad>=0 then
                            begin
                                RSt.cantPrendas := RSt.cantPrendas-RCa.cantidad;
                                Read(archCompra,RCa);
                            end
                            else
                                cantAdeudada:=cantAdeudada+RCa.cantidad;
                        end;
                        Write(archTemp,RSt);
                        Read(archStock,RSt);
                    end;
                end
                else if RSt.talle < RCa.talle then
                    begin
                        Write(archTemp,RSt);
                        Read(archStock,RSt);
                    end
                else
                    begin
                        cantAdeudada := cantAdeudada+RCa.cantidad;
                        Read(archCompra,RCa);
                    end;

            end;
        end
        else if RSt.codArt<RCa.articulo then
        begin
            Write(archTemp,RSt);
            Read(archStock,RSt);
        end
        else
            begin
                cantAdeudada := cantAdeudada+RCa.cantidad;
                Read(archCompra,RCa);
            end;
    end;
    WriteLn('La cantidad adeudada es: ', cantAdeudada);
    Write(archTemp,RSt);
    Close(archTemp);
    close(archCompra);
    Close(archStock);
    Erase(archStock);
    Rename(archTemp,nom);
end;
procedure ArmarLista(var archStock:TArchStock);
var
    R:TRegSt;
    artActual:ST4;
    talleActual:char;
    cantPrendas:byte;
    totalPrendas:word;
    montoTotal,totalNegras:real;
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
            talleActual:=R.talle;
            while (artActual = R.codArt) and (talleActual=R.talle) do
            begin
                while (artActual = R.codArt) and (talleActual=R.talle) do
                begin
                    cantPrendas:=cantPrendas+R.cantPrendas;
                    if R.color=1 then
                        totalNegras:=totalNegras+R.cantPrendas;
                    montoTotal:=montoTotal+R.precio;
                    Read(archStock,R);    
                end;
                
            end;
            totalPrendas := totalPrendas+cantPrendas;
            WriteLn(talleActual, cantPrendas:24, '$':20,montoTotal:0:2)
        end;
        
    end;
    WriteLn('Cantidad total: ', totalPrendas);
    WriteLn('El porcentaje de prendas negras es: ',totalNegras*100/totalPrendas:0:2,'%');
    Close(archStock);
end;
var
    archStock:TArchStock;
    archCompra:TArchCompra;

begin
    Assign(archCompra,'COMPRA.DAT');
    Assign(archStock,'STOCK.DAT');
    GrabarArchStock(archStock);    
    GrabarArchCompra(archCompra);
    //ArmarLista(archStock);
    ArctualizarStock(archCompra,archStock,'STOCK.DAT');
    ArmarLista(archStock);
end.