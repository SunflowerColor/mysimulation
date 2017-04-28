clc;
close all;
clear all;
load first_order;
y1 = y;
y2 = de_abnormal(y,10);

[ts,Mp,fai,tr,tp,ys,text]= value(y2,t(2)-t(1));
plot(t,y2,'k-','linewidth',2);
hold on;
[lp,m]=size(y2);
if m>lp
    lp = m;
end
dt = t(2)-t(1);
k=ys;
T=0;
Point_T632 = 0.632*ys;
err(1:lp)=0;
for i=1:lp
   err(i) = (y2(i)-Point_T632)^2;
end
[e,pos] = min(err);
T = (pos-1)*dt;
x0=0;
y4=[];

a = exp(-dt/T);
b= 1-a;

for i=1:lp
    x0=a*x0 + k*b;
    y4=[y4;x0];
end
plot(t,y4,'r--','LineWidth',1);
    
    
    
        
        