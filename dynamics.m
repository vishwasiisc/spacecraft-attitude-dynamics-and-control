function zdot = dynamics(t,z,lmo_orbit,gmo_orbit,p)


I = p.I;
mrp_BN   = z(1:3);
omega_BN = z(4:6);


mrpdot_matrix = (1-mrp_BN'*mrp_BN)*eye(3)+2*tilde(mrp_BN)+2*mrp_BN*mrp_BN';


mrp_dot = (mrpdot_matrix*omega_BN)/4;

omegadot = I\((-tilde(omega_BN)*I*omega_BN) + controller(t,z,lmo_orbit,gmo_orbit,p));

zdot = [mrp_dot;omegadot];


end