clc;
clear all;
close all;
st=3000;
dt=10;
dtb=0.001;
lp=fix(st/dt);
lpb=fix(st/dtb);
lpk=fix(lpb/lp);

r=1;
kp1=0.32;
ki1=0.0015;
kp2=20;
ki2=0.0008;
k1=0.93;
T1=73.3;
k2=2.086;
T2=96.1;

a=[ 0 0 0 0 0 0 0 -ki1;
    ki2 0 0 -ki2 0 0 0 -kp1*ki2;
    kp2*k1/T1 k1/T1 -1/T1 -kp2*k1/T1 0 0 0 -kp1*kp2*k1/T1;
    0 0 1/T1 -1/T1 0 0 0 0;
    0 0 0 k2/T2 -1/T2 0 0 0;
    0 0 0 0 1/T2 -1/T2 0 0;
    0 0 0 0 0 1/T2 -1/T2 0;
    0 0 0 0 0 0 1/T2 -1/T2 ];
b=[ki1; kp1*ki2; kp1*kp2*k1/T1;  0;0;0;0;0;];
c=[0 0 0 0 0 0 0 1];
d=zeros(1,8);

x=zeros(8,1);
t=zeros(lp,1);
y=zeros(lp,1);
% tb=zeros(lpb,1);
% faiM=zeros(8);
% nn=20;
% for ii=1:20
%     faiM=faiM+dtb^ii/factorial(ii)*a^(ii-1);
% end
% fai=eye(8)+faiM*a;
% faiM=faiM*b;
% 
% for i=1:lpb
%     tb(i)=i*dtb;
%     x=fai*x+faiM*r;
%     y(i)=c*x;
% end
% save standard1 tb y
load standard1

x=zeros(8,1);
y1=zeros(lp,1);
aa1=exp(-dt/T1);
bb1=1-aa1;
aa2=exp(-dt/T2);
bb2=1-aa2;

t1=clock;
for i=1:lp
    t(i)=i*dt;
    e1=r-x(8);
    x(1)=x(1)+ki1*dt*e1;
    u1=x(1)+kp1*e1;
    e2=u1-x(4);
    x(2)=x(2)+e2*ki2*dt;
    u2=x(2)+e2*kp2;
    x(3)=aa1*x(3)+k1*bb1*u2;
    x(4)=aa1*x(4)+bb1*x(3);
    x(5)=aa2*x(5)+bb2*k2*x(4);
    x(6)=aa2*x(6)+bb2*x(5);
    x(7)=aa2*x(7)+bb2*x(6);
    x(8)=aa2*x(8)+bb2*x(7);
    y1(i)=x(8);
end
time1=etime(clock,t1);

x=zeros(8,1);
y2=zeros(lp,1);

t2=clock;
for i=1:lp
    E=a*x+b*r;
    x=x+dt*E;
    y2(i)=c*x;
end
time2=etime(clock,t2);

x=zeros(8,1);
y3=zeros(lp,1);

t3=clock;
for i=1:lp
    x0=x;
    E1=a*x+b*r;
    x=x0+dt*E1;
    E2=a*x+b*r;
    E=(E1+E2)/2;
    x=x0+dt*E;
    y3(i)=c*x;
end
time3=etime(clock,t3);

x=zeros(8,1);
y4=zeros(lp,1);

t4=clock;
for i=1:lp
    x0=x;
    E1=a*x+b*r;
    x=x0+dt/2*E1;
    E2=a*x+b*r;
    x=x0+dt/2*E2;
    E3=a*x+b*r;
    x=x0+dt*E3;
    E4=a*x+b*r;
    E=(E1+2*E2+2*E3+E4)/6;
    x=x0+dt*E;
    y4(i)=c*x;
end
time4=etime(clock,t4);

x=zeros(8,1);
y5=zeros(lp,1);

t5=clock;
for i=1:lp
    e1=r-x(8);
    x(1)=x(1)+ki1*dt*e1;
    u1=x(1)+kp1*e1;
    e2=u1-x(4);
    x(2)=x(2)+e2*ki2*dt;
    u2=x(2)+e2*kp2;
    x(3)=x(3)+(k1*u2-x(3))/T1*dt;
    x(4)=x(4)+(x(3)-x(4))/T1*dt;
    x(5)=x(5)+(k2*x(4)-x(5))/T2*dt;
    x(6)=x(6)+(x(5)-x(6))/T2*dt;
    x(7)=x(7)+(x(6)-x(7))/T2*dt;
    x(8)=x(8)+(x(7)-x(8))/T2*dt;
    y5(i)=x(8);
end
time5=etime(clock,t5);

sum1=0;
sum2=0;
sum3=0;
sum4=0;
sum5=0;
for i = 1:lp
    sum1=sum1+(y(i*lpk)-y1(i))^2;
    sum2=sum2+(y(i*lpk)-y2(i))^2;
    sum3=sum3+(y(i*lpk)-y3(i))^2;
    sum4=sum4+(y(i*lpk)-y4(i))^2;
    sum5=sum5+(y(i*lpk)-y5(i))^2;
end


sum1=sum1/lp;
sum2=sum2/lp;
sum3=sum3/lp;
sum4=sum4/lp;
sum5=sum5/lp;
sum1s=num2str(sum1);
sum2s=num2str(sum2);
sum3s=num2str(sum3);
sum4s=num2str(sum4);
sum5s=num2str(sum5);
time1s=num2str(time1);
time2s=num2str(time2);
time3s=num2str(time3);
time4s=num2str(time4);
time5s=num2str(time5);
text0=['standard'];
text1=['t=',time1s,' sum=',sum1s];
text2=['t=',time2s,' sum=',sum2s];
text3=['t=',time3s,' sum=',sum3s];
text4=['t=',time4s,' sum=',sum4s];
text5=['t=',time5s,' sum=',sum5s];
dts=num2str(dt);
testt=['dt=',dts];
plot(tb,y,t,y1,t,y2,t,y3,t,y4,t,y5);
legend(text0,text1,text2,text3,text4,text5,4);
title(testt);


    