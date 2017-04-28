%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Object k/(1+Ts)^n input : delta比例带
%ti，积分系数,k对象放大系数，T,对象时间常数，n,等容对象阶次，r,输入幅值，tao，纯迟延，如没有可不加 
%output :
%评价品质函数值，优化后的系统输出，优化后的控制器输出，时间序列，仿真步距
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%5
function [Q,y,cu,t,dt]=Obj_Sim(delta,ti,k,T,n,r,tao)      %
dt=T/5; 
st=8*n*T;
lp=fix(st/dt);
y=[0];
t=[0];
x(1:n)=0;
u=0;
a=exp(-dt/T);
b=1-a;
cu=[0];
t=[0];
kiu=0;
kp=1/delta;
ki=kp/ti;
for i=1:lp
    e=r-x(n);
    kpu=kp*e;
    kiu=kiu+ki*e*dt;
    u=kpu+kiu;
    x(1)=a*x(1)+k*b*u;
    if n>=2
        x(2:n)=a*x(2:n)+b*x(1:n-1);
    end
    y=[y x(n)];
    t=[t i*dt];
    cu=[cu u];
end
Q=Qvalue(2,dt,y,r,5,3*n*T);


        