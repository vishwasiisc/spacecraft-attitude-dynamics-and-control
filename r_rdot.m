function state=r_rdot(t,orbit,p)
%%%%%%%%%%%%%%%%%%%%%%
%Author : vishvas gajera
%created :7 dec 2023
%modified : 7 dec 2023
%descereption : takes orbit parametrs and outputs position and velocity of
%satelite in vector form in inertial frame
%%%%%%%%%%%%%%%%%%%%%%

b1=[1,0,0]'; b2=[0,1,0]'; b3=[0,0,1]';

orbit_radious   = orbit.radious;
right_ascension = orbit.right_ascension;
inclination     = orbit.inclination;
theta_dot       = orbit.theta_dot;
theta0          = orbit.theta0;


true_anomaly = theta0 + theta_dot*t;





mu_mars=p.mu_planet;


r1=orbit_radious*b1;

theta_dot=sqrt(mu_mars/(orbit_radious.^3));

r1_dot=theta_dot*orbit_radious*b2;


%%
% body frame to inertial frame rotation matrix

R3_asc=R3(right_ascension);

R1_inc=R1(inclination);

R3_tr_a=R3(true_anomaly);
%%
%return value
%{
r=R3_tr_a*R1_inc*R3_asc*r1;
r_dot=R3_tr_a*R1_inc*R3_asc*r1_dot;
%}

%
r=R3_asc*R1_inc*R3_tr_a*r1;   
r_dot=R3_asc*R1_inc*R3_tr_a*r1_dot;
%}






state=[r;r_dot];
end