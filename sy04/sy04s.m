clc;
clear all;
close all;
kp=1;
ki=1;
kd=0;
k2=1.1;
xi=0;
chs=1;
if chs==1
    r=1;
    n1=0;
    n2=0.1;
end
if chs==2
    r=0;
    n1=0.1;
    n2=0;
end
if chs==3
    r=0;
    n1=0;
    n2=0.1;
end
y=0;

st=400;
dt=0.1;
lp=st/dt;

Y=zeros(lp,1);

e=r;
e0=0;
e1=0;
y1=0;
u=0;
for i=1:lp
    xp=e*kp;
    xi=xi+e*ki*dt;
    xd=kd*(e-e0)/dt;
    u=xp+xi+xd+n1;
%     u=u+kp*(e-e0)+ki*e+kd*(e+e1-2*e0)
    y=y+(k2*u-y)/20*dt;
    y1=y1+y*dt;
    Y(i)=y+n2;
    t(i)=i*dt;
    te(i)=u;
    e=r-Y(i);
    e1=e0;
    e0=e;
end
rs=num2str(r);
n1s=num2str(n1);
n2s=num2str(n2);
css=['r=',rs,'  n1=',n1s,'  n2=',n2s];
[z,z,z,z,z,z,g]=value(Y,dt);
figure(1)
plot(t,Y);
title(css);
hold on;
figure(2)
plot(t,te);
