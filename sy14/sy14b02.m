%滞环特性响应曲线
clc;
clear all;
close all;
k=1;
T=10;
dt=0.1;
st=200;
r=1;
lp=fix(st/dt); 
a=exp(-dt/T);
b=1-a;
e0=0;
e2=[];
e3=[];   
x(1:2)=0;
t=[];
y=[];
h=0.1;
M=1;  
for i=1:lp
    e=r-x(2);
    e1=(e-e0)/dt;
    e0=e;
if e>=h
    u=M;
else if e>-h
        if e1>0
            u=-M;    
        else u=M;
        end
    else  u=-M;
    end
end
        
    x(1)=x(1)+u*dt;
    x(2)=a*x(2)+k*b*x(1);
    if i>1
e2=[e2 e];
e3=[e3 e1];
end
    y=[y x(2)];
    t=[t i*dt];
    
end
plot(t,y);
grid on;
title('滞环特性');
 
figure(2);
plot(e2,e3);
grid on;
title('滞环特性');
