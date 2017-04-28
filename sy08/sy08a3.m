
clc;
clear all;
close all;

load soutu1;

U=r;
tao=10;

st=1000;
dt=0.1;
lp=st/dt;

t(1:lp)=0:dt:st-dt;

Yr=zeros(lp,1);
for i=1:fix(tao/dt)
    Yr(i)=Y(i);
end
for i=fix(tao/dt)+1:lp
    Yr(i)=Y(i)+Yr(i-fix(tao/dt));
end

plot(t,Y,'k',t,Yr,'r--')
legend('Âö³åÇúÏß','½×Ô¾ÇúÏß');
Y=Yr;
save souu1 Y dt U;