program Ejercicio12;

(*Ej 12) Considere el siguiente archivo de texto, donde b indica el caracter blanco:

abcdbb45.9bb111<eoln>
bb80bxzy<eoln>
bbbbb111<eoln>< eof >

y se ha declarado:
T:text;
Cad1: string[8];
Cad2, Cad3 : string[3];
a,b : word;
x: real;
c: char;

Indique para cada caso la/s sentencia/s de lectura que provocaría/n los siguientes resultados:

|Sentencia/s de lectura                            |    Cad1    |  Cad2  |  Cad3  |  a  |  b  |   x   |   c   |
|read(T, Cad2, c, x); read(T, a); read(T, Cad1);   | ´bbbbb111´ | ´abc´. |   -    |  80 |  -  |  45.9 |  ´d´  | a)
|readln(T, Cad3, Cad2); readln(T, x); readln(T, a);|     -      | ´dbb´  | ´abc´  | 111 |  -  |  80.0 |   -   | b)
|readln(T, Cad1, Cad3,b); readln(T, c, Cad2);      | ´abcdbb45´ | ´ b80´ | ´.9 b´ |  -  | 111 |   -   | ´ b´  | c)
|readln(T); readln(T,Cad1); readln(T, x);          | ´bb80bxzy´ |   -    |   -    |  -  |  -  | 111.0 |   -   | d)

Nota: el ´-´ indica que no se ha leído sobre dicha variable

IMPORTANTE: El ejercicio pode resolver la senteancia/s de lectura, el cuadro de debajo está resuleto, luego de ser escrito el codigo correspondiente dentro del begin end.

*)

var
    T:text;
    Cad1: string[8];
    Cad2, Cad3 : string[3];
    a,b : word;
    x: real; 
    c: char;

begin
    assign(T, 'datos.TXT');
    reset(T);

    (* a)
    
    read(T, Cad2, c, x);
    read(T, a);
    read(T, Cad1);
    write(Cad1, ' ',Cad2,' ',a,' ',c,' ',x:0:1,' ');       
    *)
    
    (* b)

    readln(T, Cad3, Cad2);
    readln(T, x);
    readln(T, a);
    write(' ',Cad2,' ', Cad3,' ',a,' ',x:0:1,' ');
    *)

    (* c)

    readln(T, Cad1, Cad3,b);
    readln(T, c, Cad2);
    write(Cad1, ' ',Cad2,' ',Cad3,' ',b,' ', c,' ');
    *)
    (* d)

    readln(T);
    readln(T,Cad1);
    readln(T, x);
    write(Cad1, ' ', x:0:2); 
    *)
    close(T);
end.