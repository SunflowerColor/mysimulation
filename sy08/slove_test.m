%�ɼ������ݴ���
clc;
clear all;
close all;

load sysoutu3;
Y1=Y;
[lp,m]=size(Y1);
if m>lp
    lp=m;
end
Y=de_abnormal(Y1,5);
%ƽ����
for i=3:lp-2
    Y1(i)=[Y(i-2)+Y(i-1)+Y(i)+Y(i+1)+Y(i+2)]/5;
end
%ȥ�쳣��


Y=Y1;
plot(Y)

save soutu3 Y dt r;