clc;
clear all;
close all;
r=1;
T=0.5;
mp=5;
ts=1.5;
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
t=0:0.01:5;
kc=3;
 
s=tf('s');
sys=kc*(s-zc)/(s-pc)/s/(T*s+1);
sys1=sys/(1+sys);
y=step(sys1,t);
[v1,v2,v3,v4,v5,v6,v7]=value(y,t(2)-t(1));
figure(1)
plot(t,y);
legend(v7,4);
figure(2)
rlocus(sys);
hold on;
plot(a,b,'ks',a,-b,'ks');
