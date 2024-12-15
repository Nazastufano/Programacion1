Program Ejercicio3;

(*El siguiente programa ingresa enteros desde un archivo “Números.txt” y los va insertando de 
forma ordenada descendente en un vector:  
Program xxxx; 
Const  
    MAXELEM = 20; 
Type 
    TV= array[1..MAXELEM] of .....; 

Var 
    A:   TV;
    Arch:   text;
    I,N,j:   byte;
    Num:   integer;
Begin
    Assign(...... ,........);
    Reset(..........);
    N := ...;
    While Not eof(Arch) Do
    Begin
        Read(Arch,Num);
        I := 1;
        While (I <=N)..... (Num ... A[I]) Do
        ..........;
        If I = N+1 Then
        ..........
        Else
        Begin
            For j := N ..... I Do
                A[j+1] := A[...];
            A[I-1] := Num;
        End;
    ..........
End.

Se pide: 
    a) completar el código en las líneas punteadas y  
    b) rescribir el programa para mejorar la eficiencia del código 



COMPLETANDO:

//a)

Program xxxx; 
Const  
    MAXELEM = 20; 
Type 
    TV= array[1..MAXELEM] of integer; 

Var 
    A:   TV;
    Arch:   text;
    I,N,j:   byte;
    Num:   integer;
Begin
    Assign(arch, 'Numeros.txt');
    Reset(arch);
    N := 0;
    While Not eof(Arch) Do
    Begin
        Read(Arch,Num);
        I := 1;
        While (I <=N) and (Num <= A[I]) Do
            i:=i+1;
        If I = N+1 Then
            A[i]:=num
        Else
        Begin
            For j := N downto I Do
                A[j+1] := A[J];
            A[I-1] := Num;
        End;
    .........
End.



//b)
function CalcPos(num:integer;A:TV):byte;
var
    i:byte;
begin
    I := 1;
    While (I <=N) and (Num <= A[I]) Do
        i:=i+1;
    CalcPos:=i;
end;

procedure UbicarPos(i:Byte;num:integer; var A:TV);
begin
    If I = N+1 Then
        A[i]:=num
    Else
    Begin
        For j := N downto I Do
            A[j+1] := A[J];
        A[I-1] := Num;
    End;
end;

procedure InsercionOrdenada(var V:TV;var N:byte);
var
    arch:text;
    i,j:byte;
    num:integer;
begin
    Assign(arch, 'Numeros.txt');
    Reset(arch);
    N:=0;
    while NOT eof(arch) do
    begin
        Read(arch,num);
        UbicarPos(CalcPos(num,A),num,A);
    ........
end;



*)

begin
  
end.