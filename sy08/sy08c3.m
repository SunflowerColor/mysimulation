%混沌法系统辨识
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
step=10000;

QB=10e40;
u(1:lp)=1;
Khi=[];
Thi=[];
temp1=rand();
temp2=rand();
for i=1:step
    for n=1:1
        temp1=4.0*temp1*(1-temp1);
        temp2=4.0*temp2*(1-temp2);
        k=temp1*(Kmax-Kmin)+Kmin;
        T=temp2*(Tmax-Tmin)+Tmin;
        Q=QV(Y,u,dt,k,T,n);
        Khi=[Khi,k];
        Thi=[Thi,T];
        if QB>Q
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