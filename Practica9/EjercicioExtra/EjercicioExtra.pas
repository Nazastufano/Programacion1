Program EjercicioExtra;

(*En un archivo llamado USUARIOS.DAT se tiene los siguientes datos:
    # NOMBRE DE USUARIO (campo de secuencia, clave primaria, cadena de 15 caracteres)
    # CONTRASENIA
Por otro lado, se tiene otro archivo llamado LOGIN.DAT con los siguientes datos:
    # FECHA (campo de secuencia, clave secundaria)
    # NOMBRE DE USUARIO (campo de secuencia, clave secundaria)
    # CONTRASENIA
    # ACCION (caracter). Puede ser I de Iniciar sesion, R de Registrarse o C de Cerrar sesion
Se pide:
    a) Listar los inicios de sesion fallidos (es decir, aquellos inicios de sesion en la que
       no se haya encontrado el nombre de usuario o la contrasenia sea incorrecta) en un archivo
       RECHAZADOS.DAT.
    b) Actualizar la base de datos USUARIOS.DAT.
    c) Elaborar el siguiente listado
       Fecha       Usuarios nuevos  Inicios de sesion* Cierres de sesion
       XX XX XXXX        999               999              999
       ...
       Usuarios nuevos en total: 9999
       * Inicios de sesion exitosos
    d) Informar en que dia hubo mas usuarios que se registraron

Verificar los archivos binarios con archivos de texto.*)
type
    ST15=string[15];
    ST10 = string[10];
    TRegUs = record
        usuario:ST15;
        contra:ST10;
    end;
    TRegLo =  record
        datos:TRegUs;
        fecha:ST10;
        accion:char;
    end;
    TArchUsuarios = file of TRegUs;
    TArchLogin = file of TRegLo;
procedure GrabaArchivoLogin(var archLogin:TArchLogin);
var
    R:TRegLo;
    arch:TEXT;
    aux:Char;
begin
    Assign(arch,'LOGIN.TXT');
    Reset(arch);
    Rewrite(archLogin);
    while not eof(arch) do
    begin
        ReadLn(arch,R.fecha,aux,R.datos.usuario,aux,R.datos.contra,aux,R.accion);
        Write(archLogin,R);
    end;
    close(arch);
    close(archLogin);
end;
procedure GrabaArchivoUsuarios(var archUsuarios:TArchUsuarios);
var
    arch:Text;
    R:TRegUs;
    aux:char;
begin
    Assign(arch,'USUARIOS.TXT');
    reset(arch);
    Rewrite(archUsuarios);
    while Not eof(arch) do
    begin
        ReadLn(arch,R.usuario,aux,R.contra);
        Write(archUsuarios,R);
    end;
    Close(arch);
    Close(archUsuarios);
end;
procedure AnalizarIniciosFallidos(var archUsuarios,archRechazados:TArchUsuarios;var archLogin:TArchLogin);
var
    RLo:TRegLo;
    RUs:TRegUs;
    fechaActual:ST10;
begin
    Reset(archUsuarios);
    Reset(archLogin);
    Rewrite(archRechazados);
    read(archUsuarios,RUs);
    Read(archLogin,RLo);
    while (NOT Eof(archUsuarios)) or (NOT eof(archLogin)) do
    begin
        fechaActual:=RLo.fecha;
        while fechaActual=RLo.fecha do
        begin
            If (RUs.usuario = RLo.datos.usuario) Then
            begin
                while (RUs.usuario=RLo.datos.usuario) and (fechaActual=RLo.fecha) do
                begin
                    if (RUs.contra<>RLo.datos.contra) and (RLo.accion='I') then
                        Write(archRechazados,RLo.datos);
                        
                    read(archLogin,RLo);
                end;
                Read(archUsuarios,RUs);
            end 
            else if RUs.usuario>RLo.datos.usuario then
            begin
                if (RLo.accion='I') then
                    Write(archRechazados,RLo.datos);
                read(archLogin,RLo);
            end
            else
                Read(archUsuarios,RUs);
        end;
    end;
    Write(archRechazados,RUs);
    Close(archRechazados);
    close(archUsuarios);
    Close(archLogin);
end;

procedure ActualizarBaseDeDatos(var archLogin:TArchLogin; var archUsuarios:TArchUsuarios; nom:ST15);
var
    RUs:TRegUs;
    RLo:TRegLo;
    ArchTemp:TArchUsuarios;
    fechaActual:ST10;
begin
    Assign(ArchTemp,'TEMP.DAT');
    Rewrite(ArchTemp);
    Reset(archLogin);
    Reset(archUsuarios);
    read(archLogin,RLo);
    Read(archUsuarios,RUs);
    while (not Eof(archLogin)) or (NOT eof(archUsuarios)) do
    begin
        if RUs.usuario = RLo.datos.usuario then
        begin
            Write(ArchTemp,RUs);
            while RUs.usuario = RLo.datos.usuario do
                Read(archLogin,RLo);
            Read(archUsuarios,RUs);
        end
        else If (RUs.usuario>RLo.datos.usuario) Then
        begin
            if RLo.accion='R' then
                Write(ArchTemp,RLo.datos);                
            read(archLogin,RLo);
        end
            else
                read(archUsuarios,RUs);
    end;
    Write(ArchTemp,RUs);
    Close(archLogin);
    Close(archUsuarios);
    Close(ArchTemp);
    Erase(archUsuarios);
    Rename(ArchTemp,nom);
end;
procedure MostrarBaseDeDatos(var archUsuarios:TArchUsuarios);
var
    R:TRegUs;
begin
    reset(archUsuarios);
    WriteLn('Base de datos');
    while Not Eof(archUsuarios) do
    begin
        Read(archUsuarios,R);
        WriteLn(R.usuario,' ',R.contra);
    end;
    Close(archUsuarios);
end;
procedure MostrarRechazados(var archRechazados:TArchUsuarios);
var
    R:TRegUs;
begin
    Reset(archRechazados);
    WriteLn('Los usuarios rechazados');    
    while Not Eof(archRechazados) do
    begin
        read(archRechazados,R);
        WriteLn(R.usuario,' ',r.contra);
    end;
    Close(archRechazados);
end;
procedure HacerTabla(var archLogin:TArchLogin;var archUsuarios:TArchUsuarios);
var
    RUs:TRegUs;
    RLo:TRegLo;
    contUN,contISE,contCS:word;
    fechaActual:ST10;
begin
    Reset(archUsuarios);
    Reset(archLogin);
    Writeln('Fecha       Usuarios nuevos  Inicios de sesion  Cierres de sesion');
    read(archLogin,RLo);
    read(archUsuarios,RUs);
    while (NOt Eof(archLogin)) or (NOT Eof(archUsuarios)) do
    begin
        contUN:=0;
        contISE:=0;
        contCS:=0;
        fechaActual:=RLo.fecha;
        while fechaActual=RLo.fecha do
        begin
            if (RUs.usuario=RLo.datos.usuario) then
            begin
                while (RUs.usuario=RLo.datos.usuario) and (fechaActual=RLo.fecha) do
                begin
                    if (RUs.usuario=RLo.datos.usuario) and (Rus.contra=RLo.datos.contra) and (RLo.accion='I')  then
                        contISE:=contISE+1;
                    if (RUs.usuario=RLo.datos.usuario) and (Rus.contra=RLo.datos.contra) and (RLo.accion='C')  then
                        contCS:=contCS+1;
                    
                    Read(archLogin,RLo);
                end;
                Read(archUsuarios,RUs);
            end
            else if (RUs.usuario>RLo.datos.usuario)  then
            begin
                if Rlo.accion ='R' then
                    contUN:=contUN+1;
                Read(archLogin,RLo);
            end
                else
                    Read(archUsuarios,RUs);
                
        end;
        Writeln(fechaActual, ' ', contUN:10, ' ', contISE:15, ' ', contCS:20);
    end;
    Close(archLogin);
    Close(archUsuarios);
end;
procedure DiaMasRegistros(var archLogin:TArchLogin);
var
    R:TRegLo;
    masReg,contUR:word;
    diaMR,diaActual:ST10;
    
begin
    Reset(archLogin);
    Read(archLogin,R);
    masReg:=0;
    
    while Not eof(archLogin) do
    begin
        contUR:=0;
        diaActual:=R.fecha;
        while diaActual = R.fecha do
        begin
            if r.accion='R' then
                contUR:=contUR+1;
            read(archLogin,R);
        end;
        if contUR>masReg then
        begin
            masReg:=contUR;
            diaMR:=diaActual;
        end;
    end;
    WriteLn('El dia con mas registros es: ', diaMR,' con ', masReg, ' registros');
end;
var
    archUsuarios,archRechazados:TArchUsuarios;
    archLogin:TArchLogin;
begin
    Assign(archUsuarios,'USUARIOS.DAT');
    Assign(archLogin,'LOGIN.DAT');
    Assign(archRechazados,'RECHAZADOS.DAT');

    GrabaArchivoLogin(archLogin);
    GrabaArchivoUsuarios(archUsuarios);
    //AnalizarIniciosFallidos(archUsuarios,archRechazados,archLogin);
    //MostrarRechazados(archRechazados);
    //MostrarBaseDeDatos(archUsuarios);
    //ActualizarBaseDeDatos(archLogin,archUsuarios,'USUARIOS.DAT');
    //MostrarBaseDeDatos(archUsuarios);
    HacerTabla(archLogin,archUsuarios);
    DiaMasRegistros(archLogin);
end.