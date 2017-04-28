clc;
clear all;
close all;

r=1;
kp=1;
ki=1;
k=1;

st=10;
dt=0.1;
lp=st/dt;

Y=zeros(lp,1);
t=zeros(lp,1);
x=0;

for i=1:lp
    x1=(r-ki*x)/(1+kp);
    x=x+x1*dt;
    y=(r*kp+ki*x)/(1+kp);
    Y(i)=y;
    t(i)=dt*i;
end
% [v1,v2,v3,v4,v5,v6,v7]=value(Y,dt);
plot(t,Y);
% legend(v7,4)