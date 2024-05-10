program Ejercicio5;

(*Ej 5) Sea V un arreglo de enteros, mediante procesos 
recursivos se pide:
    a) Calcular e informar la suma de sus elementos.
    b) Mostrar sus elementos.
    c) Mostrarlos en orden inverso.
    d) Obtener el máximo de sus elementos.
    e) Obtener el promedio. 
*)

Const
    N = 12;
    
Type
    TV = array[1..N] of integer;

Const
    a: TV = (5,1,12,8,-1,3,10,9,14,0,15,7);

var
    valorMaximo:integer;
    valorPromedio:real;

//a)
function SumaValores(vec:TV; indice:byte):integer;   
begin
    if indice <= length(vec) then
        SumaValores:= SumaValores(vec, indice + 1) + vec[indice]
    else
        SumaValores:= 0;
end;

//b)
procedure MostrarElementos(vec:TV; indice:byte);
begin
    if indice <> N then
    begin
        write(vec[indice], ', ');
        MostrarElementos(vec, indice + 1);
    end
    else
        write(vec[indice], '.');
end;

//c)
procedure MostrarElemInvert(vec:TV; indice:byte);
begin
    if indice <> 1 then
    begin
        write(vec[indice], ', ');
        MostrarElemInvert(vec, indice - 1);
    end
    else
        write(vec[indice], '.');
end;

//d)
procedure Maximo(vec:TV; indice:integer; var max:integer);
begin
    if indice = N then
        max := vec[1];
    
    if indice>0 then
        begin
            if max<vec[indice] then
                max:=vec[indice];
            
            Maximo(vec,indice-1,max);  
        end;
    if indice=1 then
        writeln('El maximo es: ', max);
end;

//e)
procedure Promedio(vec:TV; indice:integer; var prom:real);
begin
    if indice>0 then
        begin
            prom:= prom + vec[indice];
            Promedio(vec,indice-1,prom);  
        end;

    if indice=1 then
        begin
            prom := prom/N;
            writeln('El promedio es: ', prom:0:2);    
        end;
        
end;

begin
    valorPromedio:=0;

    writeln(SumaValores(a,1));
    MostrarElementos(a,1);
    writeln();
    
    MostrarElemInvert(a,N);
    writeln();
    
    Maximo(a,N,valorMaximo);

    Promedio(a,N,valorPromedio);
end.