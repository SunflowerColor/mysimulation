dt = 0.1;
st = 500;
T = 40;
K = 1.5;
N = 2;
lp = fix(st/dt);
u(1:200) = 1;
u(201:lp) = 0;
x(1:N) = 0;
a = exp(-dt/T);
b = 1-a;
y=[];
t=[];
for i=1:lp 
    x(1) = a * x(1) + K * b * u(i);
    x(2) = a* x(2) + b*x(1);
    y = [y x(2)];
    t = [t i*dt];
end
plot(t,y);
y1(1:200)=y(1:200);
for i=201:lp
    y1(i) = y(i) + y1(i-200);
end
hold on;
plot(t,y1);
    