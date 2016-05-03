function varargout    = mainscreen_redux(varargin)
% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @mainscreen_redux_OpeningFcn, ...
                   'gui_OutputFcn',  @mainscreen_redux_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT

% --- Executes just before autocorrelator is made visible.
function mainscreen_redux_OpeningFcn(hObject, eventdata, handles, varargin)
handles.output = hObject;

if exist('c:\windows\reg.tx','file')==2
        fid = fopen('c:\windows\reg.tx','r');
else
	clear all
	close all
	return
end
code=(fread(fid,'*char'))';
fclose(fid);
if ~strcmp(code,'alpha')
	clear all
	close all
	return
end

% Update handles structure
guidata(hObject, handles);

initialize_gui(hObject, handles, false);

% --- Outputs from this function are returned to the command line.
function varargout = mainscreen_redux_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% Get default command line output from handles structure
varargout{1} = handles.output;


% --------------------------------------------------------------------
function initialize_gui(fig_handle, handles, isreset)
global controller lvdt_config configuration
global global_px global_py global_pz
global global_mot global_mot1 global_mot2 global_mot3
global safety AD last_status

safety=0;
last_status=0;

try
last=load('lastmove.txt');
catch
    last=0;
end
try
last1=load('lastmove1.txt');
catch
    last1=0;
end
try
last2=load('lastmove2.txt');
catch
    last2=0;
end
try
last3=load('lastmove3.txt');
catch
    last3=0;
end

if last==1
    set(handles.stepper,'string','Stepper out')
    set(handles.stepper1,'enable','off')
else
    set(handles.stepper,'string','Stepper in')
end

if last1==1
    set(handles.stepper1,'string','Stepper out')
    set(handles.stepper,'enable','off')
else
    set(handles.stepper1,'string','Stepper in')
end
if last2==1
    set(handles.stepper2,'string','Stepper out')
    %set(handles.stepper,'enable','off')
else
    set(handles.stepper2,'string','Stepper in')
end
if last3==1
    set(handles.stepper3,'string','Stepper out')
    %set(handles.stepper,'enable','off')
else
    set(handles.stepper3,'string','Stepper in')
end

try
steps=load('laststeps.txt','-ascii');
catch
    steps=1000;
end
try
steps1=load('laststeps1.txt','-ascii');
catch
    steps1=1000;
end
try
steps2=load('laststeps2.txt','-ascii');
catch
    steps2=1000;
end
try
steps3=load('laststeps3.txt','-ascii');
catch
    steps3=1000;
end
set(handles.steps,'string',num2str(steps))
set(handles.steps1,'string',num2str(steps1))
set(handles.steps2,'string',num2str(steps2))
set(handles.steps3,'string',num2str(steps3))

comports = instrhwinfo('serial');
set(handles.comport,'string',comports.AvailableSerialPorts)
%if length(comports.AvailableSerialPorts)<2
%    set(handles.comport1,'value',1)
%end
%set(handles.comport1,'string',comports.AvailableSerialPorts)

configuration.ipaddress = '192.168.0.127';
configuration.port = 23;
configuration.delta = 100;
configuration.lvdt_frequence = 100000;
configuration.lvdt_amountvalues = 100;
controller.X  = struct( 'motor','a1', 'channel','0' );
controller.Y  = struct( 'motor','a1', 'channel','1' );
controller.Z  = struct( 'motor','a1', 'channel','2' );
lvdt_config.X = struct( 'channel',1,'subdevice',4);
lvdt_config.Y = struct( 'channel',0,'subdevice',4);
lvdt_config.Z = struct( 'channel',2,'subdevice',4);
lvdt_config.mot = struct( 'channel',3,'subdevice',4);
lvdt_config.mot1 = struct( 'channel',4,'subdevice',4);
lvdt_config.mot2 = struct( 'channel',5,'subdevice',4);
lvdt_config.mot3 = struct( 'channel',6,'subdevice',4);
configuration.version = 'V4';
configuration.shouldStop('X')=0;
configuration.shouldStop('Y')=0;
configuration.shouldStop('Z')=0;
configuration.shouldStop('mot')=0;
configuration.shouldStop('mot1')=0;
configuration.shouldStop('mot2')=0;
configuration.shouldStop('mot3')=0;

% Try to load default connection Options from file
load_connection_options();

% Try to load_positions_motor(handles);
load_values_motor(handles);

try
    load offsets
    if length(offsets)~=7
        offsets=[0,0,0,0,0,0,0];
    end
catch
    if last_status==3
        last_status=1;
    else
        last_status=last_status+1;
    end
    stat=get(handles.status_text,'string');
    stat(last_status)={[datestr(now, 'mm/dd/yy HH:MM:SS'),' Offset file not found!']};
    set(handles.status_text,'string',stat);
    offsets=[0,0,0,0,0,0,0];
end

configuration.xoff=offsets(1);
configuration.yoff=offsets(2);
configuration.zoff=offsets(3);
configuration.motoff=offsets(4);
configuration.motoff1=offsets(5);
configuration.motoff2=offsets(6);
configuration.motoff3=offsets(7);
try
    mot_pos=load('mot_pos.txt','-ascii');
    mot_pos1=load('mot_pos1.txt','-ascii');
    mot_pos2=load('mot_pos2.txt','-ascii');
    mot_pos3=load('mot_pos3.txt','-ascii');
catch
    if last_status==3
        last_status=1;
    else
        last_status=last_status+1;
    end
    stat=get(handles.status_text,'string');
    stat(last_status)={[datestr(now, 'mm/dd/yy HH:MM:SS'),' Motor position file not found!']};
    set(handles.status_text,'string',stat);
    %set(handles.status_text,'string',[date,'-',get_time,'  Motor position file not found!'])
    mot_pos=0;
    mot_pos1=0;
    mot_pos2=0;
    mot_pos3=0;
end
set(handles.mot_pos,'string',num2str(mot_pos));
set(handles.mot_pos1,'string',num2str(mot_pos1));
set(handles.mot_pos2,'string',num2str(mot_pos2));
set(handles.mot_pos3,'string',num2str(mot_pos3));

% If the metricdata field is present and the StopIt_X flag is false, it means
% we are just re-initializing a GUI by calling it from the cmd line
% while it is up. So, bail out as we dont want to StopIt_X the data.
if isfield(handles, 'metricdata') && ~isreset
    return;
end

handles.metricdata.steps_x = 0;
handles.metricdata.steps_y = 0;
handles.metricdata.steps_z = 0;

handles.metricdata.speed_x = 100;
handles.metricdata.speed_y = 100;
handles.metricdata.speed_z = 100;

% Update handles structure
guidata(handles.Autocorrelator, handles);

% Reading positions from lvdt's
% Construct a questdlg 
choice = questdlg('Meilhaus-AD card installed?','LVDT-Config', ...
        'Yes','No','Yes');
% Handle response
    switch choice
        case 'Yes'
            AD=1;
        case 'No'
            AD=0;
    end

if AD==1
    try
        handles.metricdata.position_x = get_position(lvdt_config.X,'X');
    catch
        handles.metricdata.position_x = 0;
    end
    try
        handles.metricdata.position_y = get_position(lvdt_config.Y,'Y');
    catch
        handles.metricdata.position_y = 0;
    end
    try
        handles.metricdata.position_z = get_position(lvdt_config.Z,'Z');
    catch
        handles.metricdata.position_z = 0;
    end
    try
        handles.metricdata.position_mot = get_position(lvdt_config.mot,'mot');
    catch
        handles.metricdata.position_mot = 0;
    end
    try
        handles.metricdata.position_mot1 = get_position(lvdt_config.mot1,'mot1');
    catch
        handles.metricdata.position_mot1 = 0;
    end
    try
        handles.metricdata.position_mot2 = get_position(lvdt_config.mot2,'mot2');
    catch
        handles.metricdata.position_mot2 = 0;
    end
    try
        handles.metricdata.position_mot3 = get_position(lvdt_config.mot3,'mot3');
    catch
        handles.metricdata.position_mot3 = 0;
    end
else
    handles.metricdata.position_x = 0;
    handles.metricdata.position_y = 0;
    handles.metricdata.position_z = 0;
    handles.metricdata.position_mot = 0;
    handles.metricdata.position_mot1 = 0;
    handles.metricdata.position_mot2 = 0;
    handles.metricdata.position_mot3 = 0;
end

set(handles.Steps_X, 'String', handles.metricdata.steps_x);
set(handles.Steps_Y, 'String', handles.metricdata.steps_y);
set(handles.Steps_Z, 'String', handles.metricdata.steps_z);

set(handles.Speed_X, 'String', handles.metricdata.speed_x);
set(handles.Speed_Y, 'String', handles.metricdata.speed_y);
set(handles.Speed_Z, 'String', handles.metricdata.speed_z);

set(handles.Target_X, 'String', handles.metricdata.position_x);
set(handles.Target_Y, 'String', handles.metricdata.position_y);
set(handles.Target_Z, 'String', handles.metricdata.position_z);

set(handles.Position_X, 'String', handles.metricdata.position_x);
set(handles.Position_Y, 'String', handles.metricdata.position_y);
set(handles.Position_Z, 'String', handles.metricdata.position_z);

set(handles.Position_mot, 'String', handles.metricdata.position_mot);
set(handles.Position_mot1, 'String', handles.metricdata.position_mot1);
set(handles.Position_mot2, 'String', handles.metricdata.position_mot2);
set(handles.Position_mot3, 'String', handles.metricdata.position_mot3);

global_px = handles.Position_X;
global_py = handles.Position_Y;
global_pz = handles.Position_Z;
global_mot = handles.Position_mot;
global_mot1 = handles.Position_mot1;
global_mot2 = handles.Position_mot2;
global_mot3 = handles.Position_mot3;

% Update handles structure
guidata(handles.Autocorrelator, handles);

% abs a1=1000 [g] moves motor a1 1000 steps_x, g means immediately 
% {set absolute position}
% for command sets velocity, with g also means immediately
% rel <motor>=<steps_x> bewegt motor um 10 steps_x mit aktueller velocity
% chl a1=<0,1,2> ist der motor, der laufen soll auswählbar

function move_motor_Callback(hObject, eventdata, handles)
global controller lvdt_config
set(hObject,'Enable','off')
str=get(hObject,'Tag');

    %X Axis
if strcmp(str,'Target_X')
    position=str2double(get(hObject,'String'));
    if isnan(position)
        oldX=get(handles.Moveto_X,'string');
        oldX=oldX(9:length(oldX));
        set(hObject,'String',oldX)
    else
        strg=['Move to ',num2str(position)];
        set(handles.Moveto_X,'String',strg)
    end
elseif strcmp(str,'Moveto_X') 
    set_speed_of_motor(controller.X, handles.metricdata.speed_x);
    move_motor_to_position('X',controller.X, lvdt_config.X, str2double(get(handles.Target_X,'string')), handles.Position_X );
elseif strcmp(str,'Steps_X')
    handles.metricdata.steps_x = update_value(hObject, handles);
    update_um_calculation(handles.Start_X,handles.metricdata.steps_x);
elseif strcmp(str,'Start_X')
    move_picomotor('X', controller.X, handles.metricdata.speed_x, handles.metricdata.steps_x, lvdt_config.X ,hObject, handles);
elseif strcmp(str,'Speed_X')
    handles.metricdata.speed_x = update_value(hObject, handles);
    guidata(hObject,handles);

    %Y Axis    
elseif strcmp(str,'Target_Y')
    position=str2double(get(hObject,'String'));
    if isnan(position)
        oldY=get(handles.Moveto_Y,'string');
        oldY=oldY(9:length(oldY));
        set(hObject,'String',oldY)
    else
        strg=['Move to ',num2str(position)];
        set(handles.Moveto_Y,'String',strg)
    end
elseif strcmp(str,'Moveto_Y') 
    set_speed_of_motor(controller.Y, handles.metricdata.speed_y);
    move_motor_to_position('Y',controller.X, lvdt_config.Y, str2double(get(handles.Target_Y,'string')), handles.Position_Y);
elseif strcmp(str,'Steps_Y')
    handles.metricdata.steps_y = update_value(hObject, handles);
    update_um_calculation(handles.Start_Y,handles.metricdata.steps_y);
elseif strcmp(str,'Start_Y')    
    move_picomotor('Y', controller.Y,handles.metricdata.speed_y,handles.metricdata.steps_y, lvdt_config.Y ,hObject, handles);
elseif strcmp(str,'Speed_Y')
    handles.metricdata.speed_y = update_value(hObject, handles);
    
    %Z Axis
elseif strcmp(str,'Target_Z')
	position=str2double(get(hObject,'String'));
    if isnan(position)
        oldZ=get(handles.Moveto_Z,'string');
        oldZ=oldZ(9:length(oldZ));
        set(hObject,'String',oldZ)
    else
        strg=['Move to ',num2str(position)];
        set(handles.Moveto_Z,'String',strg)
    end
elseif strcmp(str,'Moveto_Z') 
    set_speed_of_motor(controller.Z, handles.metricdata.speed_z);
    move_motor_to_position('Z',controller.Z, lvdt_config.Z, str2double(get(handles.Target_Z,'string')), handles.Position_Z );
elseif strcmp(str,'Steps_Z')
    handles.metricdata.steps_z = update_value(hObject, handles);
    update_um_calculation(handles.Start_Z,handles.metricdata.steps_z);
elseif strcmp(str,'Start_Z')
    move_picomotor('Z', controller.Z,handles.metricdata.speed_z,handles.metricdata.steps_z, lvdt_config.Z ,hObject, handles);
elseif strcmp(str,'Speed_Z')
    handles.metricdata.speed_z = update_value(hObject, handles);
end

guidata(hObject,handles);
set(hObject,'Enable','on')

function Steps_CreateFcn(hObject, eventdata, handles)

function Target_X_CreateFcn(hObject, eventdata, handles)
function Steps_X_CreateFcn(hObject, eventdata, handles)
function Speed_X_CreateFcn(hObject, eventdata, handles)

function Target_Y_CreateFcn(hObject, eventdata, handles)
function Steps_Y_CreateFcn(hObject, eventdata, handles)
function Speed_Y_CreateFcn(hObject, eventdata, handles)

function Target_Z_CreateFcn(hObject, eventdata, handles)
function Steps_Z_CreateFcn(hObject, eventdata, handles)
function Speed_Z_CreateFcn(hObject, eventdata, handles)


% --- Executes on button press in StopEverything.
function StopEverything_Callback(hObject, eventdata, handles)
global controller configuration stop
set(handles.MoveAllMotors,'Enable','on')
    pico_command('hal');
    refresh_motor_position('X');
    refresh_motor_position('Y');
    refresh_motor_position('Z');
    refresh_motor_position('mot');

    configuration.shouldStop('X')=0;
    configuration.shouldStop('Y')=0;
    configuration.shouldStop('Z')=0;
    configuration.shouldStop('mot')=0;
    
    %setChannel( controller.X );
    kommando = sprintf('hal %s', controller.X.motor);
    pico_command(kommando);
    kommando = sprintf('hal %s', controller.Y.motor);
    pico_command(kommando);
    kommando = sprintf('hal %s', controller.Z.motor);
    pico_command(kommando);
    
%    stop(controller.t_x);
%    stop(controller.t_y);
%    stop(controller.t_z);
    
    set(handles.Moveto_X,'Enable','on')
    set(handles.Moveto_Y,'Enable','on')
    set(handles.Moveto_Z,'Enable','on')
    set(handles.Start_X,'Enable','on')
    set(handles.Start_Y,'Enable','on')
    set(handles.Start_Z,'Enable','on')
    set(handles.Steps_X,'Enable','on')
    set(handles.Steps_Y,'Enable','on')
    set(handles.Steps_Z,'Enable','on')
    
    stop=1;

%{
global controller;
setChannel( controller.X );
%get(handles.Reverse_X, 'Value') --> 1 if selected, otherwise 0
if( get(handles.Reverse_X, 'Value') == 0 ) 
    kommando = sprintf('for %s=%d g', controller.X.motor, handles.metricdata.speed_x );
else
    kommando = sprintf('rev %s=%d g', controller.X.motor, handles.metricdata.speed_x );
end;
set(hObject,'Enable','off')
pico_command(kommando);
start(controller.t_x);
%}

% --- Executes on button press in StartController.
function StartController_Callback(hObject, eventdata, handles)
global configuration last_status
    %initialize_controller(handles.metricdata.ipaddress,handles.metricdata.port)
erg = initialize_controller(configuration.ipaddress,configuration.port);
if( erg == 0 ) 
	set( handles.ControllerStatus, 'String', 'Controller Status: Connected' );
	set(handles.ControllerStatus,'Value',1)
    set(handles.Start_X,'Enable','on')
    set(handles.Start_Y,'Enable','on')
    set(handles.Start_Z,'Enable','on')
    set(handles.Moveto_X,'Enable','on')
    set(handles.Moveto_Y,'Enable','on')
    set(handles.Moveto_Z,'Enable','on')
    set(handles.forx,'Enable','on')  
    set(handles.fory,'Enable','on')  
    set(handles.forz,'Enable','on') 
    set(handles.backx,'Enable','on')  
    set(handles.backy,'Enable','on')  
    set(handles.backz,'Enable','on')  
else
	set( handles.ControllerStatus, 'String', 'Controller Status: Not connected' );
	set(handles.ControllerStatus,'Value',0)
	if last_status==3
    	last_status=1;
    else
    	last_status=last_status+1;
    end
	stat=get(handles.status_text,'string');
	stat(last_status)={[datestr(now, 'mm/dd/yy HH:MM:SS'),' Connecting failed']};
	set(handles.status_text,'string',stat);
end;    

% --- Executes on button press in StopController.
function StopController_Callback(hObject, eventdata, handles)
shutdown_controller;
set( handles.ControllerStatus, 'String', 'Controller Status: Not connected' );
set(handles.ControllerStatus,'Value',0)
    
set(handles.Start_X,'Enable','off')
set(handles.Start_Y,'Enable','off')
set(handles.Start_Z,'Enable','off')
set(handles.Moveto_X,'Enable','off')
set(handles.Moveto_Y,'Enable','off')
set(handles.Moveto_Z,'Enable','off')
    

% --- Executes on button press in LoadDefault.
function LoadDefault_Callback(hObject, eventdata, handles)
    pico_command('DEF');


% --- Executes on button press in MoveAllMotors.
function MoveAllMotors_Callback(hObject, eventdata, handles)
    global controller;
    global lvdt_config;
    set(hObject,'Enable','off')
    %set_speed_of_motor(controller.X, handles.metricdata.speed_z);
    move_motor_to_position('X', controller.X, lvdt_config.X, handles.metricdata.target_x, handles.Position_X );
    %set_speed_of_motor(controller.Y, handles.metricdata.speed_z);
    move_motor_to_position('Y', controller.Y, lvdt_config.Y, handles.metricdata.target_y, handles.Position_Y );
    %set_speed_of_motor(controller.Z, handles.metricdata.speed_z);
    move_motor_to_position('Z', controller.Z, lvdt_config.Z, handles.metricdata.target_z, handles.Position_Z );
set(hObject,'Enable','on')

% --- Executes on button press in Refresh_Positions.
function Refresh_Positions_Callback(hObject, eventdata, handles)
global lvdt_config xoff yoff zoff AD last_status
guidata(hObject, handles);
%set( hObject, 'Enable', 'Off');
pause(0.01);
if AD==1
[actual_position,volt] = get_position(lvdt_config.X,'X');
set( handles.Position_X, 'String', num2str(actual_position));
%set( handles.Position_X, 'String',[num2str(actual_position),' (',num2str(round(volt)),')'])
[actual_position,volt]  = get_position(lvdt_config.Y,'Y');
set( handles.Position_Y, 'String', num2str(actual_position));
%set( handles.Position_Y, 'String',[num2str(actual_position),' (',num2str(round(volt)),')'])
[actual_position,volt]  = get_position(lvdt_config.Z,'Z');
set( handles.Position_Z, 'String', num2str(actual_position));
%set( handles.Position_Z, 'String',[num2str(actual_position),' (',num2str(round(volt)),')'])
set( hObject, 'Enable', 'On');
%try
[actual_position,volt]  = get_position(lvdt_config.mot,'mot');
set( handles.Position_mot, 'String', num2str(actual_position));
%set( handles.Position_mot, 'String',[num2str(actual_position),' (',num2str(round(volt)),')'])
[actual_position,volt]  = get_position(lvdt_config.mot,'mot1');
set( handles.Position_mot1, 'String', num2str(actual_position));
%set( handles.Position_mot1, 'String', [num2str(actual_position),' (',num2str(round(volt)),')'])
[actual_position,volt]  = get_position(lvdt_config.mot,'mot2');
set( handles.Position_mot2, 'String', num2str(actual_position));
%set( handles.Position_mot2, 'String',[num2str(actual_position),' (',num2str(round(volt)),')'])
[actual_position,volt]  = get_position(lvdt_config.mot,'mot3');
set( handles.Position_mot3, 'String', num2str(actual_position));
%set( handles.Position_mot3, 'String', [num2str(actual_position),' (',num2str(round(volt)),')'])
set( hObject, 'Enable', 'On');
end

% --- Executes on button press in StartConfigurationFrame.
function StartConfigurationFrame_Callback(hObject, eventdata, handles)
    h = configuration_dialog();


% --- Executes on button press in SavePositions_Motor.
function SavePositions_Motor_Callback(hObject, eventdata, handles)
    global configuration;
    file = fopen('motor-positions','wt');
    fprintf(file,'%s\n',configuration.version);
    fprintf(file,'MOTOR-POSITIONS\n');
    fprintf(file,'%d\n%d\n%d\n',handles.metricdata.position_x,handles.metricdata.position_y,handles.metricdata.position_z);
    fclose(file);


% --- Executes on button press in LoadPositions_Motor.
function LoadPositions_Motor_Callback(hObject, eventdata, handles)
    load_positions_motor(handles);

% --- Executes on button press in SaveMotorValues.
function SaveMotorValues_Callback(hObject, eventdata, handles)
    global configuration;
    file = fopen('motor-values','wt');
    fprintf(file,'%s\n',configuration.version);
    fprintf(file,'MOTOR-VALUES\n');
    fprintf(file,'%d\n%d\n%d\n',handles.metricdata.steps_x,handles.metricdata.steps_y,handles.metricdata.steps_z);
    fprintf(file,'%d\n%d\n%d\n',handles.metricdata.speed_x,handles.metricdata.speed_y,handles.metricdata.speed_z);
    fclose(file);

% --- Executes on button press in LoadMotorValues.
function LoadMotorValues_Callback(hObject, eventdata, handles)
    load_values_motor(handles);

% --- Executes on button press in JoystickMode.
function JoystickMode_Callback(hObject, eventdata, handles)
global refresh;
global configuration;

state = get(hObject,'Value');

if( state == 1 )
    % pressed down
    controllerstatus=get(handles.ControllerStatus, 'String');
    if strcmp(controllerstatus,'Controller Status: Connected')
        pico_command('hal');
        pico_command('JON');
        shutdown_controller;
        set( handles.ControllerStatus, 'String', 'Controller Status: Not connected' );
    end
    refresh.lvdt = timer;
    set(refresh.lvdt,'ExecutionMode','fixedRate','BusyMode','drop','Period',0.5, 'TasksToExecute', 900);
    refresh.lvdt.TimerFcn = 'refresh_motor_position';
    start(refresh.lvdt)
else
    try
        stop(refresh.lvdt)
    end
    erg = initialize_controller(configuration.ipaddress,configuration.port);
    if( erg == 0 ) 
        set( handles.ControllerStatus, 'String', 'Controller Status: Connected' );
        pico_command('JOF');
    else
        set( handles.ControllerStatus, 'String', 'Controller Status: Not connected' );
    end;
    
end;

% --- Executes on button press in forx.
function forback_Callback(hObject, eventdata, handles)

function velocity_Callback(hObject, eventdata, handles)

% --- Executes during object creation, after setting all properties.
function velocity_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes on button press in xzero.
function zero_Callback(hObject, eventdata, handles)
global configuration
dim=get(hObject,'tag');
try
    load offsets
    if length(offsets)~=7
        offsets=[0,0,0,0,0,0,0];
    end
catch
    offsets=[0,0,0,0,0,0,0];
end
if strcmp(dim,'xzero')
    configuration.xoff=configuration.xoff-str2double(get(handles.Position_X,'string'));
    offsets(1)=offsets(1)-str2double(get(handles.Position_X,'string'));
    set(handles.Position_X,'string','0')
elseif strcmp(dim,'yzero')
    configuration.yoff=configuration.yoff-str2double(get(handles.Position_Y,'string'));
    offsets(2)=offsets(2)-str2double(get(handles.Position_Y,'string'));
	set(handles.Position_Y,'string','0')
elseif strcmp(dim,'zzero')
    configuration.zoff=configuration.zoff-str2double(get(handles.Position_Z,'string'));
    offsets(3)=offsets(3)-str2double(get(handles.Position_Z,'string'));
    set(handles.Position_Z,'string','0') 
elseif strcmp(dim,'motzero')
    configuration.motoff=configuration.motoff-str2double(get(handles.Position_mot,'string'));
    offsets(4)=offsets(4)-str2double(get(handles.Position_mot,'string'));
    set(handles.Position_mot,'string','0') 
elseif strcmp(dim,'motzero1')
    configuration.motoff1=configuration.motoff1-str2double(get(handles.Position_mot1,'string'));
    offsets(5)=offsets(5)-str2double(get(handles.Position_mot1,'string'));
    set(handles.Position_mot1,'string','0') 
elseif strcmp(dim,'motzero2')
    configuration.motoff2=configuration.motoff2-str2double(get(handles.Position_mot2,'string'));
    offsets(6)=offsets(6)-str2double(get(handles.Position_mot2,'string'));
    set(handles.Position_mot2,'string','0')
elseif strcmp(dim,'motzero3')
    configuration.motoff3=configuration.motoff3-str2double(get(handles.Position_mot3,'string'));
    offsets(7)=offsets(7)-str2double(get(handles.Position_mot3,'string'));
    set(handles.Position_mot3,'string','0') 
end
offsets
save('offsets','offsets')

% --- Executes on button press in stepper.
function stepper_Callback(hObject, eventdata, handles)
global safety AD last_status
mode=get(hObject,'tag');
comports=get(handles.comport,'string');
val=get(handles.comport,'value');
com=cell2mat(comports(val));
direction=get(handles.stepper,'string');
status=get(handles.stepper1,'foregroundcolor'); %check if motor 2 is running
node=0;
if strcmp(mode,'stepper') && status(1)==0
    if strcmp(direction,'Stepper out')
        steps=-1*str2double(get(handles.steps,'string'));
        set(hObject,'string','Moving out','foregroundcolor','r');
        try
            set(handles.stepper1,'enable','off')
            set(handles.stepper2,'enable','off')
            set(handles.stepper3,'enable','off')
            value=stepnet(steps,mode,com,'mot',safety,node,AD);
            set(hObject,'string','Stepper in','foregroundcolor','black');
            last=0;
            save('lastmove.txt','last','-ascii')
            set(handles.stepper1,'enable','on')
        catch exception
            if last_status==3
                last_status=1;
            else
                last_status=last_status+1;
            end
            stat=get(handles.status_text,'string');
            stat(last_status)={[datestr(now, 'mm/dd/yy HH:MM:SS'),' ',exception.message, ' Line ',num2str(getfield(exception.stack,'line')),'.']};
            set(handles.status_text,'string',stat);
            fclose(serial(com))
            set(hObject,'string','Stepper out','foregroundcolor','black');
        end
        if get(handles.link_status,'value')==0
            set(handles.stepper1,'enable','on')
        end
        set(handles.stepper2,'enable','on')
        set(handles.stepper3,'enable','on')
    elseif strcmp(direction,'Stepper in')
        steps=1*str2double(get(handles.steps,'string'));
        set(hObject,'string','Moving in','foregroundcolor','r');
        try
            set(handles.stepper1,'enable','off')
            set(handles.stepper2,'enable','off')
            set(handles.stepper3,'enable','off')
            value=stepnet(steps,mode,com,'mot',safety,node,AD);
            set(hObject,'string','Stepper out','foregroundcolor','black');
            last=1;
            save('lastmove.txt','last','-ascii')
        catch exception
            if last_status==3
                last_status=1;
            else
                last_status=last_status+1;
            end
            stat=get(handles.status_text,'string');
            stat(last_status)={[datestr(now, 'mm/dd/yy HH:MM:SS'),' ',exception.message, ' Line ',num2str(getfield(exception.stack,'line')),'.']};
            set(handles.status_text,'string',stat);
            fclose(serial(com))
            set(hObject,'string','Stepper in','foregroundcolor','black');
            set(handles.stepper1,'enable','on')
        end
        if get(handles.link_status,'value')==0
            set(handles.stepper1,'enable','on')
        end
        set(handles.stepper2,'enable','on')
        set(handles.stepper3,'enable','on')
    end
elseif strcmp(mode,'stop') && status(1)==0
    try
        value=stepnet(0,mode,com,'mot',safety,node,AD);
    catch exception
        if last_status==3
        	last_status=1;
        else
        	last_status=last_status+1;
        end
        stat=get(handles.status_text,'string');
        stat(last_status)={[datestr(now, 'mm/dd/yy HH:MM:SS'),' ',exception.message, ' Line ',num2str(getfield(exception.stack,'line')),'.']};
        set(handles.status_text,'string',stat);
        fclose(serial(com))
    end
    if strcmp(direction(length(direction)),'n')
        dir='Stepper in';
        set(handles.stepper1,'enable','on')
    else
        dir='Stepper out';
    end
    if get(handles.link_status,'value')==0
    	set(handles.stepper1,'enable','on')
    end
    set(handles.stepper2,'enable','on')
    set(handles.stepper3,'enable','on')
    set(handles.stepper,'string',dir,'foregroundcolor','black');
elseif strcmp(mode,'stepperreverse')
    if strcmp(direction,'Stepper out')
        set(handles.stepper,'string','Stepper in');
        last=0;   
        set(handles.stepper1,'enable','on')
    elseif strcmp(direction,'Stepper in')
        set(handles.stepper,'string','Stepper out');
        last=1;
    end
    save('lastmove.txt','last','-ascii')
end

% --- Executes on button press in stepper1.
function stepper1_Callback(hObject, eventdata, handles)
global safety AD last_status
mode=get(hObject,'tag')
mode=mode(1:end-1)
comports=get(handles.comport,'string')
val=get(handles.comport,'value')
com=cell2mat(comports(val))
direction=get(handles.stepper1,'string')
status=get(handles.stepper,'foregroundcolor') %check if motor 1 is running
node=get(handles.comport1,'value')
if strcmp(mode,'stepper') && status(1)==0
        if strcmp(direction,'Stepper out')
            steps=1*str2double(get(handles.steps1,'string'));
            set(hObject,'string','Moving out','foregroundcolor','r');
            try
                set(handles.stepper,'enable','off')
                set(handles.stepper2,'enable','off')
                set(handles.stepper3,'enable','off')
                value=stepnet(steps,mode,com,'mot1',safety,node,AD);
                set(hObject,'string','Stepper in','foregroundcolor','black');
                last1=0;
                pause(0.01)
                save('lastmove1.txt','last1','-ascii')
                set(handles.stepper,'enable','on')
            catch exception
                if last_status==3
                    last_status=1;
                else
                    last_status=last_status+1;
                end
                stat=get(handles.status_text,'string');
                stat(last_status)={[datestr(now, 'mm/dd/yy HH:MM:SS'),' ',exception.message, ' Line ',num2str(getfield(exception.stack,'line')),'.']};
                set(handles.status_text,'string',stat);
                fclose(serial(com))
                set(hObject,'string','Stepper out','foregroundcolor','black');
            end
            if get(handles.link_status,'value')==0
                set(handles.stepper,'enable','on')
            end
            set(handles.stepper2,'enable','on')
            set(handles.stepper3,'enable','on')
        elseif strcmp(direction,'Stepper in')
            steps=-1*str2double(get(handles.steps1,'string'));
            set(hObject,'string','Moving in','foregroundcolor','r');
            try
                set(handles.stepper,'enable','off')
                set(handles.stepper2,'enable','off')
                set(handles.stepper3,'enable','off')
                value=stepnet(steps,mode,com,'mot1',safety,node,AD);
                set(hObject,'string','Stepper out','foregroundcolor','black');
                last1=1;
                pause(0.01)
                save('lastmove1.txt','last1','-ascii')
            catch exception
                if last_status==3
                    last_status=1;
                else
                    last_status=last_status+1;
                end
                stat=get(handles.status_text,'string');
                stat(last_status)={[datestr(now, 'mm/dd/yy HH:MM:SS'),' ',exception.message, ' Line ',num2str(getfield(exception.stack,'line')),'.']};
                set(handles.status_text,'string',stat);
                fclose(serial(com))
                set(hObject,'string','Stepper in','foregroundcolor','black');
                set(handles.stepper,'enable','on')
            end
            if get(handles.link_status,'value')==0
                set(handles.stepper,'enable','on')
            end            
            set(handles.stepper2,'enable','on')
            set(handles.stepper3,'enable','on')
        end
elseif strcmp(mode,'stop') && status(1)==0
    try
        value=stepnet(0,mode,com,'mot1',safety,node,AD);
    catch exception
        if last_status==3
            last_status=1;
        else
            last_status=last_status+1;
        end
        stat=get(handles.status_text,'string');
        stat(last_status)={[datestr(now, 'mm/dd/yy HH:MM:SS'),' ',exception.message, ' Line ',num2str(getfield(exception.stack,'line')),'.']};
        set(handles.status_text,'string',stat);
        fclose(serial(com))
    end
    if strcmp(direction(length(direction)),'n')
        dir='Stepper in';
        set(handles.stepper,'enable','on')
    else
        dir='Stepper out';
    end
    if get(handles.link_status,'value')==0
    	set(handles.stepper,'enable','on')
    end
	set(handles.stepper2,'enable','on')
	set(handles.stepper3,'enable','on')
    set(handles.stepper1,'string',dir,'foregroundcolor','black');
elseif strcmp(mode,'stepperreverse')
    if strcmp(direction,'Stepper out')
        set(handles.stepper1,'string','Stepper in');
        last1=0;
        set(handles.stepper,'enable','on')
    elseif strcmp(direction,'Stepper in')
        set(handles.stepper1,'string','Stepper out');
        last1=1;
    end
    save('lastmove1.txt','last1','-ascii')
end

% --- Executes on button press in stepper2.
function stepper2_Callback(hObject, eventdata, handles)
global safety AD last_status
mode=get(hObject,'tag');
mode=mode(1:end-1);
comports=get(handles.comport,'string');
val=get(handles.comport,'value');
com=cell2mat(comports(val));
direction=get(handles.stepper2,'string');
%status=get(handles.stepper,'foregroundcolor'); %check if motor 2 is running
node=get(handles.comport2,'value');
if strcmp(mode,'stepper') %&& status(1)==0
        if strcmp(direction,'Stepper out')
            steps=1*str2double(get(handles.steps2,'string'));
            set(hObject,'string','Moving out','foregroundcolor','r');
            try
                set(handles.stepper,'enable','off')
                set(handles.stepper1,'enable','off')
                set(handles.stepper3,'enable','off')
                value=stepnet(steps,mode,com,'mot2',safety,node,AD);
                set(hObject,'string','Stepper in','foregroundcolor','black');
                last2=0;
                pause(0.01)
                save('lastmove2.txt','last2','-ascii')
                %set(handles.stepper,'enable','on')
            catch exception
                if last_status==3
                    last_status=1;
                else
                    last_status=last_status+1;
                end
                stat=get(handles.status_text,'string');
                stat(last_status)={[datestr(now, 'mm/dd/yy HH:MM:SS'),' ',exception.message, ' Line ',num2str(getfield(exception.stack,'line')),'.']};
                set(handles.status_text,'string',stat);
                fclose(serial(com))
                set(hObject,'string','Stepper out','foregroundcolor','black');
            end
            if strcmp(get(handles.stepper1,'string'),'Stepper in') || get(handles.link_status,'value')==0
            	set(handles.stepper,'enable','on')
            end
            if strcmp(get(handles.stepper,'string'),'Stepper in') || get(handles.link_status,'value')==0
            	set(handles.stepper1,'enable','on')
            end
            set(handles.stepper3,'enable','on')
        elseif strcmp(direction,'Stepper in')
            steps=-1*str2double(get(handles.steps2,'string'));
            set(hObject,'string','Moving in','foregroundcolor','r');
            try
                set(handles.stepper,'enable','off')
                set(handles.stepper1,'enable','off')
                set(handles.stepper3,'enable','off')
                value=stepnet(steps,mode,com,'mot2',safety,node,AD);
                set(hObject,'string','Stepper out','foregroundcolor','black');
                last2=1;
                pause(0.01)
                save('lastmove2.txt','last2','-ascii')
            catch exception
                if last_status==3
                    last_status=1;
                else
                    last_status=last_status+1;
                end
                stat=get(handles.status_text,'string');
                stat(last_status)={[datestr(now, 'mm/dd/yy HH:MM:SS'),' ',exception.message, ' Line ',num2str(getfield(exception.stack,'line')),'.']};
                set(handles.status_text,'string',stat);
                fclose(serial(com))
                set(hObject,'string','Stepper in','foregroundcolor','black');
            end
            if strcmp(get(handles.stepper1,'string'),'Stepper in') || get(handles.link_status,'value')==0
                set(handles.stepper,'enable','on')
            end
            if strcmp(get(handles.stepper,'string'),'Stepper in') || get(handles.link_status,'value')==0
                set(handles.stepper1,'enable','on')
            end
             set(handles.stepper3,'enable','on')
        end
elseif strcmp(mode,'stop') %&& status(1)==0
    try
        value=stepnet(0,mode,com,'mot2',safety,node,AD);
    catch exception
        if last_status==3
        	last_status=1;
        else
        	last_status=last_status+1;
        end
        stat=get(handles.status_text,'string');
        stat(last_status)={[datestr(now, 'mm/dd/yy HH:MM:SS'),' ',exception.message, ' Line ',num2str(getfield(exception.stack,'line')),'.']};
        set(handles.status_text,'string',stat);
        fclose(serial(com))
    end
    if strcmp(direction(length(direction)),'n')
        dir='Stepper in';
    else
        dir='Stepper out';
    end
    if strcmp(get(handles.stepper1,'string'),'Stepper in') || get(handles.link_status,'value')==0
    	set(handles.stepper,'enable','on')
    end
    if strcmp(get(handles.stepper,'string'),'Stepper in') || get(handles.link_status,'value')==0
    	set(handles.stepper1,'enable','on')
    end
    set(handles.stepper3,'enable','on')
    set(handles.stepper2,'string',dir,'foregroundcolor','black');
elseif strcmp(mode,'stepperreverse')
    if strcmp(direction,'Stepper out')
        set(handles.stepper2,'string','Stepper in');
        last2=0;
        %set(handles.stepper,'enable','on')
    elseif strcmp(direction,'Stepper in')
        set(handles.stepper2,'string','Stepper out');
        last2=1;
    end
    save('lastmove2.txt','last2','-ascii')
end

% --- Executes on button press in stepper1.
function stepper3_Callback(hObject, eventdata, handles)
global safety AD last_status
mode=get(hObject,'tag');
mode=mode(1:end-1);
comports=get(handles.comport,'string');
val=get(handles.comport,'value');
com=cell2mat(comports(val));
direction=get(handles.stepper3,'string');
node=get(handles.comport3,'value');
%status=get(handles.stepper,'foregroundcolor'); %check if motor 1 is running
if strcmp(mode,'stepper') %&& status(1)==0
        if strcmp(direction,'Stepper out')
            steps=1*str2double(get(handles.steps3,'string'));
            set(hObject,'string','Moving out','foregroundcolor','r');
            try
                set(handles.stepper,'enable','off')
                set(handles.stepper1,'enable','off')
                set(handles.stepper2,'enable','off')
                value=stepnet(steps,mode,com,'mot3',safety,node,AD);
                set(hObject,'string','Stepper in','foregroundcolor','black');
                last3=0;
                pause(0.01)
                save('lastmove3.txt','last3','-ascii')
                %set(handles.stepper,'enable','on')
            catch exception
                if last_status==3
                    last_status=1;
                else
                    last_status=last_status+1;
                end
                stat=get(handles.status_text,'string');
                stat(last_status)={[datestr(now, 'mm/dd/yy HH:MM:SS'),' ',exception.message, ' Line ',num2str(getfield(exception.stack,'line')),'.']};
                set(handles.status_text,'string',stat);
                fclose(serial(com))
                set(hObject,'string','Stepper out','foregroundcolor','black');
            end
            if strcmp(get(handles.stepper1,'string'),'Stepper in') || get(handles.link_status,'value')==0
                set(handles.stepper,'enable','on')
            end
            if strcmp(get(handles.stepper,'string'),'Stepper in') || get(handles.link_status,'value')==0
                set(handles.stepper1,'enable','on')
            end
            set(handles.stepper2,'enable','on')
        elseif strcmp(direction,'Stepper in')
            steps=-1*str2double(get(handles.steps3,'string'));
            set(hObject,'string','Moving in','foregroundcolor','r');
            try
                set(handles.stepper,'enable','off')
                set(handles.stepper1,'enable','off')
                set(handles.stepper2,'enable','off')
                value=stepnet(steps,mode,com,'mot3',safety,node,AD);
                set(hObject,'string','Stepper out','foregroundcolor','black');
                last3=1;
                pause(0.01)
                save('lastmove3.txt','last3','-ascii')
            catch exception
                if last_status==3
                    last_status=1;
                else
                    last_status=last_status+1;
                end
                stat=get(handles.status_text,'string');
                stat(last_status)={[datestr(now, 'mm/dd/yy HH:MM:SS'),' ',exception.message, ' Line ',num2str(getfield(exception.stack,'line')),'.']};
                set(handles.status_text,'string',stat);
                fclose(serial(com))
                set(hObject,'string','Stepper in','foregroundcolor','black');
            end
            if strcmp(get(handles.stepper1,'string'),'Stepper in') || get(handles.link_status,'value')==0
                set(handles.stepper,'enable','on')
            end
            if strcmp(get(handles.stepper,'string'),'Stepper in') || get(handles.link_status,'value')==0
                set(handles.stepper1,'enable','on')
            end
            set(handles.stepper2,'enable','on')            
        end
elseif strcmp(mode,'stop') %&& status(1)==0
    try
        value=stepnet(0,mode,com,'mot3',safety,node,AD);
    catch exception
        if last_status==3
            last_status=1;
        else
        	last_status=last_status+1;
        end
        stat=get(handles.status_text,'string');
        stat(last_status)={[datestr(now, 'mm/dd/yy HH:MM:SS'),' ',exception.message, ' Line ',num2str(getfield(exception.stack,'line')),'.']};
        set(handles.status_text,'string',stat);
        fclose(serial(com))
    end
    if strcmp(direction(length(direction)),'n')
        dir='Stepper in';
    else
        dir='Stepper out';
    end
    if strcmp(get(handles.stepper1,'string'),'Stepper in') || get(handles.link_status,'value')==0
    	set(handles.stepper,'enable','on')
    end
    if strcmp(get(handles.stepper,'string'),'Stepper in') || get(handles.link_status,'value')==0
        set(handles.stepper1,'enable','on')
    end
    set(handles.stepper3,'enable','on')
    set(handles.stepper3,'string',dir,'foregroundcolor','black');
elseif strcmp(mode,'stepperreverse')
    if strcmp(direction,'Stepper out')
        set(handles.stepper3,'string','Stepper in');
        last3=0;
        %set(handles.stepper,'enable','on')
    elseif strcmp(direction,'Stepper in')
        set(handles.stepper3,'string','Stepper out');
        last3=1;
    end
    save('lastmove3.txt','last3','-ascii')
end

% --- Executes on button press in safety_1.
function safety_1_Callback(hObject, eventdata, handles)
global safety
safety=get(hObject,'value');

function steps_Callback(hObject, eventdata, handles)
val=str2double(get(hObject,'string'));
if isnan(val)
    set(hObject,'string','1000')
elseif val<0
    set(hObject,'string',num2str(-val))
end
if strcmp(get(hObject,'Tag'),'steps')
    save('laststeps.txt','val','-ascii');
elseif strcmp(get(hObject,'Tag'),'steps1')
    save('laststeps1.txt','val','-ascii');
elseif strcmp(get(hObject,'Tag'),'steps2')
    save('laststeps2.txt','val','-ascii');
elseif strcmp(get(hObject,'Tag'),'steps3')
    save('laststeps3.txt','val','-ascii');
end

% --- Executes on button press in motsave.
function motsave_Callback(hObject, eventdata, handles)
if strcmp(get(hObject,'Tag'),'motsave')
    val=str2double(get(handles.Position_mot,'string'));
    set(handles.mot_pos,'string',get(handles.Position_mot,'string'));
    save('mot_pos.txt','val','-ascii');
elseif strcmp(get(hObject,'Tag'),'motsave1')
    val=str2double(get(handles.Position_mot1,'string'));
    set(handles.mot_pos1,'string',get(handles.Position_mot1,'string'));
    save('mot_pos1.txt','val','-ascii');
elseif strcmp(get(hObject,'Tag'),'motsave2')
    val=str2double(get(handles.Position_mot2,'string'));
    set(handles.mot_pos2,'string',get(handles.Position_mot2,'string'));
    save('mot_pos2.txt','val','-ascii');
elseif strcmp(get(hObject,'Tag'),'motsave3')
    val=str2double(get(handles.Position_mot3,'string'));
    set(handles.mot_pos3,'string',get(handles.Position_mot3,'string'));
    save('mot_pos3.txt','val','-ascii');
end


% --- Executes during object creation, after setting all properties.
function steps_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes on selection change in comport.
function comport_Callback(hObject, eventdata, handles)

% --- Executes during object creation, after setting all properties.
function comport_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes when user attempts to close Autocorrelator.
function Close_CloseRequestFcn(hObject, eventdata, handles)
global last_status
try
    comports = instrhwinfo('serial');
    ports = cell2mat(comports.SerialPorts);
    for a=1:length(ports)
        fclose(serial(ports(a)))
    end
catch exception
	if last_status==3
    	last_status=1;
    else
    	last_status=last_status+1;
    end
	stat=get(handles.status_text,'string');
	stat(last_status)={[datestr(now, 'mm/dd/yy HH:MM:SS'),' ',exception.message, ' Line ',num2str(getfield(exception.stack,'line')),'.']};
	set(handles.status_text,'string',stat);
end
shutdown_controller;
delete(hObject);


% --- Executes on button press in link_status.
function link_status_Callback(hObject, eventdata, handles)
% hObject    handle to link_status (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of link_status
