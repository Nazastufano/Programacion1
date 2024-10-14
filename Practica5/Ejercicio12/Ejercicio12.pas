Program Ejercicio12;

(*Ej 12) En un archivo de texto se ha grabado por cada línea, una cadena (es una clave encriptada que
puede contener letras, números y caracteres especiales (&, $, #, etc.), y que siempre termina en letra),
luego uno o más blancos y tres números separados por blancos, por último uno o más blancos y una letra.
    Ejemplo: mU&1#hT34*A 80 40 30 P
Se pide, a partir del archivo, cargar tres arreglos paralelos:
    • VClave contendrá las claves sin los caracteres especiales, que registren en su encriptación hasta
    tres caracteres especiales (las claves que tengan más de tres invalidan la información de la línea,
    que no se almacena)
    • VProm almacena el promedio de los tres números.
    • VCar almacena el caracter que está al final de la línea, siempre que no coincida con la última letra
    de la clave, en cuyo caso invalida la información de la línea, que no se almacena)
Mostrar los arreglos generados, y luego para una letra y una clave que se ingresan por teclado:
    a) Para la letra ingresada, calcular e informar la clave de máximo promedio.
    b) Para la clave ingresada, informar el promedio y la letra asociada (puede no existir)
Resultados: si el archivo fuera
    mU&1#hT34*A   80   40   30     P
    AsD4=H23**9+T 4  78   56         L  (1)
    jYC%MkS6M      10 70 3          M   (2)
    MnDe3!ku#z        6   8   19      A
    
    VClave     VProm    VCar
    mU1hT34A   50       P
    MnDe3kuz   11       A
(1) se descarta la línea porque la clave tiene más de 3 caracteres especiales.
(2) se descarta la línea porque la última letra de la clave coincide con la última de la línea. *)
const
    N=4;
type
    ST15 = string[15];
    TvecClave = array[1..N] of ST15;
    TVecProm = array[1..N] of real;
    TVecCar = array[1..N] of char;

procedure MostrarTabla(VClave:TvecClave; VProm:TVecProm; VCar:TVecCar;pos:byte);
var
    i:Byte;
begin
    WriteLn('VClave   VProm  VCar');
    for i:=1 to pos do
    begin
        Write(VClave[i],' ');
        Write(VProm[i]:0:0,' ');
        Writeln(VCar[i]:5);
    end;
end;

procedure MostrarPorLetra(VClave:TvecClave; VProm:TVecProm; VCar:TVecCar;letra:char;indice:byte);
var
    i:byte;
    maxPromedio:real;
    nomMaxProm:ST15;
begin
    maxPromedio:=0;
    nomMaxProm:='';
    for i:=1 to indice do
    begin
        if (VCar[i] = upCase(letra)) and (maxPromedio<VProm[i]) then
            begin
                maxPromedio := VProm[i];
                nomMaxProm := VClave[i];
            end;
    end;
    if nomMaxProm<>'' then
        WriteLn('La clave de maximo promedio es: ', nomMaxProm)
    else
        WriteLn('No existe clave con esa letra');
end;

procedure MostrarPorClave(VClave:TvecClave; VProm:TVecProm; VCar:TVecCar; clave:ST15;indice:byte);
var
    i:byte;
begin
    i:=1;
    while (i<=indice) and (VClave[i] <> clave) do
        i:=i+1;
    
    if i<>indice+1 then
        WriteLn('El promedio de la clave ingresada es: ', VProm[i]:0:0, '. y la letra asociada es: ', VCar[i])
    else
        WriteLn('No existe clave ingresada');
end;

var
    arch:text;
    contCarEsp,suma,pos,i,num:byte;
    car,letra:char;
    clave:string;
    VClave:TvecClave;
    VCar:TVecCar;
    VProm:TVecProm;
    claveInvalida:Boolean;
begin
    Assign(arch,'datos.TXT');
    Reset(arch);
    pos:=0;
    while not eof(arch) do
    begin
        claveInvalida:=False;
        suma:=0;
        contCarEsp:=0;
        clave:='';
        while car<>' ' do
        begin
            Read(arch,car);
            if not ((car in ['!'..'.']) or (car in [':'..'@'])) and (car<>' ') then
                clave := clave + car
            else
                contCarEsp:= contCarEsp +1;
        
            if contCarEsp>3 then
                claveInvalida:=True;
        end;

        for i:=1 to 3 do
        begin
            Read(arch,num);
            suma:=suma+num;
        end;

        repeat
            Read(arch, car);
        until car<>' ';
        
        if (claveInvalida = false) and (clave[Length(clave)-1] <> car) then
            begin
                pos:=pos + 1;
                VClave[pos]:= clave;
                VProm[pos]:= suma/3;
                VCar[pos]:=car;
            end;
        ReadLn(arch);
    end;
    close(arch);
    MostrarTabla(VClave,VProm,VCar,pos);

    WriteLn('Ingrese una letra para calcular y analizar la clave con promedio maximo: ');
    ReadLn(letra);
    MostrarPorLetra(VClave,VProm,VCar,letra,pos);

    WriteLn('Ingrese una clave para mostrar el promedio y la letra asociada: ');
    ReadLn(clave);
    MostrarPorClave(VClave,VProm,VCar,clave,pos);
end.