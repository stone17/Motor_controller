function load_values_motor( handles )
global configuration;


if exist('motor-values','file')  == 2
    file = fopen('motor-values','rt');
    if file == -1, return; end;

    version = fscanf(file,'%s\n', 1 );

    if( strcmp(version,configuration.version)==0 ) 
        disp 'motor-values: Wrong version of configuration file';
        return;
    end;
    typ = fscanf(file,'%s\n', 1 );

    handles.metricdata.steps_x  = fscanf(file,'%d\n', 1);
    handles.metricdata.steps_y  = fscanf(file,'%d\n', 1);
    handles.metricdata.steps_z  = fscanf(file,'%d\n', 1);
    handles.metricdata.speed_x  = fscanf(file,'%d\n', 1);
    handles.metricdata.speed_y  = fscanf(file,'%d\n', 1);
    handles.metricdata.speed_z  = fscanf(file,'%d\n', 1);

    set(handles.Steps_X,  'String', handles.metricdata.steps_x);
    set(handles.Steps_Y,  'String', handles.metricdata.steps_y);
    set(handles.Steps_Z,  'String', handles.metricdata.steps_z);
    set(handles.Speed_X,  'String', handles.metricdata.speed_x);
    set(handles.Speed_Y,  'String', handles.metricdata.speed_y);
    set(handles.Speed_Z,  'String', handles.metricdata.speed_z);

    fclose(file);
else
    disp('Motor-Values file does not exist');
end;
end

