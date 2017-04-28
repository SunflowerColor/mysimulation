%二阶有自衡对象辨识
clc;
clear all;
close all;
load soutj2;

Y1=Y;
[lp,m]=size(Y1);
if m>lp
    lp=m;
end

% [v1,v2,v3,v4,v5,v6,v7]=value(Y1,dt);
% ys=v6;
ys=0;
for i=lp-50:lp
    ys=ys+Y1(i);
end
ys=ys/50;
k=ys;

da=zeros(lp,1);
for i=2:lp
    da(i)=(Y1(i)-Y1(i-1))/dt;
end
da(1)=da(2);

[d,pp]=max(da);
bm=(ys-Y1(pp))/d;
no=Y1(pp)-d*pp;
ne=-no+Y1(pp);
bi=1;
% bm=(pm-pp)*dt;
T2=bm/(1+bi);
T1=bm-T2;

Y2=zeros(lp,1);
a1=exp(-dt/T1);
b1=1-a1;
a2=exp(-dt/T2);
b2=1-a2;
y1=0;
y2=0;
r=1;
for i=1:lp
    y1=a1*y1+k*b1*r;
    y2=a2*y2+b2*y1;
    Y2(i)=y2;
    t(i)=i*dt;
end

plot(t,Y,t,Y2)
ks=num2str(k);
T1s=num2str(T1);
T2s=num2str(T2);
text1=['k=2.3,T1=16,T2=16'];
text2=['k=',ks,',T1=',T1s,',T2=',T2s];
legend(text1,text2,4);
