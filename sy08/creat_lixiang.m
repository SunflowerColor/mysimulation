clc;
clear all;
close all;

T=16;
k=2.3;
tao=1000;%脉冲持续的时间
n=3;
ubalance=1;%为0为有自衡，为1为无自衡

st=1000;
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

ks=num2str(k);
Ts=num2str(T);
ns=num2str(n);
text1=['k=',ks,',T=',Ts,',n=',ns];
plot(t,Y)
save sou3 Y dt text1 r;