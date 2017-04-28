clear all;
close all;
clc;
[num]=[5];
[den] = conv([2 1 0],[5 1]);
sys0 = feedback(tf(num,den),1);
t = 0:.5:150;
y0 = step(sys0,t);
gg0 = Tvalue(y0,t(2)-t(1));
figure(1)
plot(t,y0);
legend(gg0,4);
w = logspace(-1,2,200);
Ex_r = 30;                            %�������������ԣ��
[mag,pha] = bode(num,den,w);
[Gm,Pm,Wcg,Wcp] = MARGIN(tf(num,den));    %��ȡδУ��ϵͳ�����ԣ�ȺͲ���ͼ

fai = -180 + Ex_r + 10;              %������������ԣ�ȶ�Ӧ��δУ��ϵͳ�����fai

erra =zeros(200,1);                  %��δУ������ͼ���ҳ�һ��Ƶ��wc'����Ƶ�ʴ�����ǵ���fai(wc')=fai,
for i=1:200                               %�˴��ķ�ֵΪA(wc')���ֱ�ֵΪL(wc')
    erra(i) = abs(pha(i)-fai);
end
[aa,bb] = min(erra);          %�ڴ�֮ǰ�����еļ����У�����õ��ͺ󻷽�û�з�����ϵ
Ex_wc = w(bb);                %�ͺ󻷽�Ӧʹ�ڶ���ת��Ƶ�ʺ�ķֱ�ֵ�½�20log10(wc')���� 20log10(a) 
a = mag(bb);
w2 = 0.2*Ex_wc;               %�õڶ���ת��Ƶ��Զ��wc',�����ͺ󻷽ڴ���������ͺ�
w1 = w2/a;
T2 = 1/w2;
T1 = 1/w1;
num1 = conv(num,[T2 1]);                       %����У�����ϵͳԣ������Լ���Ӧ����
den1 = conv(den,[T1 1]);
sys1 = tf(num1,den1);

[Gm1,Pm1,Wcg1,Wcp1] = MARGIN(sys1);
figure(2)
sys2 = feedback(sys1,1);
y = step(sys2,t);
Tgg1= Tvalue(y,t(2)-t(1));
plot(t,y);
legend(Tgg1,4);
Mr = 1/(sin(Pm1*pi/180));
K0 = 2+1.5*(Mr-1) + 2.5*(Mr-1)^2;
Mp = 0.16 + 0.4*(Mr-1);
ts = K0*pi/Wcp1;
figure(3)
margin(num,den);
hold on;
margin(num1,den1);
hold on;
bode([T2 1],[T1 1]);
grid on;


Kcr = Gm;                            %���Բ���P��PI��PID��PD�����ƶ�ԭʼϵͳ���п���
Wcr = Wcg;
Pcr = 2*pi/Wcr;
kp = .7*Kcr;
ki = 0*kp*(1.2/Pcr);
kd = kp*Pcr*.2;
sysp = tf([kp],[1]);
sysi = tf([ki],[1 0]);
sysd = tf([kd 0],[1]);
syspi = parallel(sysp,sysi);
syspid = parallel(syspi,sysd);
sys4 = series(syspid,tf(num,den));
sys5 = feedback(sys4,1);
y1 = step(sys5,t);
Tgg2 = Tvalue(y1,t(2)-t(1));
figure(4)
plot(t,y1);
legend(Tgg2,4);

%P .5Kcr                                  Z-N���ľ��鹫ʽ
%PI .45Kcr   1/1.2*Pcr(Pcr=Wcr/(2*pi))
%PID .6Kcr .5Pcr   .125Pcr
%PD .7Kcr .2Pcr
