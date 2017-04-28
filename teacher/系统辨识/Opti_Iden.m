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
Step = 50;
Q_B = 10e10;
K_Cur = [];
T_Cur = [];
for K= KMin:(KMax-KMin)/Step:KMax
    for T=TMin:(TMax-TMin)/Step:TMax
        Q=Obj_Iden(y,u,dt,2,K,T);
        K_Cur = [K_Cur K];
        T_Cur = [T_Cur T];
        if Q_B > Q
            Q_B=Q;
            K_B=K;
            T_B=T;
        end
    end
end
plot(K_Cur,T_Cur,'b+');
hold on;
plot(K_B,T_B,'k+','linewidth',5);

