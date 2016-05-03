function move_motor_to_position( motor, controller, lvdt, target_position, disp_value )
    global configuration stop;
    actual_position = refresh_motor_position(motor);
    %set( disp_value, 'String', actual_position);
    stop=0;
    setChannel( controller );
    configuration.shouldStop(motor)=0;
    abs(actual_position-target_position)

    % Move motor in loop until difference of actual position and target
    % position is below given delta
    % Motor did not move since 5 seconds, something happend --> stop
    while( abs(actual_position-target_position) > 0.002 && configuration.shouldStop(motor)==0 && stop==0)
            
        diff=abs(actual_position-target_position)*1000;
        if diff <= 20
            speed=100;
        elseif diff > 20 && diff<=100
            speed=200;
        elseif diff > 100 && diff<=150
            speed=300;
        elseif diff > 150 && diff<=200
            speed=400;   
        elseif diff > 250 && diff<=300
            speed=500;
        elseif diff > 350 && diff<=400
            speed=600;
        elseif diff > 400 && diff<=500
            speed=700;
        elseif diff > 550 && diff<=600
            speed=800;   
        elseif diff > 600 && diff<=650
            speed=900;
        else
            speed=1000;
        end
        
        if( actual_position < target_position ) 
                kommando = sprintf('rev %s=%d g', controller.motor, speed);
                pico_command(kommando);
        else
                kommando = sprintf('for %s=%d g', controller.motor, speed);
                pico_command(kommando);
        end;
        pause(0.4*speed/100);
        % get new position
        actual_position = refresh_motor_position( motor );
    end
        % stop motor because target is reached
    kommando = sprintf('hal %s', controller.motor);
    pico_command(kommando);
    
    pause(1)
    actual_position = refresh_motor_position( motor );
    diff=(actual_position-target_position)*1000;
    while round(diff)~=0 && stop==0
        if diff<0
            steps=-15;
        else
            steps=15;
        end
        kommando = sprintf('rel %s %d g', controller.motor, steps);
        pico_command(kommando);
        pause(0.75)
        actual_position = refresh_motor_position( motor );
        diff=round((actual_position-target_position)*1000);
    end
    configuration.shouldStop(motor)=0;
end

