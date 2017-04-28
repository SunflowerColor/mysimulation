%非线性阻尼控制
clc;
clear all;
close all;

k=2;
T=1;
xian=0;

st=20;
dt=0.01;
lp=st/dt;

r=1;
x(1:2)=0;
a=exp(-dt/T);
b=1-a;
y=0;
t=[];
Y=[];
y0=0;
y1=0;

for i=1:lp
    e=r-y1;
    x(1)=x(1)*a+k*e*b;
    x(2)=x(2)+x(1)*dt;
    if x(2)<-xian
        y=x(2)+xian;
    else if x(2)>xian
        y=x(2)-xian;
        else
            y=0;
        end
    end
    y1=(y-y0)/dt+x(2);
    y0=y;
    Y=[Y x(2)];
    t=[t i*dt];
end
[v1,v2,v3,v4,v5,v6,v7]=value(Y,dt);
plot(t,Y);
legend(v7,4);
        