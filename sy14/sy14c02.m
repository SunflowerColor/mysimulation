%饱和非线性仿真
clc;
close all;
clear all;
k =2;
T1 = 0.1;
T2=0.25;
dt = 0.001;
st = 10;
lp = fix(st/dt);
for i=1:lp
    r(i) = 1;
end
 
x1 = 0;
x2 = 0;
x3=0;
a1= exp(-dt/T1);
b1 = 1-a1;
a2 = exp(-dt/T2);
b2 = 1-a2;
y = [0];
t = [0];
e1 = 0;
le=[];
lde=[];
delta = 1;
u=0;
for i = 1:lp
    e = r(i)-x3;
    le=[le e];
    temp = (e-e1)/dt;
    lde = [lde temp];
 
    if abs(e)<=delta
        u=2*e;
    else
        u = 2*sign(e);
    end    
    x1 = x1 + dt*k*u;
    x2 = a1*x2 + b1*x1;
    x3= a2*x3+b2*x2;
    y = [y x3];
    t = [t i*dt];
    e1 = e;
end
ks=num2str(k);
subplot(2,1,1);
title(text);
plot(t,y);
[aa,bb,cc,dd,ee,ff,gg] = value(y,dt);
grid on;
legend(gg);
subplot(2,1,2);
ec = y-1;
plot(t,ec);
grid on;
text=['k=',ks];
