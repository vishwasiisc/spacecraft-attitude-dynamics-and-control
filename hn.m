function C = hn(t,orbit)

%function that gives dcm at t time for lmo orbit, 
%dcm maps orbit frame to inertial frame or orbit frame attitude with
%respect to the inertial frame

right_ascension_lmo=orbit.right_ascension;
inclination_lmo=orbit.inclination;
theta_dot_lmo = orbit.theta_dot;
theta0_lmo = orbit.theta0;
true_anomaly_lmo=theta0_lmo+theta_dot_lmo*t;

R3_asc=R3(right_ascension_lmo);

R1_inc=R1(inclination_lmo);

R3_tr_a=R3(true_anomaly_lmo);


C=R3_asc*R1_inc*R3_tr_a;
C = C';


end