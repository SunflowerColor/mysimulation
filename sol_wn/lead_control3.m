clc;
close all;
clear all;
K=1;
T=1;
n=1;
mp = 5;
ts = T*4;
jieta = sol_jieta(mp);
wn = sol_wn(ts,jieta);
[a,b] = find_pole(jieta,wn);
P0 = a + j*b;
P1 = 0;
P2 =-1/T;
P3 = a-j*b;
angle_x = angle(P0-P1)*180/pi + angle(P0-P2)*180/pi-180;
angle_p0 = angle(P0)*180/pi;
angle_p = angle_p0/2  - angle_x/2;
angle_z = angle_p0/2 + angle_x/2;
t_p= a - b/tan(angle_p*pi/180);
t_z = a -b/tan(angle_z*pi/180);
kk = abs(((P0-t_p)*P0*(T*P0+1))/(K*(P0-t_z)));
alpha = abs(t_p/t_z);
T1 = abs(1/t_z);
T2 = abs(1/t_p);
kc = kk * abs(t_z)/abs(t_p);
dt = 0.01;
st = T*10;
lp = fix(st/dt);
a1 = exp(-dt/T2);
b1 = 1-a1;
a2 = exp(-dt/T);
b2 = 1-a2;
y=[];
t=[];
r = 1;
x(1:3)=0;
for i=1:lp
    e = r-x(3);
    u1 = kc *  (T1/T2)*e;
    x(1) = a1 * x(1) + (T2/T1-1)* b1*e;
    u = u1 + kc * (T1/T2)*x(1);
    x(2) = x(2) + dt*u;
    x(3) = a2*x(3) + K*b2*x(2);
    y = [y x(3)];
    t = [t i*dt];
end

figure(1)
plot(t,y,'k-','linewidth',2);
[a1,b1,c,d,e,f,g] = value(y,dt);
legend(g,4);
figure(2)
[num1] = [1 -t_z];
[den1] = [1 -t_p];
[num2] = [K]
[den2] = [T 1 0];
[num,den] = series(num1,den1,num2,den2);
rlocus(num,den);
[num0,den0] = feedback(num,den,1,1);

sys=tf(num0,den0);
[p,z] = pzmap(sys);                      % root locus of the system
hold on;
plot(a,b,'ks',a,-b,'ks','linewidth',2);
hold on;
for i=1:3
    plot(real(p(i)),imag(p(i)),'g+','linewidth',2);  %actual poles of the closed system
end










