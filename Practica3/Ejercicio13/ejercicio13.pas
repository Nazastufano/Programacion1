program Ejercicio13;

(*Ej 13) Dado el siguiente fragmento de código, analice si se puede reescribir usando la estructura Repeatuntil, comparar ambos códigos. ¿A qué conclusión llega?

 . . .
 Readln( Tipo, Precio); 
 Tipo := Upcase(Tipo);
 
 //{P=panadería, F=fiambrería, A=almacén}
 
 While (Tipo<>’P’) and (Tipo<>’F’) and (Tipo<>’A’) do
    Begin
        Readln (Tipo); 
        Tipo := Upcase(Tipo);
    End;
 
 . . . 
 *)

begin 
    //{P=panadería, F=fiambrería, A=almacén}
 
    repeat
        Readln (Tipo); 
        Tipo := Upcase(Tipo);    
    until (tipo='P') or (Tipo='F') or (Tipo='A');

    //Conclusion: puede darse que el primer readln de una letra distinta de P,F y A y el repeat se ejecute igualmente, esto no pasaría en el while
end;