%滞后校正
clc;
clear all;
close all;

kc=10;
ypm=10;
num=[4];
den=[1 3 0];
jieta=0.4;

G=tf(num,den);
[Gm,Pm,Wgm,Wpm]=margin(G);
Pm=2*sin(jieta)*180/pi;
dPm=Pm+5;

[mag,phase,w]=bode(G*kc);
wcg=spline(phase(1,:),w',dPm-180);
magdb=20*log10(mag);
gr=-spline(w',magdb(1,:),wcg);
alpha=10^(gr/20);
T=10/alpha/wcg;
Gc=tf([alpha*T,1],[T,1]);

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
bode(Gk,'b');
hold on;
bode(GGck,'r');
grid on;
bode(Gc*kc,'g');
legend('校正前','校正后','校正环节');