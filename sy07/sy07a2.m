clc;
clear all;
close all;

r=1;
kp=1;
ki=0;
k1=1;
T=0.001;

st=10;
dt=0.0001;
lp=st/dt;

Y=zeros(lp,1);
t=zeros(lp,1);
y=0;
y1=0;
xi=0;

for i=1:lp
    e=r-y1;
    xp=e*kp;
    xi=xi+e*ki*dt;
    u=xp+xi;
    x1=u*k1;
    y=x1;
    y1=y1+(y-y1)/T*dt;
    Y(i)=y;
    t(i)=dt*i;
end
[v1,v2,v3,v4,v5,v6,v7]=value(Y,dt);
plot(t,Y);
legend(v7,4)
