function [eni,enj,numi,numj]=funfa(L,W,l1,w1)
% L=1200;
% W=1000;
% l1=370;
% w1=250;
eni=zeros(fix(W/w1),2);
enj=zeros(fix(L/l1),2);
numi=0;
numj=0;
for mi1=0:fix(W/w1);
    for mi2=1:ceil(W/l1);
        if mi1*w1+mi2*l1>W
            numi=numi+1;
            eni(numi,1)=mi1;
            eni(numi,2)=mi2-1;
            break;
        end
    end
end
for mj1=0:fix(L/l1)
    for mj2=1:ceil(L/w1)
        if mj1*l1+mj2*w1>L
            numj=numj+1;
            enj(numj,1)=mj1;
            enj(numj,2)=mj2-1;
            break;
        end
    end
end
