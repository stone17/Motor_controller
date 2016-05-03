function shutdown_controller
    global telnet;
    global configuration;
    configuration.shouldStop('X')=0;
    configuration.shouldStop('Y')=0;
    configuration.shouldStop('Z')=0;
    configuration.shouldStop('W1')=0;
    configuration.shouldStop('W2')=0;
    configuration.shouldStop('W')=0;
    try
        pico_command('hal');
        fclose(telnet);
        delete(telnet);
        clear telnet; 
        disp 'Controller connection closed';
        refresh_motor_position('X');
        refresh_motor_position('Y');
        refresh_motor_position('Z');
        refresh_motor_position('W1');
        refresh_motor_position('W2');
        refresh_motor_position('W');
    catch ME1
        idSegLast = regexp(ME1.identifier, '(?<=:)\w+$', 'match'); 
    end
