function update_um_calculation( aim, value )
    %value_dbl = str2double(value);
    value_dbl = value;
    value_dbl = calculate_um_to_steps(value_dbl);
    %value
    value_str = sprintf('0/%s Steps', num2str(value_dbl));
    set( aim, 'String', value_str );
end

