clc;
close all;
clear all;
% load first_order;
load high_order;
y1 = y;
y2 = de_abnormal_1(y,10);

[ts,Mp,fai,tr,tp,ys,text]= value(y2,t(2)-t(1));
plot(t,y2,'y-','linewidth',5);
hold on;
[lp,m]=size(y2);
if m>lp
    lp = m;
end
dt = t(2)-t(1);
k=ys;
T=0;
Point_T040 = 0.40*ys;
Point_T080 = 0.80*ys;
slope = [0];
for i=2:lp
    slope(i-1) =(y2(i)-y2(i-1))/dt;
end
[se,pos] = max(slope);
S_Point = (pos-1) * dt;
err(1:lp)=0;
for i=1:lp
   err(i) = (y2(i)-Point_T040)^2;
end
[e40,pos40] = min(err);
T040 = (pos40-1)*dt;
err(1:lp)=0;
for i=1:lp
   err(i) = (y2(i)-Point_T080)^2;
end
[e80,pos80] = min(err);
T080 = (pos80-1)*dt;
order = [1,2,3,4,5,6,7,8,9,10];
err_n(1:10)=0;
for j=1:10
    err_n(j)=abs(sqrt(order(j))-((1.075*T040)/(T080-T040)+0.5));
end
[en,pos_n]=min(err_n);
n = pos_n;
T = (T040+T080)/(2.16*n);
x(1:n)=0;
y4=[];
a = exp(-dt/T);
b= 1-a;
for i=1:lp
    x(1)=a*x(1) + k*b;
    if n>=2
        x(2:n) = a*x(2:n) + b*x(1:n-1);
    end
    if n>1
         y4=[y4;x(n)];
    else
        y4 = [y4;x(1)];
    end
end
plot(t,y4,'k--','LineWidth',2);
Text_K = num2str(k);
Text_N = num2str(n);
Text_T = num2str(T);
Text_TNK = [Text_K,'/(1+',Text_T,')^',Text_N];
Legend('unknown system',Text_TNK,4);

    
    
    
        
        