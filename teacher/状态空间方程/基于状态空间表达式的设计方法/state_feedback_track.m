clear all;
close all;
clc;
n=2;
num = [1.5];
den = [20 1 0];
[a,b,c,d] = tf2ss(num,den)
m = ctrb(a,b);
n = rank(m);
ts = 40;
fai = 20;
jieta = sol_jieta(fai);
wn = sol_wn(ts,jieta);
JR =-wn*jieta;
JI = j*wn*sqrt(1-jieta^2);
Ahat = [a zeros(n,1);-c 0];
Bhat = [b;0];
Chat = [c 0];
J = [5*JR JR+JI JR-JI ];
Khat = place(Ahat,Bhat,J)
K = Khat(1:n);
Kl= Khat(n+1);
a1 = [a-b*K -b*Kl;-c 0];
b1 = [zeros(n,1);1];
c1 =Chat ;
d1 = 0;
t = 0:0.1:50;
[y,t,x] =step(ss(a1,b1,c1,d1),t);
plot(t,y);
dd = Tvalue(y,0.1);
legend(dd,4);

