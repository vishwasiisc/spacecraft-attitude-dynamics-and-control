function C = RcN(t,lmo_orbit,gmo_orbit,p)

state_gmo = r_rdot(t,gmo_orbit,p);
state_lmo = r_rdot(t,lmo_orbit,p);

r_gmo = state_gmo(1:3);
r_lmo = state_lmo(1:3);

dr = r_gmo - r_lmo;

r1 = -dr/norm(dr);   % put -

r2 = cross(dr,[0;0;1]);
r2 = r2/norm(r2);

r3 = cross(r1,r2);

%Rc with respect to inertial frame

Rc = [r1,r2,r3];

%inertial frame to Rc frame 

RcN = Rc';

C = RcN;



end