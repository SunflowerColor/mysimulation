clear all;
close all;
clc;
load second_test01;
KMax = 1.6;
KMin = 1.4;
TMax = 60;
TMin = 20;
K_B = KMin;
T_B = TMin;
Q_B = 10e10;
Times = 1000;
K_Cur = [];
T_Cur = [];
Temp1 = rand();
Temp2 = rand();
for i=1:Times
        Temp1 = 4.0*Temp1*(1-Temp1);
        Temp2 = 4.0*Temp2*(1-Temp2);
        K = KMin + Temp1*(KMax-KMin);
        T = TMin + Temp2*(TMax-TMin);
        K_Cur=[K_Cur K];
        T_Cur=[T_Cur T];
        Q=Obj_Iden(y,u,dt,2,K,T);
        if Q_B > Q
            Q_B=Q;
            K_B=K;
            T_B=T;
        end
end
plot(K_Cur,T_Cur,'b+');
hold on;
plot(K_B,T_B,'k+','linewidth',5);