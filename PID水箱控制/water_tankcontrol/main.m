close all;
clear all;
clc;
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
g=serial('COM1','Parity','none','DataBits',8,'StopBits',1);     %To construt a serial object(port) which is connected with COM1;
g.BaudRate=9600;               %buad rate of the object
g.InputBufferSize=4096;       %input buffer sizes of the object
g.OutputBufferSize=4096;    %output buffer sizes of the object
g.timeout=20;                        %
g.ReadAsyncMode='continuous';
g.terminator='CR'; 
g.bytesavailablefcnmode='byte'; 
fopen(g);        %To connect the serial port object to the serial port
dt=5;
temp = 6;
tt=[];
y=[];
y1=[];
u=[];
u1 = [];
i=0;
error = 0;
error1 = 0;
level = 12;
ui=0;
ui1=0;
input1 = temp;
open = 1;
input = temp;
mytimer = timer('TimerFcn','timer_callback', 'Period', dt, 'ExecutionMode', 'fixedSpacing','StopFcn','timer_stop');
start(mytimer);
AOWriteChannel(g,0,input);





