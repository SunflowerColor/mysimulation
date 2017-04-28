n = 2;
K = 1.5;
T = 40;
x(1:n) = 0;
dt = 1;
st = 8*n*T;
lp = fix(st/dt);
a = exp(-dt/T);
b = 1-a;
y = [];
u=[];


for i=1:lp
    temp = rand();
    u=[u temp];
    x(1) = a*x(1) + K*b*temp;
    if n>=2
        x(2:n) = a*x(2:n) + b*x(1:n-1);
    end
    y = [y x(n)];
end
save second_test01 y u dt;
