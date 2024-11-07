Program Parcial;

{Un banco cuenta con la informaciión de los accesos a su homebanking en el archivo Bank.TXT. De cada acceso se conoce:

    Usuario (secuencia de caracteres, letras y digitos, comenzando con un digito)
    IP origen (12 dígitos con puntos, ej 192.168.001.100)
    Tiempo de conexión (entero en segundos)

Dicha información está grabada en un archivo de texto, en cada línea una conexión con el siguiente formato:
XXXXXXXXXXXXblancoXXX.XXX.XXX.XXXblanco...blanco999

Se puede identificar según como comienza la dirección IP desde donde fueron realizados los accesos:
192 Red interna del Banco - 276 Desde Mar del Plata - 381 Desde Argentina - Otras Internacional

Por seguridad, el Usuario está encriptado dentro del archivo. Para desencriptarlo, por cada número X que aparece se deben
considerar las X letras que le siguen y descartar el resto hasta el próximo número
Ej:
    1JEF3UANETE1ZYH => JUANZ

Se pide desarrollar un programa eficaz, eficeiente y claro que lea el archivo (una sola vez) y almacene en estructuras
adecuadas el Usuario desencripatdo junto a la inforamción necesaria para luego calcular e infromar:
a) Para un determinado usuario (ingresa por teclado desencriptado) su tiempo de acceso.
b) Tiempo promedio de accesos internacionales que se realizaron
c) Usuario con origen en la red interna del banco con mayor tiempo de conexión
}
const
    MAX = 10;

type
    ST10 = string[10];
    ST3 = string[3];
    TVST10 = array[1..MAX] of ST10;
    TVST3 = array[1..MAX] of ST3;
    TVWord = array[1..MAX] of word;

procedure LecturaArch(var vecNom:TVST10; var vecIp:TVST3; var vecTiempoUso:TVWord;var cantUsuarios:byte);
var
    arch:text;
    car:char;
    nombre:ST10;
    ip:ST3;
    tiempoConexion:word;
    num,i,err:byte;
begin
    Assign(arch,'Bank.TXT');
    Reset(arch);
    cantUsuarios:=0;
    while Not eof(arch) do
    begin
        cantUsuarios:=cantUsuarios+1;
        nombre:='';
        ip:='';
        while car<>' ' do
        begin
            Read(arch,car);
            if car in ['1'..'9'] then
            begin
                Val(car,num,err);
                for i:=1 to num do
                begin
                    Read(arch,car);
                    nombre:=nombre+car;
                end;
            end
        end;
        for i:=1 to 15 do
        begin
            Read(arch,car);
            if i<=3 then
                ip:=ip+car;
        end;
        ReadLn(arch,tiempoConexion);
        vecNom[cantUsuarios]:=nombre;
        vecIp[cantUsuarios]:=ip;
        vecTiempoUso[cantUsuarios]:=tiempoConexion;
    end;
    Close(arch);
end;

function Busqueda(vecNom:TVST10;nom:ST10;cantUsuarios:byte):byte;
var
    i:byte;
begin
    i:=1;
    while (i<=cantUsuarios) and (vecNom[i]<>nom) do
        i:=i+1;
    if i<=cantUsuarios then
        Busqueda:=i
    else
        Busqueda:=0;
end;

//a)

procedure TiempoDeAcceso(vecNom:TVST10;vecTiempoUso:TVWord;cantUsuarios:byte);
var
    pos:byte;
    nom:ST10;

begin
    WriteLn('Ingrese un nombre para ver su tiempo de acceso');
    ReadLn(nom);
    nom:=upCase(nom);
    pos:=Busqueda(vecNom,nom,cantUsuarios);
    if pos<>0 then
        Writeln('El tiempo de acceso de ', nom, ' es ', vecTiempoUso[pos])
    else
        WriteLn('El nombre no se encuentra disponible');
  
end;

procedure TiempoPromInternacionales(vecIp:TVST3;vecTiempoUso:TVWord;cantUsuarios:Byte);
var 
    i,cant:byte;
    suma:word;
begin
    suma:=0;
    cant:=0;
    for i:=1 to cantUsuarios do
        if (vecIp[i] <> '192') and (vecIp[i]<> '276') and (vecIp[i]<>'381') then
        begin
            cant:=cant+1;
            suma:=vecTiempoUso[i]+suma;
        end;
    if cant<>0 then
        WriteLn('El promedio de tiempo de accesos internacionales es: ',suma/cant:0:2)
    else
        WriteLn('No hubo accesos internacionales');
end;
//c)
procedure UsuarioConexionInternaMasTiempo(vecNom:TVST10;vecIp:TVST3;vecTiempoUso:TVWord;cantUsuarios:byte);
var
    i,posMax:byte;
    
begin
    posMax:=0;
    for i:=1 to cantUsuarios do
        if (vecIp[i]='192') and ((posMax=0) or (vecTiempoUso[posMax]<vecTiempoUso[i])) then
            posMax:=i;
    WriteLn('El usuario con mayor tiempo de uso es ', vecNom[posMax]);
end;
var
    vecNom:TVST10; 
    vecIp:TVST3;
    vecTiempoUso:TVWord;
    cantUsuarios:byte;
begin
    LecturaArch(vecNom,vecIp,vecTiempoUso,cantUsuarios);
    TiempoDeAcceso(vecNom,vecTiempoUso,cantUsuarios);
    TiempoPromInternacionales(vecIp,vecTiempoUso,cantUsuarios);
    UsuarioConexionInternaMasTiempo(vecNom,vecIp,vecTiempoUso,cantUsuarios);
end.