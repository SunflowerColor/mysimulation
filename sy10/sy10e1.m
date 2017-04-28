%P¿ØÖÆ
clc;
clear all;
close all;

T=2;
n=2;
k=1;
tao=0.2;

kc=2.7;
tc=9;

Tv=0.12*tc;
Tn=0.5*tc;

kp=0.6*kc;
ki=kp/Tn;
kd=kp*Tv;

st=30;
dt=0.01;
lp=st/dt;
lp1=tao/dt;

r=1;
y=0;
xi=0;
a=exp(-dt/T);
b=1-a;
e0=0;
T=[];
Y=[];
x(1:n)=0;
l(1:lp1)=0;

for i=1:lp
    e=r-l(1);
    xp=e*kp;
    xi=xi+e*ki*dt;
    xd=(e-e0)*kd/dt;
    u=xp+xi+xd;
    e0=e;
    x(1)=x(1)*a+k*u*b;
    if n>1
        x(2:n)=x(2:n)*a+x(1:n-1)*b;
    end
    l(lp1)=x(n);
    for j=1:lp1-1
        l(j)=l(j+1);
    end
    Y=[Y l(1)];
    T=[T i*dt];
end

[v1,v2,v3,v4,v5,v6,v7]=value(Y,dt);
plot(T,Y);
legend(v7,4);
title('PID');