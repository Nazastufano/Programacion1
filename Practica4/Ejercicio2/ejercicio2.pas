program Ejercicio2;

(*Ej 2) Desarrollar una función
    para calcular el factorial de un número, recordar:
        n! = 1 (si n=0)
        n! = n(n-1)! (si n>0) *)
        
Function Factorial(n: integer): integer;
    var
        i, res: integer;

    begin
        res:= 1;

        if n = 0 then
            Factorial := 1
        else
            begin
                for i:=1 to n do
                    begin
                        res:= res*i;
                    end;
                Factorial := res
            end;
    end;

var
    numero: integer;
    
begin
    repeat
        writeln('Ingrese un numero para factorizar');
        readln(numero);    
    until (numero>=0);
    
    writeln('El factorial del numero es: ', Factorial(numero));
    readln();
end.

