%制作方波脉冲响应曲线
clc;
clear all;
close all;

T=16;
k=2.3;
tao=10;%脉冲持续的时间
n=1;
ubalance=1;%为0为有自衡，为1为无自衡

st=100;
dt=0.1;
lp=st/dt;

r=zeros(lp,1);
r(1:fix(tao/dt),1)=1;

t=zeros(lp,1);
Y=zeros(lp,1);
x=zeros(n+1,1);
a=exp(-dt/T);
b=1-a;
for i=1:lp
    x(1)=a*x(1)+k*b*r(i);
    if n>1
        x(2:n)=a*x(2:n)+b*x(1:n-1);
    end
    if ubalance==1
        x(n+1)=x(n+1)+dt*x(n);
        Y(i)=x(n+1);
    else Y(i)=x(n);
    end
    t(i)=i*dt;
end


bili=0.2*rand();%bili为噪声的最大值
%染噪声
for i=1:lp
    Y(i)=Y(i)+bili*(rand()-0.5);
end
%加入异常点
for i=1:lp
    if rand()>0.998
        Y(i)=10*Y(i);
    end
end
ks=num2str(k);
Ts=num2str(T);
ns=num2str(n);
text1=['k=',ks,',T=',Ts,',n=',ns];
plot(t,Y)
title(text1)
save sysoutu3 Y dt r text1;