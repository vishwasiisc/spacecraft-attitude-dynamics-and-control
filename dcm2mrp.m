function mrp = dcm2mrp(RN)

C = RN;
c1 = C(1,1); c2 = C(2,2); c3 = C(3,3);

%converting to quaternion

q0 = 0.5*sqrt(1+trace(C));
q1 = 0.5*sqrt(1+2*c1-trace(C));
q2 = 0.5*sqrt(1+2*c2-trace(C));
q3 = 0.5*sqrt(1+2*c3-trace(C));

q = [q0,q1,q2,q3]';

q = max([q0,q1,q2,q3]);

%%
if q0 == q

    %disp('max q0')
    Q0 = q0;

    Q1 = (C(2,3)-C(3,2))/(4*q0);
    Q2 = (C(3,1)-C(1,3))/(4*q0);
    Q3 = (C(1,2)-C(2,1))/(4*q0);

elseif q1 == q

    %disp('max q1')
    Q1 = q1;
    Q0 = (C(2,3)-C(3,2))/(4*q1);
    Q2 = (C(1,2)+C(2,1))/(4*q1);
    Q3 = (C(3,1)+C(1,3))/(4*q1);

elseif q2 == q
    %disp('max q2')
    
    Q0 = (C(3,1)-C(1,3))/(4*q2);
    Q1 = (C(1,2)+C(2,1))/(4*q2);
    Q2 = q2;
    Q3 = (C(2,3)+C(3,2))/(4*q2);
   

elseif q3 == q
    %disp('max q3')
    Q3 = q3;
    Q0 = (C(1,2)-C(2,1))/(4*q3);
    Q1 = (C(3,1)+C(1,3))/(4*q3);
    Q2 = (C(2,3)+C(3,2))/(4*q3);

end

Q = [Q0,Q1,Q2,Q3]';

mrp = Q(2:4)/(1+Q(1));


%%
if Q0 == -1
 %put 360 rotation singularity here
    mrp =[0,0,0]';
end

%%
if norm(mrp)>1
    %disp('mrp > 1')
    mrp = -mrp/(mrp'*mrp);
end


end