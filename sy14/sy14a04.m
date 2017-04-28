%摩擦特性
clc;
clear all;
close all;

dong=0.3;%动摩擦阻力
jing=0.5;%静摩擦阻力
do=0;%运动状态，0为静止，1为运动
st=10;
dt=0.01;
lp=st/dt;
t=dt:dt:st;
w=3;
u=sin(w*t);
Y=[];
for i=1:lp
    if u(i)>jing && u(i)>0
        do=1;
    end
    if u(i)<-jing && u(i)<0
        do=1;
    end
    if do==1
        if u(i)<dong  && u(i)>0
            do=0;
        end
        if u(i)>-dong && u(i)<0
            do=0;
        end
    end
    
    if do==0
        y=0;
    end
    
    if do==1
        if u(i)>0
            y=u(i)-dong;
        end
        if u(i)<0
            y=u(i)+dong;
        end
    end   
    Y=[Y y];
end
plot(t,Y);
title('摩擦特性');