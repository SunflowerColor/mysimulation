%×îÐ¡ÅÄ¿ØÖÆ
clc;
clear all;
close all;
dt=1;
t=0:dt:10*dt;
num=[2];
den=[20 1 0];
sys=tf(num,den);
GZ=c2d(sys,dt,'zoh')
fai=zpk([],[1],1,dt)
GZ1=inv(GZ)
DZ=series(GZ1,fai)
G=series(GZ,DZ)
sys=feedback(G,1);
step(sys,t);