%机跟炉协调控制
clc;
close all;
clear all;
dt=1;
st=1000;
lp=st/dt;
delta1=0.3;
ti1=100;
delta2=1;
ti2=200;
c2=8;
K1=0.4;T1=4; a1=exp(-dt/T1);b1=1-a1;
K2=1; T2=42; a2=exp(-dt/T2);b2=1-a2;
K3=1; T3=60; a3=exp(-dt/T3);b3=1-a3;
K4=0.6;T4=60;a4=exp(-dt/T4);b4=1-a4;
x(1:10)=0;
N=1;P=0; 
for i=1:lp
    e1=P-(x(2)+x(6));
    e2=N-(x(8)-x(4));
    u4=0.1*e2;
    if (e2>c2)  u4=8; end
    if (e2<-c2) u4=-8;end
    e1=u4+e1;
    x(9)=x(9)+e1*dt/delta1/ti1;
    u1(i)=e1/delta1+x(9);
    x(10)=x(10)+e2*dt/delta2/ti2;
    u2(i)=e2/delta2+x(10);
    if (u1(i)>8)u1(i)=8;  end
    if (u1(i)<-8)u1(i)=-8;end
    if (u2(i)>8)u2(i)=8;  end
    if (u2(i)<-8)u2(i)=-8;end
    uk1=u1(i);
    uk2=u2(i);
    x(1)=a1*x(1)+K1*b1*uk1;
    x(2)=a1*x(2)+b1*x(1);
    x(3)=a2*x(3)+K2*b2*uk1;
    x(4)=a2*x(4)+b2*x(3);
    x(6)=a3*x(6)+K3*b3*uk2;
    x(7)=a4*x(7)+K4*b4*uk2;
    x(8)=a4*x(8)+b4*x(7);
    Pt(i)=x(2)+x(6);
    Ne(i)=x(8)-x(4);
    t(i)=i*dt;
end
figure(1);
plot(t,Pt,t,Ne);
legend('机前压力','输出功率');
title('机跟炉');
figure(2);
plot(t,u1,t,u2);
grid on;
legend('煤量','汽轮机主汽门');
title('机跟炉');
