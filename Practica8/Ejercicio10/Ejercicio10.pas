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
{
procedure MezclarArreglos(var vec:TVMuestra;vec1,vec2:TV;i,j,k:byte);
begin
    k:=k+1;
    if (i=0) and (j=0) then
        WriteLn('Hecho')
    else
        if vec1[i]=vec2[j] then
            begin
                MezclarArreglos(vec,vec1,vec2,i-1,j-1,k);
                vec[k]:=vec1[i];
            end
        else
            if (vec1[i]>vec2[j]) and ((i<>0)) then
                begin
                    MezclarArreglos(vec,vec1,vec2,i-1,j,k);
                    vec[k]:=vec1[i];
                end
            else    
                begin
                    MezclarArreglos(vec,vec1,vec2,i,j-1,k);
                    vec[k]:=vec2[j];
                end;
                
end;
}
{procedure MezclarArreglos2(var vec:TVMuestra;vec1,vec2:TV;i,j,k:byte);
begin
    if (i>0) and (j>0) then
        if vec1[i]=vec2[j] then
            MezclarArreglos2(vec,vec1,vec2,i-1,j-1,k-1)
        else
            if (vec1[i]>vec2[j]) then
                MezclarArreglos2(vec,vec1,vec2,i-1,j,k-1)
            else
                MezclarArreglos2(vec,vec1,vec2,i,j-1,k-1);
    
    if true then
        WriteLn('i: ',i,' j: ',j,' k: ',k,' vec1[i]: ', vec1[i],' vec2[j]: ', vec2[j]);
    
    if (vec1[i]>vec2[j]) and (j>0) then
        vec[k]:=vec1[i]
    else
        vec[k]:=vec2[j];
    
end;}

procedure MezclarArreglos2(var vec:TVMuestra;vec1,vec2:TV;i,j,k:byte);
begin
    k := k-1;
    if (i>1) or (j>1) then
        if vec1[i]=vec2[j] then
            MezclarArreglos2(vec,vec1,vec2,i-1,j-1,k)
        else
            if (vec1[i]>vec2[j]) then
                MezclarArreglos2(vec,vec1,vec2,i-1,j,k)
            else
                MezclarArreglos2(vec,vec1,vec2,i,j-1,k)
    else
        if (vec1[i]<vec2[j])  then
            vec[k-1]:=vec1[i]
        else
            vec[k-1]:=vec2[j];
    if true then
        WriteLn('i: ',i,' j: ',j,' k: ',k,' vec1[i]: ', vec1[i],' vec2[j]: ', vec2[j]);
    
    if (vec1[i]>vec2[j])  then
        vec[k]:=vec1[i]
    else
        vec[k]:=vec2[j];
    
end;
var
    arreglo:TVMuestra;

begin
    InicializarVec(arreglo);
    //MezclarArreglos(arreglo,a,b,N,N,0);
    //MostrarArreglo(arreglo);
    MezclarArreglos2(arreglo,b,a,N,N,2*N);
    MostrarArreglo(arreglo);

end.