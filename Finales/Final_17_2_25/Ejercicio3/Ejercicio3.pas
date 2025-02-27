program Ejercicio3;
(*Dada las sigueintes declaraciones:

Function dddd(x,y:real):byte;
......
Procedure cccc(var h:char;z:char);
......
Procedure yyy(f, j, k:byte);
......
var
    h:real;
    b,c:byte;
    a:char;

Enumere y explique los errores del siguiente fragmento de código y si son sintáticos o semánticos:

Begin
    h:=8;
    Case dddd(h,3.5) of
        0..100: cccc('a', a);
        100..255: yyy(f,j,k);
        else
            writeln('opcion equivocada');
    end;
    proceddure yyy (5,-1,c);
    writlen(cccc(a,'b'));
End.



Begin
    h:=8;
    Case dddd(h,3.5) of
        0..100: cccc('a', a); //1)sin
        100..255: yyy(f,j,k); //2)sin //3)sin
        else
            writeln('opcion equivocada'); //4)sem
    end;
    procedure yyy (5,-1,c); //5) sin //6)sem
    writeln(cccc(a,'b')); //7) sin
End.

1) Sintactico, ya que ingresa un char en un parametro variable
2) Sintactico, repite el 100 en el segundo caso
3) Sintactico, f, j y k no estan declaradas
4) Semantico, no es necesaria la salida ya que la funcion byte solo puede devolver valores entre 0 y 255
5) Sintactico, llama al procedimiento en el main como procedure
6) Semantico, el procedimiento yyy(); tiene todos sus parametros byte y se ha ingresado un valor integer
7) Sintactico, no se puede llamar a un procedimiento como parametro dentro de otro procedimiento

*)
begin
  
end.