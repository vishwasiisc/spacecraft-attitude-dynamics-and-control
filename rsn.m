function C = rsn()

r1=[-1 , 0 , 0];
r3=[0  , 1 , 0];

r2=cross(r3,r1);

C=[r1;r2;r3];


end