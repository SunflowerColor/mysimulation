function [a,b] = find_pole(jieta,wn)
a = -jieta*wn;
b = wn*sqrt(1-jieta^2);