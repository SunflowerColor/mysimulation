%绘制伯德图和奈奎斯特曲线
clc;
clear all;
close all;
num=[1];
den=[1 0];
sys=tf(num,den);
nums=num2str(num);
dens=num2str(den);
text=['num=',nums,' den=',dens];
figure(1)
bode(sys);
title(text);
figure(2)
nyquist(sys);
title(text);
