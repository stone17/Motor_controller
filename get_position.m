function [ position, volt ] = get_position( lvdt,motor )
    %global lvdt_config;
    global configuration;
    volt=25000;
    % amount_values: how many values should be read to calculate middle value
    amount_values = configuration.lvdt_amountvalues; 
    frequency = configuration.lvdt_frequence;
   % value = 0;
%lvdt.channel
%lvdt.subdevice
    try
        value = mean(lvdt_stream( lvdt.channel, lvdt.subdevice, frequency, amount_values ));
        
    catch ME1
        disp 'Cannot communicate to lvdt'
        value = -1;
    end; 
    if strcmp(motor,'X')
        %cal=load('LVDT_X_132358_9910_int.cal','-ascii');
        offset=configuration.xoff;
        volt=value;
    elseif strcmp(motor, 'Y' ) 
        %cal=load('LVDT_X_132358_9910_int.cal','-ascii');
        offset=configuration.yoff;
    elseif strcmp(motor,'Z' )
        %cal=load('LVDT_X_132358_9910_int.cal','-ascii');
        offset=configuration.zoff;
        volt=value;
    elseif strcmp(motor, 'mot' )
        %cal=load('LVDT_X_132358_9910_int.cal','-ascii');
        offset=configuration.motoff;
        volt=value;
    elseif strcmp(motor, 'mot1' )
        %cal=load('LVDT_X_132358_9910_int.cal','-ascii');
        offset=configuration.motoff1;
        volt=value;
    elseif strcmp(motor, 'mot2' )
        %cal=load('LVDT_X_132358_9910_int.cal','-ascii');
        offset=configuration.motoff2;
        volt=value;
    elseif strcmp(motor, 'mot3' )
        %cal=load('LVDT_X_132358_9910_int.cal','-ascii');
        offset=configuration.motoff3;
        volt=value;
    else
        return;
    end;
    %mini=sqrt((cal(:,1)-value).^2);
    %[value,index]=min(mini);
    %position = cal(index,2)*1000+offset;
    position = round((-0.0008519*value+6.206)*1000+offset);
end