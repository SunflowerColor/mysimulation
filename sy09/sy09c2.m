%随机法二次辨识
clc;
clear all;
close all;
load wtankjy;
TA=clock;
[lp,m]=size(Y);
if lp<m
    lp=m;
end
 
Kmax=18;
Kmin=10;
Tmax=370;
Tmin=220;
step=100;
 
QB=10e40;
u(1:lp)=u2-u1;
Khi=[];
Thi=[];
 
for i=1:step
    for n=1:1
        k=rand()*(Kmax-Kmin)+Kmin;
        T=rand()*(Tmax-Tmin)+Tmin;
        Q=QV(Y,u,dt,k,T,n,0);
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
 
time1=etime(clock,TA);
ks=num2str(KB);
Ts=num2str(TB);
ns=num2str(nB);
QBs=num2str(QB);
text1=['k=',ks,',T=',Ts,',n=',ns,',Q=',QBs];
plot(Khi,Thi,'+');
hold on;
plot(KB,TB,'r+','linewidth',5);
title(text1)
