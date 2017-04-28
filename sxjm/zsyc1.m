clc,clear
load aqijl;
y=AQIjl1(:,1);
yt=y'; n=length(yt);
t=1:n;
% alpha=[0.2 0.5 0.8];
alpha=0.3;
% m=length(alpha);
% yhat(1,1:m)=(yt(1)+yt(2))/2;
yhat(1)=(yt(1)+yt(2))/2;
% for i=2:n
% yhat(i,:)=alpha*yt(i-1)+(1-alpha).*yhat(i-1,:);
% end
for i=2:n
yhat(i)=alpha*yt(i-1)+(1-alpha).*yhat(i-1);
end
yhat;
% err=sqrt(mean((repmat(yt,1,m)-yhat).^2))
err=sqrt(mean((repmat(yt,1)-yhat).^2))
% xlswrite('lilv.xls',yhat)
yhatyc=alpha*yt(n)+(1-alpha).*yhat(n)
for i=1:n
    er(i)=yt(i)-yhat(i);
end
plot(t,y,t,yhat)