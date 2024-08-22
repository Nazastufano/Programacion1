program Ejercicio12;

(*Ej 12) Dada una cantidad X de pesos y un tipo de moneda extranjera, ambos ingresados por teclado, se
desea determinar e informar cuánto se puede comprar dada la siguiente tabla de cotizaciones:

MONEDA    COMPRA
D=Dólar  $ 120.80
E=Euro   $ 150.10
R=Real   $ 26.50 

*)
const 
    D = 120.80; //Dolar
    E = 150.10; //Euro
    R = 26.50;  //Real
var
    cantidadDePesos, pesos: real;
    tipoDeCambio: char;
begin
    pesos := 0;
    
    writeln('Ingrese la cantidad de pesos: ');
    readln(cantidadDePesos);

    repeat
        writeln('Ingrese el tipo de cambio que desea hacer: (D=Dólar, E=Euro, R=Real) ');
        readln(tipoDeCambio);
        tipoDeCambio:= UpCase(tipoDeCambio);
    until (tipoDeCambio = 'D') or (tipoDeCambio = 'E') or (tipoDeCambio = 'R');

    case tipoDeCambio of
        'D':
            begin
                pesos := cantidadDePesos/D;
                writeln('Usted puede comprar: ', pesos:5:2, ' Dolares');
            end;
        'E':
            begin
                pesos := cantidadDePesos/E;
                writeln('Usted puede comprar: ', pesos:5:2, ' Euros');
            end;
        'R':
            begin
                pesos := cantidadDePesos/R;
                writeln('Usted puede comprar: ', pesos:5:2, ' Reales');
            end;
    end;
end.