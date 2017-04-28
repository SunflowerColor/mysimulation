%递推最小二乘法
clc;
clear all;
close all;

k=1.5;
T=0.5;
n=1;

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
for i=n+1:lp
    for j=1:n
        H1(j)=-Y1(i-j);
        H1(j+n)=U(i-j);
    end
    Y1(i)=H1*xita;
end
plot(t,Y,t,Y1);


