%È«Î¬×´Ì¬¹Û²âÆ÷
clear all;
close all;
clc;
num = [2];
den = [40 1 0];


num1 = num./den(1);
den1 = den./den(1);
a = [0 1;0 -den1(2)];
b = [0;1];
c = [num1(1) 0];
d = 0;

m = ctrb(a,b);
n = rank(m);
ts = 10;
fai = 10;
jieta = sol_jieta(fai);
wn = sol_wn(ts,jieta);
JR =-wn*jieta;
JI = j*wn*sqrt(1-jieta^2);
J = [JR+JI JR-JI ];
k = place(a,b,J);
L=k';
r=1*k(1)/c(1);
r=1;

st=20;
dt=0.01;
lp=st/dt;

x=zeros(2,1);
x1=zeros(2,1);
t=[];
Y=[];
Y1=[];
for i=1:lp
    E=(a-b*k)*x+b*r;
    x=x+E*dt;
    y=c*x;
    E=(a-b*k-L*c)*x1+b*r+L*y;
    x1=x1+E*dt;
    y1=c*x1;
    t=[t i*dt];
    Y=[Y y];
    Y1=[Y1 y1];
end
dd1 = Tvalue(Y,dt);
dd2=Tvalue(Y1,dt);
plot(t,Y,t,Y1);
legend(dd1,dd2,4);