%±æÊ¶ÆÀ¼Û
function Q=QV(Y,U,dt,k,T,n,un)

[lp,m]=size(Y);
if m>lp
    lp=m;
end

Q=0;
a=exp(-dt/T);
b=1-a;
X=zeros(n,1);
y=0;
for i=1:lp
    X(1)=a*X(1)+k*b*U(i);
    if n>1
        X(2:n)=a*X(2:n)+b*X(1:n-1);
    end
    if un==1
        y=y+X(n)*dt;
        Y1(i)=y;
    else
        Y1(i)=X(n);
    end
    Q=Q+(Y(i)-Y1(i))*(Y(i)-Y1(i));
end
Q=Q/lp;

    