function Q=QValue(eType,dt,y,r,EMp,ETs)
[lp,m]=size(y);
if lp<m
    lp=m;
end
type=0; 
length=fix(lp/20);
temp=0;
for i=lp:-1:lp-length+1
    temp=temp+y(i);
end;
temp=temp/length;
error=zeros(1,length);
for i=lp:-1:lp-length
    error(lp-i+1)= abs(y(i)-temp);
end
test=0;
for i=1:lp-1
    if(y(i+1)<y(i))
        test=test+1;
    end
end
ys=0;
[emax,te]=max(error);

if abs(emax)> 0.02*abs(temp)
    type=3;
    Mp=1000;
    ts=lp;
 
elseif test<=5
    type=1;
    ys=y(lp);
else
    type=2;
    ys=y(lp);
end


if type==1     % alwarys increase
    Mp=0;
    i=lp;
    while y(i)>ys*0.9500
        i=i-1;
    end
    ts=(i+1)*dt;     
end

 if type==2
     i=1;
     while y(i)<0.98*ys
         i=i+1;
     end
     tr=i*dt;
     i=lp;
     while y(i)>ys*0.98 && y(i)<ys*1.02
         i=i-1;
     end
     ts=i*dt;
     [ymax,tmax]=max(y);  
     Mp=(ymax-ys)/ys*100;
 end

Q=0;
if eType==1    %ISE
    for i=1:lp
        e=r-y(i);
        Q=Q+e*e*dt;
    end
end

if eType==2  %ITAE
    for i=1:lp
        e=r-y(i);
        Q=Q+i*dt*abs(e);
    end
end

if eType==3  %ITSE
    for i=1:lp
        e=r-y(i);
        Q=Q+i*dt*e*e;
    end
end

if eType==4   %ISTE
    for i=1:lp
        e=r-y(i);
        Q=Q+i*dt*i*dt*e*e;
    end
end
if EMp < Mp
    Q=Q + 1.0e10*abs((EMp-Mp)/EMp);
end
if ETs<ts
    Q=Q + 1.0e10*abs((ETs-ts)/(ETs));
end
    



        

        