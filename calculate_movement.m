function [ value, speed ] = calculate_movement(v1, v2)
    value = v1 - v2;
    speed = uint16(value / 10);
    if speed < 750, speed=750; end;
    if speed > 1000, speed = 1000; end;    
    %if speed < 2, speed=1; end;
    %if speed > 1000, speed = 1000; end;
end