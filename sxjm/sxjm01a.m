clc;
clear all;
close all;
L=1200;
W=1000;
l1=370;
w1=250;
[eni,enj,numi,numj]=funfa(L,W,l1,w1);
sum=zeros(numi,numj);
for i=1:numi
    for j=1:numj
        if eni(i,1)*w1>W/2 && enj(j,1)*l1>L/2
            i1l=ceil(eni(i,1)*w1-W/2);
            j1l=ceil(enj(j,1)*l1-L/2);
            sum(i,j)=2*eni(i,1)*enj(j,1)+2*eni(i,2)*enj(j,2)-i1l*j1l;
        elseif eni(i,2)*l1>W/2 && enj(j,2)*w1>L/2
            i2l=ceil(eni(i,2)*w1-W/2);
            j2l=ceil(enj(j,2)*l1-L/2);
            sum(i,j)=2*eni(i,1)*enj(j,1)+2*eni(i,2)*enj(j,2)-i2l*j2l;
        else
            sum(i,j)=2*eni(i,1)*enj(j,1)+2*eni(i,2)*enj(j,2);
            wle=W-2*eni(i,1)*l1;
            lle=L-2*enj(j,2)*w1;
            %
        end
    end
end

            