function [Q]=Obj_Iden(y,u,dt,n,K,T)      
[lp,m] =size(y);
if m>lp
    lp = m;
    y = y';
end
x(1:n) = 0;
a = exp(-dt/T);
b = 1-a;
y1 = [];

for i=1:lp
    x(1) = a*x(1) + K*b*u(i);
    if n>=2
        x(2:n) = a*x(2:n) + b*x(1:n-1);
    end
    y1 = [y1;x(n)];
end

Q = (y-y1)'*(y-y1);
    





        