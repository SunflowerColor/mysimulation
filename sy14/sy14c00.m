%计算临界增益
clc;
clear all;
close all;
sys1=tf(1,[0.1 1 0]);
sys2=tf(1,[0.25 1]);
sysk=sys1*sys2;
[Gm,Pm,a,b]=margin(sysk);
sys=feedback(sysk*Gm,1);
step(sys);