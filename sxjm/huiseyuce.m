clc,clear
% load data.txt %把原始数据存放在纯文本文件data.txt 中
load aqijl;
data=[AQIjl1;AQIjl3];
% data=[AQIjl1];
data=[data data]';
n=size(data,1); %求矩阵的行数，即求所有因素的个数
m=size(data,2); %求矩阵的列数，即求观测时刻的个数
for i=1:n
data(i,:)=data(i,:)/data(i,1); %标准化数据
end
m1=6; m2=6; %m1 母因素的个数，m2 子因素的个数
ck=data(m2+1:n,:); %提出母因素数据
bj=data(1:m2,:); %提出子因素数据
for i=1:m1
for j=1:m2
t(j,:)=bj(j,:)-ck(i,:);
end
mn=min(min(abs(t'))); %求母因素i 的最小差
mx=max(max(abs(t'))); %求母因素i 的最大差
rho=0.5; %分辨系数设置
ksi=(mn+rho*mx)./(abs(t)+rho*mx); %求母因素i 对所有因素的关联系数
rt=sum(ksi')/m; %求母因素i 对所有因素的关联度
r(i,:)=rt;
end
r
