%辨识一阶有自衡对象
clc;
clear all;
close all;
load so1;

Y1=Y;
[lp,m]=size(Y1);
if m>lp
    lp=m;
end

[v1,v2,v3,v4,v5,v6,v7]=value(Y1,dt);
ys=v6;
% for i=lp-10:lp
%     ys=ys+Y1(i);
% end
% ys=ys/10;
k=ys;
aT=ys*0.632;
er=zeros(lp,1);
t=zeros(lp,1);
for i=1:lp
    er(i)=(Y1(i)-aT)*(Y1(i)-aT);
end
[e,fi]=min(er);
T=(fi-1)*dt;

a=exp(-dt/T);
b=1-a;
r=1;
y=0;
for i=1:lp
    y=a*y+k*b*r;
    Y2(i)=y;
    t(i)=dt*i;
end
plot(t,Y,t,Y2)
ks=num2str(k);
Ts=num2str(T);
text1=['k=2.3,T=16'];
text2=['k^=',ks,',T^=',Ts];
legend(text1,text2,4);

