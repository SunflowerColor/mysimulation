function [Q,t,y,dt]=Qpid(kp,ki,k,T,n,r,tao)
dt=T/10; 
st=8*n*T;
lp=fix(st/dt);
y=[0];
t=[0];
x(1:n)=0;
u=0;
a=exp(-dt/T);
b=1-a;
cu=[0];
t=[0];
kiu=0;
Q=0;
for i=1:lp
    e=r-x(n);
    Q=Q+e*e*dt;
    kpu=kp*e;
    kiu=kiu+ki*e*dt;
    u=kpu+kiu;
    x(1)=a*x(1)+k*b*u;
    if n>=2
        x(2:n)=a*x(2:n)+b*x(1:n-1);
    end
    y=[y x(n)];
    t=[t i*dt];
    cu=[cu u];
end