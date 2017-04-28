%一阶系统辨识
clc;
clear all;
close all;
load wtankjy;


TA=clock;
Y1=Y;
[lp,m]=size(Y1);
if lp<m
    lp=m;
end
[v1,v2,v3,v4,v5,v6,v7]=value(Y1,dt);
ys=v6;
T632=ys*0.632;

for i=1:lp
    err(i)=(Y1(i)-T632)*(Y1(i)-T632);
end
[e,p]=min(err);
T=p*dt;

U(1:lp)=u2-u1;
dU=u2-u1;
k=ys/dU;
Q=QV(Y,U,dt,k,T,1,0)
time1=etime(clock,TA);
    