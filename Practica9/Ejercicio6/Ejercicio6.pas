Program Ejercicio6;

(*Ej 6) Una empresa paga a fin de mes a sus empleados una comisión del 0.5% sobre las ventas
efectuadas, para ello almacena el acumulado mensual de ventas en un archivo cuyo diseño de registro es: 
    # LEGAJO (campo de secuencia, clave primaria)
    # NOMBRE y APELLIDO
    # TOTAL de VENTAS
    # NRO de FACTURA de MAYOR VENTA del MES
    # IMPORTE de MAYOR VENTA del MES
Al final del día actualiza los registros de ese archivo con las ventas efectuadas almacenadas en otro
archivo cuyo diseño de registro es:
    # LEGAJO (campo de secuencia, clave secundaria)
    # NRO de FACTURA
    # IMPORTE
Se pide actualizar el primer archivo y listar las comisiones que le corresponden hasta el momento a cada
empleado. *)
Type
    ST15 = String[15];
    TRegEmpleados = record
        legajo,nroFactMVdelM:word;
        nYA:ST15;
        totalVentas:byte;
        ImporteMVdelM:real;
    end;
    TRegVentas = record
        legajo,nroFactura:word;
        importe:real;
    end;
    TArchEmpleados = file of TRegEmpleados;
    TArchVentas = file of TRegVentas;
procedure GrabaArchEmpleados(var archEmpleados:TArchEmpleados);
var
    arch:Text;
    R:TRegEmpleados;
    aux:char;
begin
    Assign(arch,'EMPLEADOS.TXT');
    Reset(arch);
    Rewrite(archEmpleados);
    while NOT eof(arch) do
    begin
        ReadLn(arch,R.legajo,aux,R.nYA,R.totalVentas,R.nroFactMVdelM,R.ImporteMVdelM);
        Write(archEmpleados,R);
    end;
    Close(arch);
    Close(archEmpleados);
end;
procedure GrabaArchVentas(var archVentas:TArchVentas);
var
    arch:text;
    R:TRegVentas;
begin
    Assign(arch,'VENTAS.TXT');
    Reset(arch);
    Rewrite(archVentas);
    while not eof(arch) do
    begin
        ReadLn(arch,R.legajo,R.nroFactura,R.importe);
        Write(archVentas,R);
    end;
    Close(arch);
    Close(archVentas);
end;
procedure ListarArchivo(var archEmpleados:TArchEmpleados);
var
    R:TRegEmpleados;
begin
    Writeln('Legajo Nombre cantVentas nroFacturamayorVenta montoMayorVenta');
    Reset(archEmpleados);
    while not Eof(archEmpleados) do
    begin
        Read(archEmpleados,R);
        WriteLn(R.legajo,' ', R.nYA,' ',R.totalVentas,' ',R.nroFactMVdelM,' ',R.ImporteMVdelM:0:2);
    end;
    Close(archEmpleados);
end;
procedure ActualizarArchivo(var archEmpleados:TArchEmpleados;var archVentas:TArchVentas;nom:ST15);
var
    archTemp:TArchEmpleados;
    REm:TRegEmpleados;
    RVe:TRegVentas;
begin
    Assign(archTemp,'TEMP.DAT');
    Rewrite(archTemp);
    Reset(archEmpleados);
    Reset(archVentas);
    Read(archEmpleados,REm);
    Read(archVentas,RVe);
    while (not Eof(archEmpleados)) or (not Eof(archVentas)) do
        if REm.legajo=RVe.legajo then
        begin
            while REm.legajo=RVe.legajo do
            begin
                REm.TotalVentas:=REm.TotalVentas+1;
                if REm.ImporteMVdelM<RVe.importe then
                begin
                    REm.nroFactMVdelM:=RVe.nroFactura;
                    REm.ImporteMVdelM:=RVe.importe;
                end;
                Read(archVentas,RVe);
            end;
            Write(archTemp,REm);
            Read(archEmpleados,REm);
        end
        else if Rem.legajo<RVe.legajo then
        begin
            Write(archTemp,REm);
            read(archEmpleados,REm);
        end
            else
                Read(archVentas,RVe);
    Write(archTemp,REm);
    Close(archTemp);
    Close(archEmpleados);
    Close(archVentas);
    Erase(archEmpleados);
    Rename(archTemp,nom);
end;
var
    archEmpleados:TArchEmpleados;
    archVentas:TArchVentas;

begin
    Assign(archEmpleados,'EMPLEADOS.DAT');
    Assign(archVentas,'VENTAS.DAT');
    GrabaArchEmpleados(archEmpleados);
    GrabaArchVentas(archVentas);
    ListarArchivo(archEmpleados);
    ActualizarArchivo(archEmpleados,archVentas,'EMPLEADOS.DAT');
    ListarArchivo(archEmpleados);
end.