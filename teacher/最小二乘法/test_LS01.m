close all;
clear all;
clc;
a = [2 3 4];
x = 1:0.1:5;
[lp,m] = size(x)
if m>lp
    lp = m;
end
y = a(1).*x.*x + a(2).*x + a(3);
for i=1:lp
    y(i) = y(i) + 0.2*rand()-0.1;
end
H = zeros(lp,3);
z = zeros(lp,1);
for i=1:lp
    H(i,1) = x(i)*x(i);
    H(i,2) = x(i);
    H(i,3) = 1;
    z(i) = y(i);
end
xita = inv(H'*H)*H'*z
y1 = zeros(lp,1);
for i=1:lp
    y1(i) = xita(1)*x(i)*x(i) + xita(2)*x(i) + xita(3);
end
plot(x,y,x,y1);
    
