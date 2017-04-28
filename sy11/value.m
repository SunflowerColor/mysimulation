function [ts,Mp,fai,tr,tp,ys,text]= value(y,dt)
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
    fai=-1;
    Mp=-1;
    ts=-1;
    tr=-1;
    tp=-1;
    ys=0;
elseif test<=5
    type=1;
    ys=y(lp);
else
    type=2;
    ys=y(lp);
end


if type==1     % alwarys increase
    fai=0;
    Mp=0;
    tp=dt*lp;
    i=lp;
    while y(i)>ys*0.9500
        i=i-1;
    end
    ts=(i+1)*dt;
    while y(i)>ys*0.900
        i=i-1;
    end
    tr=i*dt;    
end
 
 if type==2
     i=1;
     while y(i)<0.98*ys
         i=i+1;
     end
     tr=i*dt;
     i=lp;
     while y(i)>ys*0.95 && y(i)<ys*1.05
         i=i-1;
     end
     ts=i*dt;
     [ymax,tmax]=max(y);
     tp=dt*tmax;
     Mp=(ymax-ys)/ys*100;
     i=tmax;
      while(y(i)>ys)
          i=i+1;
      end
      [ysec,tsec]=max(y(i:lp));
      fai=(ymax-ysec)/(ymax-ys);
 end

ts1=num2str(ts);
mp1=num2str(Mp);
fai1=num2str(fai);
tr1=num2str(tr);
tp1=num2str(tp);
ys1=num2str(ys);
text=['ts=',ts1,',  ','Mp=',mp1,', ','FAI=',fai1,', ','tr=',tr1,', ','tp=',tp1,', ','ys=',ys1];

        

