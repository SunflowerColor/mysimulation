%间隙特性
clc;
clear all;
close all;

xian=0.5;
st=10;
dt=0.01;
lp=st/dt;
t=dt:dt:st;
w=3;
u=sin(w*t);
Y=[];
y=0;
for i=1:lp-1
    if u(i)-xian>y && u(i+1)>u(i)
        y=u(i)-xian;
    else if u(i)+xian<y && u(i+1)<u(i)
            y=u(i)+xian;
        end
    end
    Y=[Y y];
end
t=dt:dt:st-dt;
plot(t,Y);
title('间隙特性');