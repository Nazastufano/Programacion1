Program Ejercicio1;

(*Un supermercado tiene registrado en el archivo "Ventas.TXT" el monto facturado por distintos rubros durante
cada día de la semana. El archivo no guarda ningún tipo de orden y en cada línea viene organizado de la siguiente
forma: 
    Código de rubro (cadena de 5)
    Día, de 1 a 7
    Monto de la venta en miles de pesos
Tener en cuenta que el código de rubro puede repetirse en el mismo día y que puede ser que en un día no haya
habido ventas de todos los rubros.

Por otro lado se cuenta con el archivo "Rubros.TXT" con los códigos de los distintos rubros.

Se pide leer los datos de los archivos y almacenar la información en estructuras adecuadas, para luego:
    a) Obtener el código de rubro con menor venta promedio en los primeros 5 días. En caso de que exista más
       de uno, quedarse con el primero obtenido.
    b) Generar un arreglo ordenado en forma ascendente por monto con Código de Rubro y monto total
       vendido en fines de semana (días 6 y 7) solo para aquellos rubros que superen un monto total de ventas 
       de X$ en miles (X es dato ingresado por teclado). Luego mostrar el arreglo generado.

Nota: no resolver de manera recursiva ningún subprograma*)

const
    N=5;
Type
    ST5 = string[5];

    TReg = record
        cod:ST5;
        monto:Real;
    end;
    TV = array[1..N] of ST5;
    TVReg = array[1..N] of TReg;
    TM = array[1..7,1..N] of real;

procedure MostrarArreglo(vec:TVReg;cont:byte); //Genera el arreglo de los maximos
var
    i:byte;
begin
    for i := 1 to cont do
    begin
        if (i<>cont) then
            write('(',vec[i].cod, ', ',vec[i].monto:0:2,'), ')
        else
            write('(',vec[i].cod, ', ',vec[i].monto:0:2,')');      
    end;
end;
procedure InicializarMatriz(var matr:TM);
var
    i,j:byte;
begin
    for i:=1 to 7 do
        for j:=1 to N do
            matr[i,j]:=0;
end;
function Busqueda(vecRubros:TV;cod:ST5;cantRubros:byte):byte;
var
    i:byte;
begin
    i:=1;
    while (i<=cantRubros) and (cod<>vecRubros[i]) do
        i:=i+1;
    
    if i>cantRubros then
        Busqueda := 0
    else
        Busqueda:=i;  
end;

procedure LecturaRubros(var vecRubros:TV; var cantRubros:byte);
var
    archR:Text;
    cod:ST5;
    indice:byte;
begin
    Assign(archR,'Rubros.TXT');
    Reset(archR);
    
    While Not Eof(archR) Do
    Begin
        ReadLn(archR,cod);
        indice:= Busqueda(vecRubros,cod,cantRubros);
        if indice = 0 then  
        begin
            cantRubros := cantRubros+1;
            vecRubros[cantRubros]:=cod;
        end;
    End;
    close(archR);
end;
procedure LecturaVentas(vecRubros:TV;var matr:TM;cantRubros:byte);
var
    archV:text;
    cod:ST5;
    dia,indice:byte;
    monto:real;
begin
    Assign(archV,'Ventas.TXT');
    Reset(archV);
    InicializarMatriz(matr);
    while not eof(archV) do
    begin
        ReadLn(archV,cod,dia,monto);
        indice:= Busqueda(vecRubros,cod,cantRubros);

        matr[dia,indice]:=matr[dia,indice]+monto;
    end;
    close(archV);
end;

function MenorVentaPromedio(vecRubros:TV;matr:TM;cantRubros:byte):ST5;
var
    codMen:ST5;
    i,j:byte;
    suma,menosVenta:real;
begin
    menosVenta:=0;
    for j:=1 to cantRubros do
    begin
        suma:=0;
        for i:=1 to 5 do
            suma:=suma + matr[i,j];
        
        if (suma<>0) and (((suma/5)<menosVenta) or (menosVenta = 0)) then
        begin
            menosVenta:=suma/5;
            codMen:=vecRubros[j];
        end;  
    end;  
    MenorVentaPromedio:=codMen;  
end;
Procedure InsertaOrdenado ( Var vecReg: TVReg; vecRubros:TV;j:byte;Var cont: Byte; monto: Real);
Var 
    i:   Byte;
Begin
    i := cont;
    While ( i>0 ) And (monto < vecReg[ i ].monto ) Do
        Begin
            vecReg[ i+1 ] := vecReg [ i ] ;
            i := i-1;
        End;
    vecReg[i+1].monto := monto;
    vecReg[i+1].cod:=vecRubros[j];
    cont := cont+1;
End;

procedure SuperanVentasFDS(var vecReg:TVReg;vecRubros:TV;matr:TM;cantRubros:byte);
var
    x,suma:real;
    i,j,cont:byte;
begin
    WriteLn('Ingrese un monto a superar: ');
    ReadLn(x);
    cont:=0;
    for j:=1 to cantRubros do
    begin
        suma:=0;
        for i:=6 to 7 do
            suma:=suma+matr[i,j];
        if suma>x then
            InsertaOrdenado(vecReg,vecRubros,j,cont,suma);
    end;
    MostrarArreglo(vecReg,cont);
end;

var
    vecRubros:TV;
    vecReg:TVReg;
    matr:TM;
    cantRubros:byte;
begin
    cantRubros:=0;
    LecturaRubros(vecRubros,cantRubros);
    LecturaVentas(vecRubros,matr,cantRubros);
    WriteLn('El codigo con menor venta promedio es: ', MenorVentaPromedio(vecRubros,matr,cantRubros));
    SuperanVentasFDS(vecReg,vecRubros,matr,cantRubros);
end.