clc;
clear all;
close all;
u=1;h=0;k=100;b=0.01;y=[];dt=0.1;
t=[];
for i=1:10000
    %dh=k*u;
    dh=k*u-b*h;
    h=h+dh*dt;
    y=[y h];
    t=[t i*dt];
end
plot(t,y);