function load_wheel_positions( handles )
global configuration;

if exist('wheel-positions','file')  == 2
    file = fopen('wheel-positions','rt');
    if file == -1, return; end;

    version = fscanf(file,'%s\n', 1 );

    if( strcmp(version,configuration.version)==0 ) 
        disp 'wheel-positions: Wrong version of configuration file';
        return;
    end;
    typ = fscanf(file,'%s\n', 1 );

    handles.metricdata.steps_w1 = fscanf(file,'%d\n', 1);
    handles.metricdata.steps_w2 = fscanf(file,'%d\n', 1);
    handles.metricdata.steps_w  = fscanf(file,'%d\n', 1);
    handles.metricdata.speed_w1 = fscanf(file,'%d\n', 1);
    handles.metricdata.speed_w2 = fscanf(file,'%d\n', 1);
    handles.metricdata.speed_w  = fscanf(file,'%d\n', 1);

    set(handles.Steps_W1, 'String', handles.metricdata.steps_w1);
    set(handles.Steps_W2, 'String', handles.metricdata.steps_w2);
    set(handles.Steps_W,  'String', handles.metricdata.steps_w);
    set(handles.Speed_W1, 'String', handles.metricdata.speed_w1);
    set(handles.Speed_W2, 'String', handles.metricdata.speed_w2);
    set(handles.Speed_W,  'String', handles.metricdata.speed_w);

    c = fscanf(file,'%d\n', 1);
    if( isscalar(c) && (c==0 || c==1 )) set(handles.Reverse_W1, 'Value', c ); end;
    c = fscanf(file,'%d\n', 1);
    if( isscalar(c) && (c==0 || c==1 )) set(handles.Reverse_W2, 'Value',  c ); end;
    c = fscanf(file,'%d\n', 1);
    if( isscalar(c) && (c==0 || c==1 )) set(handles.Reverse_W,  'Value',  c ); end;

    fclose(file);
else
    disp('Wheel-Positions file does not exist');
end;
end

