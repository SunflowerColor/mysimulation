clc;
clear all;
close all;

r=1;
kp=0;
ki=1;
k1=1;

st=10;
dt=0.2;
lp=st/dt;

Y=zeros(lp,1);
t=zeros(lp,1);
y=0;
xi=0;

for i=1:lp
    e=r-y;
    xp=e*kp;
    xi=xi+e*ki*dt;
    u=xp+xi;
    x1=u*k1;
    y=x1;
    Y(i)=y;
    t(i)=dt*i;
end
kps=num2str(kp);
kis=num2str(ki);
k1s=num2str(k1);
dts=num2str(dt);
text=['kp=',kps,'  ki=',kis,'  k=',k1s,'  dt=',dts];
% text=['kp=',kps,'  ki=',kis,'  k=',k1s];
[v1,v2,v3,v4,v5,v6,v7]=value(Y,dt);
% plot(t,Y);
plot(Y);
legend(v7,4)
title(text)