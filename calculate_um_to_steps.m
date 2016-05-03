function [ output ] = calculate_um_to_steps( value )
if value<0 
    value = round(value .* 5400/212);
else
    value = round(value .* 4000/212);
end
 output = value;
end

