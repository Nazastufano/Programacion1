program Propuesto;

(*Vectores – Ejercicio adicional propuesto
A partir de un arreglo de enteros A generar otro arreglo B, con los elementos de A sin repetir.
Donde:
    1) A está ordenado.
    2) A está desordenado.
    3) A está desordenado y B debe quedar ordenado.
Ejemplos:
    1) A = [ -1, -1, 3, 3, 3, 5, 8, 8, 12 ] -> B = [ -1, 3, 5, 8, 12 ]
    2) A = [ 22, -1, 13, -1, 8, 8, -1, 13, 7 ] -> B = [ 22, -1, 13, 8, 7 ]
    3) A = [ 22, -1, 13, -1, 8, 8, -1, 13, 7 ] -> B = [ -1, 7, 8, 13 ] *)


const
    N=9;
type
    TV = array[1..N] of Integer;
const
    vec:TV = (-1,-1,3,3,3,5,8,8,12);
    vec2:TV = (22,-1,13,-1,8,8,-1,13,7);

procedure MostrarArreglo(vec:TV;indice:Byte);
var
    i:byte;
begin
    Write('[');
    for i:= 1 to indice do
    begin
        if i<>indice then
            Write(vec[i],', ')
        else
            WriteLn(vec[i],']');
    end;
end;

procedure SinRepeticionOrdenado(vec:TV);
var
    indice,i:byte;
    vecAux:TV;
begin
    indice:=0;
    for i:=1 to N do
    begin
        if (vecAux[indice] <> vec[i]) or (i = 1) then
            begin
                indice := indice + 1;
                vecAux[indice]:=vec[i];
            end;
    end;
    MostrarArreglo(vecAux,indice);
end;

procedure BuscarPosicion(vec:TV; numero:integer; largo:byte;var indice:Byte);
var
    i,pos:byte;
begin
    pos:=0;
    for i:= 1 to largo do
    begin
        if vec[i] = numero then
            pos:=i;
    end;
    if pos = 0 then
        indice:= largo + 1
    else
        indice:= pos;
end;

procedure SinRepeticionDesordenado(vec:TV);
var
    largo,indice,i,j:byte;
    vecAux:TV;
begin
    indice:=0;
    largo:=0;
    vecAux[1]:=vec[1];
    for i:=1 to N do
    begin        
        BuscarPosicion(vecAux,vec[i],largo,indice);
        vecAux[indice]:=vec[i];
        if indice>largo then
            largo:=indice;
    end;
    MostrarArreglo(vecAux,largo);
end;

procedure OrdenarArreglo(var vec:TV; pos:byte);
var
    i,tope,K:Byte;
    vecAux:TV;
begin
    Tope := pos;
    Repeat
        K := 0;
        For i := 1 to Tope - 1 do {el Tope no es estático, se redefine en cada pasada}
        begin
            If (vec[i] > vec[i+1]) then
                Begin
                    vecAux[1]:= vec[i]; 
                    vec[i]:= vec[i+1]; 
                    vec[i+1]:=vecAux[1];
                    K:= i; {guarda la posición del último cambio}
                End;
        end;
        Tope:= K; {fija el tope de la próxima pasada en la posición del último cambio}
    Until (K <=1);
end;

procedure SinRepeticionDesordenadoBOrd(vec:TV);
var
    largo,indice,i,j:byte;
    vecAux:TV;
begin
    indice:=0;
    largo:=0;
    vecAux[1]:=vec[1];
    for i:=1 to N do
    begin        
        BuscarPosicion(vecAux,vec[i],largo,indice);
        vecAux[indice]:=vec[i];
        if indice>largo then
            largo:=indice;
    end;
    OrdenarArreglo(vecAux,largo);
    MostrarArreglo(vecAux,largo);
end;
begin
    SinRepeticionOrdenado(vec); //Arreglo ordenado
    SinRepeticionDesordenado(vec2); //Arreglo desordenado
    SinRepeticionDesordenadoBOrd(vec2);//Arreglo desordenado y B debe quedar ordenado.  
  
end.