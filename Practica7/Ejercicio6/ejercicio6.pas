program Ejercicio6;

(*Ej 6) Idem ejercicio 5, leer dos matrices y calcular 
la matriz resultante de la suma de ambas. *)

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

procedure LlenarMatriz(vecReg:TVReg; matr:TM; lim:byte);
var
    i, x,y: byte;
begin
    for i := 1 to lim do
        begin
            x:=vecReg[i].i-1;
            y:=vecReg[i].j-1;
            matr[x, y]:= vecReg[i].valor;
        end;    
end;

procedure SumaMatrices(matr:TM;matr2:TM;n:byte;m:byte);
var
    i,j:byte;
    matrSuma:TM;
begin
    for i := 0 to n-1 do
        for j := 0 to m-1 do
            matrSuma[i,j]:= matr[i,j] + matr2[i,j];
    
    MostrarMatriz(matrSuma);
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

        
    SumaMatrices(matr, matr2, n, m);

end.