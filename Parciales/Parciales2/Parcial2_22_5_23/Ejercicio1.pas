Program Ejercicio1;

(*Un estacionamiento está compuesto por N niveles, cada uno de los cuales cuenta con M plazas. A lo
largo del día, se utiliza un dispositivo para registrar la cantidad de vehículos que ocupan cada plaza
y el tiempo que permancecen ocupados. Al final del día esta información se graba en dos matrices:
MatAutos y MatHoras.

MatAutos representa la cantidad de vehículos que ocuparon cada lugar al final del día, mientras que
MatHoras contiene la cantidad total de horas acumuladas por todos los vehículos que ocuparon cada
lugar.

Ejemplo de lote de datos
    N = 5 M = 3

            MatAutos                    MatHoras
        4       5       15          9,5     15      20 
        1       0       3           6       0       24
        10      3       9           15,3    10,5    9  
        6       5       7           12      11      14
        2       1       3           4       1       6,5

Se pide desarrollar subprogramas en Pascal para:
a) Generar y Mostrar un arreglo de regístros VNiveles, donde cada registro contine:
    Nivel (1..N)
    Total de autos
    Tiempo promedio de ocupación por auto
Este arreglo solo debe incluir los niveles donde todas las plazas se ocuparon por lo menos una vez.
El arreglo generado, será utilizado por otros subprogramas.

b) Determinar cuántos niveles cumplen con la condición de tener una plaza con una cantidad de
vehiculos mayor a un valor X, ingresado por teclado. Si esto no fuera recursivo el punto no será
evaluado.

Además se deberá declarar la sección Type de Pascal y los llamados a los subprogramas en el
programa principal. Se asume que las matrices ya se encuentran cargadas, y usted no debe
desarrollar la carga de las matrices.*)
const
    N=5;
    M=3;
type 
    TReg = record
        Nivel:byte;
        TotalAutos:word;
        TiempoProm:real;
    end;
    TMAutos = array[1..N,1..M] of byte;
    TMHoras = array[1..N,1..M] of real;
    TVNiveles = array[1..N] of TReg;
//Desarrollado a pesar de que dice que no para probar el programa
procedure CargarDatos(var matrContAutos:TMAutos; var matrHoras:TMHoras);
var
    contAutos,i,j:byte;
    horas:real;
begin
    for i:=1 to N do
        for j:=1 to M do
        begin
            WriteLn('Ingrese la cantidad de vehiculos que ocuparon la plaza ', j, ' del nivel ', i);
            readln(contAutos);
            WriteLn('Ingrese el tiempo que ha permanecido pcupada la plaza ', j, ' del nivel ', i);
            ReadLn(horas);
            matrContAutos[i,j]:=contAutos;
            matrHoras[i,j]:=horas;
        end;
end;

{a) Generar y Mostrar un arreglo de regístros VNiveles, donde cada registro contine:
    Nivel (1..N)
    Total de autos
    Tiempo promedio de ocupación por auto
Este arreglo solo debe incluir los niveles donde todas las plazas se ocuparon por lo menos una vez.}

procedure MostrarArreglo(VNiveles:TVNiveles;K:byte);
var
    i:byte;
begin
    Write('[');
    for i:=1 to K do
    begin
        if i<>K then
            Write('(',VNiveles[i].Nivel,', ',VNiveles[i].TotalAutos,', ',VNiveles[i].TiempoProm:0:2,'), ')
        else
            Writeln('(',VNiveles[i].Nivel,', ',VNiveles[i].TotalAutos,', ',VNiveles[i].TiempoProm:0:2,')]')
    end;
end;

procedure GenerarArregloVN(matrContAutos:TMAutos;matrHoras:TMHoras;var VNiveles:TVNiveles;var K:byte);
var
    cantAutosPNivel,i,j:byte;
    usaTodas:Boolean;
    horasPNivel:real;
    
begin
    i:=1;
    while i<=N do
    begin
        usaTodas:=true;
        j:=1;
        cantAutosPNivel:=0;
        horasPNivel:=0;
        while (j<=M) and (usaTodas=true) do
        begin
            if matrContAutos[i,j]=0 then
                usaTodas := false
            else
                begin
                    cantAutosPNivel:=cantAutosPNivel+matrContAutos[i,j];
                    horasPNivel:= horasPNivel+matrHoras[i,j];
                end;
            j:=j+1;
        end;
        
        If usaTodas Then
        begin
            k := k+1;
            VNiveles[k].Nivel:=i;
            VNiveles[k].TotalAutos:=cantAutosPNivel;
            VNiveles[k].TiempoProm:=horasPNivel/cantAutosPNivel;
        end;
        i:=i+1;
    end;
    MostrarArreglo(VNiveles,K);
end;

{b) Determinar cuántos niveles cumplen con la condición de tener una plaza con una cantidad de
vehiculos mayor a un valor X, ingresado por teclado. Si esto no fuera recursivo el punto no será
evaluado.}

function CantidadPlazasSuperan(matrContAutos:TMAutos;i,j,x:byte):byte;
begin
    if i=0 then
        CantidadPlazasSuperan:=0
    else            
        if matrContAutos[i,j]>x then
            CantidadPlazasSuperan:= 1 + CantidadPlazasSuperan(matrContAutos,i-1,M,x)
        else
            if j>1 then
                CantidadPlazasSuperan := CantidadPlazasSuperan(matrContAutos,i,j-1,x)
            else
                CantidadPlazasSuperan := CantidadPlazasSuperan(matrContAutos,i-1,M,x);
end;
procedure PlazaSuperanX(matrContAutos:TMAutos);
var
    x,cantSuperan:byte;
begin
    WriteLn('Ingrese una cantidad de vehiculos a superar por una plaza: ');
    ReadLn(x);
    cantSuperan:=CantidadPlazasSuperan(matrContAutos,N,M,x);
    WriteLn('La cantidad de plazas que superan es: ', cantSuperan);
end;

var
    matrContAutos:TMAutos;
    matrHoras:TMHoras;
    VNiveles:TVNiveles;
    K:byte;
begin    
    CargarDatos(matrContAutos,matrHoras);
    GenerarArregloVN(matrContAutos,matrHoras,VNiveles,K);
    PlazaSuperanX(matrContAutos);
end.