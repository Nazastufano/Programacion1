Program Propuesto3;
(*Ejercicio tipo 1er parcial

Una imprenta realiza folletos y su costo depende de la cantidad de palabras, del tipo y tamaño de letra.

Un archivo de texto contiene en cada línea (finalizada con un punto) los datos de un folleto.

El primer carácter es el tipo (A,B,C), luego un blanco el tamaño (1,2), luego un blanco seguido de una secuencia de
caracteres que forman palabras separadas por uno o mas blancos, al final un punto.

Ejemplo: A 2 xxxxx xxxxxxxxx xxxxxx xxxxxxx.

Se pide procesar el archivo y generar 3 arreglos paralelos: Costo, CantPal y MasLarga, contendrán de cada folleto su
costo, la cantidad de palabras y la cantidad de caracteres de la palabra más larga

El costo se calcula de la siguiente manera: $1 la palabra, dependiendo del Tipo de letra: 'A' duplica el importe,
'B' triplica,'C' quintuplica. Además si el tamaño es 2 tiene un costo adicional del 50%

Ejemplo: 
        Archivo                               Vcant VMasL VCosto
B 2 el sabado ire a la playa.                   6     6     27
C 1 llevaremos vino para el almuerzo.           5     10    25
B 1 todos creyeron en su palabra.               5     8     15
A 2 piensa venir en primavera.                  4     9     12


Luego:
    a) Indicar el costo del folleto que contenga la palabra mas larga, si hay mas de uno el costo promedio de los mismos.
    b) Para un entero N que ingresa por teclado, buscar el primer folleto que contenga exactamente N palabras y
    mostrar su costo. (considerar que puede no existir)
*)
const
    N=50;

type
    TVReal = array[1..N] of real;
    TVByte = array[1..N] of byte;
    

function CalcCosto(cantPalabras,tam:byte;tipo:char):real;
var
    costo:real;
begin
    costo:= (cantPalabras*1);

    case Tipo of
    'A':costo:=costo*2;
    'B':costo := costo*3;
    'C':costo := costo*5;
    end;
    if tam=2 then
        costo:=costo*1.5;
    CalcCosto:=costo;
end;

function CostFolletPalMasLar(VMasL:TVByte;VCosto:TVReal;contFilas:byte):real;
var
    i,max,contMismoLargo,pos:byte;
    sumatoria:real;
begin
    max:=0;
    contMismoLargo:=0;
    sumatoria := 0;
    for i:=1 to contFilas do
    begin
        if VMasL[i]>max then
            begin
                max:=VMasL[i];
                pos:=i;
            end;
            
    end;
    for i:=1 to contFilas do
    begin
        If max = VMasL[i] Then
            begin
                sumatoria:=sumatoria+VCosto[i];
                contMismoLargo := contMismoLargo+1;  
            end;
    end;
    CostFolletPalMasLar:=sumatoria/contMismoLargo;
end;

procedure MostrarCosto(Vcant:TVByte;VCosto:TVReal;contFilas:byte);
var
    pos,i,cantPal:byte;
    
begin
    WriteLn('Ingrese un numero palabras');
    ReadLn(cantPal);
    pos:=0;
    for i:= 1 to contFilas do
    begin
        if Vcant[i]=cantPal then 
            pos:=i;
    end;
    if pos=0 then
        WriteLn('No existe folleto con dicha cantidad de palabras')
    else
        WriteLn('El costo del folleto con ', cantPal, ' palabras es: ', VCosto[pos]:0:2);
end;

var
    arch:text;
    tipo,car,aux:char;
    palabra,palabraMasLarga:string;
    VMasL,VCant:TVByte;
    VCosto:TVReal;
    tam,contFilas,cantPalabras,i:byte;

begin
    Assign(arch,'datos.TXT');
    Reset(arch);
    contFilas := 0;
    
    while Not eof(arch) do
    begin
        Read(arch,tipo,tam,aux,car);
        contFilas:=contFilas+1;
        cantPalabras:=0;
        palabraMasLarga := '';
        while car <> '.' do
        begin
            palabra:='';
            repeat
                if (car<>' ') and (car<>'.') then
                    palabra := palabra + car;
                read(arch, car);
            until(car = ' ') or (car = '.');
            
            cantPalabras:=cantPalabras+1;
            
            if Length(palabraMasLarga)<Length(palabra) then 
                palabraMasLarga:=palabra;
        end;
        Vcant[contFilas]:= cantPalabras;
        VMasL[contFilas]:= Length(palabraMasLarga);
        VCosto[contFilas]:= CalcCosto(cantPalabras,tam,tipo);
        readln(arch);
    end;
    close(arch);

    WriteLn('El costo del folleto con la palabra mas larga es: ',CostFolletPalMasLar(VMasL,VCosto,contFilas):0:2);

    MostrarCosto(VCant,VCosto,contFilas);
end.