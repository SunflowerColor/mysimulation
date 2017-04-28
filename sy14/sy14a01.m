%饱和特性
clc;
clear all;
close all;

xian=0.6;
st=10;
dt=0.01;
lp=st/dt;
t=dt:dt:st;
w=3;
u=sin(w*t);
Y=[];
for i=1:lp
    if u(i)>xian
        y=xian;
    else if u(i)<-xian
        y=-xian;
        else
            y=u(i);
        end
    end
    
    Y=[Y y];
end
plot(t,Y);
title('饱和特性');