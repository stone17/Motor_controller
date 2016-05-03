function load_connection_options()
    global controller;
    global lvdt_config;
    global configuration;
    if exist('connection-options','file')  == 2
        file = fopen('connection-options','rt');
        if file == -1, return; end;

        version = fscanf(file,'%s', 1 );
        if( strcmp(version,configuration.version)==0 ) 
            disp 'connection-options: Wrong version of configuration file';
            return;
        end;
        typ = fscanf(file,'%s\n', 1 );

        controller.X.motor    = fscanf(file,'%s\n', 1 );
        controller.X.channel  = fscanf(file,'%s\n', 1 );
        controller.Y.motor    = fscanf(file,'%s\n', 1 );
        controller.Y.channel  = fscanf(file,'%s\n', 1 );
        controller.Z.motor    = fscanf(file,'%s\n', 1 );
        controller.Z.channel  = fscanf(file,'%s\n', 1 );
        %controller.W1.motor   = fscanf(file,'%s\n', 1 );
        %controller.W1.channel = fscanf(file,'%s\n', 1 );
        %controller.W2.motor   = fscanf(file,'%s\n', 1 );
        %controller.W2.channel = fscanf(file,'%s\n', 1 );
        %controller.W.motor    = fscanf(file,'%s\n', 1 );
        %controller.W.channel  = fscanf(file,'%s\n', 1 );

        lvdt_config.X.channel    = fscanf(file,'%d\n', 1 );
        lvdt_config.X.subdevice  = fscanf(file,'%d\n', 1 );
        lvdt_config.Y.channel    = fscanf(file,'%d\n', 1 );
        lvdt_config.Y.subdevice  = fscanf(file,'%d\n', 1 );
        lvdt_config.Z.channel    = fscanf(file,'%d\n', 1 );
        lvdt_config.Z.subdevice  = fscanf(file,'%d\n', 1 );
        lvdt_config.mot.channel    = fscanf(file,'%d\n', 1 );
        lvdt_config.mot.subdevice  = fscanf(file,'%d\n', 1 );

        configuration.ipaddress  = fscanf(file,'%s\n', 1 );
        configuration.port       = fscanf(file,'%d\n', 1 );
        configuration.delta      = fscanf(file,'%d\n', 1 );
        configuration.lvdt_frequence    = fscanf(file,'%d\n', 1 );
        configuration.lvdt_amountvalues = fscanf(file,'%d\n', 1 );

        fclose(file);
    else
        disp('Connection-Options file does not exist');
    end;
end

