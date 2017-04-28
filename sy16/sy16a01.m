clc;
clear all;
close all;
load PIDdt10;
subplot(2,1,1)
plot(tt,u);
grid on;
title('PID输出u');
subplot(2,1,2)
plot(tt,y);
grid on;
title('系统输出y');