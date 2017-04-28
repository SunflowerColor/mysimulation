%一般继电器特性
clc;
clear all;
close all;

xian1=0.3;
xian2=0.8;
st=10;
dt=0.01;
lp=st/dt;
t=dt:dt:st;
w=3;
u=sin(w*t);
Y=[];
for i=1:lp-1
    if u(i+1)>u(i)
        if u(i+1)>xian2
            y=1;
        else if u(i+1)<-xian1
                y=-1;
            else
                y=0;
            end
        end
    end
    if u(i+1)<u(i)
        if u(i+1)>xian1
            y=1;
        else if u(i+1)<-xian2
                y=-1;
            else
                y=0;
            end
        end
    end
    Y=[Y y];
end
t=t(1:lp-1);
plot(t,Y);
title('一般继电器特性');