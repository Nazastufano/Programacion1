Program Ejercicio3;

(*Siendo N una variable entera, codifique el siguiente fragmento de código utilizando la estructura while de forma
totalmente equivalente:
    Repeat
        Readln(N);
    Until (N<0) or (10<=N) and (N mod 3 = 0);

*)

begin
    //Opcion 1
    Readln(N);
    while (N>=0) and ((N mod 3 <> 0) or (10>N)) do
        ReadLn(N);
    
    //Opcion 2
    Readln(N);
    while NOT ((N<0) or (10<=N) and (N Mod 3 = 0)) do
        ReadLn(N);
end.