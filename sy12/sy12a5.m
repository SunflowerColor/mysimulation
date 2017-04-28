%大迟延系统全控制
clc;
clear all;
close all;
n=2;
k=2;
T=20;
tao=10;


kp=0.4219;
ki=0.0129;
kd=3.3130;
dt=0.1;
st=30*n*T;
lp=fix(st/dt);
r=1;
d(1:fix(lp/2))=0;
d(fix(lp/2)+1:lp)=1;
a=exp(-dt/T);
b=1-a;
%PID控制***************************************
x(1:2)=0;
ui=0;%为了积分控制作准备
dn=fix(tao/dt);%为了迟延环节做准备
delay=zeros(dn,1);
e0=0;%这是为了微分控制做准备
temp=0;
y=[];
t=[];

for i=1:lp
    e=r-temp;
    up=kp*e;
    ui=ui+ki*dt*e;
    ud=kd*(e-e0)/dt;
    pid=up+ui+ud;
    u=pid+d(i);
    e0=e;
    x(1)=a*x(1)+k*b*u;
    x(2)=a*x(2)+b*x(1);
    temp=delay(dn);
    for kk=dn:-1:2
        delay(kk)=delay(kk-1);
    end
    delay(1)=x(2);
    y=[y,temp];
    t=[t,i*dt];
end
figure(1)
plot(t,y);
legend('PID')

hold on;

%PI控制*******************************************
x(1:2)=0;
ui=0;%为了积分控制作准备
dn=fix(tao/dt);%为了迟延环节做准备
delay=zeros(dn,1);
e0=0;%这是为了微分控制做准备
temp=0;
y1=[];
t1=[];
for i=1:lp
    e=r-temp;
    up=kp*e;
    ui=ui+ki*dt*e;
    ud=0*kd*(e-e0)/dt;%去掉了微分作用
    pid=up+ui%+ud;
    u=pid+d(i);
    e0=e;
    x(1)=a*x(1)+k*b*u;
    x(2)=a*x(2)+b*x(1);
    temp=delay(dn);
    for kk=dn:-1:2
        delay(kk)=delay(kk-1);
    end
    delay(1)=x(2);
    y1=[y1,temp];
    t1=[t1,i*dt];
end
plot(t1,y1,'r');
legend('PID控制','PI控制');
%y为PID控制，y1为PI控制

%微分先行**************************************
%方式1
%加入一个超前环节（Td1s+1）/(Td2s+1),其中Td1>Td2
%上述环节可拆解成（Td1/Td2）+(1-Td1/Td2)/(Td2s+1)
%方式2
%加入1+Tds
r=1;
x(1:2)=0;
ui=0;%为了积分控制作准备
dn=fix(tao/dt);%为了迟延环节做准备
delay=zeros(dn,1);
e0=0;%这是为了微分控制做准备
temp=0;
y2=[];
t2=[];
%对微分先行环节做处理
x(3:4)=0;
ufd=0;%微分先行环节的输出
%方式1
Td1=5;
Td2=4;
kfd=Td1/Td2;
kf=1-kfd;
af=exp(-1/100);%要根据环节不同来调整这个值，否则不易调稳定
bf=1-af;
%方式2
% Td=100;Kd=0.1;
% a1=exp(-dt/Td*Kd);
% b1=1-a1;
%第一种方式相同
% Td1=6;
% Td2=4;
% kTd=Td1/Td2;
% ktd=(Td2/Td1-1)*kTd;
% dttd=Td2/100;
% atd=exp(-dttd/Td2);btd=1-atd;
% du1=0;
% du2=0;
% ufd=0;





for i=1:lp
    e=r-ufd;
    up=kp*e;
    ui=ui+ki*dt*e;
    ud=kd*(e-e0)/dt;
    pid=up+ui+ud;
    u=pid+d(i);
    e0=e;
    x(1)=a*x(1)+k*b*u;
    x(2)=a*x(2)+b*x(1);
    temp=delay(dn);
    for kk=dn:-1:2
        delay(kk)=delay(kk-1);
    end
    delay(1)=x(2);
    
    x(3)=kfd*temp;
    x(4)=af*x(4)+kf*bf*temp;
ufd=x(3)+x(4);
    
%      x(4)=x(3);
%     x(3)=a1*x(3)+b1*temp;
%     ufd=Td*(x(3)-x(4))/dt;


%   du1=temp*kTd;
%     du2=atd*du2+ktd*btd*temp;
%     ufd=du1+du2;



    y2=[y2,temp];
    t2=[t2,i*dt];
end
figure(2)
plot(t2,y2,'y','linewidth',2);
hold on
plot(t,y,'r--');
plot(t1,y1,'k');
legend('微分先行','PID控制','PI控制')

%Smith预估********************************************
delta=0.5;%我将0.2变为0.5
ti=110;
kp=1/delta;
ki=1/(delta*ti);
kd=100;
x(1:2)=0;
ui=0;%为了积分控制作准备
dn=fix(tao/dt);%为了迟延环节做准备
delay=zeros(dn,1);
e0=0;%这是为了微分控制做准备
temp=0;
y3=[];
t3=[];
%smith通道初始化部分
xs(1:2)=0;
temp_smith=0;
Ts=65;
as=exp(-dt/Ts);
bs=1-as;
dns=fix(tao/dt);
delays=zeros(dns,1);
feedback=0;
for i=1:lp
    e=r-feedback;
    up=kp*e;
    ui=ui+ki*dt*e;
    ud=0*kd*(e-e0)/dt;%去掉了微分作用
    pid=up+ui+ud;
    u=pid+d(i);
    %进入smith通道
    xs(1)=as*xs(1)+k*bs*u;
    xs(2)=as*xs(2)+1*bs*u;
    temp_smith=delays(dns);
    %smith部分的延迟环节
    for jj=dns:-1:2
        delays(jj)=delays(jj-1);
    end
    delays(1)=xs(2);
    y_smith=xs(2)- temp_smith;
    %smith通道搞定
    e0=e;
    x(1)=a*x(1)+k*b*u;
    x(2)=a*x(2)+b*x(1);
    temp=delay(dn);
    for kk=dn:-1:2
        delay(kk)=delay(kk-1);
    end
    delay(1)=x(2);
    feedback=temp+y_smith;
    y3=[y3,feedback];
    t3=[t3,i*dt];
end
figure(3)
plot(t3,y3)
hold on
plot(t1,y1,'r')
legend('smith预估','PI控制')

%自适应smith预估*******************************
delta=0.5;%我将0.2变为0.5
ti=110;
if n==1
    delta=0.5*k;
else
    delta=0.92*k*sqrt(n);
end;
ti=0.5*n*T;

kp=1/delta;
ki=1/(delta*ti);
kd=100;
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
[ts4,mp4,fai4,tr4,tp4,ys4]=value(y4,dt);
figure(4)
plot(t4,y4,'b');
hold on
plot(t1,y1,'g')
legend('自适应smith控制','PI控制')
figure(5);
plot(t,y,'y','linewidth',2);
hold on
plot(t1,y1,'k');
plot(t2,y2,'r--');
plot(t3,y3,'g');
plot(t4,y4,'b');
legend('PID控制','PI控制','微分先行','smith预估','自适应smith预估')
figure(6)
plot(t4,y4)



        
        
        



