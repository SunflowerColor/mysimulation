%增益裕度判据
clc;
clear all;
close all;
z=[];
p=[-1 -2 -1 -1];
k=1;
sysk=zpk(z,p,k);
sys=feedback(sysk,1);

zs=num2str(z);
ps=num2str(p);
text=['z=',zs,' p=',ps];

bode(sys);
grid on;
[Gm,Pm,Wgm,Wpm]=margin(sysk);
margin(sysk);
kgs=num2str(Gm);
rs=num2str(Pm);
text=['z=',zs,' p=',ps,' kg=',kgs,' r=',rs];
title(text);