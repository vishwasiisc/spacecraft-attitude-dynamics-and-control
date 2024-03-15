function R = mrp2dcm(mrp)

R = eye(3) + (8*tilde(mrp)*tilde(mrp) - 4*(1-norm(mrp)^2)*tilde(mrp))/((1+norm(mrp)^2)^2);

% refrence

%Hanspeter Schaub - Analytical Mechanics of Space Systems


 
end