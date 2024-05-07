Program Ejercicio1;

(*Ej 1) El departamento de Recursos Humanos de una empresa desea que sus 
empleados fraternicen y decidió cada 3 meses hacer un brindis por los que 
nacieron en esa estación del año. Se pide:
    ºLeer los datos (Nombre del empleado y Fecha de Nacimiento)
    ºInformar en qué estación del año se festejan más cumpleaños. *)



type
    TV= array[1..12] of byte;
    ST10 = string[10];
    TVST10 = array of ST10;
    TVbyte = array of byte;
    TVword = array of word;
    
    TregF = record
        Mes, Dia: TVbyte;
        Anio : TVword;
    end;

    TVFech = array of TregF;

    TipoReg=record
        nombre: TVST10;
        fecha: TVFech;
    end;

const 
    fechas:TV = (31,28,31,30,31,30,31,31,30,31,30,31);
    
var
    empleados:byte;
    regEmpleado:TipoReg;
    regFecha:TregF;


procedure CompletarFecha(var regFecha:TregF; posicion:word);
    var
        dia,mes:byte;
        anio:word;
    begin
        
        repeat
            writeLn('Ingrese el mes de nacimiento: ');
            readln(mes);
        until (mes>0) and (mes<13);
        repeat
            writeLn('Ingrese el dia de nacimiento: ');
            readln(dia);
        until (dia>0) and ((dia<=fechas[mes]) or (dia = fechas[2] + 1));
        repeat
            writeLn('Ingrese el anio de nacimiento: ');
            readln(anio);
        until (anio>1950) and (anio<2000);

        regFecha.mes[posicion]:= mes;
        regFecha.dia[posicion]:= dia;
        regFecha.anio[posicion]:= anio;
    end;

procedure LimiteArreglo(var regEmpleado:TipoReg;var regFecha:TregF);
    begin
        setLength(regEmpleado.nombre, empleados);
        setLength(regEmpleado.fecha, empleados);
        setLength(regFecha.mes, empleados);
        setLength(regFecha.dia, empleados);
        setLength(regFecha.anio, empleados);
    end;

procedure CompletarEmpleado(empleados: byte;var regEmpleado:TipoReg;var regFecha:TregF);
    var
        nombreEmp: ST10;
        i:word;
    begin

        LimiteArreglo(regEmpleado, regFecha);

        for i := 0 to empleados-1 do
        begin
            writeLn('Ingrese el nombre del empleado: ');
            readln(nombreEmp);
            regEmpleado.nombre[i] := nombreEmp;

            CompletarFecha(regFecha, i);
            regEmpleado.fecha[i]:= regFecha;
        end;
    end;

procedure MesConMasCumples(empleados:byte;regFecha: TregF);
    var
        numDeEstaciones: array[1..4] of byte = (0,0,0,0);
        estaciones: array[1..4] of ST10 = ('Verano', 'Otonio', 'Invierno', 'Primavera');
        estacion: ST10;
        i, masCumple:byte;
        
    begin
        masCumple := 0;
        for i := 0 to empleados-1 do
            begin
                if (regFecha.mes[i] in [1..2]) or ((regFecha.mes[i] = 3) and (regFecha.dia[i]<22)) or ((regFecha.mes[i] = 12) and (regFecha.dia[i]>20)) then
                    numDeEstaciones[1]:= numDeEstaciones[1] + 1;
                if (regFecha.mes[i] in [4..5]) or ((regFecha.mes[i] = 6) and (regFecha.dia[i]<22)) or ((regFecha.mes[i] = 3) and (regFecha.dia[i]>20)) then
                    numDeEstaciones[2]:= numDeEstaciones[2] + 1;
                if (regFecha.mes[i] in [7..8]) or ((regFecha.mes[i] = 9) and (regFecha.dia[i]<22)) or ((regFecha.mes[i] = 6) and (regFecha.dia[i]>20)) then
                    numDeEstaciones[3]:= numDeEstaciones[3] + 1;
                if (regFecha.mes[i] in [10..11]) or ((regFecha.mes[i] = 12) and (regFecha.dia[i]<22)) or ((regFecha.mes[i] = 9) and (regFecha.dia[i]>20)) then
                    numDeEstaciones[4]:= numDeEstaciones[4] + 1;
            end;
        
        for i := 1 to 4 do
            begin
                if masCumple<numDeEstaciones[i] then
                    begin
                        masCumple:=numDeEstaciones[i];
                        estacion := estaciones[i];
                    end;
            end;

        writeLn('La estacion con mas cumpleanios es: ', estacion);
    end;

begin

    repeat
        writeLn('Ingrese el numero de empleados: ');
        readln(empleados);
    until (empleados>0);
    
    CompletarEmpleado(empleados, regEmpleado, regFecha);
    MesConMasCumples(empleados,regFecha);
end.