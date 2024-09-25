program Parcial1ParteB19_4_24;

{Ejercicio 1
Se tiene un conjunto de productores que cada uno informa acerca de las parcelas que posee y
ha sembrado y cosechado con diferentes cereales. Los datos están agrupados por productor y
por cada uno se ingresa desde teclado:
    - DNI (cadena de 8,'999' es fin de datos)
    - Cantidad de parcelas que desea infromar (puede ser 0)
    y por cada una de las parcelas:
        - Total de Hectáreas (Has) sembradas, si este valor es 0 los siguientes datos no se
        ingresan
        - Tipo de cereal (T - trigo; A - avena; C - cebada)
        - Total de Toneladas (Tons) cosechadas
Obreservación: Un productor puede sembrar 1, 2 o los 3 tipos de cereal

Desarrollar el ingreso de datos almacenado para cada productor que informa parcelas, la
cantidad total de has sembradas por el productor, y el total cosechado de cada cereal

Luego obtener e informar:
    a) La cantidad de productores que han cosechado un único tipo de cereal
    b) Si todos los productores que han cosechado los 3 tipos de cereal han superado un rinde
       total de X (dato ingresado) 
       Obrservación: El rinde es Tons/Has
}
const
    N=100;

type
    ST8 = string[8];
    TVecDNI = array[1..N] of ST8;
    TvecNum = array[1..N] of word;
    TvecCereales = array[1..3] of byte;

procedure InicializarArreglo(var vec:TvecNum);
var
    i:byte;
begin
    for i:=1 to N do
    begin
        vec[i]:=0;
    end;
end;

procedure InicializarArregloDe3(var vec:TvecCereales);
var
    i:byte;
begin
    for i:=1 to 3 do
    begin
        vec[i]:=0;
    end;
end;

function UnSoloCereal(vCantCereales:TvecCereales):Boolean;
var
    i,contUnSoloCereal:byte;
begin
    contUnSoloCereal:=0;
    for i:=1 to 3 do
    begin
        if vCantCereales[i]<>0 then
        begin
            contUnSoloCereal:= contUnSoloCereal + 1;
        end;
    end;

    if contUnSoloCereal>1 then
        UnSoloCereal := false
    else
        UnSoloCereal := true;

end;

var
    dni:ST8;
    has,tons:word;
    i,cantParcelas,contProductores, cantUnSoloCereal,superaRinde:byte;
    tipoCereal:char;
    vDNI:TVecDNI;
    vHectareas,vCerealT,vCerealA,vCerealC:TvecNum;
    rinde:real;
    vCantCereales:TvecCereales;
    
begin
    writeln('Ingrese el DNI del productor: ');
    ReadLn(dni);

    contProductores := 0;
    cantUnSoloCereal := 0;
    superaRinde:=0;

    WriteLn('Ingrese un rinde a superar: ');
    ReadLn(rinde);

    InicializarArreglo(vCerealT);
    InicializarArreglo(vCerealA);
    InicializarArreglo(vCerealC);
    InicializarArreglo(vHectareas);

    while dni<>'999' do
    begin
        WriteLn('Cuantas parcelas desea informar: ');
        ReadLn(cantParcelas);
        InicializarArregloDe3(vCantCereales);
        if cantParcelas <> 0 then
        begin
            contProductores:=contProductores +1;
            vDNI[contProductores]:=dni;
            for i:=1 to cantParcelas do
            begin
                WriteLn('Ingrese la cantidad de Hectareas sembradas:');
                readln(has);
                vHectareas[contProductores] := vHectareas[contProductores] + has;
                if has<>0 then
                begin
                    repeat
                        WriteLn('Ingrese el tipo de cereal: (T - trigo; A - avena; C - cebada)');
                        ReadLn(tipoCereal);
                        tipoCereal:= upcase(tipoCereal);
                    until (tipoCereal='T') or (tipoCereal='A') or (tipoCereal='C');
                    WriteLn('Ingrese la cantidad de toneladas cosechadas: ');
                    ReadLn(tons);
                    
                    case tipoCereal of
                    'T':begin
                            vCantCereales[1] := vCantCereales[1] + 1;
                            vCerealT[contProductores] := vCerealT[contProductores] + tons;
                        end;
                    'A':begin
                            vCerealA[contProductores] := vCerealA[contProductores] + tons;
                            vCantCereales[2] := vCantCereales[2] + 1;
                        end;
                    'C':begin
                            vCerealC[contProductores] := vCerealC[contProductores] + tons;
                            vCantCereales[3] := vCantCereales[3] + 1;
                        end;
                    end
                end;
            end;

            if (vCerealT[contProductores] <> 0) and (vCerealA[contProductores]<>0) and (vCerealC[contProductores]<>0) and (((vCerealT[contProductores]+vCerealT[contProductores]+vCerealT[contProductores])/has)>rinde) then
                superaRinde:=superaRinde+1;
        
            if UnSoloCereal(vCantCereales) then
                cantUnSoloCereal:=cantUnSoloCereal+1;
        end;

        writeln('Ingrese el DNI del productor: ("999" fin de datos)');
        ReadLn(dni);
    end;
    WriteLn('La cantidad de productores que han cosechado un solo cereal es: ', cantUnSoloCereal);
    WriteLn('La cantidad de productores que superaron el rinde de: ',rinde:0:2, ' es: ',superaRinde);
end.
