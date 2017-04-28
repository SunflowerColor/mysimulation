%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Object k/(1+Ts)^n input : delta������
%ti������ϵ��,k����Ŵ�ϵ����T,����ʱ�䳣����n,���ݶ���״Σ�r,�����ֵ��tao�������ӣ���û�пɲ��� 
%output :
%����Ʒ�ʺ���ֵ���Ż����ϵͳ������Ż���Ŀ����������ʱ�����У����沽��
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


        