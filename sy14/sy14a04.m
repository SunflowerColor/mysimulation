%Ħ������
clc;
clear all;
close all;

dong=0.3;%��Ħ������
jing=0.5;%��Ħ������
do=0;%�˶�״̬��0Ϊ��ֹ��1Ϊ�˶�
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
title('Ħ������');