%随机法系统辨识
clc;
clear all;
close all;
load so1;

[lp,m]=size(Y);
if lp<m
    lp=m;
end

Kmax=4;
Kmin=1;
Tmax=40;
Tmin=10;
step=1000;

QB=10e40;
u(1:lp)=1;
Khi=[];
Thi=[];

for i=1:step
    for n=1:1
        k=rand()*(Kmax-Kmin)+Kmin;
        T=rand()*(Tmax-Tmin)+Tmin;
        Q=QV(Y,u,dt,k,T,n);
        Khi=[Khi,k];
        Thi=[Thi,T];
        if QB>Q
            QB=Q;
            KB=k;
            TB=T;
            nB=n;
        end
    end
end

ks=num2str(KB);
Ts=num2str(TB);
ns=num2str(nB);
text1=['k=',ks,',T=',Ts,',n=',ns];
plot(Khi,Thi,'+');
hold on;
plot(KB,TB,'r+','linewidth',5);
title(text1)