clear all;
close all;
clc;
[num] = [10];
[den] = [1 1 0];
t = 0:0.1:6;
sys0 = tf(num,den);
sys10 = feedback(sys0,1);
y0 = step(sys10,t);
gg0 = Tvalue(y0,t(2)-t(1));
figure(1)
plot(t,y0);
legend(gg0,4);

w = logspace(-1,2,200);
er = 45;                                                              %Expected phase margin
[Gm,Pm,Wcg,Wcp] = MARGIN(tf(num,den));
fai = er-Pm+5;                                                    %1. Calculating difference between expected
%     and un-adjusted phase margin
a = (1+sin(fai*pi/180))/(1-sin(fai*pi/180));           % 2. Calculating lead segment coefficient
tempa = -10*log10(a);                                        % 3. Finding frequency that need to be modifiyed
tempb = 10^(tempa/20);
erra =zeros(200,1);
[mag,pha] = bode(num,den,w);
for i=1:200
    erra(i) = abs(mag(i)-tempb);
end
[aa,bb] = min(erra);
wm = w(bb);                                                        %Finding wm
w1 = wm/sqrt(a);
w2 = wm*sqrt(a);
T1 = 1/w2;
T2 = 1/w1;
num1 = conv(num,[T2 1]);
den1 = conv(den,[T1 1]);
sys1 = tf(num1,den1);
[Gm1,Pm1,Wcg1,Wcp1] = MARGIN(sys1);

sys10 = feedback(sys1,1);
y = step(sys10,t);
figure(2)
gg1 = Tvalue(y,t(2)-t(1));
plot(t,y);
legend(gg1,4);
Mr = 1/(sin(Pm1*pi/180));
K0 = 2+1.5*(Mr-1) + 2.5*(Mr-1)^2;
Mp = 0.16 + 0.4*(Mr-1);
ts = K0*pi/Wcp1;
figure(3)
margin(sys0)
hold on;
margin(sys1);
hold on;
bode([T2 1],[T1 1]);
grid on;


