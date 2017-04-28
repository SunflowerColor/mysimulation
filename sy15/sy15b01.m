%×´Ì¬¹Û²âÆ÷
clear all;
close all;
clc;
num = [2];
den = [40 1 0];

r = ones(fix(50/0.1)+1,1);
num1 = num./den(1);
den1 = den./den(1);
a = [0 1;0 -den1(2)];
b = [0;1];
c = [num1(1) 0];
d = 0;

m = ctrb(a,b);
n = rank(m);
ts = 10;
fai = 10;
jieta = sol_jieta(fai);
wn = sol_wn(ts,jieta);
JR =-wn*jieta;
JI = j*wn*sqrt(1-jieta^2);
J = [JR+JI JR-JI ];
K = place(a,b,J);

J1 = [-10 -1];                           %expected observer poles
H = acker(a,b,J1);
a1 = [a  -b*K;H'*c  a-b*K-H'*c];
b1 = [b;b];
c1 = [c 0 0];
d1 = 0;
sys = ss(a1,b1,c1,d1);
t = 0:0.1:120;
[lp,m] = size(t);
if m>lp
    lp= m;
end
for i=1:lp
    u(i) = 1*K(1)/c(1) ;
end
[y,t,x] = lsim(sys,u,t);
[a1,bb,cd,dd,ee,ff,gg] = value(y,t(2)-t(1));
plot(t,y);
legend(gg,4);
