%%Rand to optimize the parameter of PID controller
clc;
close all;
clear all;
k=1.5;
n=2;
T=40;
r=1;
if n==1
    delta=0.5*k;
else
    delta=0.92*k*sqrt(n);
end
ti=0.5*n*T;
Min_delta=0.05*delta;

Max_delta=delta + (delta-0.001)*10;

Span_delta=(Max_delta-Min_delta);
Min_ti=0.05*ti;;
Max_ti=ti+ti*10;
  
Span_ti=(Max_ti-Min_ti);
best_delta=delta;
best_ti=ti;
Tdelta=num2str(best_delta);
Tti=num2str(best_ti);
Time0=clock;
[QBest,yBest,cuBest,t]=Obj_Sim(delta,ti,k,T,n,r);
y1=yBest;
cu1 = cuBest;
de_1 = rand();
while (de_1==0 | de_1==0.25 | de_1==0.5 | de_1==0.75 | de_1==1)
    de_1 = rand();
end
de_2 = rand();
while (de_2==0 | de_2==0.25 | de_2==0.5 | de_2==0.75 | de_2==1)
    de_2 = rand();
end
for i=1:1000
    de_1 = 4 * de_1 * (1.0-de_1);
    de_2 = 4 * de_2 * (1.0-de_2);
    temp_delta = Min_delta + de_1*Span_delta;
    temp_ti = Min_ti + de_2*Span_ti;
        [Q,y,cu]=Obj_sim(temp_delta,temp_ti,k,T,n,r);
        if Q<QBest
            QBest = Q;
            yBest=y;
            cuBest=cu;
            best_delta=temp_delta;
            best_ti=temp_ti;
        end
   
end
Time1=etime(clock,Time0);
[Q,y,cu,t]=Obj_Sim(best_delta,best_ti,k,T,n,r);
[a,b,c,d,e,f,g1]=value(y,t(2)-t(1));
[a,b,c,d,e,f,g2]=value(y1,t(2)-t(1));
g2=[g2,', delta=',Tdelta,' ti=',Tti];
Tdelta=num2str(best_delta);
Tti=num2str(best_ti);
g1=[g1,', Best delta=',Tdelta,' Best ti=',Tti];
subplot(2,1,1)
plot(t,y,'r-',t,y1,'k-','LineWidth',2);
legend(g1,g2);
Time1=num2str(Time1);
Time1=['Elamped time is:',Time1];
Title(Time1);
subplot(2,1,2)
plot(t,cu,'r-',t,cu1,'k-','LineWidth',2);


        