clear all;
close all;
clc;

T1 = 0.1;
T2 = 0.2;
K=15;
a =1;
k=2;

Aend = 10;
A = a:0.1:Aend;
lp1 = fix((Aend-a)/0.1);
NA = zeros(lp1+1,1);
for i = 1:lp1+1
    temp = a/A(i);
    NA(i) = 2*k/pi*(asin(temp) + temp*sqrt(1-temp^2));
end
m_NA = -1./NA;
num = [K];
den = conv([T1 1],[T2 1 0]);

w = 5:0.1:100;
[rem,img,w]=nyquist(num,den,w);
plot(real(m_NA),imag(m_NA),'r-','linewidth',2);
hold on;
plot(rem,img,'k-','linewidth',2);
grid on;
a0 = spline(real(m_NA),A,-1)
 w0 = spline(rem,w,-1)