% ��ɫԤ��ģ��matlab���� (2007-05-31 11:02:49) 
% ��ǩ����ɫģ�� gm(1 1) ������� matlab   ���ࣺ������� 

%by allen @ ���캣Ÿ 
%��ɫģ��Ԥ���������ݲ�����һ�������¿��Բ�ȡ��һ�ֽ�ģ��Ԥ�ⷽ������Ԥ��������ԭʼ���ݴ���һ���Ĺ���������

%��������ǻ�ɫģ��GM(1,1)���������Ϻ͵�ά�³´�л�Ľ�Ԥ�����,matlab6.5 ,ʹ�ñ�������ע��������洢Ϊgm1.m

%x = [5999,5903,5848,5700,7884];gm1(x);  �������� 

%�������Ԥ��GM(1,1)ģ��
function  gmcal=gm1(x)
sizexd2 = size(x,2);
%�����鳤��

k=0;
for y1=x
    k=k+1;
    if k>1
        x1(k)=x1(k-1)+x(k);
        %�ۼ�����
        z1(k-1)=-0.5*(x1(k)+x1(k-1));   
        %z1ά����1�����ڼ���B
        yn1(k-1)=x(k);
    else
        x1(k)=x(k);
    end
end
%x1,z1,k,yn1

sizez1=size(z1,2);
%size(yn1);
z2 = z1';
z3 = ones(1,sizez1)';

YN = yn1';   %ת��
%YN

B=[z2 z3];
au0=inv(B'*B)*B'*YN;
au = au0';
%B,au0,au

afor = au(1);
ufor = au(2);
ua = au(2)./au(1);
%afor,ufor,ua 
%���Ԥ���  a u �� u/a��ֵ

constant1 = x(1)-ua;
afor1 = -afor;
x1t1 = 'x1(t+1)';
estr = 'exp';
tstr = 't';
leftbra = '(';
rightbra = ')';
%constant1,afor1,x1t1,estr,tstr,leftbra,rightbra

strcat(x1t1,'=',num2str(constant1),estr,leftbra,num2str(afor1),tstr,rightbra,'+',leftbra,num2str(ua),rightbra)
%���ʱ����Ӧ����

%******************************************************
%�������

k2 = 0;
for y2 = x1
    k2 = k2 + 1;
    if k2 > k  
    else
        ze1(k2) = exp(-(k2-1)*afor);  
    end
end
%ze1

sizeze1 = size(ze1,2);
z4 = ones(1,sizeze1)';
G=[ze1' z4];
X1 = x1';
au20=inv(G'*G)*G'*X1;
au2 = au20';
%z4,X1,G,au20

Aval = au2(1);
Bval = au2(2);
%Aval,Bval
%���Ԥ���  A,B��ֵ

strcat(x1t1,'=',num2str(Aval),estr,leftbra,num2str(afor1),tstr,rightbra,'+',leftbra,num2str(Bval),rightbra)
%���ʱ����Ӧ����

nfinal = sizexd2-1 + 1;
%����Ԥ��Ĳ�����5  ����������ͨ����������

%nfinal = sizexd2 - 1 + 1;
%Ԥ��Ĳ����� 1

for  k3=1:nfinal
    x3fcast(k3) = constant1*exp(afor1*k3)+ua;
end
%x3fcast
%һ������ۼ�ֵ

for  k31=nfinal:-1:0
    if k31>1
        x31fcast(k31+1) = x3fcast(k31)-x3fcast(k31-1);
    else
        if k31>0
            x31fcast(k31+1) = x3fcast(k31)-x(1);
        else
            x31fcast(k31+1) = x(1);
        end
    end
   
end
x31fcast;
%һ�����Ԥ��ֵ


for  k4=1:nfinal
    x4fcast(k4) = Aval*exp(afor1*k4)+Bval;
end
%x4fcast

for  k41=nfinal:-1:0
    if k41>1
        x41fcast(k41+1) = x4fcast(k41)-x4fcast(k41-1);
    else
        if k41>0
            x41fcast(k41+1) = x4fcast(k41)-x(1);
        else
            x41fcast(k41+1) = x(1);
        end
    end
   
end
x41fcast;
x;
%�������Ԥ��ֵ

%***���ȼ���p C************//////////////////////////////////
k5 = 0;
for y5 = x
    k5 = k5 + 1;
    if k5 > sizexd2  
    else
        err1(k5) = x(k5) - x41fcast(k5);  
    end
end
%err1
%�������


xavg = mean(x);
%xavg
%xƽ��ֵ

err1avg = mean(err1);
%err1avg
%err1ƽ��ֵ

k5 = 0;
s1total = 0 ;
for y5 = x
    k5 = k5 + 1;
    if k5 > sizexd2  
    else
        s1total = s1total + (x(k5) - xavg)^2;  
    end
end
s1suqare = s1total ./ sizexd2;
s1sqrt = sqrt(s1suqare);
%s1suqare,s1sqrt
%s1suqare  �в�����x�ķ���  s1sqrt Ϊx�����ƽ����S1

k5 = 0;
s2total = 0 ;
for y5 = x
    k5 = k5 + 1;
    if k5 > sizexd2  
    else
        s2total = s2total + (err1(k5) - err1avg)^2;  
    end
end
s2suqare = s2total ./ sizexd2;
%s2suqare   �в�����err1�ķ���S2

Cval = sqrt(s2suqare ./ s1suqare);
Cval
%nnn = 0.6745 * s1sqrt
%Cval  C����ֵ

k5 = 0;
pnum = 0 ;
for y5 = x
    k5 = k5 + 1;
    if abs( err1(k5) - err1avg ) < 0.6745 * s1sqrt
        pnum = pnum + 1;
        %ppp = abs( err1(k5) - err1avg )     
    else
    end
end
pval = pnum ./ sizexd2;
pval
%p����ֵ

%arr1 = x41fcast(1:6)


%Ԥ����Ϊ���䷶Χ  Ԥ�ⲽ�������ݳ��ȿɵ�������������иĽ�

 
% 
% ----------����Ϊԭ����������ע��