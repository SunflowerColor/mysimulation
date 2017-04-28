clc;
% clear all;
close all;
load aqis;
a1=[AQI(:,1);AQIS1(:,1)];
a1=a1';
gm1(a1);
plot(a1);