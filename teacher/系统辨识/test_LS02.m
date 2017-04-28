clc;
clear all;
close all;
K = 1.2;
T = 40;
n =2;
st = 8*n*T;
dt = 1;
lp = fix(st/dt);
N=2;
r(lp,1) = 0;
for i=1:fix(lp/3)
    r(i) = 1;
end
for i=fix(lp/3)+1:fix(2*lp/3)
    r(i) = 0;
end
for i = fix(2*lp/3)+1:lp
    r(i) = 1;
end
% for i=1:lp
%     r(i) = rand();
% end
% r(1:lp-(N+1)) = 1;
% r(lp-N:lp) = 0;
x(1:n) = 0;
a = exp(-dt/T);
b = 1-a;
y = zeros(lp,1);
t = zeros(lp,1);
noise = 0.1;
for i=1:lp
    x(1) = a*x(1) + K*b*r(i);
    x(2:n) = a*x(2:n) + b*x(1:n-1);
    y(i) = x(n) ;
   y(i) = y(i) + 2*noise*rand()-noise;
    t(i) = i*dt;
end
plot(t,y);
H = zeros(lp-N,2*N);
z = zeros(lp-N,1);
for i=1:lp-N
    for j=1:N
        H(i,j) = -y(N+i-j);
        H(i,j+N) = r(N+i-j);
    end
    z(i) = y(i+N);
end
cov_ar = H'*H;
xita = inv(cov_ar)*H'*z;
y1(1:N) = y(1:N);
tt = zeros(2*N,1);
for i=1:lp-N
      for j=1:N
        tt(j) = -y1(N+i-j);
        tt(j+N) = r(N+i-j);
    end
    y1(i+N) = xita'*tt;
end
plot(t,y,t,y1);
    
