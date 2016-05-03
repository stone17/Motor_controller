function [ ret ] = getValue( val_str )
    ret = 0;
    %val_str
    try
        if( length(val_str) > 3 )
            ret = str2double(val_str(4:length(val_str)-1));
        end
    catch ME1
        ret = 0;
    end
    %ret
end

