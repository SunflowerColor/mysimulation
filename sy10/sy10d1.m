%超前校正
clc;
clear all;
close all;

kc=1;
ypm=10;
num=[1];
den=[1 1 0];
sys=tf(num,den);
[Gm,Pm,Wgm,Wpm]=margin(sys*kc);
[mag,pha,w]=bode(sys*kc);
Mag=20*log10(mag);

phi=(ypm-Pm)*pi/180+10;
alpha=(1+sin(phi))/(1-sin(phi));
Mn=-10*log10(alpha);
Wcgn=spline(Mag,w,Mn);
T=1/Wcgn/sqrt(alpha);
Tz=alpha*T;
Gc=tf([Tz,1],[T,1]);
G=sys;
G=G*kc;
GGc=G*Gc;
Gk=feedback(G,1);
GGck=feedback(GGc,1);
figure(1)
step(Gk,'b');
hold on;
step(GGck,'r');
grid on;
legend('校正前','校正后',4);
figure(2)
bode(G,'b');
hold on;
bode(GGc,'r');
grid on;
bode(Gc*kc,'g');
legend('校正前','校正后','校正环节');