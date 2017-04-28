clc;
clear all;
close all;
s=tf('s');
wn=1;
y=0.7;
wnc=0.1;              %changed
yc=0.7;
numc=[wnc*wnc]; 
denc=[1 2*yc*wnc wnc*wnc];
sysc1=tf(numc,denc);
sysc2=sysc1/s;
num1=[wn*wn];
den1=[1 2*y*wn wn*wn];
sys1=tf(num1,den1);
sys2=sys1/s;        %for t^2/2
te=300;              %end time
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
% y1d=zeros(te/st+1,1);%it is derivative
% y2d=zeros(te/st+1,1);
% y3d=zeros(te/st+1,1);
% y4d=zeros(te/st+1,1);

% for i=1:(te/st-1)    %calculate derivative
%     y1d(i)=(y1(i+1)-y1(i))/st;
%     y2d(i)=(y2(i+1)-y2(i))/st;
%     y3d(i)=(y3(i+1)-y3(i))/st;
%     y4d(i)=(y4(i+1)-y4(i))/st;
% end

% figure(1);
% plot(t,y1,'b',t,y2d,'r:',t,yc1,'k--');
% figure(2);
% plot(t,y2,'b',t,y3d,'r:',t,yc2,'k--');
% figure(3);
% plot(t,y3,'b',t,y4d,'r:',t,yc3,'k--');
% figure(4);
% plot(t,y4,'b',t,yc4,'k--');
[a,b,c,d,e,f,g1]=value(y2,st);
[a,b,c,d,e,f,g2]=value(yc2,st);
w1=num2str(wn);
w2=num2str(wnc);
n1=num2str(y);
n2=num2str(yc);
text1=[g1,',Wn=',w1,',y=',n1];
text2=[g2,',Wn=',w2,',y=',n2];
plot(t,y2,'b',t,yc2,'k--');
legend(text1,text2,4);
