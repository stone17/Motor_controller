function move_motor_to_position( motor, controller, lvdt, target_position, disp_value )
    global configuration;
    actual_position = get_position(lvdt,motor);
    set( disp_value, 'String', actual_position);
    n = 0;
    delta = configuration.delta;
    last_direction = 0;
    last_speed = 0;
    setChannel( controller );
    configuration.shouldStop(motor)=0;
    abs(actual_position-target_position)

    % Move motor in loop until difference of actual position and target
    % position is below given delta
    % Motor did not move since 5 seconds, something happend --> stop
    while( abs(actual_position-target_position) > delta*1e-3 && configuration.shouldStop(motor)==0 && n < 6 )
        % store old position (before new move command)
        old_position = actual_position
        
        % if actual position is "below" or "above" target position and speed or
        % direction changed, send new command to given motor
        if( actual_position < target_position ) 
            [diff,speed] = calculate_movement(target_position,actual_position);
            if( last_speed ~= speed || last_direction ~= 1 )
                %set_speed_of_motor(controller, speed);
                kommando = sprintf('for %s=%d g', controller.motor, speed);
                pico_command(kommando);
            end;
            last_direction = 1;
            last_speed = speed;
        else
            [diff,speed] = calculate_movement(actual_position, target_position);
            if( last_speed ~= speed || last_direction ~= -1 )
                %set_speed_of_motor(controller, speed);
                kommando = sprintf('rev %s=%d g', controller.motor, speed);
                pico_command(kommando);
            end;
            last_direction = -1;
            last_speed = speed;
        end;
        
        % wait to let motor move a little bit
        pause(1);
        
        % get new position
        actual_position = round(refresh_motor_position( motor ));
        %actual_position = get_position(lvdt);
        %set( disp_value, 'String', actual_position);
        
        % if actual position changed motor has moved actually
        if( actual_position ~= old_position ) 
            n = 0;
        end;
        n = n + 1;
        
    % End of loop
    end
    
    % stop motor because target is reached
    kommando = sprintf('hal %s', controller.motor);
    pico_command(kommando);
    refresh_motor_position( motor );
    configuration.shouldStop(motor)=0;

end

