function load_positions_motor( handles )
global configuration;

if exist('motor-positions','file')  == 2
    file = fopen('motor-positions','rt');
    if file==-1, return; end;

    version = fscanf(file,'%s\n', 1 );

    if( strcmp(version,configuration.version)==0 ) 
        disp 'motor-positions: Wrong version of configuration file';
        return;
    end;
    typ = fscanf(file,'%s\n', 1 );

    handles.metricdata.target_x = fscanf(file,'%d\n', 1);
    handles.metricdata.target_y = fscanf(file,'%d\n', 1);
    handles.metricdata.target_z = fscanf(file,'%d\n', 1);

    set(handles.Target_X, 'String', handles.metricdata.target_x);
    set(handles.Target_Y, 'String', handles.metricdata.target_y);
    set(handles.Target_Z, 'String', handles.metricdata.target_z);

    fclose(file);
else
    disp('Motor-Positions file does not exist');
end;
end

