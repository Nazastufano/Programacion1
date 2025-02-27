Program Ejercicio3;

(*3. Dada una matriz cuadrada A de enteros, la siguiente función verifica que todos sus elementos bajo la 
diagonal principal son NO Nulos. 

Program xxxx; 
Const  
    MAXELEM = 20; 
Type 
    TM= array[1..MAXELEM,1..MAXELEM] of integer; 
Var 
    A:TM; i,j,cont,N:byte; 
Begin 
    cargarMatriz(A,N); //Asumir que se carga A 
    Cont:=0; 
    For i:= 1 to N do
        For j:=1 to i-1 do
            If A[i,j] <> 0 then 
                Cont:=cont + 1; 
    If cont = (N*N-N)/2 then 
        Writeln(‘Ningun elem bajo la diagonal es nulo’) 
    Else 
        Writeln(‘Hay elementos nulos’); 
End. 

Se pide: 
a) completar el código en las líneas punteadas y  
b) rescribir el programa para mejorar la eficiencia de la solución, evitando consultas innecesarias *)

Const 
    MAXELEM = 20;

Type 
    TM =array[1..MAXELEM, 1..MAXELEM] Of integer;

Var 
    A:TM;
    i,j,cont,N:byte;
Begin
    cargarMatriz(A,N);
    //Asumir que se carga A 
    Cont := 0;
    i:=1;
    
    while (i<=N) and (A[i,j] <> 0) do
    begin
        j := 1;
        While (j<=i-1) And (A[i,j] <> 0) Do
        begin
            Cont := cont + 1;
            j:=j+1;
        end;
        i:=i+1;
    end;

    If cont = (N*N-N)/2 Then
        Writeln('Ningun elem bajo la diagonal es nulo')
    Else
        Writeln('Hay elementos nulos');
End.
