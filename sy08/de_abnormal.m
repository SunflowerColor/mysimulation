%此函数用来将系统中存在的异常值进行剔除
%输入参数：
%y-- 待处理的数据序列
%lamda- 差分处理的系数，该值越大，剔除的条件越严格
% 输出参数：
%y-----返回处理后的数据序列
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



