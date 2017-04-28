%测量增益裕度和周期
clc;
clear all;
close all;

num=[1];
den=[4 4 1];
sysk=tf(num,den,'outputdelay',2);
[Gm,Pm,Wgm,Wpm]=margin(sysk);
kc=Gm;
t=0:0.01:40;
sys=feedback(sysk*kc,1);
Y=step(sys,t);
plot(t,Y);