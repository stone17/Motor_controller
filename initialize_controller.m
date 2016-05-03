function erg = initialize_controller(ip,port)
    global telnet;
    telnet = tcpip(ip, port);
    set(telnet,'InputBufferSize', 30000);
    if strcmp(telnet.status,'closed')
        
    else
        
    end
    try
        fopen(telnet)
        disp 'Connection to controller set up';
        erg = 0;
        refresh_motor_position('X');
        refresh_motor_position('Y');
        refresh_motor_position('Z');
    catch ME1
        %disp ('Connecting failed');
        erg = -1;
    end;