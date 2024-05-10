program Ejercicio3;

(*Ej 3) Considerar la siguiente función recursiva:
function confuso(a,b:integer):integer;
    begin
        if (b = 0) then
            confuso := 0
        else
            if (b mod 2 = 0) then
                confuso := confuso(a+a, b div 2)
            else
                confuso := confuso(a+a, b div 2) + a;
    end;
a) Probarlo con los siguientes invocaciones: confuso(2, 17) y confuso(4, 25)
b) Determinar qué función matemática define confuso. *)

function confuso(a,b:integer):integer;
    begin
        if (b = 0) then
            confuso := 0
        else
            if (b mod 2 = 0) then
                confuso := confuso(a+a, b div 2)
            else
                confuso := confuso(a+a, b div 2) + a;
    end;

begin
    //a)
    writeln(confuso(2, 17));
    writeln(confuso(4, 25));
    
    //b)
    (*
           {        0            si b = 0
    f(a,b)={    f(2a, b/2)       si b es par
           { a + f(2a, (b-1)/2)  si b es impar
    *)
end.