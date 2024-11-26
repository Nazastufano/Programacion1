Program Ejercicio7;

(*Ej 7) Una cadena de cines tiene grabados en un archivo binario los siguientes datos de sus salas:
    # CODIGO de CINE (cadena de 4, campo de secuencia clave primaria)
    # ZONA (1..10) (puede haber más de un cine en la misma zona)
    # CAPACIDAD
Además registra en otro archivo binario la venta de localidades de las películas que proyecta:
    # CODIGO de CINE (cadena de 4, campo de secuencia, clave secundaria)
    # CODIGO de PELICULA (cadena de 3, campo de secuencia, puede repetirse en este u otro cine)
    # LOCALIDADES VENDIDAS
Se cuenta, además, con un archivo de texto que contiene los códigos de película, títulos y la duración (en
minutos) de cada película (40 como máximo); una película por línea.

Se pide generar el siguiente listado:
    Cine        Cant.Películas(1)     Cant. funciones   Total Loc.Vendidas %Ocup.Promedio
    xxxx        999                   999               999                99.99%
    . . . . . . . . . . . . . . .

    Cantidad de cines que no proyectaron ninguna película: 999
    Película con menor promedio de localidades vendidas por función: xxx(99 min.)
    Total de localidades vendidas por zona
    Zona 1          999
    . . .
    (1) Cantidad de películas diferentes. Una película se puede proyectar en varias
    funciones en el mismo cine *)
type
    ST3 = string[3];
    ST4 = string[4];    
    ST10= string[10];
    TRegCine = record
        codCine:ST4;
        zona:1..10;
        capacidad:Word;
    end;
    TRegVentas = record
        codCine:ST4;
        codPelicula:ST3;
        localVendidas:word;
    end;
    TRegPelicula=record
        codPelicula:ST3;
        titulo:ST10;
        cantFunciones,duracion:byte;
        acumLocalidades:word;
    end;

    TVContador = array[1..10] of word;
    TVPelicula = array[1..5] of TRegPelicula;
    
    TArchCines = file of TRegCine;
    TArchVentas = file of TRegVentas;
procedure GrabaArchCines(var archCines:TArchCines);
var
    arch:text;
    R:TRegCine;
begin
    Assign(arch,'CINES.TXT');
    Reset(arch);
    Rewrite(archCines);
    while NOT eof(arch) do
    begin
        ReadLn(arch,R.codCine,R.zona,R.capacidad);
        Write(archCines,R);
    end;
    Close(arch);
    Close(archCines);
end;
procedure GrabaArchVentas(var archVentas:TArchVentas);
var
    arch:Text;
    R:TRegVentas;
    aux:char;
begin
    Assign(arch,'LOCALIDADES.TXT');
    Reset(arch);
    Rewrite(archVentas);
    while Not eof(arch) do
    begin
        Readln(arch,R.codCine,aux,R.codPelicula,R.localVendidas);
        Write(archVentas,R);
    end;
    Close(arch);
    Close(archVentas);
end;

procedure ArmarVectorPelicula(var vecPeliculas:TVPelicula);
var
    arch:Text;
    i:byte;
    R:TRegPelicula;
    aux:char;
begin
    Assign(Arch,'PELICULAS.TXT');
    Reset(arch);
    i:=0;
    while Not eof(arch) do
    begin
        ReadLn(arch, R.codPelicula, aux, R.titulo, R.duracion);
        R.cantFunciones:=0;
        R.acumLocalidades:=0;
        i:=i+1;
        vecPeliculas[i]:=R;
    end;
    Close(arch);
end;
procedure InicializarVec(var vecLocalPZona:TVContador);
var
    i:byte;
begin
    for i:=1 to 10 do
        vecLocalPZona[i]:=0;
end;
function Busqueda(vecPeliculas:TVPelicula;cod:ST3):byte;
var 
    i:byte;
begin
    i:=1;
    while (vecPeliculas[i].codPelicula<>cod) do
        i:=i+1;
    Busqueda:=i;
end;
function MenorPromedioPorFuncion(vecPeliculas:TVPelicula):byte;
var
    posMenorProm,i:byte;
    menorProm,prom:real;
begin
    posMenorProm:=0;
    menorProm:=99999;
    For i:=1 To 5 Do
    Begin
        If vecPeliculas[i].cantFunciones<>0 Then
        begin
            prom:=vecPeliculas[i].acumLocalidades/vecPeliculas[i].cantFunciones;
            if prom<menorProm then
            begin
                menorProm:=prom;
                posMenorProm:=i;
            end;
        end;    
    End;
    
    MenorPromedioPorFuncion:=posMenorProm;    
end;
procedure MostrarLocalPorZona(vecLocalPZona:TVContador);
var
    i:byte;
begin
    WriteLn('Total de localidades vendidas por zona');
    For i:=1 To 10 Do
        WriteLn('Zona ',i, ' ', vecLocalPZona[i]);

end;
procedure ArmarLista(var archCines:TArchCines;var archVentas:TArchVentas; vecLocalPZona:TVContador;vecPeliculas:TVPelicula);
var
    RCin:TRegCine;
    RVen:TRegVentas;
    cantCinesSinPeli,cantFunciones,cantPeliculas,i,pos:byte;
    acumLocalidades:word;
    peliculaActual:ST3;

begin
    Reset(archCines);
    Reset(archVentas);
    Read(archCines,RCin);
    Read(archVentas,RVen);
    InicializarVec(vecLocalPZona);
    cantCinesSinPeli:=0;
    WriteLn('Cine        Cant.Peliculas     Cant. funciones   Total Loc.Vendidas %Ocup.Promedio');    
    //ocupPromedio = AcumLocalidades*100/RCin.Capacidad*cantFunciones
    while (not eof(archCines)) or (not Eof(archVentas)) do
    begin
        if RCin.codCine=RVen.codCine then
        begin
            cantPeliculas:=0;
            cantFunciones:=0;
            acumLocalidades:=0;
            while RCin.codCine=RVen.codCine do
            begin
                peliculaActual:=RVen.codPelicula;
                cantPeliculas := cantPeliculas+1;
                while (RCin.codCine = RVen.codCine) and (peliculaActual=RVen.codPelicula) do
                begin
                    cantFunciones:=cantFunciones+1;
                    acumLocalidades:=acumLocalidades+RVen.localVendidas;
                    
                    vecLocalPZona[RCin.zona]:=vecLocalPZona[RCin.zona] + RVen.localVendidas;

                    pos:=Busqueda(vecPeliculas,peliculaActual);
                    vecPeliculas[pos].cantFunciones:=vecPeliculas[pos].cantFunciones + 1;
                    vecPeliculas[pos].acumLocalidades:=vecPeliculas[pos].acumLocalidades + RVen.localVendidas;
                    
                    Read(archVentas,RVen);
                end;
            end;
            WriteLn(RCin.codCine,' ', cantPeliculas:15,' ', cantFunciones:15,' ', acumLocalidades:20,' ':15, AcumLocalidades/RCin.Capacidad*cantFunciones:0:2,'%');
            Read(archCines,RCin);
        end
        else if RCin.codCine<RVen.codCine then
        begin            
            cantCinesSinPeli:=cantCinesSinPeli+1;
            read(archCines,RCin);
        end
            else
                Read(archVentas,RVen);
        
    end;
    Close(archCines);
    close(archVentas);
    
    WriteLn('Cantidad de cines que no proyectaron ninguna pelicula: ',cantCinesSinPeli);
    pos:=MenorPromedioPorFuncion(vecPeliculas);
    if pos<>0 then
        WriteLn('Pelicula con menor promedio de localidades vendidas por funcion: ',vecPeliculas[pos].titulo,' (',vecPeliculas[pos].duracion,' mins)')
    else
        WriteLn('No hay peliculas');

    MostrarLocalPorZona(vecLocalPZona);
end;
var
    archCines:TArchCines;
    archVentas:TArchVentas;
    vecLocalPZona:TVContador;
    vecPeliculas:TVPelicula;
begin
    Assign(archCines,'CINES.DAT');
    Assign(archVentas,'LOCALIDADES.DAT');
    GrabaArchCines(archCines);
    GrabaArchVentas(archVentas);
    ArmarVectorPelicula(vecPeliculas);
    ArmarLista(archCines,archVentas,vecLocalPZona,vecPeliculas);
end.