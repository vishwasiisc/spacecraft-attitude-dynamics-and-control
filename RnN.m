function C = RnN(t,orbit,p)

state=r_rdot(t,orbit,p);

r1 = -state(1:3);

r1 = r1/norm(r1);

r2 = state(4:6);

r2 = r2/norm(r2);

r3 = cross(r1,r2);

% nadir frame with respect to inertial frame 

Rn = [r1,r2,r3];  %co-ordinate of Rn frame with respect to inertial frame

RnN = [r1,r2,r3]'; %transformation from inertial frame to Rn frame %%%% gotta check

C = RnN;




end