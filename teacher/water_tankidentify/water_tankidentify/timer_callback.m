function timer_callback()
global tt;
global dt;
global y;
global g;
global u;
global input;
global open;
global i;
value= AIReadChannel(g,0,8);
if(size(value)~=[0,0])
 x1 =value(1,1);
end
x1 = (x1-0.85)*25.0/(2.84-0.85);
y = [y1 x1];
tt=[tt i*dt];
if temp~=input
    temp = input;
    AOWriteChannel(g,0,temp);
end
u=[u temp];
hold off;
subplot(2,1,1)
plot(u);
grid on;
title('tank1 given value');
subplot(2,1,2)
plot(y);
grid on;
if open == 0
    ts=timerfind;
    if length(ts)>0
        stop(ts);
        delete(ts);    
    end
end
end
