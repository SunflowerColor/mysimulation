clc,clear
% load data.txt %��ԭʼ���ݴ���ڴ��ı��ļ�data.txt ��
load aqijl;
data=[AQIjl1;AQIjl3];
% data=[AQIjl1];
data=[data data]';
n=size(data,1); %�����������������������صĸ���
m=size(data,2); %����������������۲�ʱ�̵ĸ���
for i=1:n
data(i,:)=data(i,:)/data(i,1); %��׼������
end
m1=6; m2=6; %m1 ĸ���صĸ�����m2 �����صĸ���
ck=data(m2+1:n,:); %���ĸ��������
bj=data(1:m2,:); %�������������
for i=1:m1
for j=1:m2
t(j,:)=bj(j,:)-ck(i,:);
end
mn=min(min(abs(t'))); %��ĸ����i ����С��
mx=max(max(abs(t'))); %��ĸ����i ������
rho=0.5; %�ֱ�ϵ������
ksi=(mn+rho*mx)./(abs(t)+rho*mx); %��ĸ����i ���������صĹ���ϵ��
rt=sum(ksi')/m; %��ĸ����i ���������صĹ�����
r(i,:)=rt;
end
r
