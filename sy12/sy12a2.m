%微分先行
clc;
clear all;
close all;

T=20;
k=2;
n=2;
tao=10;

num=[k];
den=[T*T 2*T 1];
sys=tf(num,den,'outputdelay',tao);
[Gm,Pm,Wgc,Wpc]=margin(sys);
kc=Gm;
tc=2*pi/Wgc;

Tv=0.12*tc;
Tn=0.5*tc;
kp=0.6*kc;
ki=kp/Tn;
kd=kp*Tv;

st=500;
dt=0.1;
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
d(1:lp)=0;
d(fix(lp*0.5):end)=1;


for i=1:lp
    e=r-l(1)-(l(2)-l(1))*kd/dt;
    xp=e*kp;
    xi=xi+e*ki*dt;
    xd=(e-e0)*kd/dt;
    u=xp+xi+xd+d(i);
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
title('微分先行');