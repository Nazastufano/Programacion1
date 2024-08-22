program Ejercicio10;

(*Ej 10) Una empresa le brinda a sus clientes un servicio de
cable con un costo básico de $1350 por mes, el
paquete de películas se cobra $200 adicionales y el de deportes 
$270. Aparte ofrece internet por $800 con
6MB, si se desea 10MB y WIFI cuesta 20% más. La opción de grabar
programas tiene un costo adicional
de $150 por mes. La promoción es que si se contrata ambos
servicios (cable e internet), tiene una bonificación del 25% del
total. Ingresar los datos de un cliente, calcular e informar
cuánto debe pagar. *)

const
    costoBasico = 1350;
    pPeliculas = 200;
    pDeportes = 270;
    internet1 = 800;
    internet2 = internet1*(1 + 0.20);
    grabarProgramas = 150;
var
    internet, cable, grabar, respuestaPeli, respuestaDeportes, respuestaWifi: char;
    totalAPagar:real;
begin
    totalAPagar := 0;
    repeat
        writeln('Desea el servicio de cable por $1350? S/N');
        readln(cable);
        cable := UpCase(cable);
        
        if (cable <> 'S') and (cable <> 'N') then
            writeln('Por favor, Ingrese una respuesta valida');

        if cable = 'S' then
            begin
                repeat
                    writeln('Desea el pack de peliculas por $200? S/N');
                    readln(respuestaPeli);
                    respuestaPeli := UpCase(respuestaPeli);
                    
                    if (respuestaPeli <> 'S') and (respuestaPeli <> 'N') then
                        writeln('Por favor, Ingrese una respuesta valida');
                until (respuestaPeli = 'S')  or (respuestaPeli = 'N');

                repeat
                    writeln('Desea el pack de Deportes por $270? S/N');
                    readln(respuestaDeportes);
                    respuestaDeportes := UpCase(respuestaDeportes);
                    
                    if (respuestaDeportes <> 'S') and (respuestaDeportes <> 'N') then
                        writeln('Por favor, Ingrese una respuesta valida');
                until (respuestaDeportes = 'S')  or (respuestaDeportes = 'N');
            end;     
    until (cable = 'S')  or (cable = 'N');

    repeat
        writeln('Desea el servicio de Internet por $800? S/N');
        readln(internet);
        internet := UpCase(internet);
        
        if (internet <> 'S') and (internet <> 'N') then
            writeln('Por favor, Ingrese una respuesta valida');
       
        if internet = 'S' then
            begin
                repeat
                    writeln('Desea Los 10MB de internet por un 20% adicional?');
                    readln(respuestaWifi);
                    respuestaWifi := UpCase(respuestaWifi);

                    if (respuestaWifi <> 'S') and (respuestaWifi <> 'N') then
                        writeln('Por favor, Ingrese una respuesta valida');
                until (respuestaWifi = 'S') or (respuestaWifi = 'N');
            end;
    until (internet = 'S')  or (internet = 'N');

    repeat
        writeln('Desea el servicio de grabar por $150? S/N');
        readln(grabar);
        grabar := UpCase(grabar);
            
        if (grabar <> 'S') and (grabar <> 'N') then
            writeln('Por favor, Ingrese una respuesta valida');
    until (grabar = 'S')  or (grabar = 'N');

    if(cable = 'S') then
        totalAPagar := costoBasico;
    if(internet = 'S') then
        totalAPagar := totalAPagar + internet1;
    if(respuestaWifi = 'S') then
        totalAPagar := totalAPagar - internet1 + internet2;
    if(respuestaPeli = 'S') then
        totalAPagar := totalAPagar + pPeliculas;
    if(respuestaDeportes = 'S') then
        totalAPagar := totalAPagar + pDeportes;
    if(grabar='S') then 
        totalAPagar := totalAPagar + grabarProgramas;
    
    if (cable = 'S') and (internet = 'S') then
        totalAPagar := totalAPagar*(1-0.25);
    writeln('El total a pagar es: ', totalAPagar:5:2);
    readln();
end.