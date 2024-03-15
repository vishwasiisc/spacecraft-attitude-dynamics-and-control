function omega = omega_RcN(t,lmo_orbit,gmo_orbit,p)

dt = 0.000001;
t0 = t+dt;

RcN_t0 = RcN(t0,lmo_orbit,gmo_orbit,p);
RcN_t  = RcN(t,lmo_orbit,gmo_orbit,p);

RcN_dot = (-RcN_t+RcN_t0)/dt;

omega_tilde = RcN_t'*RcN_dot;

omega = -[omega_tilde(3,2),omega_tilde(1,3),omega_tilde(2,1)]';


end