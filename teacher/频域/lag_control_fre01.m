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
Ex_r = 30;                            %expected phase margin
[mag,pha] = bode(num,den,w);
[Gm,Pm,Wcg,Wcp] = MARGIN(tf(num,den));

fai = -180 + Ex_r + 10;              %calculating frecency spot need to be adjusted

erra =zeros(200,1);
for i=1:200
    erra(i) = abs(pha(i)-fai);
end
[aa,bb] = min(erra);
Ex_wc = w(bb);                %20log10(a) = 20log10(Ex_wc)
a = mag(bb);
w2 = 0.2*Ex_wc;
w1 = w2/a;
T2 = 1/w2;
T1 = 1/w1;
num1 = conv(num,[T2 1]);
den1 = conv(den,[T1 1]);
sys1 = tf(num1,den1);

[Gm1,Pm1,Wcg1,Wcp1] = MARGIN(sys1);
margin(sys1);
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