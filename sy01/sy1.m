clc 
clear all;
close all;
c1=1;
c2=1;
r1=1;
r2=1;
num1=[1];
den1=[r1*c1*r2*c2 r1*c1+r2*c2+r1*c2 1];
sys1=tf(num1,den1);
[y]=step(sys1);
%plot(y);
bode(sys1)