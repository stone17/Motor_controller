function [time]=get_time
cl=rem(now,1);
h=floor(cl*24);
m=floor((cl*24-h)*60);
s=floor(((cl*24-h)*60-m)*60);
time=[num2str(h),':',num2str(m),':',num2str(s)];
end
