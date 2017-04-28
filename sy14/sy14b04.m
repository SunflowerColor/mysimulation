%死区特性响应曲线
clc;
clear all;
close all;
dt=1;
st=100;
lp=st/dt;
k=0.1;
T=10;
a=exp(-dt/T);
b=1-a;
x(1:2)=0;
e0=0;
y1=[];
t1=[];
xx=[];
yx=[];
for i=1:lp
    r=1;
    e=r-x(2);
    e1=(e-e0)/dt;
    e0=e;
    if (e>=0.1);u=2;end
    if (e<-0.1);u=-2;end
    if (e>=-0.1 && e<0.1);u=0;end
    x(1)=x(1)+u*dt;
    x(2)=x(2)*a+k*b*x(1);
    y1=[y1 x(2)];
    t1=[t1 i*dt];
    xx=[xx e];
    yx=[yx e1];
end
xx=xx(2:end);
yx=yx(2:end);
figure(1)
plot(t1,y1);
title('死区特性')
figure(2)
plot(xx,yx);
title('死区特性相平面图');
