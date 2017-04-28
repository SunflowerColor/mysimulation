%最小二乘法辨识
clc;
clear all;
close all;
 
load wtankjy;

TA=clock;
[lp,m]=size(Y);
if lp<m
    lp=m;
end

n=1;
N=1;
U(1:lp)=u2-u1;
t(1:lp)=0:lp-1;
t=t*dt;
 
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

Q=0;
for i=1:lp
    Q=Q+(Y1(i)-Y(i))*(Y1(i)-Y(i));
end
Q=Q/lp;

for i=1:N
    num(1,i)=xita(N+i);
    den(1,i)=xita(i);
end

den=[1 den];
sys=tf(num,den,dt);
sysc=d2c(sys,'zoh');
[numc,denc]=tfdata(sysc,'v');
kt=numc(N+1)/denc(N+1);
Tt=(denc(1)/denc(N+1))^(1/N);

time1=etime(clock,TA);

ks=num2str(kt);
Ts=num2str(Tt);
ns=num2str(N);
Qs=num2str(Q);
text1=['k=',ks,',T=',Ts,',n=',ns,',Q=',Qs];
 
plot(t,Y,t,Y1);
title(text1)
