%无自衡对象辨识
clc;
clear all;
close all;
 
load wtankjy;
TA=clock;
Y1=Y;
[lp,m]=size(Y1);
 
if m>lp
    lp=m;
end
 
sum=0;
for i=lp:-1:fix(lp*0.95)
    sum=sum+(Y1(i)-Y1(i-1))/dt;
end
k=sum/(lp-fix(lp*0.95));
oh=Y1(lp)-k*dt*lp;
ota=-oh/k;
T=ota;
ta=fix(ota/dt);
ob=Y1(ta+1);
 
a=exp(-dt/T);
b=1-a;
y=0;
y1=0;
r=1;
n=1;
for i=1:lp
    y=a*y+k*b*r;
    y1=y1+y*dt;
    Y2(i)=y1;
    t(i)=i*dt;
end
 
err=zeros(lp,1);
for i=1:lp
    err(i)=abs(Y2(i)-Y(i));
end
 
[aerr]=max(err);
 
if aerr/k>0.5
    n=round(1/2/pi*(-oh/ob)*(-oh/ob)-1/6);
    if n<1
        n=1;
    end
    T=ota/n;
    aa=exp(-dt/T);
    bb=1-aa;
    X=zeros(n+1,1);
    for i=1:lp
        X(1)=a*X(1)+k*b*r;
        if n>1
            X(2:n)=aa*X(2:n)+bb*X(1:n-1);
        end
        X(n+1)=X(n+1)+X(n)*dt;
        Y2(i)=X(n+1);
    end
end
U(1:lp)=u2-u1;
dU=u2-u1;
k=k/dU;
Q=QV(Y,U,dt,k,T,n,1)
time1=etime(clock,TA);