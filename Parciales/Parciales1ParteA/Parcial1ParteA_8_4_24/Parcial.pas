program Parcial;

{En una partida de dados intervienen una cantidad desconocida de jugadores, todos realizan N tiros con 2 dados.
Dicha inforamción se agrupa: en la primera linea viene N y luego
    Nombre (Cadena de 10, 'XXX' es fin de datos)
    y a continuación, en distintas lineas, los N pares de números (entre 1 y 6)

Se pide ingresar la información desde el archivo Juego.TXT para:
    a) de cada jugador informar el puntaje obtenido (*), y por fin de proceso: 
    b) Teniendo en cuenta solo aquellos jugadores que obtuvieron puntaje total menor a X (dato ingresado por teclado) informar
el porcentaje de los jugadores que en alguna tirada sacaron el 6 en uno ó ambos dados.

(*)El puntaje de un tiro se calcula de la siguiente forma: 
        Suma de los dos dados
y además
        Triplica la suma obtenida si son iguales
        Duplica la suma obtenida si son consecutivos
NOTA: No usar Funciones ni Procedimientos
}
type
    ST10 = string[10];
var
    arch: text;
    dado1, dado2, n, i, contJugadores, contJugaConSeis:byte;
    puntaje,puntajeSuperar:word;
    nombre: ST10;
    sacaSeis:Boolean;
begin
    Assign(arch, 'Juego.TXT');
    Reset(arch);
    contJugadores := 0;
    contJugaConSeis := 0;
    WriteLn('Ingrese un puntaje que a superar: ');
    ReadLn(puntajeSuperar);
    
    readln(arch,n);
    ReadLn(arch,nombre);
    while nombre <> 'XXX' do
    begin
        sacaSeis:= false;
        contJugadores:= contJugadores +1;
        puntaje:= 0;
        for i:= 1 to n do
            begin
                ReadLn(arch, dado1, dado2);
                if dado1=dado2 then 
                    puntaje:= puntaje + (dado1+dado2)*3
                else
                    if (dado1=dado2+1) or (dado2 = dado1 + 1) then
                        puntaje := puntaje + (dado1+dado2)*2
                    else
                        puntaje := dado1 + dado2;
                
                if (dado1 = 6) or (dado2 = 6) then
                    sacaSeis:= true;    
            end;
        if sacaSeis and (puntaje<puntajeSuperar) then
            contJugaConSeis:= contJugaConSeis +1;
        
        WriteLn('El puntaje de: ', nombre, ' es: ', puntaje);
        ReadLn(arch,nombre);
    end;
    close(arch);
    WriteLn('El porcentaje de jugadores que no superaron el puntaje ', puntajeSuperar, ' y que sacaron al menos un 6 en alguna tirada es ', contJugaConSeis*100/contJugadores:0:0,'%')
end.