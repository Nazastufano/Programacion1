program Ejercicio3;

(*Ej 3) Dado un conjunto de puntos en el plano, almacenar en un arreglo sus coordenadas junto con la
distancia al centro de coordenadas y a qué cuadrante pertenece.
Usando el arreglo, se pide:
    Informar el más cercano y más lejano al centro.
    Porcentaje de puntos en cada cuadrante (1..4, centro, eje X, eje Y).
Cada punto en el plano P tiene una coordenada X y otra Y. Desarrollar la función Distancia que dados
dos puntos P y Q devuelva la distancia entre ambos.
*)

const
    N = 4;
type
    TipoReg=record
        x, y:integer;
        distancia: real;
    end;
    TVReg = array[1..N] of TipoReg;
    
var
    conjunto:TVReg;
    

procedure LlenarArreglo(var conjunto:TVReg);
    var
        i:byte;
        x,y:integer;
    begin
        for i := 1 to N do
            begin
                writeln('Ingrese la posicion en X: ');
                readln(x);
                writeln('Ingrese la posicion en Y: ');
                readln(y);

                conjunto[i].x:= x;
                conjunto[i].y:= y;
                conjunto[i].distancia := sqrt((x*x)+(y*y));
            end;
    end;

procedure MasCercano(conjunto:TVReg);
    var
        i, posMasCerca:byte;
        masCerca:real;
    begin
        masCerca:= conjunto[1].distancia;
        posMasCerca:= 1;
        for i := 2 to N do
            begin
                if masCerca> conjunto[i].distancia then
                    begin
                        masCerca:= conjunto[i].distancia;
                        posMasCerca:= i;    
                    end;
                    
            end;
        writeln('El punto mas cercano al centro es el punto (', conjunto[posMasCerca].x,', ', conjunto[posMasCerca].y,')');
    end;

procedure MasLejano(conjunto:TVReg);
    var
        i, posMaslejos:byte;
        masLejos:real;
    begin
        masLejos:= conjunto[1].distancia;
        posMaslejos:= 1;
        for i := 2 to N do
            begin
                if masLejos< conjunto[i].distancia then
                    begin
                        masLejos:= conjunto[i].distancia;
                        posMaslejos:= i;    
                    end;
                    
            end;
        writeln('El punto mas lejano al centro es el punto (', conjunto[posMaslejos].x,', ', conjunto[posMaslejos].y,')');
    end;

procedure DetecCuadrante(conjunto:TVReg);
    var     //cuadrante 1,2,3,4,centro,eje x, eje y)
        contPos: array[1..7] of byte = (0,0,0,0,0,0,0);
        i:byte;
    begin
        for i := 1 to N do
            begin
                if (conjunto[i].x  = 0) and (conjunto[i].y = 0) then
                    contPos[5]:= contPos[5] + 1
                else
                    begin
                        if conjunto[i].x = 0 then
                            contPos[7]:= contPos[7] +1
                        else
                            if conjunto[i].y = 0 then
                                contPos[6]:= contPos[6] +1
                            else
                                if conjunto[i].x > 0 then
                                    if (conjunto[i].y > 0)  then
                                        contPos[1]:= contPos[1] +1
                                    else
                                        contPos[4]:= contPos[4] +1
                                else
                                    if (conjunto[i].y > 0) then
                                        contPos[2]:= contPos[2] +1
                                    else
                                        contPos[3]:= contPos[3] +1
                    end;  
            end;
        
        for i := 1 to 7 do
            begin
                case i of
                    1..4:writeln('El porcentaje de puntos en el cuadrante: ', i, ' es de: ', (contPos[i]/N):0:2);
                    5:writeln('El porcentaje de puntos en el centro es de: ', (contPos[i]/N):0:2);
                    6: writeln('El porcentaje de puntos en el eje x es de: ', (contPos[i]/N):0:2);
                    7: writeln('El porcentaje de puntos en el eje y es de: ', (contPos[i]/N):0:2);
                end;
            end;  
    end;


function Distancia(x1:integer;x2:integer; y1:integer; y2:integer):real;
    var
        xf,yf:integer;
    begin
        xf:= x1-x2;
        yf:= y1-y2;
        Distancia := sqrt((xf*xf)+(yf*yf));
    end;

procedure LecturaPuntos(var x:integer; var y:integer);
    begin
        writeln('Ingrese un punto');
        writeln('Ingrese la coordenada x: ');
        readln(x);
        writeln('Ingrese la coordenada y: ');
        readln(y);
    end;

procedure CalcularDistancia();
    var
        x1,x2,y1,y2:integer;

    begin

        LecturaPuntos(x1,y1);
        LecturaPuntos(x2,y2);
        
        writeln('La distancia entre los puntos es: ',  Distancia(x1,x2,y1,y2):0:2);
    end;


begin
    LlenarArreglo(conjunto);
    MasCercano(conjunto);
    MasLejano(conjunto);

    DetecCuadrante(conjunto);
    
    CalcularDistancia();
end.