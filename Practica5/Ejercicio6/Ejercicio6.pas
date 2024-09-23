Program Ejercicio6;

(*Ej 6) Escriba un programa que lea una frase (secuencia de caracteres separada por espacio, coma, punto)
y mediante un menú de opciones calcule e informe:
a) El número de palabras que contiene.
b) La longitud de la palabra más larga.
c) De todas las palabras, la que aparece antes en el diccionario. Analizar las alternativas de
almacenar dicha palabra en un arreglo de caracteres o en un string.
d) la frecuencia de cada letra (mayúscula o minúscula) que aparece en la frase.
No es necesario almacenar toda la frase en un arreglo. 
*)

const
    N=30;

type
    TVec = array[1..N] of char;
    TVecNum = array[1..N] of word;
    ST1 = string[1];
//a)
function NumPalabras(pal:string):byte;
var
    i,contPal:byte;
    
begin
    contPal:=1;
    for i:= 1 to Length(pal) do
    begin
        if (pal[i] = ' ') then
            contPal:= contPal +1;
    end;
    NumPalabras:= contPal;
end;
//b)
function PalabraMasLarga(pal:string):byte;
var
    i:byte;
    car:char;
    masLarga,palabra:string;
begin
    palabra:= '';
    masLarga:= '';
    for i:= 1 to Length(pal) do
    begin
        car := pal[i];
        if ((car <> ' ') and (car <> ',') and (car <> '.')) then
                palabra := palabra + car
        else
            begin
                if (Length(palabra)>Length(masLarga)) then
                    masLarga:= palabra;
                palabra := '';
            end;
    end;
    if (Length(palabra)>Length(masLarga)) then
        masLarga:= palabra;

    PalabraMasLarga := Length(masLarga);
end;
//c) con string
function PalabraAlfabetico(pal:string):string;
var
    i:byte;
    car:char;
    priPal,palabra:string;
begin
    palabra := '';
    priPal:= '';
    for i:= 1 to Length(pal) do
    begin
        car := pal[i];
        if (car <> ' ') and (car <> ',') and (car <> '.')then
            palabra := palabra + car
        else
            begin
                if (palabra<priPal) or (priPal='') then
                    priPal:= palabra;
                palabra:= '';
            end;
    end;

    If palabra<priPal Then
        priPal := palabra;

    PalabraAlfabetico := priPal;
end;

procedure LlenarArreglo(var vec:TVec);
var
    i:byte;
begin
    for i:= 1 to N do
        vec[i]:= ' ';
end;

procedure LlenarArregloNum(var vec:TVecNum);
var
    i:byte;
begin
    for i:= 1 to N do
        vec[i]:= 0;
end;
//c) con Arreglo

function PalabraAlfabeticoV(pal:String):TVec;
var
    i,j,pos:byte;
    car:char;
    priPal,palabra:TVec;
begin
    LlenarArreglo(priPal);
    LlenarArreglo(palabra);
    pos := 1;
    for i:= 1 to Length(pal) do
    begin
        car := pal[i];
        if (car <> ' ') and (car <> ',') and (car <> '.')then
            begin
                palabra[pos] := car;
                pos:= pos +1;
            end
        else
            begin
                if (palabra<priPal) or (priPal[1] = ' ') then
                    for j:=1 to pos do
                        priPal[j]:= palabra[j];
                
                LlenarArreglo(palabra);
                pos := 1;
            end;
    end;
    If palabra<priPal Then
        for j:=1 to pos do
            priPal[j]:= palabra[j];

    PalabraAlfabeticoV := priPal;
end;

function PosicionLetra(vec:TVec; car: ST1):byte;
var
    i,pos:byte;
begin
    pos := 1;
    i := 1;
    while (vec[i] <> ' ') and (vec[i] <> ',') and (vec[i] <> '.') do
    begin        
        if vec[i] = car then
            pos := i;
        i := i + 1;
    end;
    if pos = 1 then
        pos:=i;

    PosicionLetra := pos;
end;

procedure FrecuenciaLetras(var vecFrecuencia: TVecNum; var vecLetra:TVec; pal:string);
var
    i,pos:byte;
    
begin
    LlenarArreglo(vecLetra);
    LlenarArregloNum(vecFrecuencia);
    for i:=1 to Length(pal) do
    begin
        if (pal[i] <> ' ') and (pal[i] <> '.') and (pal[i] <> ',') then
        begin
            pos := PosicionLetra(vecLetra,pal[i]);
            vecLetra[pos] := pal[i];
            vecFrecuencia[pos]:= vecFrecuencia[pos] + 1;
        end;
    end;
    for i:=1 to N do
        if (vecLetra[i] <> ' ') and (vecFrecuencia[i] <> 0) then
            Writeln(vecLetra[i],' ', vecFrecuencia[i]);
end;

var
    //i:byte;
    frase:string;
    res:char;
    vecFrecuencia:TVecNum;
    vecLetra:TVec;
begin
    WriteLn('Ingrese un afrase separada por: (".", "," o " ")');
    ReadLn(frase);
    repeat
        WriteLn('Que desea Ejecutar? (A=Numero de palabras, B=La palabra mas larga, C=La primer palabra en orden alfabetico, D=frecuencia de Letras, F=Salir)');
        ReadLn(res);
        res:= upCase(res);
        case res of 
            'A':WriteLn('El numero de palabras que tiene la frase es: ', numPalabras(frase));
            'B':WriteLn('La palabra mas larga tiene ', PalabraMasLarga(frase), ' caracteres');
            'C':WriteLn('La primera palabra en el orden alfabetico es: ',PalabraAlfabetico(frase));
            'D':FrecuenciaLetras(vecFrecuencia,vecLetra,frase);
        end;
    until res = 'F';
    {
    vecLetra:= PalabraAlfabeticoV(frase);
    WriteLn('La primera palabra en el orden alfabetico es: ');
    for i:=1 to Length(vecLetra) do
        Write(vecLetra[i],' ');
    }
end.