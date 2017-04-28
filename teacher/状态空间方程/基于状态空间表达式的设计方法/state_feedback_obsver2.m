close all;
clear all;
clc;
n=3;
num = [20];
den = conv([20 1],conv([20 1],[10 1]));
[A,B,C,D] = tf2ss(num,den);
rank([A B;-C 0]);
Ahat = [A zeros(n,1);-C 0];
Bhat = [B;0];
Chat = [C 0];
J = [-0.05+j*0.05 -0.1-j*0.05 -1 -1.1];
Khat = acker(Ahat,Bhat,J)
K = Khat(1:n);
Kl=-Khat(n+1);
a1 = [A-B*K B*Kl;-C 0];
b1 = [zeros(n,1);1];
c1 =Chat ;
d1 = 0;

J1 = [-10 -10 -10 -10];                           %expected observer poles
H = acker(a1,b1,J1);
a2 = [a1  -b1*Khat;H'*c1  a1-b1*Khat-H'*c1];
b2 = [b1;b1];
c2 = [c1 0 0 0 0];
d2 = 0;
sys = ss(a2,b2,c2,d2);
t = 0:0.1:120;
[lp,m] = size(t);
if m>lp
    lp= m;
end
for i=1:lp
    u(i) = 1;
end
[y,t,x] = lsim(sys,u,t);
[a1,bb,cd,dd,ee,ff,gg] = value(y,t(2)-t(1));
plot(t,y);
legend(gg,4);



