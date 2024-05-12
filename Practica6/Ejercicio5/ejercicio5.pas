program Ejercicio5;

(*Ej 5) Una Tarjeta de Crédito tiene información de las compras de sus N 
clientes en un archivo y en cada línea se almacenó:
    Número de cliente (puede repetirse)
    Tipo de compras (1=Supermercado, 2=Combustible, 3=Indumentaria, 4=Otros)
    Monto de la compra.
Nota: Un cliente puede registrar más de una compra del mismo tipo.

Leer los datos en un arreglo NroCli paralelo a la matriz acumulativa 
Compras de Nx4 donde la 1º columna corresponde a la compra en Supermercado,
la 2º a Combustible, la 3º a Indumentaria y la 4º a Otros. 
Calcular e Informar:
    a) Total de compras en cada rubro.
    b) Listado con los clientes en los cuales el monto en Supermercado superó a Indumentaria
    c) Promedio de compra por cliente. 
    d) Número de cliente que más consumió.
    e) Cuántos clientes no registraron compras en algún rubro. *)

const
    N=4;

type
    TVNom = array[1..N] of string;
    TM = array[1..N,1..4] of integer;
    TV = array[1..4] of integer;

var 
    NroCli:TVNom;
    NroDeCompras: TV;
    Compras:TM;
    
function EstaNombre(vecNom: TVNom;nom:string):byte;
var
    pos,i:byte;
begin
    pos:=0;
    for i := 1 to N do
        begin
            if vecNom[i] = nom then
                pos:= i;    
        end;

    EstaNombre:= pos;
end;

procedure MostrarMatriz(var matr: TM);
    var
        i,j:integer;
    begin
        write('|');
        for i := 1 to 4 do
            write(i:4, '|');   
        writeln();
        for i := 1 to N do
            begin
                write('|');
                for j := 1 to 4 do
                begin
                    write(matr[i,j]:4, '|');
                end;
                writeln();
            end;
    end;
//a))
procedure MostrarCompras(vec:TV); //Genera el arreglo con las compras
    var
        i:integer;
    begin
        writeln('(1=Supermercado, 2=Combustible, 3=Indumentaria, 4=Otros)');
        for i := 1 to 4 do
            begin
                if i=1 then
                    write('(');

                if (i<>N) then
                    write(vec[i], ', ')
                else
                    begin
                        write(vec[i], ')');      
                    end;
            end;
    end;

procedure MostrarNombres(vec:TVNom; largo:byte);
    var
        i:integer;
    begin
        for i := 1 to largo do
            begin
                if i=1 then
                    write('(');

                if (i<>largo) then
                    write(vec[i], ', ')
                else
                    begin
                        write(vec[i], ')');      
                    end;
            end;
end;

//b) Listado con los clientes en los cuales el monto en 
//Supermercado superó a Indumentaria
procedure SuperaIndu(vec:TVNom; matr:TM);
var
    vecNombres: TVNom;
    i,posicion: byte;
begin
    posicion:= 0;
    for i := 1 to N do
        if matr[i,1] > matr[i,3] then
            begin
                posicion:= posicion +1;
                vecNombres[posicion]:= vec[i];
            end;
    
    MostrarNombres(vecNombres, posicion);
end;
//c)
procedure CalcularPromedio(vec:TVNom; matr:TM);
var
    i,j, contCompras:byte;
    total: word;

begin
    for i := 1 to N do
        begin
            contCompras:=0;
            total:= 0;

            for j := 1 to 4 do
                begin
                    if matr[i,j]<>0 then
                        begin
                            contCompras:= contCompras +1;
                            total := total + matr[i,j];
                        end;
                end;
            if contCompras<>0 then
                begin
                    writeln('El promedio de compras del cliente: ', vec[i], ' es de: ', (total/contCompras):0:2);
                end;
        end;
end;
//d)
procedure MasConsumo(vec:TVNom;matr:TM);
var
    i,j:byte;
    nombreMasGasta: string;
    masGasta,total:word;
begin
    nombreMasGasta:= vec[1];
    for i := 1 to N do
        begin
            total:=0;
            for j := 1 to 4 do
                begin
                    total:= total + matr[i,j];    
                end;

            if i=1 then
                masGasta:= total;

            if total>masGasta then
                begin
                    nombreMasGasta:= vec[i];    
                    masGasta:= total;
                end;
                
        end;
    writeln('El cliente que mas gasta es: ', nombreMasGasta);
end;

//e)
procedure noRegistranCompras(vec:TVNom;matr:TM);
var
    i,j, contCeros:byte;
    noCompra:boolean;
begin
    contCeros:=0;
    for i := 1 to N do
        begin
            noCompra:=false;
            for j := 1 to 4 do
                begin
                    if matr[i,j]=0 then
                        begin
                            noCompra:=true;
                        end;
                end;
            
            if noCompra then
                contCeros:= contCeros +1;
        end;
    

    writeln('La cantidad de clientes que no registraron compras es de: ',contCeros);
end;

procedure LlenarMatricez(var vec:TVNom; var matr:TM; var vecCom: TV);
var
    arch:text;
    aux:char;
    nombre:string;
    posicion,tipoCompra,contClientes: byte;
    precio:word;

begin
    assign(arch, 'datos.TXT');
    reset(arch);

    contClientes := 0;

    while not eof(arch) do
    begin
        nombre:= '';
        read(arch, aux);

        while (aux <> ' ') do
        begin
            nombre:= nombre + aux;
            read(arch, aux);
        end;

        read(arch, tipoCompra, precio);

        posicion:= EstaNombre(vec, nombre);
        
        vecCom[tipoCompra] := vecCom[tipoCompra] + 1;

        if posicion <> 0 then
            matr[posicion, tipoCompra]:= matr[posicion, tipoCompra] + precio
        else
            begin
                contClientes := contClientes + 1;
                vec[contClientes]:= nombre;
                matr[contClientes, tipoCompra]:= precio;
            end;

        readln(arch);
    end;
end;

begin
    LlenarMatricez(NroCli, Compras, NroDeCompras);

    MostrarMatriz(Compras);
    
    writeln();
    MostrarCompras(NroDeCompras);

    writeln();
    SuperaIndu(NroCli,Compras);

    writeln();
    CalcularPromedio(NroCli,Compras);
    
    writeln();
    MasConsumo(NroCli,Compras);

    writeln();
    noRegistranCompras(NroCli,Compras);
end.