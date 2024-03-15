function plot_soln(soln,start,stop,p)
close all

t = linspace(start, stop, 100000);
zsol = deval(soln,t);

mrp = zsol(1:3,:);
omega = zsol(4:6,:);

plot(t,mrp);




end