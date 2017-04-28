%Ç°À¡¿ØÖÆ¼õÎÂË®
clc;
clear all;
close all;

kp=3.57;
% ki=0.0316;
ki=0;

k=0.4;
T=70;
KD=0.2;
TD=30;
kf=0.2;
Tf=30;

st=1000;
dt=0.1;
lp=st/dt;


%ÈÅ¶¯
dd=zeros(1,lp);
for i=fix(0.5*lp):lp
    dd(i)=1;
end

r=0;
xi=0;
a=exp(-dt/T);
b=1-a;
ad=exp(-dt/TD);
bd=1-ad;
af=exp(-dt/Tf);
bf=1-af;
fd=zeros(1,4);
fd0=0;
fd1=0;
x=zeros(1,2);
D=zeros(1,2);
y=0;
Y=[];
t=[];
for i=1:lp
    e=r-y;
    xp=e*kp;
    xi=xi+e*ki*dt;
    d=dd(i);
    fd(1)=fd(1)*af-kf*bf*d;
    fd(2)=fd(2)*af+bf*fd(1);
    fd(3)=(fd(2)+(fd(2)-fd0)*T/dt)/k;
    fd(4)=fd(3)+(fd(3)-fd1)*T/dt;
    fd0=fd(2);
    fd1=fd(3);
%     u=xp+xi+fd(4);%¶¯Ì¬²¹³¥
    u=xp+xi-kf/k;%¾²Ì¬²¹³¥
%     u=xp+xi;%ÎÞ²¹³¥
    x(1)=a*x(1)+b*k*u;
    x(2)=a*x(2)+b*x(1);
    D(1)=ad*D(1)+b*KD*d;
    D(2)=ad*D(2)+b*D(1);
    y=x(2)+D(2);
    Y=[Y y];
    t=[t i*dt];
end
[v1,v2,v3,v4,v5,v6,v7]=value(Y,dt);
plot(t,Y);
legend(v7,4);
title('r=0');