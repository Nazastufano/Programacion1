program Ejercicio6;

(*dadas tres letras mostrarlas ordenadas en forma ascendente. Plantear tres soluciones:
a) Alternativas secuenciales
b) Alternativas anidadas con expresiones lógicas compuestas
c) Alternativas anidadas con expresiones lógicas simples*)
var
     letra1, letra2, letra3, completo: string;
begin
     writeln('Ingrese la primer letra: ');
     readln(letra1);
     writeln('Ingrese la segunda letra: ');
     readln(letra2);
     writeln('Ingrese la tercer letra: ');
     readln(letra3);
(*
     if letra1>letra2 then
        if letra1>letra3 then

        else
            if letra3>letra2

     else
         if letra2>letra3 then
               if letra3>letra1

               else
                    letra1>letra2>legra3
         else
               if letra2>letra1

               begin
               if letra2>letra3 then
                    begin
                         completo := completo + letra3;
                         completo := completo + letra2;
                    end
               else
                    begin
                         completo := completo + letra2;
                         completo := completo + letra3;
                    end;
               completo := completo + letra1;
          end
          else
          if letra2>letra3 then
               if letra2>letra1 then
               begin
                    if letra1>letra3 then
                         begin
                              completo := completo + letra3;
                              completo := completo + letra1;
                         end
                    else
                         begin
                              completo := completo + letra1;
                              completo := completo + letra3;
                         end;
                    completo := completo + letra2;
               end
          else
               if letra3>letra1 then
                    if letra3>letra2 then
                    begin
                         if letra1>letra2 then
                              begin
                                   completo := completo + letra2;
                                   completo := completo + letra1;
                              end
                         else
                              begin
                                   completo := completo + letra1;
                                   completo := completo + letra2;
                              end;
                         completo := completo + letra3
                    end;
          writeln(completo);
          readln();


     *)

     if (letra1>letra2) and (letra1>letra3) then
          begin
               if letra2>letra3 then
                    begin
                    completo := completo + letra3;
                         completo := completo + letra2;
                    end
               else
                    begin
                         completo := completo + letra2;
                         completo := completo + letra3;
                    end;
               completo := completo + letra1;
          end
     else
          if (letra2>letra3) and (letra2>letra1) then
               begin
                    if letra1>letra3 then
                         begin
                              completo := completo + letra3;
                              completo := completo + letra1;
                         end
                    else
                         begin
                              completo := completo + letra1;
                              completo := completo + letra3;
                         end;
                    completo := completo + letra2;
               end
          else
               if (letra3>letra1) and (letra3>letra2) then
                    begin
                         if letra1>letra2 then
                              begin
                                   completo := completo + letra2;
                                   completo := completo + letra1;
                              end
                         else
                              begin
                                   completo := completo + letra1;
                                   completo := completo + letra2;
                              end;
                         completo := completo + letra3
                    end;
          writeln(completo);
          readln();

end.

