program Ejercicio2;

(*Ej 2) Dado un archivo de enteros, se pide almacenar en un vector V sólo los elementos impares y en otro
vector W, los pares, ignorando si hubiese, los ceros.*)

type
    TV = array of integer;

var
    arch: text;
    V, W: TV;
    valor, n, m, i: integer;

begin
    assign(arch, 'datos.TXT');
    reset(arch);
    m := 0;
    n := 0;

    SetLength(W, 0);
    SetLength(V, 0);

    read(arch, valor);
    
    while not eof(arch) do
        begin
            if valor <> 0 then
                begin
                    if valor mod 2 = 0 then
                        begin
                            SetLength(W, Length(W) + 1);
                            W[m] := valor;
                            m := m + 1;
                        end
                    else
                        begin
                            SetLength(v, Length(v) + 1);
                            V[n] := valor;
                            n:= n + 1;
                        end;    
                end; 
            read(arch, valor);
        end;
    close(arch);
    
    writeln('Elementos impares (V): ');
    for i := 0 to (Length(V) - 1) do
        begin
            write(V[i], ' ');    
        end;

    writeln();

    writeln('Elementos pares (W):');
    for i := 0 to (Length(W) - 1) do
        begin
            write(W[i], ' ');
        end;
end.