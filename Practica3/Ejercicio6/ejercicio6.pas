program Ejercicio6;
        (*Ej 6) Se conoce el saldo inicial de una cuenta bancaria y una serie de movimientos realizados, por cada
uno:
- código de movimiento (D=depósito, R=retiro ó F= fin de datos).
- monto
Escribir un programa que ingrese dichos datos y determine el saldo exacto de la cuenta después de
procesar las transacciones. Al final del proceso indique cuantas veces no pudo retirar dinero por
insuficiencia de fondos.*)
var
    movimiento:char;
    monto, deposito, retiro: integer;
    finDeDatos: boolean;
begin
    writeln('ingrese el monto de la cuenta');
    readln(monto);

    if monto <0 then
        monto:= monto*(-1);

    while movimiento <> 'f' do
        begin
            Repeat
                begin
                    writeln('ingrese movimiento: (d=depósito, r=retiro ó f= fin de datos)');
                    readln(movimiento);
                end;
            until (movimiento='d') or (movimiento='r') or (movimiento='f') ;

            case movimiento of
                'd':
                    begin
                        repeat
                            writeln('Ingrese el monto que desea depositar');
                            readln(deposito);
                        until deposito>0;

                        monto:= monto + deposito;
                    end;
                'r':
                    begin
                        repeat
                            writeln('Ingrese el monto que desea retirar');
                            readln(retiro);                          
                        until (retiro>0);

                        if retiro>monto then
                            writeln('Monto en cuenta insuficiente')
                        else
                            monto:= monto - retiro; (*VALIDAR MOVIMIENTOS*)
                    end;
                'f': writeln('Operacion terminada');
            end;
        end;
    writeln('Su monto es: ', monto);
    readln();
end.
