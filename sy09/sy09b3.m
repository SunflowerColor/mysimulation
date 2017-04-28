%高阶有自衡对象辨识
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

k=ys;

T04=ys*0.4;
T08=ys*0.8;
e04=zeros(lp,1);
e08=zeros(lp,1);
for i=1:lp
    e04(i)=[Y1(i)-T04]*[Y1(i)-T04];
    e08(i)=[Y1(i)-T08]*[Y1(i)-T08];
end
[e,pos4]=min(e04);
[e,pos8]=min(e08);
PT04=(pos4-1)*dt;
PT08=(pos8-1)*dt;
 
en=zeros(10,1);
for i=1:10
    en(i)=abs(1.075*PT04/(PT08-PT04)+0.5-sqrt(i));
end
[e,n]=min(en);
 
T=(PT04+PT08)/2.16/n;
 
a=exp(-dt/T);
b=1-a;
X=zeros(n,1);
r=1;
 
for i=1:lp
    X(1)=a*X(1)+k*b*r;
    if n>1
        for j=2:n
            X(j)=a*X(j)+b*X(j-1);
        end
    end
    t(i)=i*dt;
    Y2(i)=X(n);
end

U(1:lp)=u2-u1;
un=0;
dU=u2-u1;
k=k/dU;
Q=QV(Y,U,dt,k,T,n,un)
time1=etime(clock,TA);
