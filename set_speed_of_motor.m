function [ output_args ] = set_speed_of_motor( controller, speed )
    %setChannel( controller );
    kommando = sprintf('vel %s %s %d', controller.motor, controller.channel, speed);
    pico_command(kommando);
end

