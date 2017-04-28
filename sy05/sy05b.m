clc;
clear all;
close all;
r=1;
T=0.5;
mp=5;
ts=1.5;
% jieta = sqrt(1/(1/((log(mp/100)/pi)^2)+1));
% wn =3/(jieta *ts);
% a = -jieta*wn;
% b = wn*sqrt(1-jieta^2);
a=-1.95;
b=2.28;
p0=a+b*1i;
p1=0;
p2=-1/T;
anx=angle(p0-p1)+angle(p0-p2)-pi;
anp0=angle(p0);
anzc=anx/2+anp0/2;
anpc=anp0/2-anx/2;
zc=a-b/tan(anzc);
pc=a-b/tan(anpc);
kc=1/(abs((p0-zc)/(p0-pc))*abs(1/p0/(T*p0+1)));
kc=3;

st=5;
dt=0.01;
lp=st/dt;

x1=0;
x2=0;
x3=0;
x4=0;
for i=1:lp
    e=r-x4;
    x1=x1+((pc-zc)*e+x1*pc)*dt+e;
    x2=x2+(x1+pc*x2)*dt;
    x3=x3+x2*dt;
    x4=x4+(kc*x3-x4)/T*dt;
    y(i)=x4;
    t(i)=i*dt;
end


s=tf('s');
sys=kc*(s-zc)/(s-pc)/s/(T*s+1);
sys1=sys/(1+sys);
[v1,v2,v3,v4,v5,v6,v7]=value(y,dt);
figure(1)
plot(t,y);
legend(v7,4);
figure(2)
rlocus(sys);
hold on;
plot(a,b,'ks',a,-b,'ks');
