function timer_callback()
global tt;
global dt;
global y;
global y1;
global g;
global u;
global u1;
global input;
global input1;
global temp;
global open;
global level;
global ui;
global ui1;
global i;
global error;
global error1;
global x1;
% global x2;
% value=[1 1];
value= AIReadChannel(g,0,8);
if(size(value)~=[0,0])
 x1 =value(1,1);
%  x2 =value(1,2);
end
x1 = (x1-0.93)*23.0/(2.70-0.93);

% x2 = (x2-0.85)*25.0/(2.84-0.85);
% u1 = [u1 input];
% x=[x1 x2]
% if i==1
%     ui = 0.0001;
% end
% %delta = 0.3*1.5*2;
% %ti=0.5*2*75;
% %kp=1/delta;
% % kp=0.1;
% % ki=0.01;
% kp=1.2;
% ki=0.002;
% %ki=1/(delta*ti);
% i=i+1;
% % y=[y x2];
y = [y x1];

tt=[tt i*dt];


% error = level - x1;
% % if (i==1)
% %     ui=0.0000001;
% %     ui1=0.00000001;
% % end
% ui = ki*error*dt + ui;
% if ui>6
%     ui = 6;
% end
% if ui<-6
%     ui=-6;
% end
% input = kp*error + ui ;
% if input >6
%     input = 6;
% end
% if input <-6
%     input =-6;
% end
% input = input + 12;

% error1 = x1 - input;
% ui1 = ki*error1*dt + ui1;
% if ui1 > 6
%     ui1 = 6;
% end
% if ui1 <-6
%     ui1 = -6;
% end
% 
% input1 = kp1*error1 + ui1;
% if input1 > 7
%     input1 = 7;
% end
% if input1 < -7
%     input1 = -7;
% end
% input1 = input1 + 12;
% if abs(temp-input)>0
%     temp = input;   
     AOWriteChannel(g,0,input);       
% end
u=[u input];

hold off;
subplot(2,1,1)
plot(y);
grid on;
title('tank1 level');
subplot(2,1,2)
plot(u);
grid on;
title('tank1 given value');


if open == 0
    ts=timerfind;
    if length(ts)>0
        stop(ts);
        delete(ts);    
    end
end
end
