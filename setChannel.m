function  setChannel( controller )
    kommando = sprintf('chl %s %s', controller.motor, controller.channel);
    pico_command(kommando);
end

