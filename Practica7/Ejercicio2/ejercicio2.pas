program Ejercicio2;

(*Ej 2) En una matriz Tablero de 8x8 se almacenó una jugada de ajedrez. Además, se sabe la posición (i,j)
de una de las Torres Negras, y que juegan las negras. Determinar e informar a qué piezas “defiende” la
Torre y a cuáles “amenaza”, sabiendo que las piezas tienen dos atributos:
    Tipo: R = Rey, Q = Reina, A = Alfil, T = Torre, C = Caballo, P = Peón
    Color: 1 = Blanco, 2 = Negro
Nota: armar el Tablero leyendo desde archivo, donde en cada línea viene (fila, col, Tipo, Color) 
*)

type
    TReg = record
        tipo:char;
        color:byte;
    end;

    TM = array[1..8,1..8] of TReg;

procedure InicializarMatriz(var tablero:TM);
var
    i,j:byte;
begin
    for i:=1 to 8 do
        for j:=1 to 8 do
            tablero[i,j].color:=0;
end;

Procedure Condicion(tablero:TM; fila:byte; columna:byte);
var
    st:string;
Begin
    if tablero[fila,columna].color=1 then
        st:='amenazando'
    else
        st:='defendiendo';

    Case tablero[fila,columna].tipo Of 
        'R':   writeln('La torre esta ',st,' al Rey');
        'Q':   writeln('La torre esta ',st,' a la Reina');
        'C':   writeln('La torre esta ',st,' al Caballo');
        'T':   writeln('La torre esta ',st,' a la Torre');
        'A':   writeln('La torre esta ',st,' al Alfil');
        'P':   writeln('La torre esta ',st,' al Peon');
    End;
End;

procedure Acciones(tablero:TM;fila,columna:byte);
var
    i,j:byte;
    encuentra:Boolean;
begin
    i:=fila+1;
    j:=columna;
    encuentra:=false;
    while (i<8) and (encuentra=false) do
    begin
        Condicion(tablero,i,j);
        encuentra:=true;
        i:=i+1;
    end;
    
    i:=fila-1;
    j:=columna;
    encuentra:=false;
    while (i>1) and (encuentra=false) do
    begin
        Condicion(tablero,i,j);
        encuentra:=true;
        i:=i-1;
    end;

    i:=fila;
    j:=columna+1;
    encuentra:=false;
    while (j<8) and (encuentra=false) do
    begin
        Condicion(tablero,i,j);
        encuentra:=true;
        j:=j+1;
    end;
    
    i:=fila;
    j:=columna-1;
    encuentra:=false;
    while (j>1) and (encuentra=false) do
    begin
        Condicion(tablero,i,j);
        encuentra := true;
        j:=j-1;
    end;
end;

var
    arch:text;
    tablero:TM;
    fila,columna,color:byte;
    tipo,aux:char;
begin
    Assign(arch,'datos.TXT');
    Reset(arch);
    InicializarMatriz(tablero);
    while not eof(arch) do
    begin
        ReadLn(arch,fila,columna,aux,tipo,color);
        tablero[fila,columna].tipo:=tipo;
        tablero[fila,columna].color:=color;
    end;
    Close(arch);
    Acciones(tablero,1,1);
end.