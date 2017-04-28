clc;
clear all;
close all;

kp=3;
ki=5;
T=10;
k=1;
tao=10;

st=100;
dt=0.1;
lp=st/dt;

r=zeros(lp,1);
r2=zeros(lp,1);
r(1:fix(tao/dt),1)=1;
r1(1:lp,1)=1;
r2(fix(tao/dt):lp,1)=-1;

t=zeros(lp,1);
Y=zeros(lp,1);
y=0;
xi=0;
for i=1:lp
    e=r(i)-y;
    xp=e*kp;
    xi=xi+e*ki*dt;
    u=xp+xi;
    y=y+(k*u-y)/T*dt;
    Y(i)=y;
    t(i)=i*dt;
end

Y1=zeros(lp,1);
y=0;
xi=0;
for i=1:lp
    e=r1(i)-y;
    xp=e*kp;
    xi=xi+e*ki*dt;
    u=xp+xi;
    y=y+(k*u-y)/T*dt;
    Y1(i)=y;
end

Y2=zeros(lp,1);
y=0;
xi=0;
for i=1:lp
    e=r2(i)-y;
    xp=e*kp;
    xi=xi+e*ki*dt;
    u=xp+xi;
    y=y+(k*u-y)/T*dt;
    Y2(i)=y;
end

Yr=zeros(lp,1);
for i=1:fix(tao/dt)
    Yr(i)=Y(i);
end
for i=fix(tao/dt)+1:lp
    Yr(i)=Y(i)+Yr(i-fix(tao/dt));
end
plot(t,Y1,t,Yr)