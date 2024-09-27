program Ejercicio12;

(*Ej 12) Los dos primeros términos de la sucesión de Fibonacci valen 1, y los demás se hallan sumando los
dos anteriores: 1, 1, 2, 3, 5, 8,13, 21…
Desarrolle un programa que lea N cotas enteras positivas, y para cada una de ellas genere y muestre los
términos de la sucesión hasta superar la cota dada.*)

function Encadenado(num:word): string;
var
    s:string;
begin
    str(num, s);
    Encadenado:= s + ', ';
end;


procedure Fibonacci(val:word);
var
    n1,n2,aux:word;
    cad:string;
begin
    n1:= 1;
    n2:= 1;
    cad:= '';
    cad := cad + Encadenado(n1) + Encadenado(n2);

    repeat
        aux := n1; 
        n1 := n2; 
        n2 := aux + n1;
        cad := cad + Encadenado(n2);
    Until n2 > val;

    cad := copy(cad,1,Length(cad)-2);
    WriteLn(cad);
end;

var
    cotas:word;
    respuesta:char;
begin
    while respuesta <> 'N' do
    begin
        repeat
            WriteLn('Ingrese la cota a superar: ');
            ReadLn(cotas);
        until cotas > 1;
        Fibonacci(cotas);  
        
        WriteLn('Desea seguir ingresando valores? (S/N)');
        ReadLn(respuesta);
        respuesta := upcase(respuesta);
    end;
end.
