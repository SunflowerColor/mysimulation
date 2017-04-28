%œ‡Ω«‘£∂»
clc;
clear all;
close all;
num=[1];
den=[1 0];
sys=tf(num,den);

nums=num2str(num);
dens=num2str(den);
text=['num=',nums,' den=',dens];

bode(sys);
%[Gm,Pm,Wgm,Wpm]=margin(sys);
margin(sys);
title(text);