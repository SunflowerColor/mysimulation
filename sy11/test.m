%����ˮϵͳ��ǰ������
clc;
clear all;
close all;
%k1��ʾ����ˮϵͳ�Ĵ������棬T1��ʾ����ˮϵͳ��ʱ�䳣��
%kd��ʾ���Ŵ������棬Td��ʾ���Ŵ�����ʱ�䳣����
%��fΪ�±�ľ���ʾ�����������Ĳ���
k1=0.4;
T1=70;
n1=2;
kd=0.2;
Td=30;
nd=2;
%���Ӹ��ţ����Ӳ������ȵ���ϵͳ
delta=0.3*n1*abs(k1);%;0.28541
ti=0.5*n1*T1%;113.82
%�˴��ı���������ϵ���������Ŵ���
kp=1/delta;
ki=1/(delta*ti);
dt=1;
st=3000;
lp=fix(st/dt);
x(1:n1)=0%Ϊ����߳������Ӧ�ԣ�����2����n1
a=exp(-dt/T1);
b=1-a;
r=1;
ui=0;
y=[];
t=[];
temp=0;
temp1=0;%������ź�����


for i=1:lp
   
    %���岿�ַ���
    e=r-temp;
    up=kp*e;
    ui=ui+ki*dt*e;
    u=up+ui;
    x(1)=a*x(1)+k1*b*u;
    if n1>1
        x(2:n1)=a*x(2:n1)+1*b*x(1:n1-1);
      
        temp=x(n1);
    else
    
        temp=x(1);
    end
    y=[y,temp];
   
    t=[t,i*dt];
end
[a1,b1,c1,d1,e1,f1,g1]=value(y,t(2)-t(1));
plot(t,y,'k');

hold on


%***********************************
% %�������d
% k1=0.4;
% T1=70;
% n1=2;
% kd=0.2;
% Td=30;
% nd=2;
% %���Ӹ��ţ����Ӳ������ȵ���ϵͳ
% delta=0.28541;%0.3*n1*abs(k1);
% ti=113.82%0.5*n1*T1;
% %�˴��ı���������ϵ���������Ŵ���
% kp=1/delta;
% ki=1/(delta*ti);
% dt=1;
% st=3000;
% lp=fix(st/dt);
% x(1:n1)=0%Ϊ����߳������Ӧ�ԣ�����2����n1
% a=exp(-dt/T1);
% b=1-a;
% r=1;
% ui=0;
% y=[];
% t=[];
% temp=0;
% temp1=0;%������ź�����
% d=0;
% y1=[];
% t1=[];
% %�������Ŵ�������ĸ���dd
% dd=0;
% x_d(1:nd)=0;
% a_d=exp(-dt/Td);
% b_d=1-a_d;
% for i=1:lp
%     %�����źŵķ���
%       if i<=1500
%         d=0;
%     end
%     if i>1500
%         d=1;
%     end
%     x_d(1)=a_d*x_d(1)+kd*b_d*d;
%     if nd>1
%         x_d(2:nd)=a_d*x_d(2:nd)+1*b*x_d(1:nd-1);
%         dd=x_d(nd);
%     else
%         dd=x_d(1);
%     end
%     %�����źŷ������
%     %���岿�ַ���
%     e=r-temp;
%     up=kp*e;
%     ui=ui+ki*dt*e;
%     u=up+ui;
%     x(1)=a*x(1)+k1*b*u;
%     if n1>1
%         x(2:n1)=a*x(2:n1)+1*b*x(1:n1-1);
%       if i<=1500
%           temp=x(n1);
%       end
%       if i>1500
%         temp=x(n1)+dd;%�������
%       end
%       else
%     if i<=1500
%           temp=x(1);
%       end
%       if i>1500
%         temp=x(1)+dd;%�������
%       end
%     end
%     y1=[y1,temp];
%    
%     t1=[t1,i*dt];
% end
% [a2,b2,c2,d2,e2,f2,g2]=value(y1,t1(2)-t1(1));
% plot(t1,y1);

% 
% %******************************************
% 
k1=-0.4;
T1=70;
n1=2;
kd=0.4;
Td=30;
nd=2;
%���Ӹ��ţ����Ӳ������ȵ���ϵͳ
delta=0.3*n1*abs(k1);%;0.28541
ti=0.5*n1*T1%;113.82
%�˴��ı���������ϵ���������Ŵ���
kp=-1/delta;
ki=-1/(delta*ti);
dt=1;
st=3000;
lp=fix(st/dt);
x(1:n1)=0%Ϊ����߳������Ӧ�ԣ�����2����n1
a=exp(-dt/T1);
b=1-a;
r=1;
ui=0;
y=[];
t=[];
temp=0;

%����ǰ������
%�������d
d=0;
y1=[];
t1=[];
%�������Ŵ�������ĸ���dd
dd=0;
x_d(1:nd)=0;
a_d=exp(-dt/Td);
b_d=1-a_d;

%ǰ���������ĸ�������
 Tf1=70;Tf2=30;kf=k1/kd;
kpf1=kf*Tf1/Tf2;
kpf2=kf*Tf1/Tf2*(Tf2/Tf1-1);
dtf2=Tf2/100;
af=exp(-dtf2/Tf2);bf=kpf2*(1-af);
uf2=0;uf4=0;uf=0;


for i=1:lp
    %�����źŵķ���
    if i<=1500
        d=0;
    end
    if i>1500
        d=1;
    end
    x_d(1)=a_d*x_d(1)+kd*b_d*d;
    if nd>1
        x_d(2:nd)=a_d*x_d(2:nd)+1*b*x_d(1:nd-1);
        dd=x_d(nd);
    else
        dd=x_d(1);
    end
    %�����źŷ������
    %ǰ�����ַ���
    %�������uf��Ϊ��̬����������uf3��Ϊ��̬����
     uf1=0.5*d;
    upf=kpf1*uf1;
    uf2=af*uf2+bf*uf1;
    uf3=upf+uf2;          
    upf2=kpf1*uf3;
    uf4=af*uf4+bf*uf3;
    uf=upf2+uf4;

    %���岿�ַ���
    e=r-temp;
    up=kp*e;
    ui=ui+ki*dt*e;
    if i<=1500
        u=up+ui;
    end
   if i>1500
        u=up+ui+uf3;%���뾲/��̬����
   end   
    x(1)=a*x(1)+k1*b*u;
    if n1>1
        x(2:n1)=a*x(2:n1)+1*b*x(1:n1-1);
      
        temp=x(n1)+dd;%�������
    else
    
        temp=x(1)+dd;%�������
    end
    y1=[y1,temp];
   
    t1=[t1,i*dt];
end
[a2,b2,c2,d2,e2,f2,g2]=value(y1,t1(2)-t1(1));
plot(t1,y1,'r');

% hold on
% legend(g1,g2,4);



%*********************************************
% %�ı�Kֵ
% k1=-0.4;
% T1=70;
% n1=2;
% kd=0.1;
% Td=30;
% nd=2;
% %���Ӹ��ţ����Ӳ������ȵ���ϵͳ
% % delta=0.3*n1*abs(k1);%;0.28541
% % ti=0.5*n1*T1%;113.82
% delta=0.28541;%0.3*n1*abs(k1);
% ti=113.82%0.5*n1*T1;
% %�˴��ı���������ϵ���������Ŵ���
% kp=-1/delta;
% ki=-1/(delta*ti);
% dt=1;
% st=1500;
% lp=fix(st/dt);
% x(1:n1)=0%Ϊ����߳������Ӧ�ԣ�����2����n1
% a=exp(-dt/T1);
% b=1-a;
% r=1;
% ui=0;
% y=[];
% t=[];
% temp=0;
% %����ǰ������
% %�������d
% d=0;
% y1=[];
% t1=[];
% %�������Ŵ�������ĸ���dd
% dd=0;
% x_d(1:nd)=0;
% a_d=exp(-dt/Td);
% b_d=1-a_d;
% 
% %ǰ���������ĸ�������
%  Tf1=70;
%  Tf2=30;
%  kf=k1/kd;
% kpf1=kf*Tf1/Tf2;
% kpf2=kf*Tf1/Tf2*(Tf2/Tf1-1);
% dtf2=Tf2/100;
% af=exp(-dtf2/Tf2);
% bf=kpf2*(1-af);
% uf2=0;
% uf4=0;
% uf=0;
% 
% 
% for i=1:lp
%     %�����źŵķ���
%     if i<=1500
%         d=0;
%     end
%     if i>1500
%         d=1;
%     end
%     x_d(1)=a_d*x_d(1)+kd*b_d*d;
%     if nd>1
%         x_d(2:nd)=a_d*x_d(2:nd)+1*b*x_d(1:nd-1);
%         dd=x_d(nd);
%     else
%         dd=x_d(1);
%     end
%     %�����źŷ������
%     %ǰ�����ַ���
%     %�������uf��Ϊ��̬����������uf3��Ϊ��̬����
%      uf1=0.5*d;
%     upf=kpf1*uf1;
%     uf2=af*uf2+bf*uf1;
%     uf3=upf+uf2;          
%     upf2=kpf1*uf3;
%     uf4=af*uf4+bf*uf3;
%     uf=upf2+uf4;
% 
%     %���岿�ַ���
%     e=r-temp;
%     up=kp*e;
%     ui=ui+ki*dt*e;
%     if i<=1500
%         u=up+ui;
%     end
% %     if i>1500
%         u=up+ui+uf3;%���뾲/��̬����
% %     end   
%     x(1)=a*x(1)+k1*b*u;
%     if n1>1
%         x(2:n1)=a*x(2:n1)+1*b*x(1:n1-1);
%       
%         temp=x(n1)+dd;%�������
%     else
%     
%         temp=x(1)+dd;%�������
%     end
%     y1=[y1,temp];
%    
%     t1=[t1,i*dt];
% end
% [a3,b3,c3,d3,e3,f3,g3]=value(y1,t1(2)-t1(1));
% plot(t1,y1,'r');
% legend('��ɫΪ�ı�ǰ','��ɫΪ�ı��')
% 
% % legend(g1,g2,4);    
    

