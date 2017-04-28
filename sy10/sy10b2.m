%奈奎斯特曲线判据
clc;
clear all;
close all;
z=[-2];
p=[0.5 0];
k=1;
sysk=zpk(z,p,k);
sys=feedback(sysk,1);
zs=num2str(z);
ps=num2str(p);
text=['z=',zs,' p=',ps];
figure(1)
step(sys);
title(text);
figure(2)
nyquist(sysk);
title(text);
figure(3)
% bode(sysk);
[Gm,Pm,Wgm,Wpm]=margin(sysk);
margin(sysk);
kgs=num2str(Gm);
rs=num2str(Pm);
text=['z=',zs,' p=',ps,' kg=',kgs,' r=',rs];
title(text);