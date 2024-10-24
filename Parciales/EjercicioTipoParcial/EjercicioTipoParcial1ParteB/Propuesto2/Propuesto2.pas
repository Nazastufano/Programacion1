Program Propuesto2;


(*Ejercicios propuestos 2) Una compañía Láctea recibe la producción diaria en litros de leche, de N tambos de la zona,
durante quince días.
Los datos vienen de la siguiente manera, sin orden alguno:
* Código del Tambo (cadena de 4 caracteres) puede repetirse
* dia
* la entrega en litros.

Se pide, armar 3 vectores paralelos, COD, TOT, ENTREGAS y además calcular e
informar:
    a) Código del tambo que más leche entregó a la compañía.
    b) Cuántos superaron un promedio de X litros de entrega.
    c) Dado un código, el total y el promedio diario entregado, (si es que existe dicho código).

COD con los códigos de cada Tambo
TOT con los totales de litros entregados
ENTREGAS con La cantidad total de entregas

TAMBOS.TXT
AA12 2 200
AA12 3 100
BB07 3 200
BB07 4 110
AA12 5 50
CC33 5 85
DD45 5 80
AA12 8 150
DD45 8 120
BB07 11 100
CC33 12 60
DD45 12 80
BB07 14 120
DD45 14 140
AA12 15 100

COD  TOT ENTREGAS
AA12 600 5
BB07 520 4
CC33 245 3
DD45 420 4
*)
const
    N=5;

type
    ST4 = string[4];
    TVCod = array[1..N] of ST4;
    TVEntregas = array[1..N] of byte;
    TVLitros = array[1..N] of word;

procedure InicializarArreglo(var vEntregas:TVEntregas);
var
    i:byte;
begin
    for i:=1 to N do
        vEntregas[i]:=0;
end;

procedure InicializarArregloWord(var vLitros:TVLitros);
var
    i:byte;
begin
    for i:=1 to N do
        vLitros[i]:=0;
end;

function BuscarCodigo(vCod:TVCod; cod:ST4; indice,contTambos:byte):byte;
var
    i,pos:byte;
begin
    pos:=0;
    for i:=1 to contTambos do
    begin
        if vCod[i] = cod then
            pos := i; 
    end;
    if pos=0 then
        BuscarCodigo := indice + 1
    else
        BuscarCodigo := pos;
        

end;

function MasLeche(vCod:TVCod;vLitros:TVLitros;indice:byte):ST4;
var
    i:byte;
    mas:word;
    codMas:ST4;
begin
    mas:=vLitros[1];
    codMas:=vCod[1];
    for i:=1 to indice do
    begin
        if mas<vLitros[i] then
        begin
            mas:=vLitros[i];
            codMas:=vCod[i];
        end;
    end;
    MasLeche:=codMas;
end;

function Superaron(vLitros:TVLitros; vEntregas:TVEntregas; contTambos:byte; x:real):byte;
var
    cont,i:byte;
    
begin
    cont:=0;
    for i:=1 to contTambos do
    begin
        if ((vLitros[i]/vEntregas[i])>x) and (vEntregas[i]<>0) then
            cont:=cont +1;
    end;
    Superaron:=cont;
end;

procedure MostrarPorCodigo(vCod:TVCod; cod:ST4; vEntregas:TVEntregas; vLitros:TVLitros; contTambos:byte);
var
    i,pos:byte;
begin
    pos:=0;
    for i:=1 to contTambos do
    begin
        if vCod[i] = upcase(cod) then
            pos:=i;
    end;
    if pos=0 then
        WriteLn('No existe el codigo ingresado')
    else
        WriteLn('El total de litros del codigo: ',vLitros[pos], '. Y el promedio del codigo es: ', (vLitros[pos]/vEntregas[pos]):0:2);
end;

var
    arch:text;
    dia,contTambos,indice:byte;
    litros:word;
    cod:ST4;
    vCod: TVCod;
    vEntregas: TVEntregas;
    vLitros: TVLitros;
    cantASuperar:real;

begin
    Assign(arch,'TAMBOS.TXT');
    Reset(arch);
    
    InicializarArreglo(vEntregas);
    InicializarArregloWord(vLitros);
    contTambos:=1;
    while Not eof(arch) do
    begin
        ReadLn(arch,cod,dia,litros);
        indice := BuscarCodigo(vCod,cod,indice,contTambos);
        
        vCod[indice]:=cod;
        vLitros[indice]:=vLitros[indice]+litros;
        vEntregas[indice]:=vEntregas[indice]+1;
        if contTambos<indice then
            contTambos:=indice;
    end;
    close(arch);
    WriteLn('El codigo del tambo que mas ha entregado es: ', MasLeche(vCod,vLitros,contTambos));
    
    WriteLn('Ingrese la cantidad a superar: ');
    readln(cantASuperar);
    WriteLn('La cantidad de tambos que superaron la cantidad de litros son: ', Superaron(vLitros,vEntregas,contTambos,cantASuperar));

    WriteLn('Ingrese el codigo a buscar: ');
    readln(cod);
    MostrarPorCodigo(vCod,cod,vEntregas,vLitros,contTambos);
end.