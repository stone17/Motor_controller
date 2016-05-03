function varargout = configuration_dialog(varargin)
% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @configuration_dialog_OpeningFcn, ...
                   'gui_OutputFcn',  @configuration_dialog_OutputFcn, ...
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

% --- Executes just before configuration_dialog is made visible.
function configuration_dialog_OpeningFcn(hObject, eventdata, handles, varargin)
handles.output = hObject;
initialize_gui(hObject,eventdata,handles);
guidata(hObject, handles);

% --- Outputs from this function are returned to the command line.
function varargout = configuration_dialog_OutputFcn(hObject, eventdata, handles) 
varargout{1} = handles.output;

function initialize_gui(hObject, eventdata, handles)
global controller;
global lvdt_config;
global configuration;

update_gui_with_options(hObject, eventdata, handles);

function update_gui_with_options(hObject, eventdata, handles)
global controller;
global lvdt_config;
global configuration;

%get(handles.mx_controller, 'String');
motor   = get(handles.mx_controller, 'String' );

set( handles.mx_controller, 'Value', find(ismember(motor,controller.X.motor)==1));
set( handles.my_controller, 'Value', find(ismember(motor,controller.Y.motor)==1));
set( handles.mz_controller, 'Value', find(ismember(motor,controller.Z.motor)==1));

set( handles.mx_channel, 'Value', str2double(controller.X.channel)+1);
set( handles.my_channel, 'Value', str2double(controller.Y.channel)+1);
set( handles.mz_channel, 'Value', str2double(controller.Z.channel)+1);

set( handles.lvdt_x_channel,  'Value', lvdt_config.X.channel+1);
set( handles.lvdt_y_channel,  'Value', lvdt_config.Y.channel+1);
set( handles.lvdt_z_channel,  'Value', lvdt_config.Z.channel+1);
set( handles.lvdt_m_channel,  'Value', lvdt_config.mot.channel+1);
set( handles.lvdt_x_subdevice,'Value', lvdt_config.X.subdevice+1);
set( handles.lvdt_y_subdevice,'Value', lvdt_config.Y.subdevice+1);
set( handles.lvdt_z_subdevice,'Value', lvdt_config.Z.subdevice+1);
set( handles.lvdt_m_subdevice,'Value', lvdt_config.mot.subdevice+1);

set( handles.lvdt_delta,  'String', configuration.delta);
set( handles.IPAddress,  'String', configuration.ipaddress);
set( handles.Port,  'String', configuration.port);
set( handles.lvdt_frequence,  'String', configuration.lvdt_frequence);
set( handles.lvdt_amountvalues,  'String', configuration.lvdt_amountvalues);

%dropdown menus for motor setup
function setup_controller_Callback(hObject, eventdata, handles)
global controller;
str=get(hObject,'Tag');
var = get(hObject, 'String');
motor=str(2);
device=str(4:length(str));
    
if strcmp(device,'channel')
	if strcmp(motor,'x')
        controller.X.channel = var{get(hObject, 'Value')};
	elseif strcmp(motor,'y')
        controller.Y.channel = var{get(hObject, 'Value')};
	elseif strcmp(motor,'z')
        controller.Z.channel = var{get(hObject, 'Value')};
	end
elseif strcmp(device,'controller')
	if strcmp(motor,'x')
        controller.X.motor = var{get(hObject, 'Value')};
	elseif strcmp(motor,'y')
        controller.Y.motor = var{get(hObject, 'Value')};
	elseif strcmp(motor,'z')
        controller.Z.motor = var{get(hObject, 'Value')};
	end
end

    
function mx_controller_CreateFcn(hObject, eventdata, handles)
function mx_channel_CreateFcn(hObject, eventdata, handles)
function my_controller_CreateFcn(hObject, eventdata, handles)
function my_channel_CreateFcn(hObject, eventdata, handles)
function mz_controller_CreateFcn(hObject, eventdata, handles)
function mz_channel_CreateFcn(hObject, eventdata, handles)
    
%dropdown menus for LVDT setup    
function setup_LVDT_Callback(hObject, eventdata, handles)
global lvdt_config;
str=get(hObject,'Tag');
var = get(hObject, 'String');
motor=str(6)
device=str(8:length(str))
    
if strcmp(device,'channel')
	if strcmp(motor,'x')
    	lvdt_config.X.channel = str2double(var{get(hObject, 'Value')});
        lvdt_config.X
    elseif strcmp(motor,'y')
    	lvdt_config.Y.channel = str2double(var{get(hObject, 'Value')});
    elseif strcmp(motor,'z')
    	lvdt_config.Z.channel = str2double(var{get(hObject, 'Value')});
    elseif strcmp(motor,'m')
    	lvdt_config.mot.channel = str2double(var{get(hObject, 'Value')});
        1
    end
elseif strcmp(device,'subdevice')
	if strcmp(motor,'x')
        lvdt_config.X.subdevice = str2double(var{get(hObject, 'Value')});
	elseif strcmp(motor,'y')
        lvdt_config.Y.subdevice = str2double(var{get(hObject, 'Value')});
	elseif strcmp(motor,'z')
        lvdt_config.Z.subdevice = str2double(var{get(hObject, 'Value')});
    elseif strcmp(motor,'m')
    	lvdt_config.mot.subdevice = str2double(var{get(hObject, 'Value')});
        1
	end
end
lvdt_config.mot


function lvdt_x_channel_CreateFcn(hObject, eventdata, handles)
function lvdt_x_subdevice_CreateFcn(hObject, eventdata, handles)
function lvdt_y_channel_CreateFcn(hObject, eventdata, handles)
function lvdt_y_subdevice_CreateFcn(hObject, eventdata, handles)
function lvdt_z_channel_CreateFcn(hObject, eventdata, handles)
function lvdt_z_subdevice_CreateFcn(hObject, eventdata, handles)
function lvdt_m_subdevice_CreateFcn(hObject, eventdata, handles)
function lvdt_m_channel_CreateFcn(hObject, eventdata, handles)

    
function lvdt_delta_Callback(hObject, eventdata, handles)
    global configuration;
    var = get(hObject, 'String');
    configuration.delta = str2double(var);

function lvdt_delta_CreateFcn(hObject, eventdata, handles)

function IPAddress_Callback(hObject, eventdata, handles)
global configuration;
address = get(hObject, 'String');
configuration.ipaddress = address;

function IPAddress_CreateFcn(hObject, eventdata, handles)

function Port_Callback(hObject, eventdata, handles)
global configuration;
configuration.port = str2double(get(hObject, 'String'));
guidata(hObject,handles);

function Port_CreateFcn(hObject, eventdata, handles)

% --- Executes on button press in SaveConfiguration.
function SaveConfiguration_Callback(hObject, eventdata, handles)
    global configuration;
    global controller;
    global lvdt_config;

    file = fopen('connection-options','wt');
    fprintf(file,'%s\n', configuration.version );
    fprintf(file,'CONNECTION-OPTIONS\n' );

    fprintf(file,'%s\n', controller.X.motor );
    fprintf(file,'%s\n', controller.X.channel );
    fprintf(file,'%s\n', controller.Y.motor );
    fprintf(file,'%s\n', controller.Y.channel );
    fprintf(file,'%s\n', controller.Z.motor );
    fprintf(file,'%s\n', controller.Z.channel );
    %fprintf(file,'%s\n', controller.W1.motor );
    %fprintf(file,'%s\n', controller.W1.channel );
    %fprintf(file,'%s\n', controller.W2.motor );
    %fprintf(file,'%s\n', controller.W2.channel );
    %fprintf(file,'%s\n', controller.W.motor );
    %fprintf(file,'%s\n', controller.W.channel );

    fprintf(file,'%d\n', lvdt_config.X.channel );
    fprintf(file,'%d\n', lvdt_config.X.subdevice );
    fprintf(file,'%d\n', lvdt_config.Y.channel );
    fprintf(file,'%d\n', lvdt_config.Y.subdevice );
    fprintf(file,'%d\n', lvdt_config.Z.channel );
    fprintf(file,'%d\n', lvdt_config.Z.subdevice );
    fprintf(file,'%d\n', lvdt_config.mot.channel );
    fprintf(file,'%d\n', lvdt_config.mot.subdevice );
    
    fprintf(file,'%s\n', configuration.ipaddress );
    fprintf(file,'%d\n', configuration.port );
    fprintf(file,'%d\n', configuration.delta );
    fprintf(file,'%d\n', configuration.lvdt_frequence );
    fprintf(file,'%d\n', configuration.lvdt_amountvalues );

    fclose(file);

% --- Executes on button press in LoadConfiguration.
function LoadConfiguration_Callback(hObject, eventdata, handles)
    load_connection_options();
    update_gui_with_options(hObject, eventdata, handles);

function lvdt_frequence_Callback(hObject, eventdata, handles)
global configuration;
frequence = str2double(get(hObject, 'String'));
configuration.lvdt_frequence = frequence;

function lvdt_frequence_CreateFcn(hObject, eventdata, handles)

function lvdt_amountvalues_Callback(hObject, eventdata, handles)
global configuration;
amountvalues = str2double(get(hObject, 'String'));
configuration.lvdt_amountvalues = amountvalues;


function lvdt_amountvalues_CreateFcn(hObject, eventdata, handles)

% --- Executes on button press in CloseConfiguration.
function CloseConfiguration_Callback(hObject, eventdata, handles)
    delete(handles.figure1);
