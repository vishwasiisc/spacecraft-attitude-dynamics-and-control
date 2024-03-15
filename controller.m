function u = controller(t,z,lmo_orbit,gmo_orbit,p)

%u = [0,0,0]';%[0.01,-0.01,0.02]';

mrp = z(1:3);
omega = z(4:6);

states_lmo = r_rdot(t,lmo_orbit,p);
states_gmo = r_rdot(t,gmo_orbit,p);

r_lmo = states_lmo(1:3);
r_gmo = states_gmo(1:3);




%%
%sun stuff
R_sun = rsn();
omega_sun =[0,0,0]';
error_sun = state_error(mrp,omega,R_sun,omega_sun);



%%
%nadir stuff
RN_nadir=RnN(t,lmo_orbit,p);
omega_nadir = omega_RnN(t,lmo_orbit,p);
error_nadir = state_error(mrp,omega,RN_nadir,omega_nadir);



%%
%comunication GMO
theta_communication = deg2rad(35);
RN_comunication = RcN(t,lmo_orbit,gmo_orbit,p);
omega_comunication = omega_RcN(t,lmo_orbit,gmo_orbit,p);
error_comunication = state_error(mrp,omega,RN_comunication,omega_comunication);



%%
%targetting
if r_lmo(2) >= 0

    error_target = error_sun; 

end


if r_lmo(2) < 0
    
    theta = acos(dot(r_lmo,r_gmo)/(norm(r_lmo)*norm(r_gmo)));

    if theta <= theta_communication
        error_target = error_comunication;
    else
        error_target = error_nadir;
    end
end




mrp_BR = error_target(1:3);
omega_BR = error_target(4:6);

%%
%control
K = 0.0055;
P = 0.1667;


u = - K*mrp_BR - P*omega_BR;

end
