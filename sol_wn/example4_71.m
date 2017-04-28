close all;
clear all;
clc;
kp = 40;
ki = 70;
sys1 = tf([kp],[1]);
sys2 = tf([ki],[1 0]);
sys3 = tf([1],conv([1 2],[1 8]));
sysc = parallel(sys1,sys2);
sysn = series(sysc,sys3);
sys = feedback(sysn,1);
t = 0:0.01:10;
y=step(sys,t);
plot(t,y,'k-','linewidth',2);
[dd1,dd2,dd3,dd4,dd5,dd6,dd7] = value(y,t(2)-t(1));
legend(dd7,4);
grid on;