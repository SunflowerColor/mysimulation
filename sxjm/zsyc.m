clc;
clear all;
close all;
load aqijl;
arr=AQIjl1(:,1);
% arr=[0;6;8.3;9.8;13;15;13.5;26.1;80.3;86;102.6];
[m,n]=size(arr);
alf=0.2;
for j=1:2
    s(1,j)=arr(1,1)
end
for i=2:m
    for j=1:2
        if j==1
            s(i,j)=alf*arr(i,1)+(1-alf)*s(i-1,j);
        else
            s(i,j)=alf*s(i,j-1)+(1-alf)*s(i-1,j);
        end
    end
end
temp=alf/(1-alf);
for i=1:m
    at(i,1)=2*s(i,1)-s(i,2);
    bt(i,1)=temp*(s(i,1)-s(i,2));
    yy(i+1)=at(i,1)+bt(i,1);
end
for i=2:m
    y1(i-1)=yy(i);
end
for i=2:m
    b(i-1)=arr(i);
end
for i=1:3
    y2(i)=at(m,1)+bt(m,1)*(i+1);
end
year=[1:m+2];
year=year';
y1=y1';
y2=y2';
b=b';
data=cat(1,y1,y2);
data1=cat(1,b,y2);
% plot(year,data,'-rs','markerFaceColor','g', 'MarkerSize',3);
plot(year,data,'k',year,data1,'-rs');
for i=1:m
    er=data(i)-data1(i);
end