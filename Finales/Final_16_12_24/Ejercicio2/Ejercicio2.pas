program Ejercicio2;

(*La siguiente función pretende obtener la cantidad de filas en una matriz cuadrada que verifican que
sus elementos tienen valor decreciente, y ha sido invocada como Writeln(Decreciente(A,1,2,N));.

Function Decreciente(A:Mat, i,j,N:byte):byte;
begin
    If (i>N) or (j>N) then //1)
        Decreciente:= 0
    else
        begin
            Decreciente:= A[i,j] > A[i,j-1]; //2) //3) 
            if Decreciente then //6)
                if j = N then
                    Decreciente:= 1 + Decreciente(A, i+1,1,N) //4)
                else
                    Decreciente:=Decreciente(A,i,j+1,N)
            else
                Decreciente:=Decreciente(A,i,j+1,N) //5)
            end;
        end;
end;

Se pide:
    a) Señalar en el código los errores que tiene para cumplir la tarea indicada y luego reescribirla para que
       resuelva lo pedido de modo eficiente.
    b) Reescribirla como Procedimiento, devolviendo un parámetro con la cantidad de filas que cumplen lo
       pedido.

a)

1) si j>N cuando se termina la ultima columna de la primer fila la funcion finaliza devolviendo 0
2) "decreciente" ya es el nombre de la funcion, no es boolean y en todo caso no estaria declarada
3) mal analizada la logica, resta en vez de sumar
4) j debe ser 2
5) suma en columnas en vez de en filas
6) Invocacion recursiva sin parametro

Function Decreciente(A:Mat, i,j,N:byte):byte;
begin
    If (i>N) then
        Decreciente:= 0
    else
        begin
            if (A[i,j] > A[i,j+1]) then
                if (j = N-1)  then
                    Decreciente:= 1 + Decreciente(A, i+1,2,N)
                else
                    Decreciente := Decreciente(A,i,j+1,N)
            else
                Decreciente:=Decreciente(A,i+1,2,N);
        end;
end;
*)

procedure Decreciente(A:Mat;i,j,N:byte; var cantFilas:byte);
begin
    If (i<=N) then
    begin
        if (A[i,j] > A[i,j+1]) then
            if (j = N-1) then
                begin
                    cantFilas:= cantFilas + 1;
                    Decreciente(A,i+1,2,N,cantFilas);
                end
            else
                Decreciente(A,i,j+1,N,cantFilas)
        else
            Decreciente(A,i+1,2,N,cantFilas);
    end;
end;
var
    A:Mat;
    cantFilas:byte;
begin
    //ArmarMat(A,N);
    //...
    Decreciente(A,1,2,N,cantFilas);
    WriteLn(cantFilas);
end.