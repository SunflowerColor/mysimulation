clc;
clear all;
close all;

kp=15;
ki=20;

st=15;
dt=0.01;
lp=st/dt;

xi=0;
y1=0;
y2=0;

for i=1:lp
    r(i)=i*dt;
    e=r(i)-y2;
    xp=kp*e;
    xi=xi+ki*e*dt;
    u=xp+xi;
    y1=y1+(2*u-y1)*dt;
    y2=y2+(y1-10*y2)*dt;
    y(i)=y2;
    t(i)=i*dt;
    te(i)=e;
end
s=tf('s');
sys=(kp+ki/s)/(s+1)/(s+10);
[v1,v2,v3,v4,v5,v6,v7]=value(y,dt);
figure(1)
plot(t,y);
legend(v7,4)
figure(2)
plot(t,te);
figure(3)
rlocus(sys);
hold on;
plot(-1.95,2.28,'ks',-1.95,-2.28,'ks')