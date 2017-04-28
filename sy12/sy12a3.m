%SmithԤ��********************************************
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
kp=0.6*kc;
ki=kp/Tn;
kd=kp*Tv;



st=500;
dt=0.05;
lp=st/dt;

r=1;
ui=0;%Ϊ�˻��ֿ�����׼��
dn=fix(tao/dt);%Ϊ�˳��ӻ�����׼��
delay=zeros(dn,1);
e0=0;%����Ϊ��΢�ֿ�����׼��
temp=0;
Y=[];
t=[];
%smithͨ����ʼ������
xs(1:2)=0;
temp_smith=0;
x(1:2)=0;
a=exp(-dt/T);
b=1-a;
as=exp(-dt/Ts);
bs=1-as;
dns=fix(tao/dt);
delays=zeros(dns,1);
feedback=0;
d(1:lp)=0;
d(fix(lp*0.5):end)=1;

for i=1:lp
    e=r-feedback;
    up=kp*e;
    ui=ui+ki*dt*e;
    ud=0*kd*(e-e0)/dt;%ȥ����΢������
    pid=up+ui+ud;
    u=pid+d(i);
    %����smithͨ��
    xs(1)=as*xs(1)+k*bs*u;
    xs(2)=as*xs(2)+1*bs*u;
    temp_smith=delays(dns);
    %smith���ֵ��ӳٻ���
    for jj=dns:-1:2
        delays(jj)=delays(jj-1);
    end
    delays(1)=xs(2);
    y_smith=xs(2)- temp_smith;
    %smithͨ���㶨
    e0=e;
    x(1)=a*x(1)+k*b*u;
    x(2)=a*x(2)+b*x(1);
    temp=delay(dn);
    for kk=dn:-1:2
        delay(kk)=delay(kk-1);
    end
    delay(1)=x(2);
    feedback=temp+y_smith;
    Y=[Y,feedback];
    t=[t,i*dt];
end
[v1,v2,v3,v4,v5,v6,v7]=value(Y,dt);
plot(t,Y)
legend(v7,4);
title('smithԤ��');