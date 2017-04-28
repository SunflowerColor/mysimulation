%理想继电器特性
clc;
clear all;
close all;

xian=1;
st=10;
dt=0.01;
lp=st/dt;
t=dt:dt:st;
w=3;
u=sin(w*t);
Y=[];
for i=1:lp
    if u(i)>0
        y=xian;
    else if u(i)<0
        y=-xian;
        end
    end   
    Y=[Y y];
end
plot(t,Y);
title('理想继电器特性');