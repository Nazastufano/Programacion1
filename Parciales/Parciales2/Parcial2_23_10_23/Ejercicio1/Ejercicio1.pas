Program Ejercicio1;

(*Una aduana portuaria registra infromación sobre exportaciones mensuales de cereales en 2 archivos de
texto:

'Cereales.txt', con los siguientes pares de datos:
    -   Tipo de cereal que se exporta (cadena de 10)
    -   Precio por tonelada (en DOLARES)
    
'Exportaciones.txt' con los datos de las exportaciones de un mes: 
    -   Código de silo (de 1 a 10)
    -   Tipo de cereal guardado p/exportar (cadena de 10)
    -   Toneladas: Teneladsa del cereal guardado en el silo para exportación

Leer la inforamción en estructuras adecuadas para luego calcular e informar:
a)  Para un Tipo de cereal C(ingresado por el usuario), en cuántos silos se encuentra guardado. Informar si no se
    guardó en ninguno.
b)  Para los silos que contienen más de Z(ingresado por el usuario) toneladas en total de todos los tipos de 
    cereal, generar una estructura con: código de silo e importe total en PESOS del contenido del silo.
    Considerar una cotización de dólar oficial a $360, más un recargo de impuestos del 25% si el TOTAL supera los
    100 millones de pesos o un descuento del 5% en caso contrario. Luego listarlos.*)
const
    MAX=50;
type
    ST10 = string[10];
    TRegCerales = record
        tipoDeCeral: ST10;
        precio:real; //por tonelada en dolares
    end;

    TRExportaciones = record
        codigoDeSilo:1..10;
        tipoDeCeral:ST10;
        toneladas:word;
    end;
    TVRegC = array[1..10] of TRegCerales;
    TMRegE = array[1..MAX,1..10] of TRExportaciones;
var
    
procedure LecturaCereales(vecRegC:TVRegC;var cantCereal:Byte);
var
    arch:text;
    tipoDeCeral:st10;
    precio:real;
    aux:char;
begin
    Assign(arch,'Cereales.txt');
    Reset(arch);
    cantCereal:=0;
    while Not eof(arch) do
    begin
        readln(arch,tipoDeCeral,precio);
        cantCereal:=cantCereal+1;
        vecRegC[cantCereal].tipoDeCeral:=tipoDeCeral;
        vecRegC[cantCereal].precio:=precio;
    end;
    Close(arch);
end;

procedure LecturaExportaciones();
var
    arch:text;
    
begin
  
end;
begin
    
end.