function [value,isterminal,direction] = mrpswitch(t,z)
%%%Not in use 
mrp = z(1:3);

value = norm(mrp)-1;
isterminal = 0;
direction = 0;



end