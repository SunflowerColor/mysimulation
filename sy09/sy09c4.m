%粒子群二次辨识
clc;
clear all;
close all;
load wtankjy;
 
TA=clock;
[lp,m]=size(Y);
if lp<m
    lp=m;
end

U(1:lp)=u2-u1;
Kmax=18;
Kmin=10;
Tmax=370;
Tmin=220;
num=50;
maxv(1)=(Kmax-Kmin)/10;
maxv(2)=(Tmax-Tmin)/10;
 
c1=0.7;
c2=1.4;
c3=1.4;
 
for i=1:num
    PSO(i,1)=rand()*(Kmax-Kmin)+Kmin;
    PSO(i,2)=rand()*(Tmax-Tmin)+Tmin;
    PSOV(i,1)=rand()*(Kmax-Kmin)+Kmin;
    PSOV(i,2)=rand()*(Tmax-Tmin)+Kmin;
end
 
bestPSO(1:num)=10e40;
solpso=10e40;
Q(1:num)=10e40;
bestq(1:num)=10e40;
Khi=[];
Thi=[];
for n=1:1
    for ab=1:2
        for i=1:num
            Q(i)=QV(Y,U,dt,PSO(i,1),PSO(i,2),n,0);
            Khi=[Khi PSO(i,1)];
            Thi=[Thi PSO(i,2)];
            if Q(i)<bestq(i)
                bestq(i)=Q(i);
                bestPSO(i,1)=PSO(i,1);
                bestPSO(i,2)=PSO(i,2);
            end
        end
        bestp=Q(1);
        for i=2:num
            if Q(i)<bestp
                bestp=Q(i);
                bestpPSO(1)=PSO(i,1);
                bestpPSO(2)=PSO(i,2);
            end
        end
        if bestp<solpso
            solpso=bestp;
            solk=bestpPSO(1);
            solt=bestpPSO(2);
            soln=n;
        end
        for i=1:num
            PSOV(i,1)=c1*PSOV(i,1)+c2*rand()*(bestPSO(i,1)-PSO(i,1))+c3*rand()*(bestpPSO(1)-PSO(i,1));
            PSOV(i,2)=c1*PSOV(i,2)+c2*rand()*(bestPSO(i,2)-PSO(i,2))+c3*rand()*(bestpPSO(2)-PSO(i,2));
            if PSOV(i,1)>maxv(1)
                PSOV(i,1)=maxv(1);
            end
            if PSOV(i,2)>maxv(2)
                PSOV(i,2)=maxv(2);
            end
            if PSOV(i,1)<-maxv(1)
                PSOV(i,1)=-maxv(1);
            end
            if PSOV(i,2)<maxv(2)
                PSOV(i,2)=-maxv(2);
            end
            
            
            PSO(i)=PSO(i)+PSOV(i);
            if PSO(i,1)>Kmax
                PSO(i,1)=Kmax;
            end
            if PSO(i,2)>Tmax
                PSO(i,2)=Tmax;
            end
            if PSO(i,1)<-Kmax
                PSO(i,1)=-kmax;
            end
            if PSO(i,2)<-Tmax
                PSO(i,2)=-Tmax;
            end
        end
    end
end

time1=etime(clock,TA);
ks=num2str(solk);
Ts=num2str(solt);
ns=num2str(soln);
QBs=num2str(solpso);
text1=['k=',ks,',T=',Ts,',n=',ns,',Q=',QBs];
plot(Khi,Thi,'+');
hold on;
plot(solk,solt,'r+','linewidth',5);
title(text1)
