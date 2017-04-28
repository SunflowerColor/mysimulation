function timer_stop()
global tt;
global dt;
global y;
global y1;
global g;
global u;
global u1;
fclose(g);
delete(g);
save y_tt dt u y tt;
end