Program Ejercicio10;

(*Ej 10) Dado dos arreglos de enteros A y B ordenados ascendentemente, realizar un algoritmo
recursivo que mezcle ambos arreglos en otro C manteniendo el orden. Cada arreglo no tiene valores
repetidos. Si un valor aparece en ambos arreglos, debe pasar a C uno solo. 
*)

const
    N = 5;
type
    TV = array[1..N] of integer;
    TVMuestra = array[1..2*N] of integer;
const
    a:   TV =   (2,3,5,10,11);
    b:   TV =   (1,5,8,12,13);

procedure InicializarVec(vec:TVMuestra);
var
    i:byte;
begin
    for i:=1 to 2*N do
        vec[i]:=0;
end;

procedure MostrarArreglo(vec:TVMuestra); //Genera el arreglo de los maximos
var
    i:integer;
begin
    write('(');
    i:=1;
    while (vec[i]<>0) and (i<=2*N) do
    begin
        if (vec[i+1]<>0) and (i<2*N) then
            write(vec[i], ', ')
        else
            write(vec[i], ')');
        i:=i+1;
    end;
end;
procedure MezclarArreglos(var vec:TVMuestra;vec1,vec2:TV;i,j,k:byte);
begin
    if ((i<=N) or (j<=N)) and (vec1[i]=vec2[j]) then
        begin
            vec[k]:=vec1[i];
            MezclarArreglos(vec,vec1,vec2,i+1,j+1,k+1);  
        end
    else
        if ((vec1[i]<vec2[j]) or (j>N)) and (i<=N) then
            begin
                vec[k]:=vec1[i];
                MezclarArreglos(vec,vec1,vec2,i+1,j,k+1);  
            end        
        else
            If ((vec1[i]>vec2[j]) Or (i>N)) And (j<=N) Then
            begin
                vec[k]:=vec2[j];
                MezclarArreglos(vec,vec1,vec2,i,j+1,k+1);  
            end;
end;

var
    arreglo:TVMuestra;

begin
    InicializarVec(arreglo);
    MezclarArreglos(arreglo,b,a,1,1,1);
    MostrarArreglo(arreglo);
end.