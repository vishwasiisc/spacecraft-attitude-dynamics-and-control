%space craft dynamics and control mars capstone coursera

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                           Problem descreption
%planet mars
%two satellite in the orbit one observation satellite in low mars orbit
%2nd in mars geosync orbit for comunication
%simulate linear PD controls for attitued control for satellite in
%low mars orbit
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


clear
clc
format long
close all

%%
%orbit parameters

%format long
R       = 3396.19e3;    %radious of the planet
mu_mars = 42828.3e9;    %g*planet_radious_squared


%%
%orbit lmo
h                   = 400e3;        %height of the orbit from surface
r_lmo               = R+h;          %lmo orbit radious
right_ascension_lmo = deg2rad(20);
inclination_lmo     = deg2rad(30);
theta0_lmo          = deg2rad(60);
theta_dot_lmo       = 0.000884797;  %sqrt(mu_mars/(r_lmo.^3));


%packing orbit lmo

lmo_orbit.right_ascension = right_ascension_lmo;
lmo_orbit.inclination     = inclination_lmo;
lmo_orbit.radious         = r_lmo;
lmo_orbit.theta_dot       = theta_dot_lmo;
lmo_orbit.theta0          = theta0_lmo;


%%
%orbit gmo communication
r_gmo               = 20424.2e3;    %geosynchronous mars orbit radious
right_ascension_gmo = 0;
inclination_gmo     = 0;
theta0_gmo          = deg2rad(250);
theta_dot_gmo       = 0.0000709003;


%%packing orbit gmo
gmo_orbit.right_ascension = right_ascension_gmo;
gmo_orbit.inclination     = inclination_gmo;
gmo_orbit.radious         = r_gmo;
gmo_orbit.theta_dot       = theta_dot_gmo;
gmo_orbit.theta0          = theta0_gmo;



%%
% packing parameters
p.h         = h;  
p.R         = R;   
p.mu_planet = mu_mars;



%%
% initial conditions

s_BN     = [0.3, -0.4, 0.5]';           %initial attitude co-ordinates in  MRP
w_lmo_BN = deg2rad([1, 1.75, -2.20]');  %initial body angular velocity in body frame with respect to intertial frame
I        = [10,0,0; 0,5,0; 0,0,7.5];    %rigid spacecraft inertial tensor

p.I = I;

z0 =[s_BN;w_lmo_BN];

%%
%%%%%%%%%%%%%%%%ode solution%%%%%%%%%%%%%%%%%
%%time
tend=10000;%7270;
t=linspace(0,tend,1000000);

%%create a function
therhs = @(t,z) dynamics(t,z,lmo_orbit,gmo_orbit,p);

%solve ode
small    = 1e-9;
options  = odeset('AbsTol', small, 'RelTol', small); 
soln1    = ode45(therhs,t, z0,options);
%soln      = ode4(therhs,t,z0);

%%
%%%%%%%%%%%%%%%%%solution%%%%%%%%%%%%%%%%%%%%%%%%%%%
%plot_soln(soln,0,tend,p)

%zsol = soln';%deval(soln,tplot);
zsol = deval(soln1,t);

mrp   = zsol(1:3,:);
omega = zsol(4:6,:);


%%
%%%%%%%%%%plotting%%%%%%%%
%{
mrp_sun = dcm2mrp(rsn());
mrp_sun_p = ones(3,length(t));
mrp_sun_p(1,:) = mrp_sun(1)*mrp_sun_p(1,:);
mrp_sun_p(2,:) = mrp_sun(2)*mrp_sun_p(2,:);
mrp_sun_p(3,:) = mrp_sun(3)*mrp_sun_p(3,:);


close all
figure(1)
hold on
plot(t,mrp,'.');
plot(t,mrp_sun_p)
movegui('northwest')

figure(2)
plot(t,omega);
movegui('northeast')
%}

 %mrp(:,end)
 

 animate(soln1,50,lmo_orbit,gmo_orbit,p,t)








