clc 
clear all;
c1=1;
c2=1;
r1=1;
r2=1;
num1=[1];
den1=[r1*c1 0];
sys1=tf(num1,den1);
num2=[c2*r2+c2*r1 1];
den2=[c2*r2 1];
sys2=tf(num2,den2);
sys3=feedback(sys1,sys2);
num4=[1];
den4=[c2*r2 1];
sys4=tf(num4,den4);
sys5=series(sys3,sys4);
[y]=step(sys5);
plot(y)