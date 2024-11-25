Program Ejercicio1;

(*Ej 1) Una empresa de transporte de encomiendas tiene un registro de los paquetes a transportar en un
archivo PAQUETES.DAT, de cada uno se conoce:
    # CODIGO de PAQUETE
    # PESO
    # CODIGO de DESTINO (1..30)
    # MONTO ASEGURADO
Por otro lado se cuenta con un archivo DESTINO.DAT que contiene:
    # CODIGO de DESTINO (1..30, desordenado)
    # DESCRIPCION (cadena de 15)
Se desea saber:
    a) El peso promedio de los paquetes.
    b) Total del monto asegurado de la carga a transportar.
    c) Al finalizar el proceso armar el siguiente listado:
    
        Destino             Cantidad de Paquetes
        Xxxxxxxxxxxxxxxx            99
        . . . . . .
        TOTAL                       99 *)
type    
    ST15 = string[15];
    TRegPaq = record
        codPaq:word;
        peso, monto:real;
        codDestino:byte;
    end;
    TRegDes = record
        codDestino:byte;
        descripcion: ST15;
    end;
    TArchPaq = File of TRegPaq;
    TArchDes = File of TRegDes;
    TV = array[1..30] of byte;

procedure InicializarVec(var cantPaquetes:TV);
var
    i:Byte;
begin
    for i:=1 to 30 do
        cantPaquetes[i]:=0;
end;
procedure GrabaArchPaq(var archPaq:TArchPaq;var cantPaquetes:TV);
var
    R:TRegPaq;
    arch:text;
begin
    Assign(arch,'PAQUETES.TXT');
    Reset(arch);
    Rewrite(archPaq);
    InicializarVec(cantPaquetes);
    while not eof(arch) do
    begin
        ReadLn(arch,R.codPaq,R.peso,R.codDestino,R.monto);
        cantPaquetes[R.codDestino]:=cantPaquetes[R.codDestino]+1;
        Write(archPaq,R);
    end;
    Close(arch);
    Close(archPaq);
end;
procedure GrabaArchDes(var archDes:TArchDes);
var
    R:TRegDes;
    aux:char;
    arch:text;
begin
    Assign(arch,'DESTINO.TXT');
    Reset(arch);
    Rewrite(archDes);
    while not eof(arch) do
    begin
        ReadLn(arch,R.codDestino,aux,R.descripcion);
        Write(archDes,R);
    end;
    Close(arch);
    Close(archDes);
end;

procedure PesoProm(var archPaq:TArchPaq);
var
    pesoProm:real;
    cantPaq:byte;
    R:TRegPaq;
begin
    Reset(archPaq);
    pesoProm:=0;
    cantPaq:=0;
    while NOT eof(archPaq) do
    begin
        Read(archPaq,R);
        cantPaq:=cantPaq+1;
        PesoProm:= PesoProm + R.peso;
    end;
    Close(archPaq);
    WriteLn('El peso promedio es: ', PesoProm/cantPaq:0:2);
end;

procedure TotalAsegurado(var archPaq:TArchPaq);
var
    totalMontoAse:real;
    R:TRegPaq;
begin
    Reset(archPaq);
    totalMontoAse:=0;
    while NOT eof(archPaq) do
    begin
        Read(archPaq,R);
        totalMontoAse:= totalMontoAse + R.monto;
    end;
    Close(archPaq);
    WriteLn('El total de monto asegurado es: ', totalMontoAse:0:2);
end;
procedure ArmarLista(var archDes:TArchDes;cantPaquetes:TV);
var
    R:TRegDes;
    total:word;
begin
    Reset(archDes);
    WriteLn('DESTINO          CANTIDAD PAQUETES');
    total:=0;
    while not eof(archDes) do
    begin
        Read(archDes,R);
        WriteLn(R.descripcion:6, cantPaquetes[R.codDestino]:10);
        total:=total+cantPaquetes[R.codDestino];
    end;
    WriteLn('TOTAL',total:20);
    Close(archDes);
end;
var
    archPaq:TArchPaq;
    archDes:TArchDes;
    cantPaquetes:TV;
begin
    Assign(archPaq,'PAQUETES.DAT');
    Assign(archDes,'DESTINO.DAT');
    GrabaArchPaq(archPaq,cantPaquetes);
    GrabaArchDes(archDes);
    PesoProm(archPaq);
    TotalAsegurado(archPaq);
    ArmarLista(archDes,cantPaquetes);
end.