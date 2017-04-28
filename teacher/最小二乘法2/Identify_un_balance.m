clc;
close all;
clear all;
load un_balance2;
y1 = y;
plot(t,y1,'y-','linewidth',3);
hold on;
[lp,m]=size(y1);
if m>lp
    lp = m;
end
dt = t(2)-t(1);
T=0;
count1 = 0;
slope = 0;
for i=lp:-1:fix(lp*0.95)
    slope = slope + (y1(i)-y1(i-1))/dt;
    count1 = count1+1;
end
slope = slope/count1;
k = slope;      
Oh =y1(lp) - (slope * lp*dt);
bias = -Oh;
Ota = bias /slope;
Ta = fix(Ota/dt);
Ob = y(Ta+1);
T = Ota;
[num]=k;
den=conv([1 0],[T 1]);
y3=step(num,den,t);
All_Err(1:lp) = 0;
for i=1:lp
    All_Err(i) = abs(y3(i)-y1(i));
end
Text_K = num2str(k);
Text_T = num2str(T);
Text_TNK = [Text_K,'/s(1+',Text_T,')'];
[Max_Err] = max(All_Err);
if Max_Err/k >0.5
    n = fix(1/(2*3.1415926)*(bias/Ob)^2-1/6);
    T = Ta/n*dt;
    x(1:n+1) = 0;
    aa = exp(-dt/T);
    bb = 1-aa;
    y3 = [];
    for i=1:lp
        x(1) = x(1) + k*dt;
        x(2:n+1) = aa*x(2:n+1) + bb*x(1:n);
        y3 = [y3 x(n+1)];
    end
     Text_T = num2str(T);
     Text_N = num2str(n);
    Text_TNK = [Text_K,'/s(1+',Text_T,')^',Text_N];   
end
plot(t,y3,'k-','linewidth',0.5);
Legend('unknown system',Text_TNK,4);
hold on;
yn = [];
tn = [];
for i = 0:fix(lp/10)
yn = [yn slope*10*dt*i-bias];
tn = [tn 10*dt*i];
end
plot(tn,yn,'k.','linewidth',0.5);
grid on;


    

