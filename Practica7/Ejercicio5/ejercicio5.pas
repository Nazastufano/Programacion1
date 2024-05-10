program Ejercicio5;

(*Ej 5) Ingresar N y M y luego los elementos no nulos de una matriz rala por filas (i, j, valor) y almacenar en
un arreglo de registros.
    a) Mostrar en formato matricial completando los ceros faltantes.
    b) Si es cuadrada, modificarla para obtener la traspuesta. *)


type
    TipoReg = record
        i,j: byte;
        valor:integer;
    end;
    TVReg = array[1..50] of TipoReg;
    TM = array of array of integer;

var
    i, j, n, m,contValores: byte;
    valor: integer;
    arch:text;
    vecReg: TVReg;
    matr: TM;

procedure MostrarMatriz(var matr: TM);
    var
        i,j:integer;
    begin
        for i := 0 to Length(matr)-1 do
            begin
                for j := 0 to Length(matr[1])-1 do
                begin
                    write(matr[i,j], ' ');
                end;
                writeln();
            end;
    end;

procedure LlenarRegistro(var vecReg:TVReg; i:byte; j:byte; valor:integer; contValores:byte);
    begin
        vecReg[contValores].i:= i;
        vecReg[contValores].j:= j;
        vecReg[contValores].valor:= valor;
    end;

procedure MatrizTranspuesta(var matr:TM; n:byte; m:byte);
    var
        i, j:byte;
        matr2:TM;
    begin
        setLength(matr2, n, m);
        for i := 0 to n-1 do
            for j := 0 to m-1 do
                matr2[j, i] := matr[i, j];

        MostrarMatriz(matr2);
    end;

procedure LlenarMatriz(vecReg:TVReg; matr:TM; lim:byte);
    var
        i, x, y: byte;
    begin
        for i := 1 to lim do
            begin
                x:=vecReg[i].i-1;
                y:=vecReg[i].j-1;
                matr[x, y]:= vecReg[i].valor;
            end;    
    end;
 
begin
    assign(arch, 'datos.TXT');
    reset(arch);

    readln(arch, n, m);
    
    setLength(matr, n, m);
    contValores:=1;
    while not eof(arch) do 
        begin
            readln(arch, i, j, valor);
            LlenarRegistro(vecReg, i, j, valor, contValores);
            contValores:=contValores+1;
        end;
    close(arch);

    LlenarMatriz(vecReg, matr, contValores);
        
    MostrarMatriz(matr);

    if n = m then
        MatrizTranspuesta(matr, n, m);
end.