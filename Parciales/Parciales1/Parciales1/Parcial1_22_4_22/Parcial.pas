Program Parcial;

{En una ruta argentina, se intenta determinar el correcto funcionamiento de un nuevo radar, que detecta la 
velocidad a la que circulan los vehículos. En un archivo de texto RADAR.TXT se encuentra la información obtenida 
por el radar en un determinado día. El archivo contiene: 
    ● Tipo Vehículo (1-Moto, 2-Auto, 3-Camión)  
    ● Velocidad (expresada en Km/h)  
    ● Zona de la lectura (AN3), ya está validada 
    ● Patente (Cadena de 7) 
Se pide desarrollar un programa Pascal, claro y eficiente, que ingrese desde un archivo la información 
almacenándola en las estructuras que corresponda, sólo si corresponde a una infracción.  
Se entiende por infracción al exceso de velocidad, para Motos > 100 Km/h, para Autos > 110 Km/h y para 
Camiones > 90 Km/h.  
La multa a abonar por cada infracción es una tasa fija (Motos: $1000, Autos: $2000, Camiones: $5000) 
multiplicada por un factor que depende de la zona en la que se produjo. Este factor se obtiene de otro archivo de 
texto ZONAS.TXT: 
    ● Zona (AN3) 
    ● Coeficiente para multiplicar tasa fija  
Luego resuelva: 
    a) Promedio de velocidad de las lecturas del radar que no corresponden a infracciones. 
    b) Patente correspondiente a la máxima velocidad de las infracciones cometidas en cada zona (si se repite la
    velocidad máxima, tomar la última). 
    c) Importe total de multas de una zona ingresada por teclado (puede no existir). 
Importante: Debe implementar funciones o procedimientos en los procesos que corresponda. }

begin
  
end.