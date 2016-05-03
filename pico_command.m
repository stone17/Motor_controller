function value = pico_command(cmd)
    global telnet;
    %cmd = sprintf('%s\n', cmd )
    %disp 'Anfang*';
    try
        fprintf(telnet, cmd );
    catch ME1
        disp ('Not connected!');
        value='';
        return;
    end;
    while( get(telnet, 'BytesAvailable') == 0 )
       pause(0.1);
    end
    value = '';
    while (get(telnet, 'BytesAvailable') > 0)
        %telnet.BytesAvailable
        value = strcat( value, fscanf(telnet, '%c', telnet.BytesAvailable));
    end