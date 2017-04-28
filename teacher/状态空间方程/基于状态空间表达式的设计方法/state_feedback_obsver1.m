close all;
clear all;
clc;
A = [ 0 1 0;0 0 1;0 -0.0015  -0.15];
B = [0;0;1];C = [0.002 0 0];D=0;

[num,den] = ss2tf(A,B,C,D);
sys = tf(num,den)
order = rank([B A*B A*A*B]);
J = [-0.1+j*0.1 -0.1-j*0.1 -1];      %expected poles
K = place(A,B,J);
% aa = a - b*K;
% bb = b*K(1);
% D = 0;
J1 = [-10 -1 -1];                           %expected observer poles
H = acker(A,B,J1);
a1 = [A  -B*K;H'*C  A-B*K-H'*C];
b1 = [B;B];
c1 = [C 0 0 0];
d1 = 0;
sys = ss(a1,b1,c1,d1);
t = 0:0.1:120;
[lp,m] = size(t);
if m>lp
    lp= m;
end
for i=1:lp
    u(i) = 1*K(1)/C(1) ;
end
[y,t,x] = lsim(sys,u,t);
[a11,bb,cd,dd,ee,ff,gg] = value(y,t(2)-t(1));
plot(t,y);
legend(gg,4);
