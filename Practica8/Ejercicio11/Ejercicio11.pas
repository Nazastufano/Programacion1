Program Ejercicio11;

(*Ej 11) Desarrollar un procedimiento recursivo para imprimir una media pirámide de dígitos como se
muestra a continuación:
1
2 1
3 2 1
4 3 2 1
5 4 3 2 1
6 5 4 3 2 1
7 6 5 4 3 2 1
8 7 6 5 4 3 2 1
9 8 7 6 5 4 3 2 1
Nota: Utilizar un procedimiento recursivo para generar cada fila de la media pirámide. *)

procedure MediaPiramide(c,a,f,tope:byte);
begin
    if c > f then
        if a = f then
            begin
                MediaPiramide(c-1,c-1,f,1);
                WriteLn;
            end
        else
            MediaPiramide(c,a-1,f,tope+1);
    Write(tope:4);
end;

Begin
    MediaPiramide(9,9,1,1);
End.