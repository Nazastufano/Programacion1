Program Ejercicio1;

(*Un estacionamiento está compuesto por N niveles, cada uno de los cuales cuenta con M plazas. A lo
largo del día, se utiliza un dispositivo para registrar la cantidad de vehículos que ocupan cada plaza
y el tiempo que permancecen ocupados. Al final del día esta información se graba en dos matrices:
MatAutos y MatHoras.

MatAutos representa la cantidad de vehículos que ocuparon cada lugar al final del día, mientras que
MatHoras contiene la cantidad total de horas acumuladas por todos los vehículos que ocuparon cada
lugar.

Ejemplo de lote de datos
    N = 5 M = 3

            MatAutos
        4       5       15
        1       0       3
        10      3       9
        6       5       7
        2       1       3
        
            MatHoras
        9,5     15      20
        6       0       24
        15,3    10,5    9
        12      11      14
        4       1       6,5

Se pide desarrollar subprogramas en Pascal para:
a) Generar y Mostrar un arreglo de regístros VNiveles, donde cada regisstro contine:
    Nivel (1..N)
    Total de autos
    Tiempo promedio de ocupación por auto
Este arreglo solo debe inculir los niveles donde todas las plazas se ocuparon por lo menos una vez
El arreglo generado, será utilizado por otros subprogramas.

b) Determinar cuántos niveles cumplen con la condición de tener una plaza con una cantidad de
vehiculos mayor a un valor X, ingresado por teclado. Si esto no fuera recursivo el punto no será
evaluado.

Además se deberá declarar la sección Type de Pascal y los llamados a los subprogramas en el
programa principal. Se asume que las matrices ya se encuentran cargadas, y usted no debe
desarrollar la carga de las matrices.*)

type 
    TReg = record
        Nivel:byte;
        TotalAutos:word;
        TiempoProm:real;
    end;
    TMAutos = array[1..N,1..M] of byte;
    TMHoras = array[1..N,1..M] of real;
    TVNiveles = array[1..N] of TReg;
procedure CargarDatos(var mat:)
var
    VNiveles:TVNiveles
begin
  
end.