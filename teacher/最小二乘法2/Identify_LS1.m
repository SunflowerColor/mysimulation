clc;
close all;
clear all;
load second_order_ls;
[lp,m] = size(y);
if m>lp
    lp = m;
end

N =2;
X = zeros(lp-N,2*N);
Y = zeros(lp-N,1);
for i=1:N
    for j=1:lp-N
        X (j,i) = -y(j+N-i);
%         X(j,N+1) = u(j+N);
%         X(j,N+i+1) = u(j+N-i);
X(j,N+i) = u(j+N-i);
        Y(j,1) = y(N+j);
    end    
end
xita = inv(X'*X)*X'*Y;
y_cat(1:N) = y(1:N);
for tt = 1:lp-N
    y_cat(N+tt) = xita' * X(tt,:)';
end
plot(t,y,'y-','linewidth',4);
hold on;
%plot(t,y_cat,'k--','linewidth',1);

y_cat1(1:lp) = 0;
y_cat1(1:N)= y(1:N);
for j = 1:lp-N
    for i=1:N
        x_cat(i) = -y_cat1(j+N-i);        
        x_cat(i+N) = u(j+N-i);
    end
%     x_cat(N+1) = u(j+N);
    y_cat1(N+j) = xita' * x_cat';
end
xita = xita';
text_xita = num2str(xita);
plot(t,y_cat1,'k--','linewidth',0.5);
title(xita);
