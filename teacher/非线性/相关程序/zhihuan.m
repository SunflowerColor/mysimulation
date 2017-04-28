clc;
clear all;
close all;
M = 4;
a = 1;
AEnd = 100;
AStart = 0.2;
A = AStart:0.1:AEnd;
lp = fix((AEnd-AStart)/0.1)+2;
NA = zeros(lp,1);

for i=1:lp
    NA(i) = 4*M/(pi*A(i))*sqrt(1-(a/A(i))^2) - j*4*M*a/(pi*A(i)*A(i));
    m_NA(i) = -1/NA(i);
end

plot(real(m_NA),imag(m_NA),'r-','linewidth',2);