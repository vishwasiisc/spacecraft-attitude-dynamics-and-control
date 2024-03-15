function omega = omega_RnN(t,lmo_orbit,p)


theta_dot_lmo = lmo_orbit.theta_dot;
C = RnN(t,lmo_orbit,p);


omega = theta_dot_lmo*[0,0,1]';

omega = -C'*omega;






end
