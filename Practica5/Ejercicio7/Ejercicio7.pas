Program Ejercicio7;

(*Ej 7) Realizar la suma de dos números positivos muy grandes (de 10 cifras, por ejemplo). Implementar el
programa principal que lea ambos números, invoque el subprograma que resuelve la suma y muestre el
resultado. *)

const
    N=10;
type
    TV = array[1..N] of byte;

function Pasaje(n:string): TV;
var
    i:byte;
    vecAux:TV;
begin
    for i:=1 to Length(n) do
        begin
            vecAux[Length(n)-i+1]:= Ord(n[i])-48; //Se almacena el numero al reves, en espejo EJ: 123 = 321
        end;
    Pasaje:= vecAux;
end;

procedure SumaNumeros(vecMC,vecML:TV; num,cort:byte);
var
    i,contDig:byte;
    vecTotal:array[1..N+1] Of byte;
begin
    //Inicializa el array resultante con todos ceros
    for i:=1 to N+1 do
    begin
        vecTotal[i]:=0; 
    end;

    contDig:=0;
    
    //Suma cada posicion de los arreglos y lo guarda en la posicion donde iria esa suma
    for i:=cort downto 1 do //va desde el arreglo mas corto hasta el 1
    begin
        vecTotal[i] := vecMC[i] + vecML[i]; 
        contDig := contDig +1; //Cuenta los digitos
    end;

    //Termina de cargar el arreglo resultante con los valores del arreglo mas grande
    for i:=num downto cort+1 do 
    begin
        vecTotal[i]:= vecTotal[i] + vecML[i];
        contDig := contDig +1;

    end;
    //Analiza cada posicion para que no haya mas de 2 digitos por posicion
    for i:=num downto 1 do
    begin
        if vecTotal[i]>=10 then
        begin
            vecTotal[i+1] := vecTotal[i+1] + (vecTotal[i] div 10); 
            vecTotal[i]:= vecTotal[i] mod 10; //guarda el resto
        end;
    end;
    
    //Muestra el arreglo
    for i:=contDig downto 1 do
        Write(vecTotal[i]);
end;
var
    num1,num2: string;
    vc1,vc2,vcMasLargo,vcMasCorto:TV;
    largo,corte:byte;
begin
    WriteLn('Escribe un numero de mas de 10 cifras');
    ReadLn(num1);
    WriteLn('Escribe otro: ');
    ReadLn(num2);
    vc1:= Pasaje(num1);
    vc2:= Pasaje(num2);

    if Length(num1)>Length(num2) then
        begin
            vcMasLargo:= vc1;
            vcMasCorto := vc2;
            largo:= Length(num1);
            corte:= Length(num2);
        end
    else
        begin
            vcMasLargo:=vc2;
            vcMasCorto := vc1;
            largo:= Length(num2);
            corte:= Length(num1);  
        end;        

    SumaNumeros(vcMasCorto,vcMasLargo,largo,corte);
end.

{
//Opción más sencilla?
procedure SumaNumeros(n1,n2:QWord);
begin
    WriteLn('La suma de los numeros es: ', n1+n2);
end;
var
    num1,num2:QWord;
begin
    WriteLn('Escribe un numero de mas de 10 cifras');
    ReadLn(num1);
    WriteLn('Escribe otro: ');
    ReadLn(num2);

    SumaNumeros(num1,num2);
end.
}