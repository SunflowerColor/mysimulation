%递推最小二乘法
clc;
clear all;
close all;
 
load wtankjy;
TA=clock;
[lp,m]=size(Y);
if lp<m
    lp=m;
end

U(1:lp)=u2-u1;
t(1:lp)=0:lp-1;
t=t*dt;
 
lamda=1;
N=1;
xita=zeros(2*N,1);
I=eye(2*N);
P=10e10*I;
 
for i=N+1:lp
    for j=1:N
        h(j)=-Y(i-j);
        h(j+N)=U(i-j);
    end
    K=P*h'*inv(h*P*h'+lamda);
    xita=xita+K*(Y(i)-h*xita);
    P=1/lamda*(I-K*h)*P;
end
 
 
Y1(1:N)=Y(1:N);
for i=N+1:lp
    for j=1:N
        H1(j)=-Y1(i-j);
        H1(j+N)=U(i-j);
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
