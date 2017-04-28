%串级控制
clc;
clear all;
close all;
dt=2;
st=16000;
lp=fix(st/dt);
d(1:fix(lp/2))=0;
d(fix(lp/2)+1:lp)=1;



kp1=0.32;
ki1=0.0015;
kp2=20;
ki2=0.0008;
n1=2;


k1=0.93;
T1=73.3;


n2=4;
k2=2.086;
T2=96.1;

%串级控制
t0=clock;
x=zeros(8,1);
r=1;
y=[0];
t=[0];

x=zeros(8,1);
aa_in=exp(-dt/T1);
bb_in=1-aa_in;

aa_out=exp(-dt/T2);
bb_out=1-aa_out;
y2=[0];

for i=1:lp
    e=r-x(8);
    up1=kp1*e;
    x(1)=x(1)+ki1*dt*e;
    u1=up1+x(1)-x(4);
    
    up2=kp2*u1;
    x(2)=x(2)+ki2*dt*u1;
    u2=up2+x(2)+d(i);
    x(3)=aa_in*x(3)+k1*bb_in*u2;
    x(4)=aa_in*x(4)+1*bb_in*x(3);
    x(5)=aa_out*x(5)+k2*bb_out*x(4);
    x(6)=aa_out*x(6)+1*bb_out*x(5);
    x(7)=aa_out*x(7)+1*bb_out*x(6);
    x(8)=aa_out*x(8)+1*bb_out*x(7);
    y=[y,x(8)];
    t=[t,i*dt];
end
t_k1=num2str(k1);
t_T1=num2str(T1);
t_sys=['K1=',t_k1,'   T1=',t_T1]
plot(t,y,'b')
[a,b,c,d,e,f,g]=value(y,t(2)-t(1))
hold on
plot(t,y,'b')
legend(t_sys,g,4)
title('串级控制')


%单回路控制
dt=2;
st=16000;
lp=fix(st/dt);
d(1:fix(lp/2))=0;
d(fix(lp/2)+1:lp)=1;


kp=0.4;
ki=0.0015;

n1=2;
k1=0.93;
T1=73.3;


n2=4;
k2=2.086;
T2=96.1;
a1=exp(-dt/T1);
b1=1-a1;
a2=exp(-dt/T2);
b2=1-a2;


t1=[];
y1=[];
x(1:6)=0;
ui=0;
r=1;
for i=1:lp
    e=r-x(6);
    up=kp*e;
    ui=ui+ki*dt*e;
    u=up+ui+d(i);
    x(1)=a1*x(1)+k1*b1*u;
    x(2)=a1*x(2)+1*b1*x(1);
    
    x(3)=a2*x(3)+k2*b2*x(2);
    x(4:6)=a2*x(4:6)+1*b2*x(3:5);
    y1=[y1,x(6)];
    t1=[t1,i*dt];
end
figure(2)
t_k1=num2str(k1);
t_T1=num2str(T1);
t_sys=['K1=',t_k1,'   T1=',t_T1]
plot(t1,y1)
hold on
plot(t1,y1)

[a1,b1,c1,d1,e1,f1,g1]=value(y1,t1(2)-t1(1))
legend(t_sys,g1,4)
title('单回路控制')


figure(3)
plot(t,y,'r');
hold on
plot(t1,y1)
legend('串级控制','单回路控制')
