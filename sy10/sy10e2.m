%PI¿ØÖÆ
clc;
clear all;
close all;

T=2;
n=1;
k=1;

kp=1;
ki=0.01;
kd=0.01;

st=20;
dt=0.01;
lp=st/dt;

r=1;
y=0;
xi=0;
a=exp(-dt/T);
b=1-a;
e0=0;
T=[];
Y=[];
x(1:n)=0;

for i=1:lp
    e=r-y;
    xp=e*kp;
    xi=xi+e*ki*dt;
    xd=(e-e0)*kd/dt;
    u=xp+xi;
    e0=e;
    x(1)=x(1)*a+k*u;
    if n>1
        x(2:n)=x(2:n)*a+x(1:n-1)*b;
    end
    Y=[Y x(n)];
    T=[T i*dt];
end

[v1,v2,v3,v4,v5,v6,v7]=value(Y,dt);
plot(T,Y);
legend(v7,4);
    