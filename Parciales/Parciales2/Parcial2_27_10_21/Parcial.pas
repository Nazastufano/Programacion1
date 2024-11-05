Program Parcial;

(*Un edificio de departamentos de N pisos registra información respecto a los ocupantes de cada 
departamento(son 6 departamentos por piso). Esta información se encuentra en un archivo de texto 
OCUPANTES.TXT. El archivo no está ordenado por ningún criterio y no se registra información de los 
departamentos desocupados. La primera línea contiene el valor de N, y desde la segunda línea cada una 
contiene los siguientes datos: 
    • Piso (1..N)
    • Departamento (1..6)
    • Apellido del ocupante responsable (cadena de 12) 
    • Categoría (cadena de 3, referencia en archivo CATEGORIAS.TXT) 
    • Cantidad de ocupantes del departamento 
    • Propietario (S/N) 

El archivo CATEGORIAS.TXT posee los siguientes datos: 
    • Código (cadena de 3) 
    • Descripción 
    • Importe mensual expensas. Los propietarios tienen un 10% de descuento. 

Se pide leer los datos y almacenarlos en estructuras adecuadas. Luego, obtener e informar: 
    a) Cuántos pisos tienen todos sus departamentos ocupados por más de 2 personas. 
    b) Dada una categoría CATEG ingresada por teclado calcular lo que debería abonarse en 
    concepto de expensas en un mes para dicha categoría. 
    c) Generar un arreglo con los apellidos y pisos de los ocupantes que son propietarios de los 
    departamentos identificados con un número  (entre 1 y 6)  ingresado por teclado. Luego 
    mostrar el arreglo generado. 
Condición para aprobar: los siguientes subprogramas (función o procedimiento, según corresponda), 
necesarios para resolver el problema planteado, deben ser resueltos correctamente en forma recursiva: 
- Verificar si determinado piso tiene todos sus departamentos ocupados con más de 2 personas (para el 
inciso a)  
- Contar departamentos ocupados en todo el edificio para determinada categoría (discriminado en 
propietarios y no propietarios) (para el inciso b)  

Importante: 
    • Los archivos deben recorrerse una sola vez. 
    • La solución se debe implementar usando indefectiblemente registros, vectores y matrices 
    • Cada proceso debe ser implementado en un subprograma (según corresponda función o 
      procedimiento) 
    • Se considerarán la eficiencia, claridad y modularización adecuada del código. 
    • Los datos del ejemplo son ilustrativos para realizar una ejecución con los mismos, NO deben 
      figurar como constantes en el código desarrollado. 
    • Para entregar, nombrar el archivo .PAS o .LPR con su apellido (NO subir archivo .LPI ni .LPS)*)
type
    ST3 = string[3];
    ST12 = string[12];
    TRegOcu = record
        piso,departamento,cantOcup:byte;
        propietario:char;
        categoria:ST3;
        apellido:ST12;
    end;
    TRegCat = record
        cod:ST3;
        descripcion:ST12;
        expensas:real;
    end;
    TRegAP = record
        apellido:ST12;
        piso:byte;
    end;
    TM = array[1..10,1..6] of TRegOcu;
    TVCat = array[1..3] of TRegCat;
    TVRegAP = array[1..10] of TRegAP;
    TV2 = array[1..2] Of byte;

procedure InicializarMatriz(var matr:TM;N:byte);
var
    i,j:byte;
begin
    for i:=1 to N do
        for j:=1 to 6 do
            matr[i,j].cantOcup:=0;
end;

procedure LecturaO(var matr:TM;var N,cantOcupantes:byte);
var
    arch:Text;
    piso,departamento,cantOcup:byte;
    apellido:ST12;
    aux,propietario:char;
    categoria:ST3;
begin
    Assign(arch,'OCUPANTES.TXT');
    Reset(arch);
    ReadLn(arch,N);
    cantOcupantes:=0;
    InicializarMatriz(matr,N);
    while NOT eof(arch) do
    begin
        cantOcupantes:=cantOcupantes+1;
        ReadLn(arch,piso,departamento,aux,apellido,categoria,cantOcup,aux,propietario);
        matr[piso,departamento].piso:=piso;
        matr[piso,departamento].departamento:=departamento;
        matr[piso,departamento].cantOcup:=cantOcup;
        matr[piso,departamento].propietario:=propietario;
        matr[piso,departamento].categoria:=categoria;
        matr[piso,departamento].apellido:=apellido;
    end;
end;
procedure LecturaC(var vecCat:TVCat);
var 
    arch:text;
    cod:ST3;
    descripcion:ST12;
    expensas:real;
    k:byte;
begin
    Assign(arch,'CATEGORIAS.TXT');
    Reset(arch);
    k:=0;
    while Not eof(arch) do
    begin
        ReadLn(arch,cod,descripcion,expensas);
        k:=k+1;
        vecCat[k].cod:=cod;
        vecCat[k].descripcion:=descripcion;
        vecCat[k].expensas:=expensas;
    end;
    close(arch);
end;

{a) Cuántos pisos tienen todos sus departamentos ocupados por más de 2 personas.
- Verificar si determinado piso tiene todos sus departamentos ocupados con más de 2 personas (para el 
inciso a)  }
function PisoSuperaMDP(matr:TM;j,piso:byte):Boolean;
begin
    if j=0 then
        PisoSuperaMDP:=true
    else
        if matr[piso,j].cantOcup>2 then
            PisoSuperaMDP := PisoSuperaMDP(matr,j-1,piso)
        else
            PisoSuperaMDP := false;
end;
procedure PisosMasDe2(matr:TM;N:byte);
var
    i,cont:byte;
begin
    cont:=0;
    for i:=1 to N do
    begin
        if PisoSuperaMDP(matr,6,i) then
            cont:=cont+1;
    end;
    WriteLn('La cantidad de pisos todos los departamentos con mas de 2 personas es: ',cont);
end;

{b) Dada una categoría CATEG ingresada por teclado calcular lo que debería abonarse en 
    concepto de expensas en un mes para dicha categoría. 
- Contar departamentos ocupados en todo el edificio para determinada categoría (discriminado en 
propietarios y no propietarios) (para el inciso b)}

procedure ContarDepsMismCategVec(var vec:TV2;matr:TM;i,j:byte;categ:ST3);
begin
    if i<>0 then
    begin
        if matr[i,j].categoria=categ then
            if matr[i,j].propietario = 'S' then
                vec[1] := vec[1] + 1
            else
                vec[2] := vec[2] + 1;
        if j>1 then
            ContarDepsMismCategVec(vec,matr,i,j-1,categ)
        else
            ContarDepsMismCategVec(vec,matr,i-1,6,categ);
    end;   
end;
{
function ContarDepsMismCateg(matr:TM;i,j:Byte;categ:ST3):byte;
var
    cont:byte;
begin
    cont:=0;
    if i=0 then
        ContarDepsMismCateg:=cont
    else
        begin
            if categ = matr[i,j].categoria then
                cont:=1;
            if j>1 then
                ContarDepsMismCateg := cont + ContarDepsMismCateg(matr,i,j-1,categ)
            else
                ContarDepsMismCateg := cont + ContarDepsMismCateg(matr,i-1,6,categ);    
        end;
end;
}

procedure InicializarArreglo(var vec:TV2);
var
    i:byte;
begin
    for i:=1 to 2 do
        vec[i]:=0;
end;

procedure CalcularAbono(matr:TM;vecCat:TVCat;N:byte);
var
    i:byte;
    categ:ST3;
    vec:TV2;
    totalAPagar:real;
begin
    WriteLn('Ingrese una categoria');
    ReadLn(categ);
    categ:=upcase(categ);
    
    InicializarArreglo(vec);
    ContarDepsMismCategVec(vec,matr,N,6,categ);
    
    totalAPagar:=0;
    i:=1;
    while (i<=3) and (vecCat[i].cod <> categ) do
        i:=i+1;

    if i>3 then
        WriteLn('No hay ocupantes en esa categoria')
    else
        begin
            totalAPagar:= vecCat[i].expensas*((0.9*vec[1]) + vec[2]);  
            WriteLn('El total a pagar para la categoria: ',categ,' es $',totalAPagar:0:2);
        end;
        

end;



{c) Generar un arreglo con los apellidos y pisos de los ocupantes que son propietarios de los 
    departamentos identificados con un número  (entre 1 y 6)  ingresado por teclado. Luego 
    mostrar el arreglo generado. }

procedure MostrarArreglo(VRegAP:TVRegAP;K:byte);
var
    i:byte;
begin
    Write('[');
    for i:=1 to K do
    begin
        if i<>K then
            Write('(',VRegAP[i].apellido,', ',VRegAP[i].piso,'),')
        else  
            Writeln('(',VRegAP[i].apellido,', ',VRegAP[i].piso,')]');
    end;
end;
procedure GenerarArreglo(matr:TM;N:byte);
var
    departamento,i,k:byte;
    VRegAP:TVRegAP;
begin
    WriteLn('Ingrese un departamento');
    ReadLn(departamento);
    for i:=1 to N do
    begin
        if matr[i,departamento].cantOcup<>0 then
        begin
            k:=k+1;
            VRegAP[k].apellido:=matr[i,departamento].apellido;
            VRegAP[k].piso:=matr[i,departamento].piso;
        end;
    end;
    if k<>0 then
        MostrarArreglo(VRegAP,K)
    else
        WriteLn('No existen pisos con ese departamento ocupado');
end;
var
    N,cantOcupantes:byte;
    vecCat:TVCat;
    matr:TM;
    VRegAP:TVRegAP;
begin
    LecturaO(matr,N,cantOcupantes);
    LecturaC(vecCat);
    PisosMasDe2(matr,N);
    GenerarArreglo(matr,N);
    CalcularAbono(matr,vecCat,N);
end.