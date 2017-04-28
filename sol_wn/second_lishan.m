clc;
close all;
clear all;
dt = 0.1;
st = 20;
t=0:dt:st;
num = [1 1];
den = [1 1 1];
sys = tf(num,den);
y1 = step(sys,t);
lp = fix(st/dt);
x = zeros(2,1);
a = [0 1;-den(3) -den(2)];
b = [0;1];
c = [num(1) num(2)];
d = 0;
faiA = eye(2) + dt*a + dt^2/2*a*a;
y = [0];
faiM = (dt.*eye(2) + 0.5*dt^2.*a )*b;
for i = 1:lp
    x = faiA * x +  faiM;
    temp = c*x + d;
    y = [y temp];
end
plot(t,y1,t,y);