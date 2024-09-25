program Ejercicio17;

(*Ej 17) Un médico tiene en un archivo de texto información sobre sus pacientes ordenado por su número
de historia clínica. En cada línea:
    • Número Historia Clínica (entero positivo, orden ascendente)
    • Apellido y Nombre del Paciente (cadena de 30)
Se desea obtener un listado de los pacientes con apellidos que comienzan entre ‘A’ y ‘F’ ordenados
alfabéticamente. *)

const
    N=5;

type
    ST30 = string[30];
    TVNombres = array[1..N] of ST30;
    TVNum = array[1..N] of word;

procedure OrdenarArreglo(var vPacientes:TVNombres;pos:byte);
var
    i,tope,K:Byte;
    vecAux:TVNombres;
begin
    Tope := pos;
    Repeat
        K := 0;
        For i := 1 to Tope - 1 do {el Tope no es estático, se redefine en cada pasada}
        begin
            If (vPacientes[i] > vPacientes[i+1]) then
                Begin
                    vecAux[1]:= vPacientes[i]; 
                    vPacientes[i]:= vPacientes[i+1]; 
                    vPacientes[i+1]:=vecAux[1];
                    K:= i; {guarda la posición del último cambio}
                End;
        end;
        Tope:= K; {fija el tope de la próxima pasada en la posición del último cambio}
    Until (K <=1);
end;

procedure MostrarArreglo(vPacientes:TVNombres;pos:byte);
var
    i:byte;
begin
    for i:=1 to pos do
    begin
        if (vPacientes[i][1] In ['A'..'F']) then
            Writeln(vPacientes[i],'. ');
    end;
end;

var
    arch:text;
    num:word;
    nombre:ST30;
    aux:char;
    vPacientes:TVNombres;
    vNumHistCli:TVNum;
    contPacientes:byte;
begin
    Assign(arch,'datos.TXT');
    Reset(arch);
    contPacientes:=0;
    while not eof(arch) do
    begin
        ReadLn(arch,num,aux,nombre);
        contPacientes:= contPacientes +1;
        vPacientes[contPacientes]:=nombre;
        vNumHistCli[contPacientes]:=num;
    end;
    OrdenarArreglo(vPacientes,contPacientes);
    MostrarArreglo(vPacientes,contPacientes);
end.