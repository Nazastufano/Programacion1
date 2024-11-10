Program Parcial;

{En una ruta argentina, se intenta determinar el correcto funcionamiento de un nuevo radar, que detecta la 
velocidad a la que circulan los vehículos. En un archivo de texto RADAR.TXT se encuentra la información obtenida 
por el radar en un determinado día. El archivo contiene: 
    ● Tipo Vehículo (1-Moto, 2-Auto, 3-Camión)  
    ● Velocidad (expresada en Km/h)  
    ● Zona de la lectura (AN3), ya está validada 
    ● Patente (Cadena de 7) 
Se pide desarrollar un programa Pascal, claro y eficiente, que ingrese desde un archivo la información 
almacenándola en las estructuras que corresponda, sólo si corresponde a una infracción.  
Se entiende por infracción al exceso de velocidad, para Motos > 100 Km/h, para Autos > 110 Km/h y para 
Camiones > 90 Km/h.  
La multa a abonar por cada infracción es una tasa fija (Motos: $1000, Autos: $2000, Camiones: $5000) 
multiplicada por un factor que depende de la zona en la que se produjo. Este factor se obtiene de otro archivo de 
texto ZONAS.TXT: 
    ● Zona (AN3) 
    ● Coeficiente para multiplicar tasa fija  
Luego resuelva: 
    a) Promedio de velocidad de las lecturas del radar que no corresponden a infracciones. 
    b) Patente correspondiente a la máxima velocidad de las infracciones cometidas en cada zona (si se repite la
       velocidad máxima, tomar la última). 
    c) Importe total de multas de una zona ingresada por teclado (puede no existir). 
Importante: Debe implementar funciones o procedimientos en los procesos que corresponda. }
const
    MAX = 20;
type
    ST3 = string[3];
    ST7 = string[7];
    TVZona = array[1..MAX] of ST3;
    TVReal = array[1..MAX] of Real;
    TVAcum = array[1..2] of Word;
    TVPatente = array[1..MAX] of ST7;
    TVTipoVehi = array[1..MAX] of byte;
    TVVelocidad = array[1..MAX] of word;

procedure LecturaArchZona(var vecZonas:TVZona;var vecCoef:TVReal; var cantZonas:byte);
var
    arch:text;
    zona:ST3;
    coefMult:real;

begin
    Assign(arch,'ZONAS.TXT');
    Reset(arch);
    cantZonas:=0;
    while NOT Eof(arch) do
    begin
        cantZonas:=cantZonas+1;
        ReadLn(arch,zona,coefMult);
        vecZonas[cantZonas]:=zona;
        vecCoef[cantZonas]:=coefMult;
    end;
    Close(arch);
end;
function Busqueda(vecZonas:TVZona;zona:ST3;cantZonas:byte):byte;
var
    i:byte;
begin
    i:=1;
    while (i<=cantZonas) and (zona<>vecZonas[i]) do
        i:=i+1;
    if i<=cantZonas then
        Busqueda:=i
    else
        Busqueda:=0;
end;

procedure LecturaArchRadar(var vecPatente:TVPatente;var vecVelocidad:TVVelocidad;var vecMulta:TVReal;
                            var vecZonaPA:TVZona;var velYCant:TVAcum; vecCoef:TVReal;vecZonas:TVZona; 
                            var cantMultas:byte;cantZonas:byte);
var
    arch:text;
    pos,tipoVehiculo,velocidad:byte;
    zona:ST3;
    patente:ST7;
    aux:Char;

begin
    Assign(arch,'RADAR.TXT');
    Reset(arch);
    velYCant[1]:=0;
    velYCant[2]:=0;
    cantMultas:=0;
    while NOT Eof(arch) do
    begin
        ReadLn(arch,tipoVehiculo,velocidad,aux,zona,aux,patente);
        if ((tipoVehiculo=1) and (velocidad>100)) or ((tipoVehiculo=2) and (velocidad>110)) or ((tipoVehiculo=3) and (velocidad>90)) then
        begin
            cantMultas:=cantMultas+1;
            vecPatente[cantMultas]:=patente;
            vecVelocidad[cantMultas]:=velocidad;
            vecZonaPA[cantMultas]:=zona;
            pos:=Busqueda(vecZonas,zona,cantZonas);
            case tipoVehiculo of
                1:vecMulta[cantMultas]:=1000*(1+vecCoef[pos]);
                2:vecMulta[cantMultas]:=2000*(1+vecCoef[pos]);
                3:vecMulta[cantMultas]:=5000*(1+vecCoef[pos]);
            end;
        end
        else
            begin
                velYCant[1]:=velYCant[1]+velocidad;
                velYCant[2]:=velYCant[2]+1;
            end;
    end;
    Close(arch);
end;
procedure PromVelSinMulta(velYCant:TVAcum);
begin
    if velYCant[2]<>0 then
        WriteLn('El promedio de las velocidades de los autos sin multa es: ', velYCant[1]/velYCant[2]:0:2)
    else
        WriteLn('No hay autos sin multa');
end;
procedure maxVelPorZona(vecPatente:TVPatente;vecZonaPA,vecZonas:TVZona;vecVelocidad:TVVelocidad;cantMultas,cantZonas:byte);
var
    vecMaxVel:TVVelocidad;
    vecPatMaxVel:TVPatente;
    i,pos:byte;
begin
    for i:=1 to cantZonas do
        vecMaxVel[i]:=0;
    
    for i:=1 to cantMultas do
    begin
        pos:=Busqueda(vecZonas,vecZonaPA[i],cantZonas);
        if vecMaxVel[pos]<vecVelocidad[i] then
        begin
            vecMaxVel[pos]:=vecVelocidad[i];
            vecPatMaxVel[pos]:=vecPatente[i];
        end;
    end;
    for i:=1 to cantZonas do
        if vecMaxVel[i]<>0 then
            WriteLn('La patente con la velocidad maxima de la zona ', vecZonas[i], ' es ', vecPatMaxVel[i]);
end;

procedure importeDeZona(vecMulta:TVReal;vecZonas,vecZonaPA:TVZona;zona:ST3;cantMultas,cantZonas:byte);
var
    pos,i:byte;
    importeTotal:real;
begin
    importeTotal := 0;
    pos := Busqueda(vecZonas,zona,cantZonas);
    if pos<>0 then
        begin
            for i:=1 to cantMultas do
            begin
                if (zona=vecZonaPA[i]) then
                    importeTotal:=importeTotal+vecMulta[i];
            end;
            WriteLn('El importe de la zona ', zona, ', ingresada por teclado, es ', importeTotal:0:2);
        end
    else
        WriteLn('La zona ingresada no existe');
    
end;
var
    vecZonas,vecZonaPA:TVZona;
    vecCoef,vecMulta:TVReal; 
    vecPatente:TVPatente;
    vecVelocidad:TVVelocidad;
    velYCant:TVAcum;
    cantMultas,cantZonas:byte;
    zona:ST3;
begin
    LecturaArchZona(vecZonas,vecCoef,cantZonas);
    LecturaArchRadar(vecPatente,vecVelocidad,vecMulta,vecZonaPA,velYCant,vecCoef,vecZonas,cantMultas,cantZonas);
    PromVelSinMulta(velYCant);
    maxVelPorZona(vecPatente,vecZonaPA,vecZonas,vecVelocidad,cantMultas,cantZonas);
    
    WriteLn('Ingrese una zona');
    ReadLn(zona);
    zona:=upCase(zona);
    importeDeZona(vecMulta,vecZonas,vecZonaPA,zona,cantMultas,cantZonas);
end.