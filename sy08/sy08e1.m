%最小二乘法辨识对象
clc;
clear all;
close all;

k=1.5;
T=0.5;
n=1;
N=1;

st=10;
dt=0.1;
lp=st/dt;

X=zeros(n,1);
a=exp(-dt/T);
b=1-a;

for i=1:lp
    U(i)=1+0.1*(rand()-0.5);
end

for i=1:lp
    X(1)=a*X(1)+k*b*U(i);
    if n>1
        X(2:n)=a*X(2:n)+b*X(1:n-1);
    end
    Y(i)=X(n)+0.2*(rand()-0.5);
    t(i)=i*dt;
end

H=zeros(lp-n,2*n);
Z=zeros(lp-n,1);
for i=n+1:lp
    for j=1:n
        H(i,j)=-Y(i-j);
        H(i,j+n)=U(i-j);
    end
    Z(i)=Y(i);
end

xita=inv(H'*H)*H'*Z;
Y1(1:n)=Y(1:n);

for i=n+1:lp
    for j=1:n
         H1(j)=-Y1(i-j);
         H1(j+n)=U(i-j);
    end
    Y1(i)=H1*xita;
end

for i=1:N
    num(1,i)=xita(N+i);
    den(1,i)=xita(i);
end

% num=[num 0];
% den=[1 den];
sys=tf(num,den,dt);
sysc=d2c(sys,'zoh');
[numc,denc]=tfdata(sysc,'v');
kt=numc(N);
Tt=(denc(1)/denc(N))^(1/n);

ks=num2str(kt);
Ts=num2str(Tt);
ns=num2str(N);
text1=['k=',ks,',T=',Ts,',n=',ns];

plot(t,Y,t,Y1);
title(text1)
