%减温水系统的前馈控制
clc;
clear all;
close all;
%k1表示减温水系统的传函增益，T1表示减温水系统的时间常数
%kd表示干扰传函增益，Td表示干扰传函的时间常数；
%以f为下标的均表示补偿控制器的参数
k1=0.4;
T1=70;
n1=2;
kd=0.2;
Td=30;
nd=2;
%不加干扰，不加补偿，先调稳系统
delta=0.3*n1*abs(k1);%;0.28541
ti=0.5*n1*T1%;113.82
%此处的比例、积分系数的正负号待定
kp=1/delta;
ki=1/(delta*ti);
dt=1;
st=3000;
lp=fix(st/dt);
x(1:n1)=0%为了提高程序的适应性，不用2代替n1
a=exp(-dt/T1);
b=1-a;
r=1;
ui=0;
y=[];
t=[];
temp=0;
temp1=0;%串入干扰后的输出


for i=1:lp
   
    %主体部分仿真
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
% %串入干扰d
% k1=0.4;
% T1=70;
% n1=2;
% kd=0.2;
% Td=30;
% nd=2;
% %不加干扰，不加补偿，先调稳系统
% delta=0.28541;%0.3*n1*abs(k1);
% ti=113.82%0.5*n1*T1;
% %此处的比例、积分系数的正负号待定
% kp=1/delta;
% ki=1/(delta*ti);
% dt=1;
% st=3000;
% lp=fix(st/dt);
% x(1:n1)=0%为了提高程序的适应性，不用2代替n1
% a=exp(-dt/T1);
% b=1-a;
% r=1;
% ui=0;
% y=[];
% t=[];
% temp=0;
% temp1=0;%串入干扰后的输出
% d=0;
% y1=[];
% t1=[];
% %经过干扰传函后串入的干扰dd
% dd=0;
% x_d(1:nd)=0;
% a_d=exp(-dt/Td);
% b_d=1-a_d;
% for i=1:lp
%     %干扰信号的仿真
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
%     %干扰信号仿真结束
%     %主体部分仿真
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
%         temp=x(n1)+dd;%加入干扰
%       end
%       else
%     if i<=1500
%           temp=x(1);
%       end
%       if i>1500
%         temp=x(1)+dd;%加入干扰
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
%不加干扰，不加补偿，先调稳系统
delta=0.3*n1*abs(k1);%;0.28541
ti=0.5*n1*T1%;113.82
%此处的比例、积分系数的正负号待定
kp=-1/delta;
ki=-1/(delta*ti);
dt=1;
st=3000;
lp=fix(st/dt);
x(1:n1)=0%为了提高程序的适应性，不用2代替n1
a=exp(-dt/T1);
b=1-a;
r=1;
ui=0;
y=[];
t=[];
temp=0;

%加入前馈补偿
%串入干扰d
d=0;
y1=[];
t1=[];
%经过干扰传函后串入的干扰dd
dd=0;
x_d(1:nd)=0;
a_d=exp(-dt/Td);
b_d=1-a_d;

%前馈补偿器的各个部分
 Tf1=70;Tf2=30;kf=k1/kd;
kpf1=kf*Tf1/Tf2;
kpf2=kf*Tf1/Tf2*(Tf2/Tf1-1);
dtf2=Tf2/100;
af=exp(-dtf2/Tf2);bf=kpf2*(1-af);
uf2=0;uf4=0;uf=0;


for i=1:lp
    %干扰信号的仿真
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
    %干扰信号仿真结束
    %前馈部分仿真
    %如果加入uf则为动态补偿，加入uf3则为静态补偿
     uf1=0.5*d;
    upf=kpf1*uf1;
    uf2=af*uf2+bf*uf1;
    uf3=upf+uf2;          
    upf2=kpf1*uf3;
    uf4=af*uf4+bf*uf3;
    uf=upf2+uf4;

    %主体部分仿真
    e=r-temp;
    up=kp*e;
    ui=ui+ki*dt*e;
    if i<=1500
        u=up+ui;
    end
   if i>1500
        u=up+ui+uf3;%加入静/动态补偿
   end   
    x(1)=a*x(1)+k1*b*u;
    if n1>1
        x(2:n1)=a*x(2:n1)+1*b*x(1:n1-1);
      
        temp=x(n1)+dd;%加入干扰
    else
    
        temp=x(1)+dd;%加入干扰
    end
    y1=[y1,temp];
   
    t1=[t1,i*dt];
end
[a2,b2,c2,d2,e2,f2,g2]=value(y1,t1(2)-t1(1));
plot(t1,y1,'r');

% hold on
% legend(g1,g2,4);



%*********************************************
% %改变K值
% k1=-0.4;
% T1=70;
% n1=2;
% kd=0.1;
% Td=30;
% nd=2;
% %不加干扰，不加补偿，先调稳系统
% % delta=0.3*n1*abs(k1);%;0.28541
% % ti=0.5*n1*T1%;113.82
% delta=0.28541;%0.3*n1*abs(k1);
% ti=113.82%0.5*n1*T1;
% %此处的比例、积分系数的正负号待定
% kp=-1/delta;
% ki=-1/(delta*ti);
% dt=1;
% st=1500;
% lp=fix(st/dt);
% x(1:n1)=0%为了提高程序的适应性，不用2代替n1
% a=exp(-dt/T1);
% b=1-a;
% r=1;
% ui=0;
% y=[];
% t=[];
% temp=0;
% %加入前馈补偿
% %串入干扰d
% d=0;
% y1=[];
% t1=[];
% %经过干扰传函后串入的干扰dd
% dd=0;
% x_d(1:nd)=0;
% a_d=exp(-dt/Td);
% b_d=1-a_d;
% 
% %前馈补偿器的各个部分
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
%     %干扰信号的仿真
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
%     %干扰信号仿真结束
%     %前馈部分仿真
%     %如果加入uf则为动态补偿，加入uf3则为静态补偿
%      uf1=0.5*d;
%     upf=kpf1*uf1;
%     uf2=af*uf2+bf*uf1;
%     uf3=upf+uf2;          
%     upf2=kpf1*uf3;
%     uf4=af*uf4+bf*uf3;
%     uf=upf2+uf4;
% 
%     %主体部分仿真
%     e=r-temp;
%     up=kp*e;
%     ui=ui+ki*dt*e;
%     if i<=1500
%         u=up+ui;
%     end
% %     if i>1500
%         u=up+ui+uf3;%加入静/动态补偿
% %     end   
%     x(1)=a*x(1)+k1*b*u;
%     if n1>1
%         x(2:n1)=a*x(2:n1)+1*b*x(1:n1-1);
%       
%         temp=x(n1)+dd;%加入干扰
%     else
%     
%         temp=x(1)+dd;%加入干扰
%     end
%     y1=[y1,temp];
%    
%     t1=[t1,i*dt];
% end
% [a3,b3,c3,d3,e3,f3,g3]=value(y1,t1(2)-t1(1));
% plot(t1,y1,'r');
% legend('黑色为改变前','红色为改变后')
% 
% % legend(g1,g2,4);    
    

