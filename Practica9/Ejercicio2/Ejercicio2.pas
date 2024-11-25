Program Ejercicio2;

(*Ej 2) Un Banco registra en TARJETAS.DAT el movimiento de las tarjetas de crédito de sus usuarios.
    # NUMERO de TARJETA (1er campo de secuencia, clave primaria)
    # NOMBRE del PROPIETARIO
    # TOPE
    # GASTO del MES (hasta el momento)
Además, se van ingresando (desde teclado ó archivo de texto) las compras con los siguientes datos:
    - Número de Tarjeta (puede repetirse)
    - Monto
    - Código de operación
Procesar los datos, actualizando los gastos del mes, siempre que no supere el monto tope, en caso
contrario, rechazarlo y grabar en un archivo RECHAZADOS.DAT con la siguiente información:
    # NUMERO de TARJETA
    # CODIGO DE OPERACION
    # MONTO
Sugerencia: para obtener la dirección relativa y acceder en forma directa al archivo TARJETAS, descargar
del mismo los números de tarjeta sobre un arreglo (tabla). *)
type
    ST10 = String[10];
    ST16 = String[16];
    TVTabla = array[0..1000] of ST16;
    TRegTar = record
        numTarjeta: ST16;
        nombreProp:ST10;
        tope,gastoMes: real;
    end;
    TRegRec = record
        numTarjeta: ST16;
        monto:real;
        codOperacion:byte;
    end;
    TArchTarjetas = file of TRegTar;
    TArchRechazados = file of TRegRec;
procedure GrabarArchTarjetas(var archTarjetas:TArchTarjetas;var vecTabla:TVTabla);
var
    arch:Text;
    R:TRegTar;
    aux:Char;
    cantTarjetas:integer;
begin
    Assign(arch,'TARJETAS.TXT');
    Reset(arch);

    Rewrite(archTarjetas);
    cantTarjetas:=-1;
    while NOT Eof(arch) do
    begin
        ReadLn(arch, R.numTarjeta, aux, R.nombreProp, R.tope, R.gastoMes);
        cantTarjetas:=cantTarjetas+1;
        vecTabla[cantTarjetas]:= R.numTarjeta;
        
        Write(archTarjetas,R);
    end;
    close(arch);
    close(archTarjetas);
end;
function Busqueda(vecTabla:TVTabla; tarjeta:ST16):word;
var
    i:word;
begin
    i:=0;
    while vecTabla[i]<>tarjeta do
        i:=i+1;

    Busqueda:=i;
end;
procedure ActualizarTarjetas(var archTarjetas:TArchTarjetas; var archRechazados:TArchRechazados; vecTabla:TVTabla);
var
    arch:text;
    R:TRegRec;
    R2:TRegTar;
begin
    Assign(arch, 'COMPRAS.TXT');
    Reset(arch);
    
    Rewrite(archRechazados);
    Reset(archTarjetas);
    while NOT Eof(arch) do
    begin
        ReadLn(arch, R.numTarjeta, R.monto, R.codOperacion);
        Seek(archTarjetas, Busqueda(vecTabla, R.numTarjeta));
        Read(archTarjetas,R2);
        if R2.gastoMes + R.monto <= R2.Tope then
            begin
                R2.gastoMes := R2.gastoMes + R.monto;
                Write(archTarjetas,R2);
            end
        else
            Write(archRechazados, R);
    end;
    Close(arch);
    close(archTarjetas);
    Close(archRechazados);
end;
procedure ListaRechazados(var archRechazados:TArchRechazados);
var
    R:TRegRec;
begin
    reset(archRechazados);
    WriteLn('LA LISTA DE RECHAZADOS');
    while not eof(archRechazados) do
    begin
        read(archRechazados, R);
        WriteLn(R.numTarjeta,' ', R.monto:0:2,' ', R.codOperacion);
    end;
    Close(archRechazados);
end;
var
    archTarjetas:TArchTarjetas;
    archRechazados:TArchRechazados;
    vecTabla:TVTabla;
begin
    Assign(archTarjetas,'TARJETAS.DAT');
    Assign(archRechazados,'RECHAZADOS.DAT');
    GrabarArchTarjetas(archTarjetas,vecTabla);
    ActualizarTarjetas(archTarjetas,archRechazados,vecTabla);
    ListaRechazados(archRechazados);
end.