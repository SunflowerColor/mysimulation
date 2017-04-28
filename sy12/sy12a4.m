%自适应smith预估
clc;
clear all;
close all;
T=20;
Ts=20;
k=2;
n=2;
tao=10;

num=[k];
den=[T*T 2*T 1];
sys=tf(num,den,'outputdelay',tao);
[Gm,Pm,Wgc,Wpc]=margin(sys);
kc=Gm;
tc=2*pi/Wgc;

Tv=0.12*tc;
Tn=0.5*tc;
kp=0.6*kc*0.3;
ki=kp/Tn;
kd=kp*Tv;



st=500;
dt=0.05;
lp=st/dt;

r=1;

d(1:lp)=0;
d(fix(lp*0.5):end)=1;
a=exp(-dt/T);
b=1-a;
m=fix(tao/dt)
de(1:m)=0;
x(1:n)=0;
ab(1:m)=0;
temp=0;
ui=0;
y4=[];
t4=[];  
Td1=6;
Td2=4;
kTd=Td1/Td2;
ktd=(Td2/Td1-1)*kTd;
dttd=Td2/100;
atd=exp(-dttd/Td2);
btd=1-atd;du1=0;
du2=0;
du=0;
qq=0;
for i=1:lp  
   e=r-qq;
   up=kp*e;
   ui=ui+ki*e*dt;
   upi=up+ui+d(i);
    x(1)=a*x(1)+b*(k*upi);
    if n>1                            %%%%%自适应Smith预估
        x(2:n)=a*x(2:n)+b*x(1:n-1);
    end
    temp1=de(m);
    for j=1:m-1
        de(m-j+1)=de(m-j);
    end
    de(1)=x(n);
    du1=1*kTd;
    du2=atd*du2+ktd*btd*1;
    du=du1+du2;
    qq=du*x(n);
    y4=[y4 temp1];
    t4=[t4 i*dt];
end
[ts4,mp4,fai4,tr4,tp4,ys4,v7]=value(y4,dt);
figure(4)
plot(t4,y4,'b');
title('自适应史密斯预估');
legend(v7,4);