Program Parcial;

{En un archivo se han grabado los datos de un conjunto de personas sobre las que se ha probado un nuevo 
medicamento para controlar la presión, la identificación de las mismas está encriptada para mantener su anonimato. 
En cada línea: 
    • presión máxima 
    • presión mínima 
    • Identificación que incluye el nombre y la edad encriptados 
Se pide leer el archivo y seleccionar solo los pacientes de riesgo(*) almacenando sus datos en tres arreglos  VNom, 
VEdad y VRiesgo. 
    - VNom contendrá el nombre 
    - VEdadcontendrá  la edad 
    - VRiesgo la diferencia entre la presión máxima y mínima 
La identificación deberá desencriptarse, se trata de una cadena de longitud variable terminada con un punto, a partir 
de la misma se obtendrá el nombre y la edad de la siguiente forma: 
El nombre se formará con los caracteres que sigan a un carácter #, & ó %, la edad será el 5 vecesla longitud de la 
cadena sin el punto. 
Luego, a partir de los arreglos obtenidos, calcular e informar: 
    a) Para un rango de edades [E1, E2], la diferencia promedio  
    b) Nombre y Edad de la persona de máxima diferencia 
    c) Cantidad de pacientes que registren menos de X % de diferencia con respecto a la máxima diferencia 
       obtenida en el punto b. 
Debe resolver cada item (lectura, a, b y c ) mediante una función o procedimiento, según corresponda.E1, E2 y X se 
piden por teclado antes del respectivo cálculo. 
(serán parámetros de entrada del subprograma que resuelve)  
 
(*) Se considera paciente de riesgo:  
 - por presión alta si: mínima >90  y máxima>140   
 - por presión baja si: mínima <65 y máxima<100  
 - o bien,  si la diferencia entre máxima y mínima es menor o igual a 25}
const
    Max = 10;
type
    ST10 = String[10];
    TVByte= array[1..Max] of byte;
    TVNom = array[1..Max] of ST10;
    
procedure LecturaArch(var vecEdad:TVByte; var vecNom:TVNom; var vecRiesgo:TVByte;var cantPacientes:byte);
var
    arch:text;
    pMinima,pMaxima,cantCaracteres:byte;
    nom:ST10;
    car:char;
begin
    Assign(arch,'datos.TXT');
    Reset(arch);
    cantPacientes:=0;
    
    while Not eof(arch) do
    begin
        Read(arch,pMaxima,pMinima,car);
        if ((pMinima>90) and (pMaxima>140)) or ((pMinima<65) and (pMaxima<100)) or (pMaxima-pMinima<=25) then
            begin
                cantPacientes:=cantPacientes+1;
                cantCaracteres:=0;
                nom:='';
                while (not eoln(arch)) and (car<>'.') do
                begin
                    Read(arch,car);
                    if car<>'.' then
                    begin
                        cantCaracteres:=cantCaracteres+1;
                        if (car='#') or (car='&') or (car = '%') then
                        begin
                            Read(arch,car);
                            cantCaracteres:=cantCaracteres+1;
                            nom:=nom+car;
                        end;
                    end;
                end;
                vecEdad[cantPacientes]:=cantCaracteres*5;
                vecNom[cantPacientes]:=nom;
                vecRiesgo[cantPacientes]:=pMaxima-pMinima;
            end;
        ReadLn(arch);
    end;
    Close(arch);
end;
//a)
procedure diferenciaPromE1yE2(vecRiesgo,vecEdad:TVByte;cantPacientes:byte);
var
    e1,e2,cant,i:byte;
    suma:word;
begin
    WriteLn('Ingrese una edad minima');
    ReadLn(e1);
    WriteLn('Ingrese una edad maxima');
    ReadLn(e2);

    cant:=0;
    suma:=0;
    for i:=1 to cantPacientes do
    begin
        if (vecEdad[i]>=e1) and (vecEdad[i]<=e2) then
        begin
            suma:=suma+vecRiesgo[i];
            cant:=cant+1;
        end;
    end;
    if cant<>0 then
        WriteLn('La diferencia promedio en el rango [',e1,', ',e2,'] es: ', suma/cant:0:2)
    else
        WriteLn('No hay pacientes en ese intervalo');
end;
//b)
procedure nomYEdadMaximaDif(vecEdad,vecRiesgo:TVByte;vecNom:TVNom;cantPacientes:byte);
var
    edadMax,difMax,i:byte;
    nombreMax:ST10;
    
begin
    for i:=1 to cantPacientes do
    begin
        if (i=1) or (difMax<vecRiesgo[i]) then
        begin
            difMax := vecRiesgo[i];
            nombreMax:= vecNom[i];
            edadMax:=vecEdad[i];
        end;
    end;
    WriteLn('El nombre del paciente con mayor diferencia de presion es: ',nombreMax,' y la edad es: ', edadMax);
end;
//c)
procedure cantPaciRegMenosDeX(vecRiesgo:TVByte;cantPacientes:byte);
var
    i,difMax,x,cant:byte;
begin
    repeat
        WriteLn('Ingrese un % (del 1 al 100)');
        ReadLn(x);
    until (x>0) and (x<=100);
    For i:=1 To cantPacientes Do
        If (i=1) Or (difMax<vecRiesgo[i]) Then
            difMax := vecRiesgo[i];
    cant:=0;
    for i:=1 to cantPacientes do
        if vecRiesgo[i]<difMax*(x/100) then
            cant:=cant+1;
    WriteLn('La cantidad de pacientes que registran menos de ',x,'% respecto a la maxima de ', difMax,' es ',cant );

end;
var
    vecEdad:TVByte;
    vecNom:TVNom;
    vecRiesgo:TVByte;
    cantPacientes:byte;
begin
    LecturaArch(vecEdad,vecNom,vecRiesgo,cantPacientes);
    diferenciaPromE1yE2(vecRiesgo,vecEdad,cantPacientes);
    nomYEdadMaximaDif(vecEdad,vecRiesgo,vecNom,cantPacientes);
    cantPaciRegMenosDeX(vecRiesgo,cantPacientes);
end.