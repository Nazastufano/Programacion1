Program Ejercicio13;

(*Ej 13) En una estación de peaje hay N cabinas por donde pasan varios vehículos. Desde un archivo se lee
la siguiente información:
    • Número de cabina
    • Tipo de vehículo (1=auto, 2=moto, 3=camioneta, 4=camión, 5=colectivo)
    • Hora (0..23) 
Las tarifas son: moto = $150, auto y camioneta = $300, camión = $470, colectivo = $390.
Si la hora está entre las 10 y las 18 sufre un incremento del 10%.
Calcular e informar:
    a) Cuántos vehículos atendió cada una de las N cabinas.
    b) Cuál fue la que más importe recaudó. *)

const
    N = 5;
    tarifas: array[1..5] of real = (150,300,300,470,390);
type
    TVecCont = array[1..N] of byte;
    TVecImporte = array[1..N] of real;
procedure LlenarArregloCont(var vecCont:TVecCont);
var
    i:byte;
begin
    for i:=1 to N do
    begin
        vecCont[i]:=0;
    end;
end;
procedure LlenarArregloImporte(var vecImporte:TVecImporte);
var
    i:byte;
begin
    for i:=1 to N do
    begin
        vecImporte[i]:=0;
    end;
end;

procedure MostrarArreglo(vecCont:TVecCont);
Var 
    i:   byte;
Begin
    Write('(');
    For i:=1 To N Do
    Begin
        Write(vecCont[i]);
        If i<>N Then
            Write(', ');
    End;
    Writeln(')');
End;

function MasRecauda(vecImporte:TVecImporte):byte;
var
    i,pos:byte;
    max:real;
begin
    max:=0;
    for i:=1 to N do
    begin
        if max<vecImporte[i] then
        begin
            max:=vecImporte[i];
            pos:=i;
        end;
    end;
    MasRecauda:=pos;
end;


var
    arch:Text;
    hora,tipoVehiculo,numCabina:byte;
    tarifa:real;
    vecCont:TVecCont;
    vecImporte:TVecImporte;

begin
    Assign(arch,'datos.TXT');
    Reset(arch);
    
    LlenarArregloCont(vecCont);
    LlenarArregloImporte(vecImporte);

    while not Eof(arch) do
    begin
        ReadLn(arch,numCabina,tipoVehiculo,hora);
        tarifa := tarifas[tipoVehiculo];
        if hora in [10..18] then
            tarifa:= tarifa*(1+0.1);  
        
        vecCont[numCabina]:= vecCont[numCabina] + 1;
        vecImporte[numCabina]:= vecImporte[numCabina] + tarifa;
    end;
    Close(arch);
    MostrarArreglo(vecCont);

    WriteLn('La cabina que mas ha recaudado es: ', vecCont[MasRecauda(vecImporte)], '. Recaudo: $',vecImporte[MasRecauda(vecImporte)]:0:2);
end.