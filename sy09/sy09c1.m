%穷举法二次辨识
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
for i=Kmin:(Kmax-Kmin)/step:Kmax
    for j=Tmin:(Tmax-Tmin)/step:Tmax
        for n=1:2
            Q=QV(Y,u,dt,i,j,n,0);
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
