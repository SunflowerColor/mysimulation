%¥Û¡÷À„∑®
clc;
close all;
clear all;
K = 20;
T = 40;
dt =0.1;
tao = 20;
Tb = 50;

st = 500;
r=1;
lp =fix(st/dt);
m = fix(tao/dt);
if m==0
    m=1;
end
dm = zeros(1,m);
um = zeros(1,m+1);
x1 = 0;
da1 = exp(-dt/T); 
db1 = 1-da1;
a = exp(-dt/Tb); 
b1=(1-a)/(K*(1-exp(-dt/T)));
b2 = b1*a;
e = 0;e1=0;
y = [0];
u0 = [0];
t = [0];
for i = 1:lp
    e = r-dm(m);
    if i-1<1
        u1 = 0;
    else
        u1 = um(1);
    end
    if i-m-1<1
        u2 = 0;
    else
        u2 = um(m+1);
    end
    u = b1*e -b2*e1 + a*u1 + (1-a)*u2;
    u0 = [u0 u];
    for hh = m+1:-1:2
        um(hh) = um(hh-1);
    end
    um(1) = u;
    x1 = da1*x1 + K*db1*u;
    for hh = m:-1:2
        dm(hh) = dm(hh-1);
    end
    dm(1) = x1;
    e1 = e;
    y = [y dm(m)];
    t = [t i*dt];
end
plot(t,y);
[f1,f2,f3,f4,f5,f6,f7] = value(y,dt);
legend(f7,4);
Tbs=num2str(Tb);
text=['Tb=',Tbs];
title(text);
