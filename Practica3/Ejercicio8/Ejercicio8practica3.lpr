(*Ej 8) Dado el siguiente programa Pascal indicar qué realiza y cuál es la salida, para ello grabar en un
archivo de texto, un número por línea y luego ejecutar el programa.*)


Program Ejercicio8practica3; (*Lote de prueba: 3, -5, 8, 12, -9, 1, -6, 7, -13*)

uses unit1;

Var
   Arch: text;
   A, Sum, Cont : integer;
   Begin
     Assign( Arch, 'datos.TXT' );
     reset( Arch );
     Sum:=0;
     Cont := 0;
   While NOT eof ( Arch ) do
      Begin
        Readln( Arch, A );
        If A > 0 then
          begin
               Sum := Sum + A ; Cont := Cont + 1;
          End;
  End;
      Close ( Arch );
  If Cont <> 0 then
     Writeln( Sum / Cont )
  Else
      Writeln ('no hay numeros positivos');
End.
