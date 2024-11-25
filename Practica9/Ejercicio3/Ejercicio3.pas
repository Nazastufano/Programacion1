Program Ejercicio3;

(*Ej 3) Una empresa de turismo ofrece a sus clientes distintas excursiones a los distintos puntos de interés
de la ciudad (paseo a las Sierras, a la Laguna, City Tour, viaje en barco, etc.):
    # CODIGO de EXCURSIÓN (cadena de 3, no hay más de 50)
    # DESCRIPCION (cadena de 15)
    # PRECIO BASE
    # PRECIO de la COMIDA
Por otro lado se tiene un archivo BOLETERIA.DAT con el registro de los boletos vendidos con los
siguientes datos:
    # CODIGO de EXCURSION (cadena de 3, campo de secuencia, clave secundaria)
    # NRO de BOLETO
    # INCLUYE COMIDA (S/N)
Se desea realizar el siguiente listado:
    Excursión    Cantidad de Boletos     Cantidad de Comida      Monto Total
    xxxxxxxxxxxx          99                       99             $9999.99
    . . . . . . . . . . . .
    % de turistas que contrataron excursión con comida: 99.99% *)
type
    ST3 = string[3];
    ST15 = string[15];
    TRegExc = record
        codExcursion:ST3;
        descripcion:ST15;
        precioBase,precioComida:real;
    end;
    TRegBol = record
        codExcursion:ST3;
        nroBoleto:word;
        incluyeCom:char;
    end;
    TArchBoleteria = file of TRegBol;
    TVExc = array[1..50] of TRegExc;
procedure ArmarVecRegistro(var vecExcu:TVExc);
var
    i:byte;
    arch:text;
    R:TRegExc;
    aux:char;
begin
    Assign(arch,'EXCURSIONES.TXT');
    reset(arch);
    i:=0;
    while not eof(arch) do
    begin
        Readln(arch, R.codExcursion, aux, R.descripcion, R.precioBase, R.precioComida);
        i:=i+1;
        vecExcu[i]:=R;
    end;
    Close(arch);
end;
function Busqueda(vecExcu:TVExc;cod:ST3):Byte;
var
    i:byte;
begin
    i:=1;
    while vecExcu[i].codExcursion <> cod do
        i:=i+1;
    Busqueda:=i;
end;
procedure GrabarArchBoleteria(var archBoleteria:TArchBoleteria);
var
    arch:text;
    R:TRegBol;
    aux:char;
begin
    Assign(arch,'BOLETERIA.TXT');
    Reset(arch);
    Rewrite(archBoleteria);
    while not eof(arch) do
    begin
        ReadLn(arch, R.codExcursion, R.nroBoleto, aux, R.incluyeCom);
        Write(archBoleteria, R);
    end;
    Close(arch);
    Close(archBoleteria);
end;
procedure ArmarLista(Var archBoleteria:TArchBoleteria;vecExcu:TVExc);
var
    R:TRegBol;
    pos,cantBoletos,cantComida,totalConComida,totalBoletos:byte;
    montoTotal:real;
    codExcActual:ST3;
begin
    Reset(archBoleteria);
    Read(archBoleteria,R);
    Writeln('Excursion    Cantidad de Boletos     Cantidad de Comida      Monto Total');
    totalBoletos:=0;
    totalConComida:=0;
    while not eof(archBoleteria) do
    begin
        cantBoletos:=0; 
        cantComida:=0;
        montoTotal:=0;
        codExcActual:=R.codExcursion;
        pos:=Busqueda(vecExcu,codExcActual);
        while codExcActual=R.codExcursion do
        begin
            cantBoletos:=cantBoletos+1;
            if R.incluyeCom='S' then
                begin
                    cantComida := cantComida+1;
                    montoTotal:=montoTotal+vecExcu[pos].precioComida;
                end;
            montoTotal:=montoTotal+vecExcu[pos].precioBase;
            Read(archBoleteria,R);
        end;
        totalBoletos:=totalBoletos+cantBoletos;
        totalConComida:=totalConComida+cantComida;
        Writeln(vecExcu[pos].descripcion,' ', cantBoletos:10, ' ', cantComida:20,'               $', montoTotal:0:2);
    end;
    if cantBoletos<>0 then
        WriteLn('% de turistas que contrataron excursion con comida: ', totalConComida*100/totalBoletos:0:2,'%');
    Close(archBoleteria);
end;
var
    archBoleteria: TArchBoleteria;
    vecExcu:TVExc;

begin
    Assign(archBoleteria,'BOLETERIA.DAT');
    ArmarVecRegistro(vecExcu);
    GrabarArchBoleteria(archBoleteria);
    ArmarLista(archBoleteria,vecExcu);
end.