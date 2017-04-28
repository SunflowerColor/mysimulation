close all;
clear all;
clc;
n=3;
num = [20];
den = conv([10 1],conv([10 1],[10 1]));
[A,B,C,D] = tf2ss(num,den);
rank([A B;-C 0]);
Ahat = [A zeros(n,1);-C 0];
Bhat = [B;0];
Chat = [C 0];
J = [-0.05+j*0.05 -0.05-j*0.05 -1 -2];
Khat = place(Ahat,Bhat,J)
K = Khat(1:n);
Kl=-Khat(n+1);
a1 = [A-B*K B*Kl;-C 0];
b1 = [zeros(n,1);1];
c1 =Chat ;
d1 = 0;
t = 0:0.1:150;
[lp,m] = size(t);
if m>lp
    lp= m;
end
sys = ss(a1,b1,c1,d1);
[y,t,x] = step(sys,t);
y = y;
[aa,bb,cd,dd,ee,ff,gg] = value(y,t(2)-t(1));
plot(t,y);
legend(gg,4);
