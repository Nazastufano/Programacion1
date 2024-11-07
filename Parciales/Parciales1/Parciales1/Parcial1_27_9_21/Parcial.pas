Program Parcial;

{En una competencia automovilística se registran los tiempos realizados por cada corredor en cada vuelta del circuito, 
pudiendo haber realizado más de una vuelta cada uno y representando a la misma escudería en toda la 
competencia. Esos datos se han grabado en un archivo de texto, una línea por cada uno, no ordenado por ningún 
criterio: 
    ● Nombre Corredor (Cadena de 16) 
    ● Código Escudería (1 a 4) (*) 
    ● Tiempo de la vuelta del circuito (en segundos) 
(*) Considerar que 1 es Mercedes; 2 es McLaren; 3 es Ferrari; 4 es Williams 
Se pide desarrollar un programa Pascal, claro y eficiente, que ingrese desde un archivo la información de toda la 
competencia, almacenándola en las estructuras que corresponda, y luego resuelva: 
 
    a) Mostrar por pantalla para cada Escudería, su nombre y la cantidad de vueltas totales que realizaron los 
       corredores pertenecientes a la misma. Para resolverlo, se pide no recorrer los arreglos más de una vez. 
    b) Mostrar el nombre del Corredor que alcanzó el primer puesto de la competencia (se calcula en base al menor 
       promedio de tiempo entre todas las vueltas). En caso de haber más de uno, se elige el Corredor que haya 
       realizado la mayor cantidad de vueltas (suponer único) 
    c) Dado un Código de Escudería E y un tiempo T (en segundos) determinar si todos los corredores de E realizaron 
       un tiempo promedio menor o igual a T (E y T se ingresan por teclado) }
const
    MAX = 20;
type
    ST16 = string[16];
    TVNom = array[1..MAX] of ST16;
    TVEsc = array[1..MAX] of 1..4;
    TVCantVue = array[1..MAX] of byte;
    TVTiempoProm = array[1..MAX] of real;

function Busqueda(vecNom:TVNom;nom:ST16;cantPilotos:byte):byte;
var
    i:byte;
begin
    i:=1;
    while (i<=cantPilotos) and (vecNom[i]<>nom) do
        i:=i+1;
    if i<=cantPilotos then
        Busqueda:=i
    else
        Busqueda:=0;
end;

procedure LecturaArch(var vecNom:TVNom; var vecEsc:TVEsc; var vecCantVue:TVCantVue; var vecTiempoProm:TVTiempoProm;var cantPilotos:byte);
var
    arch:text;
    pos,tiempoVue,i:byte;
    nom:ST16;
    esc:1..4;

begin
    Assign(Arch,'datos.TXT');
    Reset(Arch);
    cantPilotos:=0;
    while NOT Eof(arch) do
    begin
        ReadLn(arch,nom,esc,tiempoVue);
        
        pos:=Busqueda(vecNom,nom,cantPilotos);
        if pos=0 then
        begin
            cantPilotos:=cantPilotos+1;
            vecNom[cantPilotos]:=nom;
            vecEsc[cantPilotos]:=esc;
            vecCantVue[cantPilotos]:=1;
            vecTiempoProm[cantPilotos]:=tiempoVue;
        end
        else
            begin
                vecCantVue[pos]:=vecCantVue[pos]+1;
                vecTiempoProm[pos]:=vecTiempoProm[pos]+ tiempoVue;
            end;
    end;
    for i:=1 to cantPilotos do
        vecTiempoProm[i]:=vecTiempoProm[i]/vecCantVue[i];
    Close(arch);
end;
//a)
procedure VueltasPorEscuderia(vecNom:TVNom;vecEsc:TVEsc;vecCantVue:TVCantVue;cantPilotos:byte);
var
    vecVueltasPorEscuderia:array[1..4] of byte;
    i:Byte;
begin
    for i:=1 to 4 do
        vecVueltasPorEscuderia[i]:=0;

    for i:=1 to cantPilotos do
        vecVueltasPorEscuderia[vecEsc[i]]:=vecVueltasPorEscuderia[vecEsc[i]]+vecCantVue[i];
    
    for i:=1 to 4 do
    begin
        Write('La escuderia ');
        case i of
            1: Write('Mercedes');
            2: Write('McLaren');
            3: Write('Ferrari');
            4: Write('Williams');
        end;
        WriteLn(' tiene ',vecVueltasPorEscuderia[i], ' vueltas recorridas');
    end;
end;
//b)
procedure PrimerPuest(vecNom:TVNom;vecTiempoProm:TVTiempoProm;vecCantVue:TVCantVue;cantPilotos:byte);
var
    posPri,i:byte;
begin
    posPri:=0;
    for i:=1 to cantPilotos do
        if ((vecTiempoProm[posPri]>vecTiempoProm[i]) or (posPri=0)) or ((vecTiempoProm[posPri]=vecTiempoProm[i]) and (vecCantVue[posPri]<vecCantVue[i])) then
            posPri:=i;

    WriteLn('El corredor en el primer puesto es: ', vecNom[posPri]);
end;
//c)
procedure VerificarTiempoMenorA(vecEsc:TVEsc;vecTiempoProm:TVTiempoProm;cantPilotos:byte);
var
    E,i:byte;
    T:real;
    todos:Boolean;
begin
    repeat
        WriteLn('Ingresa una escuderia');
        ReadLn(E);
    until E in [1..4];
    repeat
        WriteLn('Ingrese un tiempo promedio');
        ReadLn(T);
    until T>0;
    todos:=true;
    i:=1;
    while (i<=cantPilotos) and (todos) do
    begin
        if (vecEsc[i]=E) and (vecTiempoProm[i]>=T) then
            todos:=false;
        i:=i+1;
    end;
      
    if todos then
        WriteLn('Verdadero. Todos los pilotos de la escuderia ', E, ' tienen un tiempo promedio menor que ', T:0:2)
    else
        WriteLn('Falso. No todos los pilotos de la escuderia ', E, ' tienen un tiempo promedio menor a ', T:0:2);
end;
var
    vecNom:TVNom; 
    vecEsc:TVEsc;
    vecCantVue:TVCantVue;
    vecTiempoProm:TVTiempoProm;
    cantPilotos:byte;
begin
    LecturaArch(vecNom,vecEsc,vecCantVue,vecTiempoProm,cantPilotos);
    VueltasPorEscuderia(vecNom,vecEsc,vecCantVue,cantPilotos);
    PrimerPuest(vecNom,vecTiempoProm,vecCantVue,cantPilotos);
    VerificarTiempoMenorA(vecEsc,vecTiempoProm,cantPilotos);
end.