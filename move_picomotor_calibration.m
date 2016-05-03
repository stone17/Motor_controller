function move_picomotor( motor, control, speed, amount_steps)
global configuration;
    % REV motor --> reverse direction
    amount_steps = calculate_um_to_steps( amount_steps );
    configuration.shouldStop(motor) = 0;
    setChannel( control );
    kommando = sprintf('pos %s 0', control.motor);
    pico_command(kommando);
    pause(1);
    set_speed_of_motor( control, speed );
    pause(1);
    
    control.motor;
    amount_steps;
    
    % command "rel" can go steps backward! so negative values would work
    kommando = sprintf('rel %s %d g', control.motor, amount_steps);
    pico_command(kommando);
    pause(1);
    position = 0;
    n = 0;
    while (position < amount_steps && n < 100 && configuration.shouldStop(motor)==0 )
        kommando = sprintf('pos %s', control.motor);
        ausgabe = pico_command(kommando);
        if isempty(ausgabe)
            return
        end
        pause(1);
        %ausgabe
        position_new = getValue(ausgabe);
        %set(hObject,'String',[num2str(position_new),'/',num2str(amount_steps),' Steps'],'Foregroundcolor','r')
        if position_new>position
            position=position_new;
        else
            %return
        end
        n = n + 1;
        %refresh_motor_position(motor);
        pause(01);
        
    end;
    %refresh_motor_position(motor);
    pause(0.1);
    configuration.shouldStop(motor) = 0;

end

