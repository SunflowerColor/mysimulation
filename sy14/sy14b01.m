%继电特性响应曲线
clc;
clear all;
close all;
k=1;   
T=10;
dt=0.1;
st=100;
lp=fix(st/dt);      
a=exp(-dt/T);
b=1-a;
x(1:2)=0;
t=[];
y=[];
yz=[];
h=0.5;
r=1;M=1;e0=0;e2=[];e3=[];
for i=1:lp
    e=r-x(2);%误差 
    e1=(e-e0)/dt;%误差的导数
    e0=e;
    if e>h
    u=M;
else if e>=-h
        u=0;  
    else u=-M;
    end
end
    x(1)=x(1)+u*dt;
    x(2)=a*x(2)+k*b*x(1);
    y=[y x(2)];
    t=[t i*dt];
    if i>1
     e2=[e2 e];e3=[e3 e1];
    end
end
plot(t,y,'r');grid on;
 
 
hold on;
k=1;
T=20;
dt=0.1;
st=100;
lp=fix(st/dt);      
a=exp(-dt/T);
b=1-a;
x(1:2)=0;
t1=[];
y1=[];
r=1;
M=1;
e0=0;
e4=[];
e5=[];
for i=1:lp
    e=r-x(2);
    e1=(e-e0)/dt;
    e0=e;
    if e>=0
    u=M; 
else u=-M;
end
    x(1)=x(1)+u*dt;
    x(2)=a*x(2)+k*b*x(1);
    y1=[y1 x(2)];
    t1=[t1 i*dt];
    if i>1
     e4=[e4 e];e5=[e5 e1];
    end
end
plot(t1,y1);
legend('一般继电特性','理想继电特性');
 
hold on;
figure(2);
plot(e2,e3,'r',e4,e5,'b');
legend('一般继电特性','理想继电特性');
title('继电特性相平面图')
grid on;
