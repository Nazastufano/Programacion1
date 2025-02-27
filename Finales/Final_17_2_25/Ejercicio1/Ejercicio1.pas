Program Ejercicio1;

(**)
type
    ST3 = string[3];
    ST10 = string[10];

    TRegMed = record
        codLab:ST3;
        nomMed:string;
        codPresentacion:1..5;
        descripcion:ST10;
        cantDisp:word;
        precio:real;
        compraMin,porcenDescuento:byte;
    end;

    TRegLab = record
        cod:ST3;
        nombreLab:string;
    end;
    TRegCod = record
        codPresentacion:1..5;
        tipoMedi:string;
    end;

    TRegCC = record
        datos:TRegCod;
        cantArt:word;
    end;

    TVecLab = array[1..50] of TRegLab;
    TVecCod = array[1..5] of TRegCC;

    TArchMed = file of TRegMed;
    TArchLab = file of TRegLab;
    TArchCod = file of TRegCod;

procedure ArmarVecLab(var archLab:TArchLab;var vecLab:TVecLab;var cantLab:byte);
var
    i:byte;
    R:TRegLab;
begin
    reset(archLab);
    read(archLab,R);
    i:=0;
    while NOT eof(archLab) do
    begin
        i:=i+1;
        vecLab[i]:=R;
        read(archLab,R);
    end;
    cantLab:=i;
    Close(archLab);
end;

procedure ArmarVecCod(var archCod:TArchCod;var vecCod:TVecCod);
var
    i:byte;
    R:TRegCod;
begin
    reset(archCod);
    read(archCod,R);
    i:=0;
    while NOT eof(archCod) do
    begin
        i:=i+1;
        vecCod[i].datos:=R;
        vecCod[i].cantArt:=0;
        read(archCod,R);
    end;
    close(archCod);
end;

function BusquedaCodLab(vecLab:TVecLab;codLab:ST3;cantLab:byte):byte;
var
    i:byte;
begin
    i:=1;
    while (i<cantLab) and (vecLab[i].cod<>codLab) do
        i:=i+1;
    BusquedaCodLab:=i;
end;

procedure MostrarLista(vecCod:TVecCod);
var
    i:byte;
begin
    WriteLn('Codigo-Presentacion        Tipo            Cant. de Articulos');
    for i:=1 to 5 do
        WriteLn('   ',vecCod[i].datos.codPresentacion,'       ',vecCod[i].datos.tipoMedi,'     ',vecCod[i].cantArt)
end;

procedure ArmarListado(var archMed:TArchMed; var vecCod:TVecCod;vecLab:TVecLab;cantLab:byte);
var
    RMe,RAux:TRegMed;
    maxCantMed,cantMedDesc,cantMed20Desc, posLab:byte;
    codLabMasMedDes, codLabActual:ST3;
    medActual:String;
    codPresentActual:1..5;
begin
    reset(archMed);
    read(archMed,RMe);
    WriteLn('           Listado de Ofertas');
    maxCantMed:=0;
    
    while Not Eof(archMed) do
    begin
        codLabActual:=RMe.codLab;
        cantMedDesc:=0;
        cantMed20Desc:=0;
        posLab:=BusquedaCodLab(vecLab,codLabActual,cantLab);
        WriteLn('Codigo de Laboratorio ', codLabActual,'        Nombre: ', vecLab[posLab].nombreLab);
        while codLabActual=RMe.codLab do
        begin
            medActual:=RMe.nomMed;
            WriteLn('Medicamento: ',medActual);
            WriteLn('Tipo present   Descripcion     Minimo de unid      % de Dcto       Precio      Cantidad Disp.');
            while (codLabActual=RMe.codLab) and (medActual=RMe.nomMed) do
            begin
                codPresentActual:=RMe.codPresentacion;
                while (codLabActual=RMe.codLab) and (medActual=RMe.nomMed) and (codPresentActual=RMe.codPresentacion) do
                begin
                    if RMe.porcenDescuento<>0 then
                    begin
                        cantMedDesc:=cantMedDesc+1;
                        if (RMe.porcenDescuento>=20) then
                            cantMed20Desc:=cantMed20Desc+1;
                        
                        vecCod[codPresentActual].cantArt:=vecCod[codPresentActual].cantArt+1;
                        WriteLn(codPresentActual,'  ', Rme.descripcion,'    ',RMe.compraMin,'   ',RMe.porcenDescuento,'%   $',rme.precio,'  ',RMe.cantDisp);
                    end;
                    read(archMed,RMe);
                end;
            end;
        end;
        WriteLn('Cantidad de medicamentos con mas del 20% de descuento: ',cantMed20Desc);
        if cantMedDesc>maxCantMed then
        begin
            maxCantMed:=cantMedDesc;
            codLabMasMedDes:=codLabActual;
        end;
    end;
    WriteLn('El Laboratorio ', vecLab[codLabMasMedDes].nombreLab,' tiene la mayor cantidad de medicamentos con descuento');
    close(archMed);
end;

var
    archCod:TArchCod;
    archMed:TArchMed;
    archLab:TArchLab;
    vecCod:TVecCod;
    vecLab:TVecLab;
    cantLab:byte;
begin
    Assign(archCod,'CODIGOS.DAT');
    Assign(archMed,'MEDICAMENTOS.DAT');
    Assign(archLab,'LABORATORIOS.DAT');

    ArmarVecLab(archLab,vecLab,cantLab);
    ArmarVecCod(archCod,vecCod);
    ArmarListado(archMed,vecCod,vecLab,cantLab);
    MostrarLista(vecCod);
end.