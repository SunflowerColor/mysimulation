%�˺���������ϵͳ�д��ڵ��쳣ֵ�����޳�
%���������
%y-- ���������������
%lamda- ��ִ����ϵ������ֵԽ���޳�������Խ�ϸ�
% ���������
%y-----���ش�������������
function [y] = de_abnormal(y,lamda)
[m,lp]=size(y);
if m>lp
    lp=m;
end
i=6;
while i<lp-6
    slope = 0;
    for j=1:4
        slope = slope + abs((y(i-j)-y(i-j-1)));
    end
    if abs(y(i)-y(i-1)) > lamda* slope/4
        if abs(y(i+1)-y(i-1))>lamda*slope/4
            if abs(y(i+2)-y(i-1))>lamda*slope/4
                if abs(y(i+3)-y(i-1))>lamda*slope/4
                    i=i+4;
                    continue;
                else
                    y(i)=2*y(i-1)-y(i-2);
                    y(i+1)=2*y(i) - y(i-1);
                    y(i+2)=2*y(i+1)-y(i);
                    i = i+3;
                    continue;
                end
            else
                y(i) = 2*y(i-1)-y(i-2);
                y(i+1)=2*y(i)-y(i-1);
                i=i+2;
                continue;
            end
        else
            y(i)=2*y(i-1)-y(i-2);
            i=i+1;
            continue;
        end
    else
        i=i+1;
    end
end



