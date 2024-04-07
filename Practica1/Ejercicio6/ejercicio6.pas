(*Ej 7) Se dispone de dos mazos de cartas españolas. Cada carta tiene los siguientes atributos:
• Color del mazo (Rojo, Azul)
• Palo (O,C,E,B)
• Numero(1..12)
Considerando que una carta esta representada en tres variables, una por cada atributo, se pide expresar
las siguientes situaciones con operadores relacionales y lógicos.
a) Carta AS de copa de cualquier mazo
b) Carta figura del mazo rojo, cualquier palo
c) Dos cartas iguales de diferente mazo
d) Dos cartas consecutivas del mismo palo sin importar el mazo
e) Dos cartas suman doce, de distinto palo y mazo
f) Dos cartas de igual número, en el mismo mazo o del mismo palo
g) Dos cartas de distinto número en el mismo mazo y palo
h) La primera carta mayor que la segunda (el mazo rojo tiene más peso que el azul, cuando coinciden
en el mazo, el palo determina supremacía en el orden en que se describieron, por último define el
número) *)

program ejercicio6;

var color,numero1, i, numero2: integer;
    palo, palo1, palo2: char;
    color1, color2: boolean; //rojo=false, azul=true
    
begin
    //Ingrese 2 cartas
    palo := 'a';
    palo2 := 'a';
    palo1 := 'a';
    numero1 := 0;
    numero2 := 0;

    repeat
        writeln('Ingrese a que mazo pertenece su primera carta 0 = rojo, 1 = azul ');
        readln(color);
    until color in [0..1];

    if color = 1 then
        begin
            color1 := true;
            color:= 2;
        end
    else
        begin
            color1 := false;
            color:= 2;
        end;
    
    repeat
        writeln('Ingrese a que mazo pertenece su segunda carta 0 = rojo, 1 = azul ');
        readln(color);
    until color in [0..1];
    
    if color = 1 then
        begin
            color2 := true;
            color:= 2;
        end
    else
        begin
            color2 := false;
            color:= 2;
        end;

    repeat
        writeln('Ingrese el palo de la primera carta ("O" = Oro, "C" = Copa, "E" = Espada, "B" = Basto)');
        readln(palo);
        palo := UpCase(palo);
    until (palo = 'O') or (palo = 'C') or (palo = 'E') or (palo = 'B');
    
    case palo of
        'O': palo1 := '4';
        'C': palo1 := '3';
        'E': palo1 := '2';
        'B': palo1 := '1';
    end;

    repeat
        writeln('Ingrese el palo de la segunda carta ("O" = Oro, "C" = Copa, "E" = Espada, "B" = Basto)');
        readln(palo);
        palo := UpCase(palo);
    until (palo = 'O') or (palo = 'C') or (palo = 'E') or (palo = 'B');

    case palo of
        'O': palo2 := '4';
        'C': palo2 := '3';
        'E': palo2 := '2';
        'B': palo2 := '1';
    end;

    repeat
        writeln('Ingrese el numero de la primera carta: ');
        readln(numero1);
    until numero1 in [1..12];

    repeat
        writeln('Ingrese el numero de la segunda carta: ');
        readln(numero2);
    until numero2 in [1..12];

    //a)
    if (numero1 = 1) and (palo1 = 'c') then
        writeln('Tu carta es un AS de copa')
    else
        writeln('Tu carta no es el AZ de copa');
    
    //b)
    if (color1 = false) then
        writeln('Tu carta es del mazo roja')
    else
        writeln('Tu carta se encuentra en el mazo azul');    
    
    //c)
    if (numero1 = numero2) and (palo1 = palo2) then
        writeln('Tus 2 cartas son iguales')
    else
        writeln('Tus cartas son diferentes');
    
    //d)
    if (palo1 = palo2) and ((numero1 = numero2 +1) or (numero1 = numero2 - 1)) then
        writeln('Tus cartas son consecutivas')
    else 
        writeln('Tus cartas no son consecutivas');
    
    //e)
    if ((numero1 + numero2) = 12) and (palo1 <> palo2) and (color1<>color2) then
        writeln('Tus cartas suman 12 y son de palo y mazo diferente')
    else
        writeln('Tus cartas son de diferente palo, mazo o no suman 12'); //JAJA, ineficiente
    
    //f)
    if (numero1 = numero2) and ((color1 = color2) or (palo1 = palo2)) then
        writeln('Tus cartas tienen el mismo numero')
    else
        writeln('Tus cartas no tienen el mismo numero o son de mazo y palo distinto');
    
    //g)
    if (numero1 <> numero2) and (palo1 = palo2) and (color1 = color2) then
        writeln('Tus cartas son de distinto numero, palo y mazos iguales')
    else
        writeln('Tus cartas son de igual numero, palo o color distinto');

    //h)
    if (color1 = color2) then
        if (palo1 = palo2) then
            if numero1 = numero2 then
                writeln('Tus cartas son iguales')
            else
                if numero1>numero2 then
                    writeln('La primera carta es mayor que la segunda ingresada')
                else
                    writeln('La segunda carta es mayor que la primera')
        else
            if palo1>palo2 then 
                writeln('la carta de palo ', palo1, 'es mayor')
            else
                writeln('La carta de palo ', palo2, 'es mayor')
    else
        if (color1 = true) then
            writeln('La primera carta ingresada es mayor, ya que es de mazo rojo')
        else
            writeln('La segunda carta ingresada es mayor, ya que es de mazo rojo');
    
end.
