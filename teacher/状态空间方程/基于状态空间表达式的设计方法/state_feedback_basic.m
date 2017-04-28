clear all;
close all;
clc;
num = [2];
den = [20 1 0];
% [a,b,c,d] = tf2ss(num,den);
r = ones(fix(50/0.1)+1,1);
num1 = num./den(1);
den1 = den./den(1);
a = [0 1;0 -den1(2)];
b = [0;1];
c = [num1(1) 0];
d = 0;
%r = ones(fix(50/0.1)+1,1).*(k(1)/c(1));
m = ctrb(a,b);
n = rank(m);
ts = 10;
fai = 10;
jieta = sol_jieta(fai);
wn = sol_wn(ts,jieta);
JR =-wn*jieta;
JI = j*wn*sqrt(1-jieta^2);
J = [JR+JI JR-JI ];
k = place(a,b,J);

a1 = a-b*k;
b1 = b;
c1 = c;
d1 = 0; 
t = 0:0.1:50;
[y,t,x] = lsim(ss(a1,b1,c1,d1),r,t);

plot(t,y);
dd = Tvalue(y,0.1);
legend(dd,4);