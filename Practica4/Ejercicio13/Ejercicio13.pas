program Ejercicio13;

(* Ej 13) Desarrollar un procedimiento que dada una Hora Inicial (horas, minutos, segundos) y unos
segundos transcurridos, devuelva la Hora Final (en horas, minutos y segundos). *)

procedure HoraTranscurrida(tiempoPasado:word; var h,m,s:byte);
var
    seg, min, hor: byte;
    tiempo: word;
begin    
    seg := tiempoPasado Mod 60;
    min := tiempoPasado div 60;    
    hor := tiempoPasado div 3600;
    
    s:= s + seg;
    If s >= 60 Then
    Begin
        m := m + (s Div 60);
        s := s Mod 60;
    End;
    
    if (tiempoPasado < 3600) then
    begin
        m := m + min;
        If m >= 60 Then
        Begin
            h := h + (m div 60);
            m := m mod 60;
        End;  
    end;

    h:= h + hor;
    If h >= 24 Then
        h := h Mod 24;
end;

var
    horas, minutos, segundos:byte;
    segTransc:word;

begin
    repeat
        WriteLn('Ingrese una hora inicial: ("HH:MM:SS", separada por enter)');
        ReadLn(horas, minutos, segundos);  
    until (horas <= 24) and (minutos <= 60) and (segundos<=60);
    
    WriteLn('Cuantos segundos pasaron: ');
    ReadLn(segTransc);
    
    HoraTranscurrida(segTransc, horas,minutos,segundos);
    WriteLn(horas, ':', minutos, ':', segundos);
end.