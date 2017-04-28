%饱和特性响应曲线
clc;
clear all;
close all;
k=1;
T=10;
dt=1;
st=200;
lp=fix(st/dt);
a=exp(-dt/T);
b=1-a;
r=1;
x1=0;
xi=0;
ui=0;
e2=[];
e3=[];
e0=0;
t=[0];
y=[0];
for i=1:lp
    e=r-x1;
     e1=(e-e0)/dt; 
    e0=e;
    if e>1
        u=1;
    else if e>=-1
            u=e;
        else u=-1;
        end 
    end
    ui=ui+u*dt;
    x1=a*x1+k*b*ui;
    y=[y x1];
    t=[t i*dt];
    if i>1
    e2=[e2 e];e3=[e3 e1];
    end
end
plot(t,y);
grid on; 
title('饱和特性曲线'); 
hold on;
figure(2);
plot(e2,e3);
grid on;
title('饱和特性曲线');
