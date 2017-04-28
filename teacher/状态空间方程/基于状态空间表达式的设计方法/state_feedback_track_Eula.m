clear all;
close all;
clc;
n=2;
num = [1.5];
den = [20 1 0];
[a,b,c,d] = tf2ss(num,den)
m = ctrb(a,b);
n = rank(m);
ts = 10;
fai = 1;
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
Kl= -Khat(n+1);
dt = .1;
st = 50;
lp = fix(st/dt);
r = 1;
x1=zeros(n,1);
ie=0;
y = [];
uc = [];
t = [];
for i=1:lp
    e = r-c*x1;
    ie = ie + Kl*dt*e;    
    u = ie - K*x1;
    x0 = x1;
    [E0] = SF(K,a,b,c,u,x0);
    x1 = x0 + dt*E0;
     [E1] = SF(K,a,b,c,u,x1);
     E = (E0+E1)/2;
     x1 = x0 + dt*E;    
    y = [y c*x1];
    uc = [uc u];
    t = [t i*dt];
end
figure(1)
plot(t,y);
gg1 = Tvalue(y,dt);
legend(gg1,4);
figure(2)
plot(t,uc);
grid on;
