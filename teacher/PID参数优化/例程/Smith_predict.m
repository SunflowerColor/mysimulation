clc;
clear all;
close all;
delta=0.2;
ti=110;
kd=100;
k=0.45;
T=65;
tao=60;
n=2;
dt=0.1;
st=10*n*T;
lp=fix(st/dt);
m=fix(tao/dt);
de(1:m)=0;
a=exp(-dt/T);b=1-a;
ui=0;e0=0;
D(1:5000)=0;D(5001:lp)=1;
r=1;
x(1:n)=0;
%PID
y=[];t=[];
for i=1:lp
    e=r-x(2);
    ui=ui+e*dt/(delta*ti);
    up=e/delta;
    ud=kd*(e-e0)/dt;
    pid=ui+up+ud;
    e0=e;
    u(i)=pid+D(i);
    x(1)=a*x(1)+b*k*u(i);
    x(2)=a*x(2)+b*x(1);
    temp=de(m);
    for j=(m-1):-1:1
        de(m-j+1)=de(m-j);
    end
    de(1)=x(2);
    y=[y temp];
    t=[t i*dt];
end
%PI
x(1:n)=0;ui=0;de(1:m)=0;y1=[];t1=[];
for i=1:lp
    e=r-x(2);
    ui=ui+e*dt/(delta*ti);
    up=e/delta;
    u(i)=ui+up+D(i);
    x(1)=a*x(1)+b*k*u(i);
    x(2)=a*x(2)+b*x(1);
    temp=de(m);
    for j=(m-1):-1:1
        de(m-j+1)=de(m-j);
    end
    de(1)=x(2);
    y1=[y1 temp];
    t1=[t1 i*dt];
end
figure(1)
plot(t,y,t1,y1)
legend('PID控制','PI控制')
%微分先行
ti=100;kd=80;delta=0.1;
de(1:m)=0;
Td=100;Kd=0.1;
a1=exp(-dt/Td*Kd);b1=1-a1;
ui=0;e0=0;
r=1;
x(1:4)=0;
y2=[];t2=[];
udd=0;
for i=1:lp
    e=r-x(2);
    ui=ui+e*dt/(delta*ti);
    up=e/delta;
    ud=kd*(e-e0)/dt;
    pid=ui+up+ud;
    e0=e;
    u(i)=pid+D(i)-udd;
    x(1)=a*x(1)+b*k*u(i);
    x(2)=a*x(2)+b*x(1);
    temp=de(m);
    for j=(m-1):-1:1
        de(m-j+1)=de(m-j);
    end
    de(1)=x(2);
    y2=[y2 temp];
    t2=[t2 i*dt];
    x(4)=x(3);
    x(3)=a1*x(3)+b1*y(i);
    udd=Td*(x(3)-x(4))/dt;
end
figure(2)
plot(t,y,t2,y2)
legend('PID控制','微分先行控制')
%Smith预估
de(1:m)=0;
ui=0;e0=0;
x(1:n)=0;xs(1:n)=0;
delta=0.26;
ti=106;
y3=[];t3=[];
Ts=65;
as=exp(-dt/Ts);bs=1-as;
de_smith(1:m)=0;
feedback=0;
for i=1:lp
    e=r-feedback;
    ui=ui+e*dt/(delta*ti);
    up=e/delta;
    u(i)=ui+up+D(i);
    %smith通道
    xs(1)=as*xs(1)+k*bs*u(i);
    xs(2)=as*xs(2)+bs*xs(1);
    temp_smith=de_smith(m);
    for j=(m-1):-1:1
        de_smith(m-j+1)=de_smith(m-j);
    end
    de_smith(1)=xs(2);
    y_smith=xs(2)-temp_smith;
    x(1)=a*x(1)+b*k*u(i);
    x(2)=a*x(2)+b*x(1);
    temp=de(m);
    for j=(m-1):-1:1
        de(m-j+1)=de(m-j);
    end
    de(1)=x(2);
    y3=[y3 temp];
    t3=[t3 i*dt];
    feedback=y_smith+temp;
end
figure(3)
plot(t1,y1,t3,y3)
legend('PI控制','Smith预估')
