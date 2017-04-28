clc;
close all;
clear all;
delta = 0.9;
ti = 60;
kp = 1/delta;
ki = 0;%1/(delta*ti);
K = 2;
T = 40;
dt = 1;
st = 1200;
lp = fix(st/dt);
a=exp(-dt/T);
b = 1-a;
r=1;
x(1:3)=0;
ui = 0;
y = [0];
t = [0];
for i=1:lp
    e = r-x(3);
    up = kp*e;
    ui = ui + ki*e*dt;
    u = up+ui;
    ux = u + r/K;
    x(1) = a*x(1)+K*b*ux;
    x(2:3) = a*x(2:3) + b*x(1:2);
    y = [y x(3)];
    t = [t i*dt];
end
plot(t,y,'k-','linewidth',3);
grid on;
[a,b,c,d,e,f,g] = value(y,t(2)-t(1));
legend(g,4);

    