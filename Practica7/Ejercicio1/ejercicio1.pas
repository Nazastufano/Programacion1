Program Ejercicio1;

(*Ej 1) El departamento de Recursos Humanos de una empresa desea que sus 
empleados fraternicen y decidió cada 3 meses hacer un brindis por los que 
nacieron en esa estación del año. Se pide:
    ºLeer los datos (Nombre del empleado y Fecha de Nacimiento)
    ºInformar en qué estación del año se festejan más cumpleaños. *)
const
    N=10;
type
    ST20 = string[20];
    TRegF = record
        Mes, Dia:byte;
        Anio:word;
    end;
    TRegE = record
        nombre:ST20;
        fechaNacimiento:TRegF;
    end;
    TV = array[1..N] of TRegE;

procedure CargarEmpleado(var vec:TV;var cant:byte);
Var
    Res:char;
Begin
    cant:=0; 
    Write('Ingresa datos (S/N)'); 
    Readln(Res);
    While (Upcase(Res) ='S') and (cant<N) do
    Begin
        cant:=cant+1;
        With vec[cant] do
        Begin
            WriteLn('Ingrese nombre: ');
            Readln(Nombre);
            WriteLn('Ingrese dia de nacimiento: ');
            ReadLn(fechaNacimiento.Dia);
            WriteLn('Ingrese mes de nacimiento: ');
            ReadLn(fechaNacimiento.mes);
            WriteLn('Ingrese anio de nacimiento: ');
            ReadLn(fechaNacimiento.Anio);
        End;
    Write('Ingresa datos (S/N)'); Readln(Res);
    End; 
end;
procedure EstacionMasCumple(vec:TV;cant:byte);
var
    i,max:byte;
    st:string;
    estaciones:array[1..4] of byte;
begin
    max:=0;
    for i:=1 to 4 do
        estaciones[i]:=0;
    for i:=1 to cant do
    begin
        if (vec[i].fechaNacimiento.Mes in [1..2]) or ((vec[i].fechaNacimiento.Mes = 3) and (vec[i].fechaNacimiento.dia<22)) or ((vec[i].fechaNacimiento.Mes = 12) and (vec[i].fechaNacimiento.dia>20)) then
            estaciones[1] := estaciones[1]+1;
        if (vec[i].fechaNacimiento.Mes in [4..5]) or ((vec[i].fechaNacimiento.Mes = 6) and (vec[i].fechaNacimiento.dia<22)) or ((vec[i].fechaNacimiento.Mes = 3) and (vec[i].fechaNacimiento.dia>20)) then
            estaciones[2] := estaciones[2]+1;
        if (vec[i].fechaNacimiento.Mes in [7..8]) or ((vec[i].fechaNacimiento.Mes = 9) and (vec[i].fechaNacimiento.dia<22)) or ((vec[i].fechaNacimiento.Mes = 6) and (vec[i].fechaNacimiento.dia>20)) then
            estaciones[3] := estaciones[3]+1;
        if (vec[i].fechaNacimiento.Mes in [10..11]) or ((vec[i].fechaNacimiento.Mes = 12) and (vec[i].fechaNacimiento.dia<22)) or ((vec[i].fechaNacimiento.Mes = 9) and (vec[i].fechaNacimiento.dia>20)) then
            estaciones[4] := estaciones[4]+1;
    end;
    for i:=1 to 4 do
    begin
        if max<estaciones[i] then
        begin
            max := estaciones[i];
            case i of
            1:st:='verano';
            2:st:='otonio';
            3:st:='primavera';
            4:st:='invierno';
            end;      
        end;
    end;    
    WriteLn('La estacion con mas cantidad de cumpleanios es: ',st);
end;
var
    empleados:TV;
    cant:byte;
begin
    CargarEmpleado(empleados,cant);
    EstacionMasCumple(empleados,cant);
end.