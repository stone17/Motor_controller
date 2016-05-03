close all
clear all
clc
hold on
for a=1:500
    
    value(a,1)=lvdt_stream(2,4,100000,100)/6.4010e+4*32.5*1000-16590;%/2.17798e+3;
    %position = round((value-32764.75)*(.8840)*10)/10
    if a>1
        if round(value(a,1))~=round(value(a-1,1))
            plot(a,round(value(a,1))/1000,'x')
        else
            plot(a,round(value(a,1))/1000)
        end
    else
        plot(a,round(value(a,1))/1000)
    end
    
    plot(a,(value(a,1))/1000,'r')
    pause(0.01)
end

hold off

average=mean(value);
minimum=min(value);
maximum=max(value);

delta=maximum-minimum
average/1000