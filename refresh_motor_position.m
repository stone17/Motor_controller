function [ actual_position,err ] = refresh_motor_position(motor)
global lvdt_config;
global global_px global_py global_pz global_mot global_mot1 global_mot2 global_mot3

if nargin==1      
    if strcmp(motor,'X')
        disp_value = global_px;
        lvdt = lvdt_config.X;
    elseif strcmp(motor,'Y') 
        disp_value = global_py;
        lvdt = lvdt_config.Y;
    elseif strcmp(motor,'Z')
        disp_value = global_pz;
        lvdt = lvdt_config.Z;
    elseif strcmp(motor,'mot')
        disp_value = global_mot;
        lvdt = lvdt_config.mot;
    elseif strcmp(motor,'mot1')
        disp_value = global_mot1;
        lvdt = lvdt_config.mot1;
    elseif strcmp(motor,'mot2')
        disp_value = global_mot2;
        lvdt = lvdt_config.mot2;
    elseif strcmp(motor,'mot3')
        disp_value = global_mot3;
        lvdt = lvdt_config.mot3;
    else
        return;
    end;
    [actual_position,err] = get_position(lvdt,motor);
    %set( disp_value, 'String',[num2str(actual_position),' (',num2str(round(volt)),')']);
    set( disp_value, 'String',num2str(actual_position))
    pause(0.0001);
else
    for a=1:7
        if a==1
            motor='X';
        elseif a==2
            motor='Y';
        elseif a==3
            motor='Z';
        elseif a==4
            motor='mot';
        elseif a==5
            motor='mot1';
        elseif a==6
            motor='mot2';
        else
            motor='mot3';
        end
        refresh_motor_position(motor);
    end
end
end

