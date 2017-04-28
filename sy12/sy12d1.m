%炉跟机协调控制
clc;
clear all;
close all;
dt=1;
st=1000;
lp=st/dt;
delta1=0.8;
ti1=35;
kp1=1/(delta1);
ki1=1/(delta1*ti1);
delta2=1.2;
ti2=153;
kp2=1/(delta2);
ki2=1/(delta2*ti2);
c1=0.5;
k1=1; T1=42; a1=exp(-dt/T1); b1=1-a1;
k2=0.4; T2=4; a2=exp(-dt/T2);b2=1-a2;
k3=0.6; T3=60; a3=exp(-dt/T3);b3=1-a3;
k4=1; T4=60; a4=exp(-dt/T4);b4=1-a4;
x(1:9)=0;
ui1=0;ui2=0;u21=0;
N=1;P=0;
for i=1:lp
    e1=N-x(8);
    e2=P-x(9);
    
    if (e2>c1) u21=0.1*e2-c1;end
    if (e2<-c1)u21=0.1*e2+c1;end
    e1=e1-u21;
 
    up1=kp1*e1;
    ui1=ui1+ki1*dt*e1;
    u1(i)=up1+ui1;
    
    up2=kp2*e2;
    ui2=ui2+ki2*dt*e2;
    u2(i)=up2+ui2;
    
    x(1)=a1*x(1)+k1*b1*u1(i);
    x(2)=a1*x(2)+1*b1*x(1);
    
    x(3)=a2*x(3)+k2*b2*u1(i);
    x(4)=a2*x(4)+1*b2*x(3);
    
    x(5)=a3*x(5)+k3*b3*u2(i);
    x(6)=a3*x(6)+1*b3*x(5);
    
    x(7)=a4*x(7)+k4*b4*u2(i);
    
    x(8)=x(2)+x(6);
    x(9)=x(7)-x(4);
    
    Ne(i)=x(8);
    Pt(i)=x(9);
    t(i)=i*dt;
end
figure(1)
plot(t,Ne,t,Pt)
legend('输出功率','机前压力')
title('炉跟机')
figure(2)
plot(t,u1,t,u2)
legend('主汽调节门','煤量')
title('炉跟机')
