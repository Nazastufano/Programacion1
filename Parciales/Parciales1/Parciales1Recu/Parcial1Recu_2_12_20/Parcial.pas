Program Parcial;

(*En el archivo de texto ‘HISOPADOS.TXT‘ están registrados los resultados de diferentes estudios 
realizados en un Laboratorio de Análisis Clínicos, de la siguiente forma: 
    ● Código de Paciente (ANU6) 
    ● PCR positivo: S o N (indicando Si o No) 
    ● IGG e IGM: dos valores numéricos reales 
    
Se pide procesar el archivo y almacenar en una estructura adecuada (sólo por cada hisopado en el 
que el PCR dio positivo), el Código de Paciente y los valores de IGG y de IGM, ordenado 
descendente por IGG. 
Luego, con los pacientes seleccionados, hallar e informar: 
    a) Cantidad de los pacientes que tuvieron IGG superando un umbral X, e IGM superando un 
       umbral Y, respectivamente (con X e Y ingresados por teclado). 
    b) Dado un Código de paciente K ingresado por teclado, informar su IGM e IGG (puede no 
       existir). 
    c) El porcentaje de pacientes que han obtenido un IGM superior al IGG (sobre el total de 
       pacientes con PCR positivo). *)
const
    MAX = 20;  
type
    ST6 = String[6];
    TVReal = array[1..MAX] of real;
    TVCod = array[1..MAX] of ST6;

procedure InsertarOrdenado(var vecCod:TVCod; var vecIGG, vecIGM:TVReal;cod:ST6; IGG,IGM:real;cantHisopados:byte);
var
    j:byte;
begin
    j:=cantHisopados;
    while (j>0) and (vecIGG[j]<IGG) do
    begin
        vecCod[j+1]:=vecCod[j];
        vecIGG[j+1]:=vecIGG[j];
        vecIGM[j+1]:=vecIGM[j];
        j:=j-1;
    end;
    vecCod[j+1]:=cod;
    vecIGG[j+1]:=IGG;
    vecIGM[j+1]:=IGM;
end;
function Busqueda(cod:ST6;vecCod:TVCod;cantHisopados:byte):byte;
var
    i:byte;
begin
    i:=1;
    while (i<=cantHisopados) and (vecCod[i]<>cod) do
        i:=i+1;
    if i<=cantHisopados then
        Busqueda:=i
    else
        Busqueda:=0;
end;
procedure LecturaArch(var vecCod:TVCod; var vecIGG, vecIGM:TVReal; var cantHisopados:byte);
var
    arch:Text;
    cod:ST6;
    PCR,aux:char;
    IGG,IGM:real;
begin
    cantHisopados:=0;
    Assign(arch,'HISOPADOS.TXT');
    Reset(arch);

    while Not eof(arch) do
    begin
        ReadLn(arch,cod,aux,PCR,IGG,IGM);
        if PCR = 'S' then
        begin
            cantHisopados:=cantHisopados+1;
            vecCod[cantHisopados]:=cod;
            vecIGG[cantHisopados]:=IGG;
            vecIGM[cantHisopados]:=IGM;
            InsertarOrdenado(vecCod,vecIGG,vecIGM,cod,IGG,IGM,cantHisopados);
        end;
    end;
    Close(arch);
end;
//a)
procedure CantPacientesSuperanXeY(vecIGG,vecIGM:TVReal;cantHisopados:byte);
var
    cant,i:byte;
    x,y:real;
begin
    WriteLn('Ingrese un valor de IGG a superar');
    ReadLn(x);
    WriteLn('Ingrese un valor de IGM a superar');
    ReadLn(y);
    cant:=0;
    for i:=1 to cantHisopados do
        if (vecIGG[i]>x) and (vecIGM[i]>y) then
            cant:=cant+1;
    WriteLn('La cantidad que superan un IGG de ',x:0:2,' y un IGM de ', y:0:2,' es: ', cant);
end;

procedure InformarIGMeIGG(vecCod:TVCod;vecIGG,vecIGM:TVReal;cantHisopados:Byte);
var
    pos,i:byte;
    cod:ST6;

begin
    WriteLn('Ingrese un codigo para informar IGM e IGG');
    ReadLn(cod);
    cod:=upCase(cod);
    pos:= Busqueda(cod,vecCod,cantHisopados);
    if pos<>0 then
        WriteLn('El IGM del codigo ingresado es: ', vecIGM[pos]:0:2, ' y el IGG es ', vecIGG[pos]:0:2)
    else
        WriteLn('El codigo ingresado no existe');
end;

//c)
procedure IGMMayorQueIGG(vecIGG,vecIGM:TVReal;cantHisopados:byte);
var
    i,cant:byte;

begin
    cant:=0;
    for i:=1 to cantHisopados do
        if vecIGM[i]>vecIGG[i] then
            cant:=cant+1;
    WriteLn('El porcentaje de pacientes que han obtenido un IGM mayor que IGG es de %', cant*100/cantHisopados:0:2);
end;

var
    vecCod:TVCod;
    vecIGG, vecIGM:TVReal; 
    cantHisopados:byte;
begin
    LecturaArch(vecCod,vecIGG,vecIGM,cantHisopados);
    CantPacientesSuperanXeY(vecIGG,vecIGM,cantHisopados);
    InformarIGMeIGG(vecCod,vecIGG,vecIGM,cantHisopados);
    IGMMayorQueIGG(vecIGG,vecIGM,cantHisopados);
end.