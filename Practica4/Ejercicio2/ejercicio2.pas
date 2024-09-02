program Ejercicio2;

(*Ej 2) Desarrollar una función
    para calcular el factorial de un número, recordar:
        n! = 1 (si n=0)
        n! = n(n-1)! (si n>0) *)
        
Function Factorial(n: word): word;
    var
        i: byte;
        res: word;
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
    numero: word;
    
begin
    
    writeln('Ingrese un numero para factorizar');
    readln(numero);    
    
    writeln('EL resultado de ', numero ,'! es: ', Factorial(numero));
    readln();
end.

