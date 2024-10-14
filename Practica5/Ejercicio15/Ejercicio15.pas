program Ejercicio15;

(*Ej 15) Una planta de silos registra el ingreso de camiones de sus clientes con cereal, por cada uno se
tiene:
    • Cliente
    • Patente del camión
    • Tipo de cereal ( 1-trigo, 2-girasol, 3-soja, 4-maiz )
    • Toneladas
Se pide que lea los datos desde un archivo y mediante un menú de opciones iterativo calcule e informe:
    a) Porcentaje de toneladas de cada cereal respecto del total.
    b) Dada una patente, si es que existe, decir qué tipo de cereal transporta, las toneladas y a qué cliente
        pertenece.
    c) Generar un arreglo con los clientes que transportaron más de X toneladas, ordenado
    alfabéticamente.
Generar un archivo de texto, con un mínimo de 10 líneas, que obtenga los siguientes resultados:
    a) Trigo: 30%, Girasol: 20%, Soja: 40%, Maiz: 10%.
    b) Para la patente AB123CD -> Soja, 45, MDP3
    c) X = 30 -> [BAL1, MDP3, NEC3, TAN2] 
*)

const
    N = 100;
Type
    ST10 = string[10];
    ST7 = string[7];
    TVCereales = array[1..4] of word;
    TVTipoCereal = array[1..N] of byte;
    TVPatentes = array[1..N] of ST7; 
    TVCliente = array[1..N] of ST10;
    TVToneladas = array[1..N] of word;

procedure InicializarArregloSt(var clientesSuperan:TVCliente);
var
    i:byte;
begin
    for i:=1 to N do
    begin
        clientesSuperan[i]:='';
    end;
end;

procedure InicializarArregloWord(var vec:TVCereales);
var
    i:byte;
begin
    for i:=1 to 4 do
        vec[i]:=0;
end;

procedure CargarArreglo(var vec:TVCereales;pos:byte;valor:word);
begin
    vec[pos]:= vec[pos] + valor;
end;

function Porcentaje(vCereales:TVCereales):String;
var
    i:byte;
    total:word;
    prom:real;
    st,aux:string;
begin
    st:='';
    total:= vCereales[1] + vCereales[2] + vCereales[3] + vCereales[4];
    for i:= 1 to 4 do
    begin 
        prom := vCereales[i]*100/total;
        str(prom:0:2,aux);
        case i of
        1: st := st + 'Trigo: ' +  aux + '%, ';
        2: st := st + 'Girasol: ' + aux + '%, ';
        3: st := st + 'Soja: ' + aux + '%, ';
        4: st := st + 'Maiz: ' + aux + '%';
        end; 
    end;
    Porcentaje:=st;
end;

function MostrarPatente(vPatentes:TVPatentes;vCliente:TVCliente;vTipoCereal:TVTipoCereal;vToneladas: TVToneladas;indice:byte;patente:ST7):string;
var
    i:byte;
    aux1,palabra,st:string;
begin
    i:=1;
    while (i<=indice) and (vPatentes[i] <> patente) do
        i:=i+1;
    
    if i=indice+1 then
        st:='La patente escrita no existe'
    else
        begin
            case vTipoCereal[i] of
            1:palabra:='Trigo';
            2:palabra:='Girasol';
            3:palabra:='Soja';
            4:palabra:='Maiz';
            end;
            str(vToneladas[i],aux1);
            st:= 'La patente: '+  patente +  '. Transporta el tipo de cereal: ' + palabra + '. ' + aux1 + ' toneladas y pertenece al cliente: ' + vCliente[i];
        end;
    MostrarPatente:=st; 
end;

procedure SuperanValor(var clientesSuperan: TVCliente;vCliente:TVCliente;vToneladas:TVToneladas;var pos:byte; indice:byte; toneladasASuperar:word);
var
    i:byte;
    
begin
    for i:=1 to indice do
    begin
        if (vToneladas[i]>toneladasASuperar) then
        begin
            pos := pos+1;
            clientesSuperan[pos]:=vCliente[i];
        end;
    end;
end;

procedure OrdenarArreglo(var clientesSuperan:TVCliente;pos:byte);
var
    i,tope,K:Byte;
    vecAux:TVCliente;
begin
    Tope := pos;
    Repeat
        K := 0;
        For i := 1 to Tope - 1 do {el Tope no es estático, se redefine en cada pasada}
        begin
            If (clientesSuperan[i] > clientesSuperan[i+1]) then
                Begin
                    vecAux[1]:= clientesSuperan[i]; 
                    clientesSuperan[i]:= clientesSuperan[i+1]; 
                    clientesSuperan[i+1]:=vecAux[1];
                    K:= i; {guarda la posición del último cambio}
                End;
        end;
        Tope:= K; {fija el tope de la próxima pasada en la posición del último cambio}
    Until (K <=1);
end;

function MostrarVector(clientesSuperan:TVCliente;toneladasASuperar:word;pos:byte):string;
var
    i:byte;
    st,aux:string;
begin
    str(toneladasASuperar,aux);
    st:='Los clientes que transportaron mas de ' + aux +' toneladas son: [';
    for i:=1 to pos do
        begin
            if (clientesSuperan[i]<>'') then
                if (i<>pos) then
                    st:=st+ clientesSuperan[i] + ', '
                else
                    st:=st+ clientesSuperan[i] + ']';
        end;
    MostrarVector:=st;
end;

var
    arch,arch2:text;
    cliente:ST10;
    patente:ST7;
    res:char;
    contClientes,tipoCereal,pos:byte;
    toneladas,toneladasASuperar:word;
    vCereales:TVCereales;
    vPatentes:TVPatentes;
    vCliente,clientesSuperan:TVCliente;
    vTipoCereal:TVTipoCereal;
    vToneladas: TVToneladas;

begin
    Assign(arch,'datos.TXT');
    Reset(arch);

    Assign(arch2,'salida.TXT');
    Rewrite(arch2);

    InicializarArregloWord(vCereales);
    contClientes:=0;
    pos:=0;
    while not eof(arch) do
    begin
        contClientes := contClientes + 1;
        ReadLn(arch, cliente);
        ReadLn(arch,patente);
        ReadLn(arch,tipoCereal);
        ReadLn(arch,toneladas);
        
        vCliente[contClientes]:=cliente;
        vPatentes[contClientes]:=patente;
        vTipoCereal[contClientes]:=tipoCereal;
        vToneladas[contClientes]:=toneladas;

        CargarArreglo(vCereales,tipoCereal,toneladas);
    end;
    close(arch);

    repeat
        repeat
            WriteLn('A = Calcular porcentaje de cada cereal, B = Buscar Informacion por patente, C = Superaron el valor y ordenarlo alfabeticamente, F = fin de datos');
            ReadLn(res);
            res:=upCase(res);
        until (res = 'A') or (res = 'B') or (res = 'C') or (res = 'F');
        case res of
        'A':begin
                WriteLn(Porcentaje(vCereales)); //a)  
                WriteLn(arch2,Porcentaje(vCereales)); //a) pero en archivo
            end;
        'B':begin
                WriteLn('Ingrese una patente: ');
                ReadLn(patente);
                WriteLn(MostrarPatente(vPatentes,vCliente,vTipoCereal,vToneladas,contClientes,patente)); //b)
                WriteLn(arch2,MostrarPatente(vPatentes,vCliente,vTipoCereal,vToneladas,contClientes,patente)); //b), pero en archivo
            end;
        'C':begin
                WriteLn('Ingrese el valor a superar: '); //c)
                ReadLn(toneladasASuperar);

                InicializarArregloSt(clientesSuperan);
                SuperanValor(clientesSuperan,vCliente,vToneladas,pos,contClientes,toneladasASuperar);
                OrdenarArreglo(clientesSuperan,pos);

                WriteLn(MostrarVector(clientesSuperan,toneladasASuperar,pos));
                WriteLn(arch2,MostrarVector(clientesSuperan,toneladasASuperar,pos)); //c) en archivo
            end;
        end;
    until (res = 'F');
    Close(arch2);
end.