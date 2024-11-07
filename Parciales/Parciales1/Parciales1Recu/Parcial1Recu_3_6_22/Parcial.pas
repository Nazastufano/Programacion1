Program Parcial;

(*En el último censo del 2022  se guardaron los datos en un archivo de texto CENSO.TXT con el siguiente 
contenido: 
    ● Código Comprobante de Censo (AN8, los últimos dos caracteres corresponden a la provincia) 
    ● Se realizó digitalmente (S/N) 
    ● Cantidad de habitantes de la vivienda 
    ● Ingreso total en $ de los habitantes de la vivienda (en miles) 
    ● Alquila (S/N) 
 
Adicionalmente, se dispone de otro archivo de PROVINCIAS.TXT con los siguientes datos clasificados en 3 
regiones dentro del país  
    ● Código Provincia (AN2) 
    ● Nombre Provincia (AN30) 
    ● Código de Región (C-Centro; N-Norte; S-Sur) 
    ● Cantidad de habitantes en 2010 
 
Se pide desarrollar un programa Pascal, claro y eficiente, que ingrese desde los archivos la información 
almacenando sólo la que sea relevante para este problema en las estructuras que corresponda, sólo si 
corresponde a censos digitales. 
Hallar y mostrar: 
 
    a) Cantidad de habitantes censados en cada región. 
    b) Nombre de la Provincia con mayor ingreso promedio por vivienda (si se repite el ingreso total tomar 
    la primera). 
    c) Importe total de subsidios de un código de provincia ingresado por teclado (puede no existir). 
    Considerando que el subsidio es el 10% del ingreso total de las viviendas, si la cantidad censada de la 
    provincia supera la cantidad de habitantes del 2010, de lo contrario no tiene subsidio 
 
Importante: Debe implementar funciones o procedimientos en los procesos que corresponda. Recorrer los 
archivos solo una vez. 
*)
const
    MAX = 10;
type
    ST6 = String[6];
    ST2 = string[2];
    ST30 = string[30];
    TVST2 = array[1..MAX] of ST2;
    TVST30 = array[1..MAX] of ST30;
    TVChar = array[1..MAX] of char;
    TVByte = array[1..MAX] of byte;
    TVWord = array[1..MAX] of word;
procedure IniVecByte(var vec:TVByte;cantRegiones:byte);
var
    i:byte;
begin
    for i:=1 to cantRegiones do
        vec[i]:=0;
end;

Procedure IniVecWord(Var vec:TVword;cantRegiones:byte);
Var 
    i:   byte;
Begin
    For i:=1 To cantRegiones Do
        vec[i] := 0;
End;


procedure LecturaArchProv(var vecCod:TVST2; var vecNom:TVST30; var vecRegion:TVChar;var vecCant:TVByte; var cantRegiones:byte);
var
    arch:Text;
    cod:ST2;
    aux,region:char;
    cant:byte;
    nombre:ST30;
begin
    Assign(arch,'PROVINCIAS.TXT');
    reset(arch);
    cantRegiones:=0;
    while Not Eof(arch) do
    begin
        ReadLn(arch, cod, aux, nombre, aux, region, cant);
        cantRegiones:=cantRegiones+1;
        vecCod[cantRegiones]:=cod;
        vecNom[cantRegiones]:=nombre;
        vecRegion[cantRegiones]:=region;
        vecCant[cantRegiones]:=cant;
    end;
    Close(arch);
end;

function Busqueda(vecCod:TVST2;cod:ST2;cantRegiones:byte):byte;
var
    i:byte;
begin
    i:=1;
    while (i<=cantRegiones) and (cod<>vecCod[i]) do
        i:=i+1;
    if i<=cantRegiones then
        Busqueda:=i
    else
        i:=0;
end;

procedure LecturaArchCenso(var vecContRep,vecContHab:TVByte; var vecAcum:TVWord; cantRegiones:byte;vecCod:TVST2);
var
    arch:text;
    auxST6:ST6;
    alquila,digital,aux:char;
    cod:ST2;
    cantHabi,ingreso,pos:byte;

begin
    Assign(arch,'CENSO.TXT');
    Reset(arch);

    IniVecByte(vecContRep,cantRegiones);
    IniVecByte(vecContHab,cantRegiones);
    IniVecWord(vecAcum,cantRegiones);
    while NOt Eof(arch) do
    begin
        ReadLn(arch,auxST6,cod,aux,digital,cantHabi,ingreso,aux,alquila);
        if digital='S' then
        begin
            pos:=Busqueda(vecCod,cod,cantRegiones);
            vecContRep[pos]:=vecContRep[pos]+1;
            vecContHab[pos]:=vecContHab[pos]+cantHabi;
            vecAcum[pos]:=vecAcum[pos]+ingreso;
        end;
    end;
    Close(arch);
end;
//a)
procedure CantHabiPorRegion(vecRegion:TVChar; vecContHab:TVByte; cantRegiones:byte);
var
    i:byte;
    vec:array[1..3] of byte;
begin
    for i:=1 to 3 do
        vec[i]:=0;
    for i:=1 to cantRegiones do
    begin
        case vecRegion[i] of
            'C':vec[1] := vec[1] + vecContHab[i];
            'S':vec[2] := vec[2] + vecContHab[i];
            'N':vec[3] := vec[3] + vecContHab[i];
        end;
    end;
    WriteLn('La region C tiene ', vec[1], ' censados. La S: ', vec[2], ' y la N: ', vec[3]);
end;

//b)
procedure NomProvMayorIngrProm(vecNom:TVST30; vecAcum:TVWord; vecContRep:TVByte; cantRegiones:byte);
var
    posMIP,i:byte;
    mayorIngresoProm:real;
    
begin
    mayorIngresoProm:=0;
    for i:=1 to cantRegiones do
        if (vecContRep[i]<>0) and (mayorIngresoProm<vecAcum[i]/vecContRep[i]) then
        begin
            mayorIngresoProm := vecAcum[i]/vecContRep[i];
            posMIP:=i;      
        end;
    WriteLn('El nombre de la provinca con mayor ingreso promedio es ',vecNom[posMIP]);
end;

//C)
procedure TotalDeSubsidios(vecCod:TVST2;vecCant,vecContHab:TVByte;vecAcum:TVWord;cantRegiones:byte);
var 
    cod:ST2;
    pos:Byte;
    importe:real;
begin
    WriteLn('Ingrese un codigo de provincia');
    ReadLn(cod);
    cod:=upCase(cod);
    pos:=Busqueda(vecCod,cod,cantRegiones);
    importe:=0;
    if pos<>0 then
        begin
            if vecContHab[pos]>vecCant[pos] then
                importe:=vecAcum[pos]*0.1;
            WriteLn('El importe de subsidio es: $', importe:0:2);
        end
    else
        WriteLn('El codigo ingresado no existe');
    
end;
var
    vecCod:TVST2; 
    vecNom:TVST30; 
    vecRegion:TVChar;
    vecContRep,vecContHab,vecCant:TVByte;
    vecAcum:TVWord;
    cantRegiones:byte;
    
begin
    LecturaArchProv(vecCod,vecNom,vecRegion,vecCant,cantRegiones);
    LecturaArchCenso(vecContRep,vecContHab,vecAcum,cantRegiones,vecCod);
    CantHabiPorRegion(vecRegion,vecContHab,cantRegiones);
    NomProvMayorIngrProm(vecNom,vecAcum,vecContRep,cantRegiones);
    TotalDeSubsidios(vecCod,vecCant,vecContHab,vecAcum,cantRegiones);
end.