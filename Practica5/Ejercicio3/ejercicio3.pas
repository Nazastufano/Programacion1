program Ejercicio3;

(*Ej 3) Dado un arreglo V y un número K, cambiar todas las ocurrencias 
de K por 0. *)

type
    TV = array of integer;

var
    arreglo: TV;
    largo, valor, i:integer;

procedure LlenarArreglo(var vec:TV;var n: integer);
    var
        i: integer;
begin
        
    repeat
        writeln('Ingrese el largo del arreglo: ');
        readln(n);
    until (n>0);

    setLength(vec, n);

    for i := 0 to (Length(vec)-1) do        
        begin
            writeln('Ingrese el valor de la posicion: ', i);
            readln(vec[i]);   
        end;
end;

procedure RemplazarCero(var vec:TV);
    var
        valor,i:integer;
begin
    writeln('Que numero desea cambiar?');
    readln(valor);

    for i := 0 to (Length(vec)-1) do
        begin
            if vec[i]=valor then
                vec[i]:=0;      
        end;
end;

procedure MostrarArreglo(vec:TV);
begin
    for i := 0 to (Length(vec)-1) do
        begin
            if i=0 then
                write('(');

            if (i<>Length(vec)-1) then
                write(vec[i], ', ')
            else
                begin
                    write(vec[i], ')');      
                end;
        end;
end;

begin
    LlenarArreglo(arreglo,largo);
    RemplazarCero(arreglo);
    MostrarArreglo(arreglo);
end.