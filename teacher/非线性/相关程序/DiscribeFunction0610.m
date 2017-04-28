clear all;
close all;
clc;
T1 = 0.1;
T2 = 0.2;
K=1;
Astart=0.01
M=1;
Aend = 1;
A = Astart:0.01:Aend;
lp1 = fix((Aend-Astart)/0.01);
NA = zeros(lp1+1,1);
for i = 1:lp1+1   
    NA(i) = 4*M/(pi*A(i));
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
 a0 = spline(real(m_NA),A,-0.0667)
 na0 = spline(A,NA,a0)
w0 = spline(rem,w,-0.0667)
