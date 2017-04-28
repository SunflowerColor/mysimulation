%随机法整定PID
clc;
clear all;
close all;

k=2;
T=10;
n=2;

kp=0.833;
ki=0.0833;

pmax=kp*5;
pmin=kp/5;
imax=ki*5;
imin=ki/5;

step=100;
r=1;
QB=10e40;
for i=1:step
    for j=1:step
        kpr=(pmax-pmin)*rand()+pmin;
        kir=(imax-imin)*rand()+imin;
        [Q,t,y,dt]=Qpid(kpr,kir,k,T,n,r,0);
        if (Q<QB)
            QB=Q;
            pB=kpr;
            iB=kir;
            tB=t;
            yB=y;
        end
    end
end
[Q,t,y]=Qpid(kp,ki,k,T,n,r,0);
[v1,v2,v3,v4,v5,v6,v7]=value(y,dt);
[v1,v2,v3,v4,v5,v6,v7b]=value(yB,dt);
kps=num2str(kp);
kis=num2str(ki);
pbs=num2str(pB);
ibs=num2str(iB);
v7=[v7,' kp=',kps,' ki=',kis];
v7b=[v7b,' kp=',pbs,' ki=',ibs];
plot(t,y,'b',t,yB,'r--')
legend(v7,v7b,4);
title('随机法优化PID参数');

