global tt;
global st;
global dt;
global lp;
global r;
global x;
global y;
global i;
x=0;
dt=1;
st=150;
r=1;
lp=st/dt;
i=1;
tt=[];
y=[];
mytimer = timer('TimerFcn','timer_callback', 'Period', 1, 'ExecutionMode', 'fixedSpacing','StopFcn','timer_stop');
start(mytimer);

