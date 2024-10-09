Program Ejercicio7;

(*Ej 7) La Secretaría de Transporte quiere evaluar el movimiento de pasajeros en N paradas de colectivo.
En cada una de ellas se detienen M líneas de colectivo. Dispositivos electrónicos han registrado el
movimiento de un día y grabado en un archivo de texto dicha información en tiempo real (desordenada).
En cada registro se expresa:
     Parada (1..N)
     Línea (1..M)
     Cantidad de pasajeros que ascienden
     Cantidad de pasajeros que descienden
Se pide leer la información del archivo, almacenándola de forma adecuada para calcular e informar:
    a) Parada con mayor cantidad de pasajeros que bajaron.
    b) Línea con menor cantidad de pasajeros que subieron.
    c) Cantidad de paradas en las cuales el total de personas que subieron fue menor al 40% de las que
    bajaron.
    d) Cuántas líneas no registraron subida o bajada de pasajeros en alguna parada.
Los ítems anteriores se refieren al movimiento de todo el día.
¿Qué debería agregar/modificar si se pidiera para cada línea o parada promedio de gente que ascendió o
descendió cada vez que se detuvo el colectivo?


Se podria hacer un arreglo paralelo, con las paradas o las lineas donde hayan bajado o subido personas
y luego hacer una sumatoria de esos valores y dividirlo por el largo del arreglo.
*)

const
    N=10;
    M=10;
type
    TM = array[1..N,1..M] of word;
procedure InicizalizarMatriz(var matr:TM);
var
    i,j:byte;
begin
    for i:=1 to N do
        for j:=1 to M do
            matr[i,j]:=0;
end;
//a) Parada con mayor cantidad de pasajeros que bajaron.
function MasBajaron(matrBajada:TM;filas,columnas:byte):word;
var
    i,j,paradaMasBajaron:byte;
    maxBajaron,sumaBajadas:word;
begin
    maxBajaron:=0;
    for i:=1 to filas do
    begin
        sumaBajadas:=0;
        for j:=1 to columnas do
        begin
            sumaBajadas := sumaBajadas + matrBajada[i,j];
        end;

        if maxBajaron<sumaBajadas then
            begin
                maxBajaron := sumaBajadas;
                paradaMasBajaron:=i;
            end;
    end;
    MasBajaron:=paradaMasBajaron;
end;
//b) Línea con menor cantidad de pasajeros que subieron.
function LineaMenosSubieron(matrSubida:TM;filas,columnas:byte):byte;
var
    i,j:byte;
    menosSubieron,lineaMenSub,sumaSubidas:word;
begin
    for j:=1 to columnas do
    begin
        sumaSubidas:=0;
        for i:=1 to filas do
        begin
            sumaSubidas:= sumaSubidas + matrSubida[i,j];
        end;
        
        if ((sumaSubidas<menosSubieron) or (j=1)) and (sumaSubidas<>0) then
            begin
                menosSubieron := sumaSubidas;
                lineaMenSub:=j;
            end;
    end;
    LineaMenosSubieron:=lineaMenSub;
end;

procedure MostrarMatriz(matrSubida:TM;filas,columnas:byte);
var
    i,j:byte;
begin
    for i:=1 to filas do
    begin
        for j:=1 to columnas do
        begin
            Write(matrSubida[i,j],' ');  
        end;
        WriteLn();
    end;
end;

//c) Cantidad de paradas en las cuales el total de personas que subieron fue menor al 40% de las que bajaron.

function MasBajaronQueSubieron(matrBajada,matrSubida:TM;filas,columnas:byte):word;
var
    i,j,cont:byte;
    sumaB, sumaS:word;
begin
    cont:=0;
    for i:=1 to filas do
    begin
        sumaB:=0;
        sumaS:=0;
        for j:=1 to columnas do
        begin
            sumaB:=sumaB + matrBajada[i,j];
            sumaS:=sumaS + matrSubida[i,j];
        end;
        if sumaS<(sumaB*0.4) then
            cont:=cont+1;
    end;
    MasBajaronQueSubieron:=cont;
end;
//d) Cuántas líneas no registraron subida o bajada de pasajeros en alguna parada.

function NoRegistranSOB(matrBajada,matrSubida:TM;filas,columnas:byte):byte;
var
    i,j,cont:byte;
    registra:Boolean;
begin
    cont:=0;
    for j:=1 to columnas do
    begin
        registra:=true;
        for i:=1 to filas do
        begin
            if ((matrBajada[i,j]=0) or (matrSubida[i,j]=0)) and (registra=true) then
            begin
                cont:=cont+1;
                registra := false;
            end;
        end;
    end;
    NoRegistranSOB:=cont;
end;
var
    arch:text;
    parada, linea, ascienden,descienden,filas,columnas,i:byte;
    matrSubida,matrBajada:TM;
begin
    Assign(arch,'datos.TXT');
    Reset(arch);
    filas:=0;
    columnas:=0;
    InicizalizarMatriz(matrSubida);
    InicizalizarMatriz(matrBajada);

    while Not eof(arch) do
    begin
        readln(arch,parada,linea,ascienden,descienden);
        matrSubida[parada,linea]:= matrSubida[parada,linea] + ascienden;
        matrBajada[parada,linea]:= matrBajada[parada,linea] + descienden;

        if parada > filas then
            filas := parada;
        
        if linea > columnas then
            columnas := linea;
    end;
    Close(arch);
    WriteLn('La parada donde mas personas bajaron es: ', MasBajaron(matrBajada,filas,columnas));
    WriteLn('La linea donde menos pasajeros subieron es la: ', LineaMenosSubieron(matrSubida,filas,columnas));
    WriteLn('La cantidad de paradas en las cuales la cantidad de personas que subieron fueron menor al 40% de las que bajaron son: ', MasBajaronQueSubieron(matrBajada,matrSubida,filas,columnas));
    WriteLn('La cantidad de lineas que no han registrado personas en alguna parada son: ', NoRegistranSOB(matrBajada,matrSubida,filas,columnas));
end.