clc;
close all;
clear all;
dt = .05;
st = 400;
k = 1.1;
T = 20;
n = 2;
delta = 0.2*k*T;
ti = 0.3*n*T;
kp = 1/delta;
ki = 1/(delta*ti);
lp = fix(st/dt);
x = zeros(3,1);
r = 1;
y = [0];
t = [0];
a = [0 0 -ki; 1.1/20 -1/20 -1.1/20*kp; 0 1/20 -1/20];
b = [ ki; kp*1.1/20; 0];
c = [0 0 1];
d = 0;
nn = 20; 
FaiM = zeros(3);
for ii = 1:nn
    FaiM = FaiM + dt^ii/factorial(ii)*a^(ii-1);
end
Fai = eye(3) + FaiM*a;
FaiM = FaiM * b;

for i = 1:lp
    x = Fai*x + FaiM* r;
    temp = c*x + d*r;
    y = [y temp];
    t = [t i*dt];
end
t1 = clock;
aa = exp(-dt/T);
bb = 1-aa;
x1 = zeros(3,1);
y1 = [0];
for i=1:lp
    e = r-x1(3);
    up = kp*e;
    x1(1) = x1(1) + ki*dt*e;
    u = up+x1(1);
    x1(2) = aa*x1(2) + k*bb*u;
    x1(3) = aa*x1(3) + 1*bb*x1(2);
    y1 = [y1 x1(3)];
end
time1 = etime(clock,t1);
t2 = clock;
x = zeros(3,1);
y2 =[0];
for i=1:lp
    E = funRK_1(a,b,x,1);
    x = x + dt*E;
    temp= c*x;
    y2 = [y2 temp];
end
time2 =  etime(clock,t2);;
t3 = clock;
x = zeros(3,1);
y3 = [0];
for i=1:lp
    x0 = x;
    E1 = funRK_1(a,b,x,1);    
    x = x0 + dt*E1;
    E2 = funRK_1(a,b,x,1);
    E = (E1+E2)/2;
    x = x0 + dt*E;
    temp= c*x;
    y3 = [y3 temp];
end
time3= etime(clock,t3);
t4 = clock;
x = zeros(3,1);
y4 = [0];
for i=1:lp
    x0 = x;
    E1 = funRK_1(a,b,x,1);
    x = x0 + dt/2*E1;
    E2 = funRK_1(a,b,x,1);
    x = x0+dt/2*E2;
    E3 = funRK_1(a,b,x,1);
    x = x0+dt*E3;
    E4 = funRK_1(a,b,x,1);
    E = (E1+2*E2+2*E3+E4)/6;
    x = x0 + dt*E;
    temp = c*x;
    y4 = [y4 temp];
end
time4= etime(clock,t4);
plot(t,y,'k-',t,y1,'r-',t,y2,'g-',t,y3,'b-',t,y4,'y-','linewidth',2);
sum1 = 0;
 sum2 = 0;
 sum3 = 0;
sum4 = 0;
for i = 1:lp+1
    sum1 = sum1+(y(i)-y1(i))^2;
     sum2 = sum2+(y(i)-y2(i))^2;
    sum3 = sum3+(y(i)-y3(i))^2;
    sum4 = sum4+(y(i)-y4(i))^2;
end
sum1/lp
time1
sum2/lp
time2
 sum3/lp
 time3
 sum4/lp
    
    
    
    