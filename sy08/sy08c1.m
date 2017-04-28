%穷举法辨识对象
clc;
clear all;
close all;
load soutj2;

[lp,m]=size(Y);
if lp<m
    lp=m;
end

Kmax=4;
Kmin=1;
Tmax=40;
Tmin=10;
step=100;

QB=10e40;
u(1:lp)=1;
Khi=[];
Thi=[];
for i=Kmin:(Kmax-Kmin)/step:Kmax
    for j=Tmin:(Tmax-Tmin)/step:Tmax
        for n=2:2
            Q=QV(Y,u,dt,i,j,n);
            Khi=[Khi,i];
            Thi=[Thi,j];
            if QB>Q
                QB=Q;
                KB=i;
                TB=j;
                nB=n;
            end
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
