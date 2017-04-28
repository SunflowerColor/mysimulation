close all;
clear all;
clc;
N=2;
k=1.5;
n=2;
T=40;
r=1;
if n==1
    delta=0.5*k;
else
    delta=0.92*k*sqrt(n);
end
ti=0.5*n*T;
[Q0,y0,cu0,t,dt]=Obj_Sim(delta,ti,k,T,n,r);
[a,b,c,d,e,f,g0]= Value(y0,dt);
Tti=num2str(ti);
Tdelta = num2str(delta);
g0=[g0,' Initial parameters,delta=',Tdelta,', ti=',Tti];
Min_delta=0.05*delta;
Max_delta=delta*20;
Min_ti=0.05*ti;
Max_ti=ti*20;
Low=[Min_delta,Min_ti];
High=[Max_delta,Max_ti];
Span=High-Low;
Step=Span/20;
Quit_Err=1.0e-20;
x=zeros(N+1,N);
x(1,1)=delta;
x(1,2)=ti;
for i=2:N+1
    x(i,:)=x(1,:);
    x(i,i-1)=x(1,i-1)+Step(i-1)*Span(i-1)*rand();
end

for i=2:N+1
    for j=1:N
        if x(i,j)<Low(j); x(i,j)=Low(j);end
        if x(i,j)>High(j);x(i,j)=High(j);end
    end
end
loops=0;
Simx = [];
for loops=1:200
    if (abs(x(1,2)-x(2,2))/x(1,2) < 1.0e-10 && abs(x(2,2)-x(3,2))/x(2,2)< 1.0e-10)
        x(2,:)=x(2,:) + rand()*Span/20;
        x(3,:)=x(3,:) + rand()*Span/20;
    end
    for i=1:N+1
        [Q(i)]=Obj_Sim(x(i,1),x(i,2),k,T,n,r);
    end
     
    [Q_L,Pos]=min(Q);
    temp=x(1,:); x(1,:)=x(Pos,:); x(Pos,:)=temp;
    temp=Q(1); Q(1) = Q_L;  Q(Pos) = temp;
    Simx = [Simx;x(1,:)];
    [Q_H,Pos]=max(Q);
    temp = x(N+1,:); x(N+1,:)=x(Pos,:); x(Pos,:)=temp;
    temp = Q(N+1);  Q(N+1) = Q_H; Q(Pos) = temp;
    [Q_G,Pos]=max(Q(1:N));
    temp = x(N,:); x(N,:)=x(Pos,:); x(Pos,:)=temp;
    temp = Q(N); Q(N) = Q_G; Q(Pos) = temp;

    if abs((Q_H-Q_L)/Q_L) < Quit_Err
        break;
    end

    xc=(sum(x)-x(N+1,:))/N;
    alfa = 1;
    xr = xc + alfa *( xc-x(N+1,:));
    for i=1:N
        if xr(i) < Low(i); xr(i)=Low(i); end
        if xr(i) > High(i); xr(i)= High(i); end
    end
    [Q_r]=Obj_Sim(xr(1),xr(2),k,T,n,r);
    if Q_r < Q_G                %ю╘уе
        miu = 2;
        xe = xc + miu*(xr-xc);
        % xe=miu*xr + (1-miu)*xc;
        for i=1:N
            if xe(i)<Low(i); xe(i)=Low(i);end
            if xe(i)>High(i);xe(i)=High(i);end
        end
        [Q_xe]=Obj_Sim(xe(1),xe(2),k,T,n,r);
        if Q_xe < Q_r
            x(N+1,:) = xe; Q(N+1)= Q_xe;
        else
            x(N+1,:)= xr; Q(N+1)= Q_r;
        end
        continue;
    end
    if Q_r >= Q_G
        lamda = 0.5;
        if Q_r > Q(N+1)
            xs = x(N+1,:) + lamda * (xc - x(N+1,:));
        else
            xs = xc + lamda * (xr-xc);
        end
        for i = 1:N
            if xs(i)<Low(i); xs(i)=Low(i); end
            if xs(i)>High(i); xs(i)=High(i);end
        end
        [Q_s] = Obj_Sim(xs(1),xs(2),k,T,n,r);
        if Q_s < Q(N)
            x(N+1,:) = xs; Q(N+1)=Q_s;
        else
            for i=2:N+1
                x(i,:) = x(1,:) + 0.5*(x(i,:)-x(1,:));
                for j=1:N
                    if x(i,j) < Low(j); x(i,j)=Low(j);end
                    if x(i,j) > High(j); x(i,j) = High(j);end
                end
                [Q(i)]=Obj_Sim(x(i,1),x(i,2),k,T,n,r);
            end
        end
    end
    
end

[Q,y,cu,t]=Obj_Sim(x(1,1),x(1,2),k,T,n,r);
[a,b,c,d,e,f,g]= Value(y,dt);
Tti=num2str(x(1,2));
Tdelta = num2str(x(1,1));
g=[g,' Optimized parameters,delta=',Tdelta,', ti=',Tti];
figure(1)
subplot(2,1,1)

plot(t,y0,'k-',t,y,'r-','LineWidth',2);
legend(g0,g);
subplot(2,1,2)
plot(t,cu0,'k-',t,cu,'r-','LineWidth',2);
figure(2)
plot(Simx(:,1),Simx(:,2),'LineWidth',2);
xlabel('delta');
ylabel('ti');



