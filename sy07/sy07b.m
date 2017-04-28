clc;
clear all;
close all;

kp=3;
ki=5;
r=1;
T=1;
k=1;

st=100;
dt=0.001;
ts=1;
lp1=fix(st/ts);
lp2=fix(ts/dt);

xi=0;
y=0;
a=exp(-dt/T);
b=1-a;
n=0;

for i=1:lp1
    e=r-y;
    xp=e*kp;
    xi=xi+e*ki*dt;
    u=xp+xi;
    for j=1:lp2
        n=n+1;
        y=y*a+k*u*b;
        Y(n)=y;
        U(n)=u;
        t(n)=n*dt;
    end
end
tss=num2str(ts);
text=['ts=',tss];
[v1,v2,v3,v4,v5,v6,v7]=value(Y,dt);
figure(1)
plot(t,Y)
title(text);
legend(v7,4);
t1=t(1:10000);
U1=U(1:10000);
figure(2)
plot(t1,U1)
title(text);