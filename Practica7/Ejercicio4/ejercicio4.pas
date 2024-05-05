program Ejercicio4;

(*Ej 4) En una competencia intervienen N equipos deportivos de los cuales se registró:
 Nombre del Club
 Cantidad de partidos jugados
 El resultado de cada encuentro ( G = ganado, E = empatado, P = perdido)
Se pide almacenar los datos en una estructura adecuada junto con el total del puntaje obtenido. Por cada
partido ganado son 3 puntos, empatado 1 y perdido 0.
A partir de lo almacenado, informar:
a) Listado con los nombres de los clubes junto con el puntaje obtenido.
b) Nombre de el/los punteros de la Tabla.
c) Porcentaje de los que no perdieron ningún partido sobre el total de clubes. *)

const 
    N = 10; //numero de equipos

type
    ST10 = string[10];
    TipoRec = record
        nombre: ST10;
        cantPartidos: array[1..(N-1)] of byte;
        resPart: array[1..3] of byte; //( G = ganado, E = empatado, P = perdido)
        totalPuntos: byte;
    end;
    TE = array[1..N] of TipoRec;

var
    equipos: TE;

procedure SumarPuntos(var reg:TE; k:byte);
    var
        puntaje:byte;
    begin
        puntaje :=  reg[k].resPart[1]*3 + reg[k].resPart[2]*1;
        reg[k].totalPuntos := puntaje;
    end;

procedure CompletarRegis(var reg:TE);
    var
        nombreEquipo: ST10;
        resultado: char;
        i,k:integer;

    begin
        for i := 1 to length(reg) do
        begin
            writeln('Ingrese el nombre del equipo: ');
            readln(nombreEquipo);
            reg[i].nombre := nombreEquipo;

            for k := 1 to length(reg[i].cantPartidos) do
                begin
                    repeat
                        writeln('El partido ', k, ': gano, empato o perdio? ( G = ganado, E = empatado, P = perdido)');
                        readln(resultado);
                        resultado:= upCase(resultado);  
                    until (resultado = 'G') or (resultado = 'E') or (resultado = 'P');
                    case resultado of
                        'G': reg[i].resPart[1] := reg[i].resPart[1] + 1;
                        'E': reg[i].resPart[2] := reg[i].resPart[2] + 1;
                        'P': reg[i].resPart[3] := reg[i].resPart[3] + 1;
                    end;
                    SumarPuntos(reg, i);
                end;        
        end;
    end;

Procedure Burbujeo (Var reg : TE);
    Var
        Aux: TE;
        i, k, tope: byte;
    Begin
        Repeat
            Tope:=length(reg);
            k := 0;
            For i := 1 to (Tope -1) do {el Tope no es estático, se redefine en cada pasada}
                If reg[i].totalPuntos < reg[i+1].totalPuntos then
                    Begin
                        Aux[1]:= reg[i]; 
                        reg[i]:= reg[i+1]; 
                        reg[i+1]:= Aux[1];
                        k:= i; {guarda la posición del último cambio}
                    End;
                Tope:= k; {fija el tope de la próxima pasada en la posición del último cambio}
        Until K <=1; {hasta que no se produzcan cambios, o el último cambio es en el 1er para}
    end;


procedure MostrarTabla(reg:TE);
    var
        i: integer;
    begin
        Burbujeo(reg);
        writeln('Nombre, G, P, E');
        for i := 1 to length(reg) do
            begin
                write(reg[i].nombre, ' |');
                write(reg[i].resPart[1], ' |', reg[i].resPart[2], ' |', reg[i].resPart[3], ' |');
                writeln();
            end;    
    end;

procedure MostrarPunteros(reg:TE);
    var
        cantPunteros, i:integer;
        puntero: byte;
    begin
        puntero:= reg[1].totalPuntos;
        cantPunteros := 0;
        for i := 1 to N do
            begin
                if reg[i].totalPuntos = puntero then
                    begin
                        cantPunteros := cantPunteros +1;
                    end;
            end;

        if cantPunteros <> 1 then
            begin
                writeln();
                writeln('Los puntero son: ');
                for i := 1 to cantPunteros do
                    begin
                        writeln(reg[i].nombre, ' con ', reg[i].totalPuntos, ' puntos.');        
                    end;
            end
        else
            begin
                writeln();
                writeln('El puntero es: ', reg[1].nombre, ' con ', reg[1].totalPuntos, ' puntos.');
            end;
    end;

procedure Invictos(reg:TE);
    var
        contInvictos,i:integer;
        promedio:real;
    begin
        promedio:= 0;
        contInvictos:=0;
        for i := 1 to N do
            begin
                if reg[i].resPart[3] <>0 then
                    contInvictos := contInvictos +1;
            end;
        promedio := contInvictos/N;
        writeln('El promedio de invictos es de: ', promedio:0:2);
    end;

begin
    CompletarRegis(equipos);
    
    MostrarTabla(equipos);

    MostrarPunteros(equipos);

    Invictos(equipos);
end.