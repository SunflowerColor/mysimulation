%有自衡对象脉冲响应转阶跃响应
clc;
clear all;
close all;

T=10;
k=1;
tao=10;

st=100;
dt=0.1;
lp=st/dt;

r=zeros(lp,1);
r(1:fix(tao/dt),1)=1;
r1(1:lp,1)=1;

t=zeros(lp,1);
Y=zeros(lp,1);
y=0;
xi=0;
for i=1:lp
    y=y+(k*r(i)-y)/T*dt;
     Y(i)=y;
    t(i)=i*dt;
end

Y1=zeros(lp,1);
y=0;
xi=0;
for i=1:lp
    y=y+(k*r1(i)-y)/T*dt;
    Y1(i)=y;
end

Yr=zeros(lp,1);
for i=1:fix(tao/dt)
    Yr(i)=Y(i);
end
for i=fix(tao/dt)+1:lp
    Yr(i)=Y(i)+Yr(i-fix(tao/dt));
end
plot(t,Y,'k',t,Y1,'b',t,Yr,'r--')
legend('脉冲曲线','阶跃曲线','转换结果');
title 有自衡对象