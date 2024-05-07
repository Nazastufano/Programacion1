Program Ejercicio2;

(*Ej 2) En una matriz Tablero de 8x8 se almacenó una jugada de ajedrez. Además, se sabe la posición (i,j)
de una de las Torres Negras, y que juegan las negras. Determinar e informar a qué piezas “defiende” la
Torre y a cuáles “amenaza”, sabiendo que las piezas tienen dos atributos:
    Tipo: R = Rey, Q = Reina, A = Alfil, T = Torre, C = Caballo, P = Peón
    Color: 1 = Blanco, 2 = Negro
Nota: armar el Tablero leyendo desde archivo, donde en cada línea viene (fila, col, Tipo, Color) 
*)

type
    //TVTipoPieza = array[1..6] of char;
    //TVColor = array[1..2] of byte;
    TipoReg=record
        tipo:char;
        color:byte;
    end;
    TM = array[1..8,1..8] of TipoReg;

var
    arch:text;
    tablero: TM;
    i,j:integer;

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

    while not eof(arch) do 
        begin
            read(arch, i, j);
            read(arch, tipo);
            readln(arch, tipo, color);
            LlenarMatriz(tablero, i, j, tipo,color);
        end;
end;



begin
    assign(arch, 'datos.TXT');
    reset(arch);

    LeerTablero(arch, tablero);
    for j := 1 to 8 do
        writeln(tablero[1,j].tipo);
end.