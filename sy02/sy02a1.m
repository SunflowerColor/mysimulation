clc;
clear all;
close all;
s=tf('s');
for i=1:0.4:3
k=1;
T=1;
kc=1;
Tc=i;
num1=[k];
den1=[T 1];
numc=[kc];
denc=[Tc 1];
sys1=tf(num1,den1);
sys2=sys1/s;        %for t^2/2
sysc1=tf(numc,denc);
sysc2=sysc1/s;
te=15;              %end time
st=0.01;            %step
t=0:st:te;
t=t';
y1=impulse(sys1,t);
y2=step(sys1,t);
y3=lsim(sys1,t,t);
y4=lsim(sys2,t,t);
yc1=impulse(sysc1,t);
yc2=step(sysc1,t);
yc3=lsim(sysc1,t,t);
yc4=lsim(sysc2,t,t);
y1d=zeros(te/st+1,1);%it is derivative
y2d=zeros(te/st+1,1);
y3d=zeros(te/st+1,1);
y4d=zeros(te/st+1,1);
for i=1:(te/st-1)    %calculate derivative
    y1d(i)=(y1(i+1)-y1(i))/st;
    y2d(i)=(y2(i+1)-y2(i))/st;
    y3d(i)=(y3(i+1)-y3(i))/st;
    y4d(i)=(y4(i+1)-y4(i))/st;
end
% figure(1);
% plot(t,y1,'b',t,y2d,'r',t,yc1,'k--');
% figure(2);
% plot(t,y2,'b',t,y3d,'r',t,yc2,'k--');
% figure(3);
% plot(t,y3,'b',t,y4d,'r',t,yc3,'k--');
% figure(4);
% plot(t,y4,'b',t,yc4,'k--');

figure(1);
plot(t,y1,'b',t,yc1,'k--');
hold on;
figure(2);
plot(t,y2,'b',t,yc2,'k--');
hold on;
figure(3);
plot(t,y3,'b',t,yc3,'k--');
hold on;
figure(4);
plot(t,y4,'b',t,yc4,'k--');
hold on;
end