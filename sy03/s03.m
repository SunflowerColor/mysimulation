clc;
clear all;
close all;
s=tf('s');
t=0:0.01:5;
sys1=1.05/(s*s+s+1)/(0.5*s+1)/(0.125*s+1)*(0.150*s+1);
sys2=1.05/(s*s+s+1)/(0.5*s+1);
y1=step(sys1,t);
y2=step(sys2,t);
[a,b,c,d,e,f,g1]=value(y1,t(2)-t(1));
[a,b,c,d,e,f,g2]=value(y2,t(2)-t(1));
plot(t,y1,'b',t,y2,'r--');
legend(g1,g2,4);
% title('G(s)=1.05/(s*s+s+1)/(0.5*s+1)');