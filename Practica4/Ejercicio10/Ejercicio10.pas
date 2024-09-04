program Ejercicio10;
(*Ej 10) Dado el siguiente trozo de código detectar los errores, enumerarlos y justificar.

ProcedureAAA(var C : char; var N:byte; x,y:real );
………………….
Function BBB( M:integer; B:boolean): char;
…………………
Function CCC(Car : char; W:real):Boolean;
……………………
Procedure DDD(varN,M:integer);
………………………
Var
Car: char;
    M, Z, W : real;
    P: byte;
    N: integer;
Begin
Readln(Z, W);
AAA (‘c’, P, Z, W);
If CCC( BBB( N, Z<> W), 5.4) then
DDD(N, M)
Else
DDD(12.5, N-2);
Write (BBB(20, P=0));
Write (AAA(Car, P, M, Z));
……………………… *)

ProcedureAAA(Var C : char; Var N:byte; x,y:real ); //falta espacio entre la funcion y el nombre
………………….
Function BBB( M:integer; B:boolean):   char;
…………………
Function CCC(Car : char; W:real):   Boolean;
……………………
Procedure DDD(varN,M:integer); //falta espacio entre var y el nombre de la variable
………………………

Var 
Car:   char;
    M, Z, W :   real;
    P:   byte;
    N:   integer;
Begin
Readln(Z, W);
AAA (‘c’, P, Z, W); //no se utilizan las comillas adecuadas, la p no está definida
If CCC( BBB( N, Z<> W), 5.4) Then //N no está deifinida, 
DDD(N, M) //N no está declarada y M es un rea, y la función pide un integer
Else
DDD(12.5, N-2); //se utiliza 12.5 que es un real, en la posición de un integer
Write (BBB(20, P=0)); //P no está definida
Write (AAA(Car, P, M, Z)); //car, P y M no están definidas
………………………

//El codigo no está bien indentado