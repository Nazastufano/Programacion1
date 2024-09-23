Program Ejercicio11;

(*Ej 11) De una competencia de atletismo se tienen los siguientes datos del lanzamiento de jabalina:
    • Nombre del competidor (ordenado ascendentemente por este dato)
    • 1º lanzamiento
    • 2º lanzamiento
Se pide:
    a) Cuántos competidores superaron con el 2º lanzamiento el 1º.
    b) Nombre del atleta que registró la mejor marca.
    c) Dado el Nombre de un atleta, informar la marca que realizó en ambos lanzamientos.
    d) Generar un nuevo arreglo con los participantes que pasaron a la semifinal (aquellos que superaron
    una marca X establecida en el 1º ó 2º lanzamiento). Mostrar ambos arreglos.*)

const
    N = 3;
    
type
    ST10 = string[10];
    TVecNom = array[1..N] of ST10;
    Tvec = array[1..N] of Byte;

procedure MostrarArreglo(vec:TVecNom;indice:byte);
var
    i:byte;
begin
    Write('(');
    for i:=1 to indice do
    begin
        Write(vec[i]);    
        if i<>indice then
            Write(', ');
    end;
    Writeln(')');
end;

procedure LlenarArreglos(var nombres: TVecNom; var priLanza,segLanza:Tvec);
var
    i:byte;
begin
    for i:= 1 to N do
    begin
        WriteLn('Escribe el nombre del participante numero ', i);
        ReadLn(nombres[i]);
        
        WriteLn('Ingrese la puntuacion del primer lanzamiento: ');
        ReadLn(priLanza[i]);

        WriteLn('Ingrese la puntuacion del segundo lanazmiento: ');
        ReadLn(segLanza[i]);
    end;
end;


function Superan(pri,seg:Tvec): byte;
var
    i,contCompSuper:byte;
begin
    contCompSuper:= 0;

    for i:= 1 to N do
    begin
        if pri[i]<seg[i] then
            contCompSuper:= contCompSuper +1;
    end;
    Superan:=contCompSuper;
end;

function MejorMarca(pri,seg:Tvec;nom:TVecNom):ST10;
var
    mejor,mayor,i:byte;
    nombreMejor:ST10;
begin
    nombreMejor:='';
    mejor:=0;
    for i:=1 to N do
    begin
        if pri[i]>seg[i] then
            mayor:=pri[i]
        else
            mayor:=seg[i];
            
        if (mejor<mayor) then
        begin
            mejor:=mayor;
            nombreMejor:=nom[i];
        end;
    end;
    MejorMarca:=nombreMejor;
end;

procedure PuntajesPorNombre(pri,seg:Tvec;nombres:TVecNom;nombre:ST10);
var
    i,pos:byte;
begin

    for i:=1 to N do
    begin
        if UpCase(nombres[i]) = Upcase(nombre) then
            pos:=i;
    end;

    WriteLn('El puntaje del atleta: ', nombre, '. En el primer lanzamiento es: ', pri[pos],'. Y en el segundo: ',seg[pos]);
end;

procedure SemiFinales(pri,seg:Tvec;nombres:TVecNom; puntosSuperar:byte);
var
    pos,i:byte;
    nombresASemis:TVecNom;
begin
    pos:=0;
    for i:=1 to N do
    begin
        if ((puntosSuperar<pri[i]) or (puntosSuperar<seg[i])) and (pos<=4) then
        begin
            pos:=pos +1;
            nombresASemis[pos]:=nombres[i];
        end;
    end;

    MostrarArreglo(nombresASemis,pos);
end;

var
    priLanza, segLanza:TVec;
    nombres:TVecNom;
    nombre:ST10;
    puntos:Byte;
begin
    WriteLn('Ingrese la cantidad de puntos a superar');
    ReadLn(puntos);
    LlenarArreglos(nombres,priLanza,segLanza);

    WriteLn('La cantidad de competidores que superaron con el segundo lanzamiento al primeros son: ', Superan(priLanza,segLanza));

    WriteLn('El nombre del atleta que ha registrado la mejor marca es: ', MejorMarca(priLanza,segLanza,nombres));

    WriteLn('Ingrese el nombre de un competidor');
    ReadLn(nombre);
    PuntajesPorNombre(priLanza,segLanza,nombres,nombre);

    SemiFinales(priLanza,segLanza,nombres,puntos);
end.