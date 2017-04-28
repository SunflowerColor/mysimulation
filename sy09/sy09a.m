%数据处理
clc;
clear all;
close all;

load wtank;
Y=y;

sa=314;
en=842;
u1=6.5;
u2=7;

Y1(1:en-sa+1)=Y(sa:en);
U(1:en-sa+1)=u(sa:en);

[lp,m]=size(Y1);
if lp<m
    lp=m;
end

dt=2;

Y2=Y1;
for i=3:lp-2
    Y2(i)=(Y1(i-2)+Y1(i-1)+Y1(i)+Y1(i+1)+Y1(i+2))/5;
end

Y2=de_abnormal(Y2,10);

y0=Y2(1);
Y3=Y2-y0;

nzero=1;
Y4=Y3(1+nzero:lp);
U=U(1+nzero:lp);
t(1:lp)=0:lp-1;
t=t*dt;


t2(1:1481)=0:1480;
t2=t2*dt;

t1=t(1:lp-nzero);
% plot(t,Y1);
% hold on;
plot(t1,Y4);
% subplot(2,1,1)
% plot(t2,u)
% subplot(2,1,2)
% plot(t2,y)
Y=Y4;
save wtankjy Y dt u1 u2;

    