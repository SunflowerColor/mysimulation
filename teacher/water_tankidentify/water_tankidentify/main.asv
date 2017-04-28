close all;
clear all;
clc;
global tt;
global dt;
global y;
global g;
global u;
global input;
global open;
global temp;
global i;
g=serial('COM1','Parity','none','DataBits',8,'StopBits',1);     %To construt a serial object(port) which is connected with COM1;
g.BaudRate=9600;               %buad rate of the object
g.InputBufferSize=4096;       %input buffer sizes of the object
g.OutputBufferSize=4096;    %output buffer sizes of the object
g.timeout=20;                        %
g.ReadAsyncMode='continuous';
g.terminator='CR'; 
g.bytesavailablefcnmode='byte'; 
fopen(g);        %To connect the serial port object to the serial port
dt=2;
tt=[];
y=[];
u=[];
i=0;
input =7;
temp = input;
open = 1;
mytimer = timer('TimerFcn','timer_callback', 'Period', dt, 'ExecutionMode', 'fixedSpacing','StopFcn','timer_stop');
start(mytimer);
AOWriteChannel(g,0,input);





