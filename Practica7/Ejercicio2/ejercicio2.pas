Program Ejercicio2;

(*Ej 2) En una matriz Tablero de 8x8 se almacenó una jugada de ajedrez. Además, se sabe la posición (i,j)
de una de las Torres Negras, y que juegan las negras. Determinar e informar a qué piezas “defiende” la
Torre y a cuáles “amenaza”, sabiendo que las piezas tienen dos atributos:
    Tipo: R = Rey, Q = Reina, A = Alfil, T = Torre, C = Caballo, P = Peón
    Color: 1 = Blanco, 2 = Negro
Nota: armar el Tablero leyendo desde archivo, donde en cada línea viene (fila, col, Tipo, Color) 
*)

type
    TipoReg=record
        tipo:char;
        color:byte;
    end;
    TM = array[1..8,1..8] of TipoReg;

var
    arch:text;
    tablero: TM;

procedure LlenarMatriz(var tablero:TM; i:byte; j:byte; tipo:char;color:byte);
    begin
        tablero[i,j].tipo:= tipo;
        tablero[i,j].color:= color;
    end;

procedure LeerTablero(var arch:text; var tablero:TM);
    var
        i, j, color:byte;
        tipo:char;
    begin
        assign(arch, 'datos.TXT');
        reset(arch);

        while not eof(arch) do 
            begin
                //Lee fila, columna, espacio auxiliar, el tipo, y el color
                readln(arch, i, j, tipo, tipo, color);
                LlenarMatriz(tablero, i, j, tipo,color);
            end;
        close(arch);
    end;

procedure Defendido(tablero:TM; i:byte; j:byte);
    begin
        case tablero[i,j].tipo of
            'R': writeln('La torre esta defendiendo al Rey');
            'Q': writeln('La torre esta defendiendo a la Reina');
            'C': writeln('La torre esta defendiendo al Caballo');
            'T': writeln('La torre esta defendiendo a la Torre');
            'A': writeln('La torre esta defendiendo al Alfil');
            'P': writeln('La torre esta defendiendo al Peon');
        end;
    end;

procedure Amenazado(tablero:TM; i:byte; j:byte);
    begin
        case tablero[i,j].tipo of
            'R': writeln('La torre esta amenazando al Rey');
            'Q': writeln('La torre esta amenazando a la Reina');
            'C': writeln('La torre esta amenazando al Caballo');
            'T': writeln('La torre esta amenazando a la Torre');
            'A': writeln('La torre esta amenazando al Alfil');
            'P': writeln('La torre esta amenazando al Peon');
        end;
    end;

procedure Defensa(tablero:TM; x:byte; y:byte);
    var
        i,j:byte;
    begin
        for i := x+1 to 8 do
            begin
                if tablero[i,y].color = 2 then
                    begin
                        Defendido(tablero,i,y);
                        break;
                    end;
            end;
        for i := x-1 downto 1 do
            begin
                if tablero[i,y].color = 2 then
                    begin
                        Defendido(tablero,i,y);
                        break;
                    end;
            end;    

        for j := y+1 to 8 do
            begin
                if tablero[x,j].color = 2 then
                    begin
                        Defendido(tablero,x,j);
                        break;
                    end;
            end;
        for j:= y-1 downto 1 do
            begin
                if tablero[x,j].color = 2 then
                    begin
                        Defendido(tablero,x,j);
                        break;
                    end;
            end;
    end;

procedure Ataque(tablero:TM; x:byte; y:byte);
    var
        i,j:byte;
    begin
        for i := x+1 to 8 do
            begin
                if tablero[i,y].color = 1 then
                    begin
                        Amenazado(tablero,i,y);
                        break;
                    end;
            end;
        for i := x-1 downto 1 do
            begin
                if tablero[i,y].color = 1 then
                    begin
                        Amenazado(tablero,i,y);
                        break;
                    end;
            end;    

        for j := y+1 to 8 do
            begin
                if tablero[x,j].color = 1 then
                    begin
                        Amenazado(tablero,x,j);
                        break;
                    end;
            end;
        for j:= y-1 downto 1 do
            begin
                if tablero[x,j].color = 1 then
                    begin
                        Amenazado(tablero,x,j);
                        break;
                    end;
            end;
    end;

begin
    LeerTablero(arch, tablero);

    Defensa(tablero, 1,1);
    Ataque(tablero, 1,1);
end.