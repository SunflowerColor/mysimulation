clc;
clear all;
close all;
kp=3;
ki=5;
k=1;
T=1;
Ty=0.01;
r=1;

st=50;
dt=0.01;
lp=fix(st/dt);

xi=0;
y=0;
x1=0;
ys=zeros(fix(Ty/dt),1);

for i=1:lp
    e=r-ys(1);
    xp=kp*e;
    xi=xi+ki*e*dt;
    u=xp+xi;
    x1=x1+(k*u-x1)/T*dt;
    ys(fix(Ty/dt))=x1;
    for j=1:fix(Ty/dt)-1
        ys(j)=ys(j+1);
    end
    Y(i)=ys(1);
    t(i)=i*dt;
end
Tys=num2str(Ty);
text=['tao=',Tys];
[v1,v2,v3,v4,v5,v6,v7]=value(Y,dt);
plot(t,Y)
legend(v7,4);
title(text);
    