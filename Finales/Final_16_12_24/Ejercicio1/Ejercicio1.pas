Program Ejercicio1;

(*Una adminsitradora de edificios tiene información de los edificos que administra en el archivo
EDIFICIOS.DAT con la siguiente información:
    # NRO_EDIFICIO (entero) {campo de secuencia, clave primaria}
    # DIRECCION
    # CANT_DEPARTAMENTOS
    # FONDO_RESERVA (real, puede ser negativo)
    # GASTOS_OCTUBRE
Además, se tiene infromación de las expensas del mes de octubre de algunos de los edificios
administrados en OCTUBRE.DAT
    # NRO_EDIFICIO (entero, no validado) {campo de secuencia, clave secundaria}
    # NRO_DEPTO (1..50, no validado) {campo de secuencia, clave secundaria} (°)
    # VALOR (>0, en $)
    # TIPO [E: el valor es el de la expensa del mes; P: el valor es de un pago del mes]
(°) un mismo departamento puede haber hecho más de un pago en el mes

Se pide, definir tipos y utilizando la técnica de corte de control y/o enfrentamiento, según
corresponda, resolver (sin reccorrer los archivos más de una vez):
    -   Actualizar el fondo de reserva de EDIFICIOS.DAT considerando que se incrementa o
        decrementa, según si en el mes lo recaudado supera o no al valor de los gastos.
    -   Mostrar un informe en el que conste para los edificios X e Y (X e Y enteros, datos de
        entrada) la siguiente información solo para los departamentos que tienen deuda en octubre:

            Numero Edificio: 9999               Direccion Edificio: xxxxxxxxxxx
            Departamento                    Valor Deuda Octubre
                99                              $9999.99
            Todos los deptos. pagaron el total de sus expensas en octubre: [S/N]

*)
type
    TRegEdi = record
        nroEdificio:word;
        direccion:String;
        cantDepart:byte;
        fondosReserva,gastosOctubre:real;
    end;
    TRegOct = record
        nroEdificio:wrod;
        nroDepto:1..50;
        valor:real;
        tipo:char;
    end;
    
    TArchEdi = file of TRegEdi;
    TArchOct = file of TRegOct;

procedure ArmarTabla(var archEdi:TArchEdi; var archOct:TArchOct;x,y:word);
var
    REd,RAux:TRegEdi;
    ROc:TRegOct;
    edificioActual:word;
    recaudado,recaudadoEdi,deuda:Real;
    res:char;
begin
    reset(archEdi);
    reset(archOct);
    Read(archEdi,REd);
    read(archOct,ROc);
    
    while (not eof(archEdi)) or (Not eof(archOct)) do
    begin
        if REd.nroEdificio = ROc.nroEdificio then
        begin
            recaudadoEdi:=0;
            while REd.nroEdificio = ROc.nroEdificio do
            begin
                nroDeptoActual:=ROc.nroDepto;
                If (Red.nroEdificio = x) Or (REd.nroEdificio = y) Then
                begin
                    WriteLn('Numero Edificio: ', REd.nroEdificio,'          Direccion Edificio:', REd.direccion);
                    WriteLn('Departamento           Valor Deuda Octubre');
                    res := 'S';
                end;
          
                if nroDeptoActual in [1..50] then
                begin                       
                    recaudado:=0;
                    deuda:=0;
                    while (REd.nroEdificio = ROc.nroEdificio) and (nroDeptoActual = ROc.nroDepto) do
                    begin                
                        if Roc.tipo = 'P' then
                            recaudado:=recaudado+Roc.valor
                        else
                            deuda:=deuda+Roc.valor;
                        read(archOct,ROc);
                    end;
                    
                    if deuda-recadado>0 then
                    begin
                        res:= 'N';
                        WriteLn(' ',nroDeptoActual,'            $',deuda-recaudado);
                    end;
                    
                    recaudadoEdi:=recaudadoEdi+recaudado;
                end
                else
                    while (REd.nroEdificio = ROc.nroEdificio) and (nroDeptoActual = ROc.nroDepto) do
                        Read(archOct,ROc);        
            end;            
            
            if (Red.nroEdificio = x) Or (REd.nroEdificio = y) then
                WriteLn('Todos los deptos. pagaron el total de sus expnesas en octubre: ', res);     
            
            REd.fondosReserva := recaudadoEdi-REd.gastosOctubre;
            Read(archEdi,REd);
        end
        else if REd.nroEdificio > ROc.nroEdificio then
            begin
                edificioActual:=ROc.nroEdificio;
                while ROc.nroEdificio = edificioActual do
                    Read(archOct,ROc);
            end
        else
            Read(archEdi,REd);
    end;
    close(archEdi);
    Close(archOct);
end;

var
    archEdi:TArchEdi;
    archOct:TArchOct;
    x,y:word;

begin
    Assign(archEdi,'EDIFICIOS.DAT');
    Assign(archOct,'OCTUBRE.DAT');

    WriteLn('Ingrese un edificio x');
    ReadLn(x);
    WriteLn('Ingrese un edificio y');
    ReadLn(y);

    ArmarTabla(archEdi,archOct,x,y);
end.