program Ejercicio14;

(*a) Analice y explique brevemente qué realiza el siguiente fragmento de código. Indicar el resultado
en cada uno de los tres lotes de prueba.

Lote1 : 0          Resultado: 0
Lote2 : 70, 40, 20 Resultado: 110
Lote3 : 70 , 0     Resultado: 70

 . . . .
Bool:=false ;
Sum:=0;
Readln( x );
If x <> 0 then
    Repeat
        Sum := Sum + x;
        If Sum > 100 then
            Bool :=true;
        Readln( x );
    Until (x=0) or Bool;
Writeln(‘Resultado: ’, Sum );
. . . .

b) Reescríbalo reemplazando la estructura Repeat, los dos If y la variable booleana Bool por una
estructura While. *)

begin
    Sum:=0;
    Readln( x );
    while (x<>0) and (sum<=100) do
        begin
            sum:= sum + x;
            readln(x);    
        end;
    Writeln('Resultado: ', Sum );    
end.