close all;
clear all;
clc;

k=1.5;
n=1;
T=50;
r=1;
c1=0.7;
c2=1.4;
c3=1.4;
if n==1
    delta=0.5*k;
else
    delta=0.92*k*sqrt(n);
end
ti=0.5*n*T;
Best_Q = 1.0e20;
Best_PSO=[delta,ti];
[Best_Q,y0,cu0,t,dt]=Obj_Sim(Best_PSO(1),Best_PSO(2),k,T,n,r);
[a,b,c,d,e,f,g0]= Value(y0,dt);
Tti=num2str(Best_PSO(2));
Tdelta = num2str(Best_PSO(1));
g0=[g0,' Initial parameters,delta=',Tdelta,', ti=',Tti];
Q_T1=num2str(Best_Q);
Min=[delta*.05 ti*.05];
Max=[delta*20 ti*20];
Span=Max-Min;
Max_V=(Max-Min)/10;
Num=50;
bPSO=[];
for i=1:Num
    PSO(i,1)=Min(1)+Span(1)*rand();
    PSO(i,2)=Min(2)+Span(2)*rand();
    PSO_V(i,1)=Max_V(1)*(rand()-0.5);
    PSO_V(i,2)=Max_V(2)*(rand()-0.5);
end
Better_Q(1:Num)=1.0e20;
Sol_Q = 1.0e20;
Sol_PSO = Best_PSO;
Better_PSO = PSO;
for qq=1:200
    for i=1:Num
        [Q(i)]=Obj_Sim(PSO(i,1),PSO(i,2),k,T,n,r);
    end
    for i=1:Num
        if Q(i) < Better_Q(i)
            Better_PSO(i) = PSO(i);
            Better_Q(i) = Q(i);
        end
    end
    Best_Q = Q(i);
    Best_PSO = PSO(1,:);
    for i=2:Num
        if Q(i) < Best_Q
            Best_Q = Q(i);
            Best_PSO =PSO(i,:);
        end
    end
    if Sol_Q > Best_Q
        Sol_Q = Best_Q;
        Sol_PSO = Best_PSO;
    end
    if Sol_Q < 100
        break;
    end
    for i=1:Num
        PSO_V(i,:)= c1*PSO_V(i,:)  +c2 *rand()* (Better_PSO(i,:)-PSO(i,:)) +c3*rand()*(Best_PSO - PSO(i,:));
        if PSO_V(i,1) >Max_V(1)    PSO_V(i,1)=Max_V(1); end
        if PSO_V(i,1) <-Max_V(1)    PSO_V(i,1)=-Max_V(1); end
        if PSO_V(i,2) >Max_V(2)    PSO_V(i,2)=Max_V(2); end
        if PSO_V(i,2) <-Max_V(2)    PSO_V(i,2)=-Max_V(2); end

        PSO(i) = PSO(i) + PSO_V(i);
        if PSO(i,1) > Max(1)    PSO(i,1) = Max(1);  end
        if PSO(i,1) < Min(1)    PSO(i,1) = Min(1);  end
        if PSO(i,2) > Max(2)    PSO(i,2) = Max(2);  end
        if PSO(i,2) < Min(2)    PSO(i,2) = Min(2);  end
    end
    bPSO = [bPSO;Sol_PSO];
end

[Sol_Q,y1,cu0,t,dt]=Obj_Sim(Sol_PSO(1),Sol_PSO(2),k,T,n,r);
[a,b,c,d,e,f,g3]= Value(y1,dt);
Tti=num2str(Sol_PSO(2));
Tdelta = num2str(Sol_PSO(1));
Q_T2=num2str(Sol_Q);
g3=[g3,' Optimized parameters,delta=',Tdelta,', ti=',Tti];
Q_T = ['Initial Quality is: ',Q_T1,'  Optimized Quality is: ',Q_T2]; 
%  subplot(1,2,1);
plot(t,y0,'r-',t,y1,'k-','LineWidth',2);
grid on;
legend(g0,g3);
title(Q_T);
%  subplot(1,2,2);
%  plot(bPSO(:,1),bPSO(:,2),'LineWidth',2);

