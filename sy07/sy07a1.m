clc;
clear all;
close all;

r=1;
kp=2;
ki=0;
k1=1;
Ty=0.1;

st=10;
dt=0.1;
lp=st/dt;

Y=zeros(lp,1);
t=zeros(lp,1);
ys=zeros(fix(Ty/dt),1);
xi=0;

for i=1:lp
    e=r-ys(1);
    xp=e*kp;
    xi=xi+e*ki*dt;
    u=xp+xi;
    x1=u*k1;
    ys(fix(Ty/dt))=x1;
    for j=1:fix(Ty/dt)-1
        ys(j)=ys(j+1);
    end
    Y(i)=ys(1);
    t(i)=dt*i;
end
[v1,v2,v3,v4,v5,v6,v7]=value(Y,dt);
plot(t,Y);
legend(v7,4)
