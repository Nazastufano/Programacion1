Program Ejercicio3;

(*El siguiente fragmento de código verifica si en un vector V de enteros hay algún 
elemento positivo en las posiciones pares. 

program Final_20200312_ejer3a; 
var 
    V: array [1..50] of . . .; 
    i, N, contador:byte;
    aux:. . .; 
begin 
    contador:= . . . ; 
    For i:=1 to N do  
    Begin 
        aux:= . . . mod . . . ;   
        if aux . . . . . . then 
            if V[i] . . . . . .  then  
                contador:=contador+ 1; 
    end; 
    if Contador . . . . . .  then 
        Writeln(. . . . . . .) 
    else 
        Writeln(. . . . . . .); 
end. 

Se pide: 
a) Completar el código en las líneas punteadas  
b) Calcular el tiempo de ejecución del  FOR encerrado en el recuadro. 
c) Rescribir el programa para mejorar la eficiencia de la solución, evitando consultas 
innecesarias.


//a)
program Final_20200312_ejer3a; 
var 
    V: array [1..50] of integer; 
    i, N, contador:byte; 
    aux:byte; 
begin 
    contador:= 0; 
    For i:=1 to N do  
    Begin 
        aux:= i mod 2 ;   
        if aux = 0 then 
            if V[i] > 0  then  
                contador:=contador+ 1; 
    end; 
    if Contador = 0  then 
        Writeln('No hay enteros positivos en las posiciones pares') 
    else 
        Writeln('La cantidad de enteros positivos en posiciones pares es: ', contador); 
end. 



//c)
program Final_20200312_ejer3a; 
var 
    V: array [1..50] of integer; 
    i, N, contador:byte;
begin 
    contador:= 0; 
    i:=2;
    while (i<=N) do
    Begin 
        if V[i] > 0  then  
            contador:=contador+ 1; 
        i:=i+2;
    end; 
    if Contador = 0  then 
        Writeln('No hay enteros positivos en las posiciones pares') 
    else 
        Writeln('La cantidad de enteros positivos en posiciones pares es: ', contador); 
end. 

*)

begin
  
end.