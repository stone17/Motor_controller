clear all
clc
offset=num2str(0);
cancel=0;
index=0;


controller.X  = struct( 'motor','a1', 'channel','0' );

global configuration telnet
configuration.ipaddress = '192.168.0.126';
configuration.port = 23;
configuration.delta = 1;
configuration.lvdt_frequence = 100000;
configuration.lvdt_amountvalues = 100;
configuration.version = 'V4';
configuration.shouldStop('X')=0;
configuration.shouldStop('Y')=0;
configuration.shouldStop('Z')=0;
telnet = tcpip(configuration.ipaddress, configuration.port);
set(telnet,'InputBufferSize', 30000);
fopen(telnet)

prompt = {'Enter LVDT name:'};
dlg_title = 'Input for LVDT calibration';
num_lines = 1;
def = {'LVDT'};
answer = inputdlg(prompt,dlg_title,num_lines,def);
if isempty(answer)
    return
end
answer = [cell2mat(answer),'.cal'];    


hold on
distance=-10000000;

while round(distance)<=20
    index=index+1;
   
    clear value distance
    
    distance=Heidenhain;
  
    for a=1:100
        value(a,1)=mean(lvdt_stream(1,4,100000,100));
    end
    
    round(mean(value))
    Calibration(index,1)=distance;
    Calibration(index,2)=mean(value);
    Calibration(index,3)=min(value);
    Calibration(index,4)=max(value);
    Calibration(index,5)=Calibration(index,4)-Calibration(index,3);
    
    plot(round(mean(value)),distance,'o')
    move_picomotor_calibration('X', controller.X , 100, 200)
    save(answer,'Calibration','-ascii');
end


pico_command('hal');
fclose(telnet);
delete(telnet);
clear telnet; 
