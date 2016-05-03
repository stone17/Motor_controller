function [value]=stepnet(steps,mode,com,motor,safety,node,AD)
%clear all
s = instrfind;
if ~isempty(s)
fclose(s)
end
clear s
if strcmp(mode,'stepper')
s = serial(com,'BaudRate',9600,'DataBits',8,'Parity','none','Terminator','','StopBits',1); 
fopen(s);

%disable amplifier
a=1;
cycle=0;
while a==1 && cycle<10
    fprintf(s,'%s\r', [num2str(node), ' s r0x24 0']);
    pause(1)
    readout = fscanf(s,'%c',s.BytesAvailable);
    if strcmp(readout(1),'o')
        a=0;
    end
    cycle=cycle+1;
end

if cycle==10
    fclose(s);
    delete(s)
    clear s
    return
end

%set to relative move trapezoidal
fprintf(s,'%s\r', [num2str(node), ' s r0xc8 256']);
pause(.2)
readout = fscanf(s,'%c',s.BytesAvailable);
%set position
posi=[num2str(node), ' s r0xca ', num2str(round(steps))];
fprintf(s,'%s\r', posi);
pause(.2)
%set velocity 0.1counts/second   1count= 0.25mm/1000steps 
readout = fscanf(s,'%c',s.BytesAvailable);
fprintf(s,'%s\r', [num2str(node), ' s r0xcb 5000000']);
pause(.2)
readout = fscanf(s,'%c',s.BytesAvailable);
%set accelertion 10count/second^2
fprintf(s,'%s\r', [num2str(node), ' s r0xcc 100000']);
pause(.2)
readout = fscanf(s,'%c',s.BytesAvailable);
%set accelertion 10count/second^2
fprintf(s,'%s\r', [num2str(node), ' s r0xcd 100000']);
pause(.2)
readout = fscanf(s,'%c',s.BytesAvailable);
%enable amplifier
fprintf(s,'%s\r', [num2str(node), ' s r0x24 31'])
pause(.2)
readout = fscanf(s,'%c',s.BytesAvailable);
%execute move 
fprintf(s,'%s\r', [num2str(node), ' t 1'])
pause(.2)
readout = fscanf(s,'%c',s.BytesAvailable);

a=1;
while a>0
    %check move
    fprintf(s,'%s\r', [num2str(node), ' g r0xa0']);
    pause(1)
    readout = fscanf(s,'%c',s.BytesAvailable)
    if AD==1
        try
            [actual_position,err]=refresh_motor_position(motor);
        catch exception
            err=25000;
            exception.message
        end
    else
        err=25000;
    end
    a=str2double(readout(3));
    if err<450 || err> 6.5e+004 && safety==1
        'Emergency motor stop!'
        a=0;
    end
end
elseif strcmp(mode,'stop')
    try
    s = serial(com,'BaudRate',9600,'DataBits',8,'Parity','none','Terminator','','StopBits',1); 
    fopen(s);
    catch exception
        global exception
        exception.message
    end
end
%disable amplifier
fprintf(s,'%s\r', [num2str(node), ' s r0x24 0'])
pause(.2)
readout = fscanf(s,'%c',s.BytesAvailable)
value=1;

fclose(s)
delete(s)
clear s
end