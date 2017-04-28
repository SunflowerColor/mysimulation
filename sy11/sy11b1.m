%Ç°À¡¿ØÖÆ
clc;
clear all;
close all;

k=2;
T=10;
k1=2;
T1=10;
n=2;

kp=1.096;
ki=0.046;
ki=0;
d=0.2;

st=100;
dt=0.01;
lp=st/dt;


y=0;
qian=0;
xi=0;
r=1;
r0=0;
f10=0;
x=zeros(1,n);
t=[];
Y=[];

a=exp(-dt/T);
b=1-a;
a1=exp(-dt/T1);
b1=1-a1;

for i=1:lp
    e=r-y;
    xp=e*kp;
    xi=xi+ki*e*dt;
    f1=(r+(r-r0)*T1/dt)/k1;
    f2=f1+(f1-f10)*T1/dt;
    f10=f1;
    r0=r;
    u=xp+xi+f2;%¶¯Ì¬Ç°À¡²¹³¥
%     u=xp+xi+r/k1;%¾²Ì¬Ç°À¡²¹³¥
%     u=xp+xi;%ÎÞÇ°À¡²¹³¥
    x(1)=x(1)*a+k*b*u;
    if n>1
        x(2:n)=x(2:n)*a+x(1:n-1)*b;
    end
    y=x(n)+d;
    Y=[Y y];
    t=[t i*dt];
end

plot(t,Y);
[v1,v2,v3,v4,v5,v6,v7]=value(Y,dt);
legend(v7,4);
title('¶¯Ì¬Ê§ºâP¿ØÖÆT=12');