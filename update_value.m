function [ output_args ] = update_value( hObject, handles )
steps = str2double(get(hObject, 'String'));
if isnan(steps)
    set(hObject, 'String', 0);
    errordlg('Input must be a number','Error');
end

% Save the new Steps_X value
output_args = steps;
%guidata(hObject,handles);

end

