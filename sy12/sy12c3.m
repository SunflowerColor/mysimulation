%��̬����
clc;
clear all;
close all;
dt=1;
st=1000;
lp=fix(st/dt);
 
k1=0.4; T1=40; n1=2; 
a1=exp(-dt/T1); b1=1-a1;
 
k2=1; T2=60; n2=2;
a2=exp(-dt/T2); b2=1-a2;
 
k3=1.3; T3=42; n3=2;
a3=exp(-dt/T3); b3=1-a3;
 
k4=0.6; T4=50; n4=2;
a4=exp(-dt/T4); b4=1-a4;
 
N11=1;
N21=0;
N12=0;
N22=1;
 
%    x1=1; x2=0;
  x1=0; x2=1;
 
x(1:22)=0;
x11=0;
x18=0;
d1=0;
d10=0;
d20=0
d2=0;
for i=1:lp
        if i>lp/2
        x1=1;
    end
    x11=x(11);%����Ϊ��΢�ֻ��ڵķ���
    d10=x(12)+x(13);%ǰһʱ�̵�ֵ
    x18=x(18);
    d20=x(19)+x(20);
    
    x(9)=a2*x(9)+1*b2*x1;
    x(10)=a2*x(10)+1*b2*x(9);
    x(11)=(k2/k4)*x(10);%����ʱ�̵�ֵ***************-
    x(12)=x(11);
    x(13)=T4*(x(11)-x11)/dt;
    d1=x(12)+x(13);%����ʱ�̵�ֵ
    x(14)=d1;
    x(15)=T4*(d1-d10)/dt;
    N21=x(14)+x(15);
    
    x(16)=(k3/k1)*x2;%************************-
    x(17)=a3*x(17)+1*b3*x(16);
    x(18)=a3*x(18)+1*b3*x(17);
    x(19)=x(18);
    x(20)=T1*(x(18)-x18)/dt;
    d2=x(19)+x(20);
    x(21)=d2;
    x(22)=T1*(d2-d20)/dt;
    N12=x(21)+x(22);
    
     u1=x1*N11+N12;
    u2=N21+x2*N22;
    
     if (u1>8)  u1=8;  end
    if (u1<-8) u1=-8; end
    if (u2>8)  u2=8;  end
    if (u2<-8) u2=-8; end
 
    
    x(1)=a1*x(1)+k1*b1*u1;
    x(2)=a1*x(2)+1*b1*x(1);
    
    x(3)=a2*x(3)+k2*b2*u1;
    x(4)=a2*x(4)+1*b2*x(3);
    
    x(5)=a3*x(5)+k3*b3*u2;
    x(6)=a3*x(6)+1*b3*x(5);
    
    x(7)=a4*x(7)+k4*b4*u2;
    x(8)=a4*x(8)+1*b4*x(7);
    
    y1(i)=x(2)+x(6);
    y2(i)=x(4)+x(8);
    t(i)=i*dt;
end
t_x1=num2str(x1);
t_x2=num2str(x2);
% t_input=['x1=',t_x1,'   ','x2=',t_x2];
% plot(0,0,'g*');
% hold on
plot(t,y1,'b',t,y2,'r--');
% legend(t_input,'y1','y2',4);
legend('y1','y2',4);
title('��̬����');